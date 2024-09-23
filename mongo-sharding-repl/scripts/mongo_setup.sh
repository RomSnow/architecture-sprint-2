#!/bin/bash

docker compose up -d;

docker compose exec mongodb_shard1-0 mongosh --port 27019 --eval '
rs.add({_id: 1, host: "mongodb_shard1-1:27011"});
rs.add({_id: 2, host: "mongodb_shard1-2:27012"});
';

docker compose exec mongodb_shard2-0 mongosh --port 27020 --eval '
rs.add({_id: 1, host: "mongodb_shard2-1:27021"});
rs.add({_id: 2, host: "mongodb_shard2-2:27022"});
';