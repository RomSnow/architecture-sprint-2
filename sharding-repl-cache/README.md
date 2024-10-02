# Шардирование
## Инстансы
mongodb_config_server:27017 - сервер конфигурации

mongodb_router:27018 - роутер

mongodb_shard1-0:27019 - шард 1

mongodb_shard1-1:27011 - шард 1 (реплика)

mongodb_shard1-2:27012 - шард 1 (реплика)

mongodb_shard2-0:27020 - шард 2

mongodb_shard2-0:27021 - шард 2 (реплика)

mongodb_shard2-0:27022 - шард 2 (реплика)

redis1                 - кэш

## Инициализация


Для инициализации системы необходимо выполнить docker comopose up -d в текущей директории, а после запустить скрипт scripts/app_setup.sh

Если система показывает, что в mongo отсутствуют записи, то нужно дополнительно запустить скрипт scripts/mogno-init.sh


## Схема

Схему находится в файле task2.drawio корневой директории репозитория или по ссылке

https://drive.google.com/file/d/1IevnWVezHQ2p0RFx89w1-b3HsZyOXWxu/view?usp=sharing
