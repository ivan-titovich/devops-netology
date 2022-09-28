# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [elasticsearch:7](https://hub.docker.com/_/elasticsearch) как базовый:

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
`sudo docker build --tag=titovichia/es.7.17.5 .`
`sudo docker image push titovichia/es.7.17.5`
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины


Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib` 
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
```dockerfile
FROM elasticsearch:7.17.5
COPY --chown=elasticsearch:elasticsearch elasticsearch.yml /usr/share/elasticsearch/config/
RUN chown -R elasticsearch:elasticsearch /var/lib
```
```yaml
network.host: 0.0.0.0
http.port: 9200
transport.host: localhost
discovery.type: single-node
transport.tcp.port: 9300
cluster.name: "netology_test"
path.data: "/var/lib"
xpack.security.enabled: true
```
- ссылку на образ в репозитории dockerhub
> https://hub.docker.com/repository/docker/titovichia/es.7.17.5
- ответ `elasticsearch` на запрос пути `/` в json виде
```json
{
  "name" : "f9c733cd6935",
  "cluster_name" : "netology_test",
  "cluster_uuid" : "OBmTYRD1RFSyKNJFsJbCIg",
  "version" : {
    "number" : "7.17.5",
    "build_flavor" : "centos_8",
    "build_type" : "docker",
    "build_hash" : "8d61b4f7ddf931f219e3745f295ed2bbc50c8e84",
    "build_date" : "2022-06-23T21:57:28.736740635Z",
    "build_snapshot" : false,
    "lucene_version" : "8.11.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

Подсказки:
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения
- обратите внимание на настройки безопасности такие как `xpack.security.enabled` 
- если докер образ не запускается и падает с ошибкой 137 в этом случае может помочь настройка `-e ES_HEAP_SIZE`
- при настройке `path` возможно потребуется настройка прав доступа на директорию

Далее мы будем работать с данным экземпляром elasticsearch.

## Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных


Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.
`http://localhost:9200/_cat/indices`:
```
green  open .geoip_databases lgyWF-AsSFqgNUjbCebG7w 1 0 40 0 37.6mb 37.6mb
green  open .security-7      DkyfyEq-SaejlHoQ3af7tA 1 0  7 0 25.7kb 25.7kb
green  open ind-1            vXOz4AU5Suq0l1gART7BOA 1 0  0 0   226b   226b
yellow open ind-3            CWSx66_dRvK-RGMbD8UzFg 4 2  0 0   904b   904b
yellow open ind-2            bzBXxzwoS22ghVZzGsqKKw 2 1  0 0   452b   452b
```
Получите состояние кластера `elasticsearch`, используя API.
`http://localhost:9200/_cat/health`
```
1658985751 05:22:31 netology_test yellow 1 1 11 11 0 0 11 0 - 50.0%
```
Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?
- > Потому что для снижения вероятности потери данных необходимо, чтобы все primary шарды были со статусом ASSIGNED.
- > Для индекса ind-1: указано количество шард 1 и она со статусом ASSIGNED;
- > Для индекса ind-2: указано количество шард 2 и одна со статусом ASSIGNED, одна со статусом UNASSIGNED;
- > Для индекса ind-3: указано количество шард 4 и одна со статусом ASSIGNED, 3 со статусом UNASSIGNED;
- > Весь индекс в желтом статусе т.к. есть индексы с желтым статусом и не обеспечена сохранность данных в случае сбоя.
```
ind-1            0 p STARTED     0   226b 127.0.0.1 f9c733cd6935
ind-3            1 p STARTED     0   226b 127.0.0.1 f9c733cd6935
ind-3            1 r UNASSIGNED                     
ind-3            1 r UNASSIGNED                     
ind-3            2 p STARTED     0   226b 127.0.0.1 f9c733cd6935
ind-3            2 r UNASSIGNED                     
ind-3            2 r UNASSIGNED                     
ind-3            3 p STARTED     0   226b 127.0.0.1 f9c733cd6935
ind-3            3 r UNASSIGNED                     
ind-3            3 r UNASSIGNED                     
ind-3            0 p STARTED     0   226b 127.0.0.1 f9c733cd6935
ind-3            0 r UNASSIGNED                     
ind-3            0 r UNASSIGNED                     
.security-7      0 p STARTED     7 25.7kb 127.0.0.1 f9c733cd6935
ind-2            1 p STARTED     0   226b 127.0.0.1 f9c733cd6935
ind-2            1 r UNASSIGNED                     
ind-2            0 p STARTED     0   226b 127.0.0.1 f9c733cd6935
ind-2            0 r UNASSIGNED                     
.geoip_databases 0 p STARTED    40 37.6mb 127.0.0.1 f9c733cd6935
```
Удалите все индексы.
`DELEE http://localhost:9200/ind-*`

**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

## Задача 3

В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

`PUT http://localhost:9200/_snapshot/netology_backup`
```
{
  "type": "fs",
  "settings": {
    "location": "/snapshots"
  }
}
```
`{
    "acknowledged": true
}`

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.
`PUT http://localhost:9200/test`
```
{
  "settings": {
    "index": {
      "number_of_shards": 1,  
      "number_of_replicas": 0 
    }
  }
}
```
> Indeces: 
``` 
green open .geoip_databases O7y3XdmIRn-niI6iGz6gxA 1 0 40 0 37.6mb 37.6mb
green open .security-7      1cxgu9vtS6Se2JgW8lJByQ 1 0  7 0 25.7kb 25.7kb
green open test             59KazMPURYq0wFTdYFwAmA 1 0  0 0   226b   226b

```


[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.
`PUT http://localhost:9200/_snapshot/netology_backup/netology_backup_280722`
**Приведите в ответе** список файлов в директории со `snapshot`ами.
```shell
ll /snapshots/
total 56
drwxr-xr-x 1 elasticsearch elasticsearch  4096 Jul 28 06:13 ./
drwxr-xr-x 1 root          root           4096 Jul 28 06:02 ../
-rw-rw-r-- 1 elasticsearch root           1108 Jul 28 06:13 index-0
-rw-rw-r-- 1 elasticsearch root              8 Jul 28 06:13 index.latest
drwxrwxr-x 5 elasticsearch root           4096 Jul 28 06:13 indices/
-rw-rw-r-- 1 elasticsearch root          29667 Jul 28 06:13 meta--Drm4SwxTZaGskYt6IFXYg.dat
-rw-rw-r-- 1 elasticsearch root            511 Jul 28 06:13 snap--Drm4SwxTZaGskYt6IFXYg.dat

```

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

```
green open .geoip_databases O7y3XdmIRn-niI6iGz6gxA 1 0 40 0 37.6mb 37.6mb
green open .security-7      1cxgu9vtS6Se2JgW8lJByQ 1 0  7 0 25.7kb 25.7kb
green open test2            q0YRoz9oTbm49wQaA6z7Jw 1 0  0 0   226b   226b
```

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 
'DELETE http://localhost:9200/test2'
`PUT http://localhost:9200/_snapshot/netology_backup/netology_backup_280722/_restore`
`{
  "indices": "test"
}`

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.
`GET http://localhost:9200/_cat/indices`
```
green open .geoip_databases O7y3XdmIRn-niI6iGz6gxA 1 0 40 0 37.6mb 37.6mb
green open .security-7      1cxgu9vtS6Se2JgW8lJByQ 1 0  7 0 25.7kb 25.7kb
green open test             pMNY_EM2SQ2ggrEuk9TytA 1 0  0 0   226b   226b
```
Подсказки:
- возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch`

---
