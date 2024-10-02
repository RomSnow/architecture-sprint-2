#!/bin/bash

cd ..

docker exec mongodb_config_server mongosh --port 27017 --eval 'rs.initiate(
  {
    _id : "config_server",
    configsvr: true,
    members: [
      { _id : 0, host : "mongodb_config_server:27017" }
    ]
  }
);';

docker exec mongodb_shard1-0 mongosh --port 27019 --eval 'rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "mongodb_shard1-0:27019" }
      ]
    }
);';

docker exec mongodb_shard2-0 mongosh --port 27020 --eval 'rs.initiate(
    {
      _id : "shard2",
      members: [
        { _id : 0, host : "mongodb_shard2-0:27020" }
      ]
    }
);';

max_iteration=5

for i in $(seq 1 $max_iteration)
do
  docker exec mongodb_router mongosh --port 27018 --eval '
      sh.addShard("shard1/mongodb_shard1-0:27019");
      sh.addShard("shard2/mongodb_shard2-0:27020");
      sh.enableSharding("somedb");
      sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )
  '
  result=$?
  if [[ $result -eq 0 ]]
  then
    break
  else
    sleep 2
  fi
done;

docker exec mongodb_shard1-0 mongosh --port 27019 --eval '
rs.add({_id: 1, host: "mongodb_shard1-1:27011"});
rs.add({_id: 2, host: "mongodb_shard1-2:27012"});
';

docker exec mongodb_shard2-0 mongosh --port 27020 --eval '
rs.add({_id: 1, host: "mongodb_shard2-1:27021"});
rs.add({_id: 2, host: "mongodb_shard2-2:27022"});
';

cd scripts;

./mongo-init.sh
