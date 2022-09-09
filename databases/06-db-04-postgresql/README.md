# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.
```
sudo docker run -dp 5432:5432 --name pdb -v /postgre-db/:/var/lib/postgresql/data -e POSTGRES_DB=postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=example postgres:13.7
```

Подключитесь к БД PostgreSQL используя `psql`.
``` 
sudo docker exec -it pdb /bin/bash -c 'psql -U postgres'
```

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД  `\l ` ***l[+]   [PATTERN]      list databases***
- подключения к БД  `\c` ***\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo} connect to new database (currently "postgres")***
- вывода списка таблиц `\dt` ***\dt[S+] [PATTERN]      list tables ***
- вывода описания содержимого таблиц `\dd` ***\dd[S]  [PATTERN]      show object descriptions not displayed elsewhere***
- выхода из psql `\q` 

## Задача 2

Используя `psql` создайте БД `test_database`.
```
CREATE DATABASE test_database;
```

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.
``` 
sudo docker cp ../test-data/test_dump.sql pdb:/test_dump.sql
sudo docker exec -it pdb /bin/bash -c 'psql -U postgres -d test_database < test_dump.sql'
```
Перейдите в управляющую консоль `psql` внутри контейнера.
``` 
sudo docker exec -it pdb /bin/bash -c 'psql -U postgres'
```
Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.
```
\c test_database
ANALYZE orders;
ANALYZE


```
Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

> Наибольший стоблец titles.
``` 
SELECT tablename, attname, avg_width  FROM pg_stats WHERE tablename = 'orders' 
tablename|attname|avg_width|
---------+-------+---------+
orders   |id     |        4|
orders   |title  |       16|
orders   |price  |        4|
```
## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.
> Т.к. существующую таблицу шардировать нельзя, необходимо создать новую, разбить согласно условиям задания, скопировать в нее данные, переименовать: 
``` 
CREATE TABLE new_orders (LIKE orders) PARTITION BY RANGE (price) ;
CREATE TABLE orders_1 PARTITION OF new_orders FOR VALUES FROM ('499') TO ('2147483647') ;
CREATE TABLE orders_2 PARTITION OF new_orders FOR VALUES FROM ('0') TO ('499');

INSERT INTO new_orders(id, title, price) SELECT id, title, price FROM orders;

ALTER TABLE orders RENAME TO orders_backup;
ALTER TABLE new_orders RENAME TO orders;

DROP TABLE	orders_backup;
```
Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

> Да. Изначально нужно было создать таблицу с поддержкой разбиения.
``` 
CREATE TABLE new_orders (LIKE orders) PARTITION BY RANGE (price) ;
CREATE TABLE orders_1 PARTITION OF new_orders FOR VALUES FROM ('499') TO ('2147483647') ;
CREATE TABLE orders_2 PARTITION OF new_orders FOR VALUES FROM ('0') TO ('499');
```

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

``` 
sudo docker exec  pdb /bin/bash -c "/usr/bin/pg_dump  -U postgres test_database > /home/test_db-backup.sql" 

```

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?
>В конце файла дописать:
``` 
ALTER TABLE ONLY public.orders ADD CONSTRAINT orders_title_price_key UNIQUE (title, price);

ALTER TABLE ONLY public.orders_1 ADD CONSTRAINT orders_1_title_price_key UNIQUE (title, price);

ALTER TABLE ONLY public.orders_2 ADD CONSTRAINT orders_2_title_price_key UNIQUE (title, price);

ALTER INDEX public.orders_title_price_key ATTACH PARTITION public.orders_1_title_price_key;

ALTER INDEX public.orders_title_price_key ATTACH PARTITION public.orders_2_title_price_key;

```
---
