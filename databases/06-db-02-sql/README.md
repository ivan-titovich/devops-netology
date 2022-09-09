# Домашнее работа к занятию "6.2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.
```yaml
version: '3.1'

volumes:
    backup:
      external: true
    pgdata: {}

services:

  db1:
    image: postgres:12.11-bullseye
    volumes:
      - backup:/home/postgre/backup
      - pgdata:/var/lib/postgresql/data
    restart: always
    environment:
      POSTGRES_DB: "postgres"
      POSTGRES_USER: "postgres"
      POSTGRES_PASSWORD: example
    ports:
      - 5432:5432
```
```yaml
version: '3.1'

volumes:
    backup:
      external: true
    pgdata: {}

services:

  db2:
    image: postgres:12.11-bullseye
    volumes:
      - backup:/home/postgre/backup
      - pgdata:/var/lib/postgresql/data
    restart: always
    environment:
      POSTGRES_DB: "postgres"
      POSTGRES_USER: "postgres"
      POSTGRES_PASSWORD: example
    ports:
      - 5432:5432
```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)
```

CREATE TABLE orders (
    id serial PRIMARY KEY,
    name varchar,
    price integer
);
```

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)
``` 

CREATE TABLE clients (
    id serial PRIMARY KEY,
    firstname varchar,
    county varchar ,
    "order" integer, 
    FOREIGN KEY("order")
    REFERENCES orders(id)
);
```
Приведите:
- итоговый список БД после выполнения пунктов выше,
```sql
SELECT datname FROM pg_database;
```
```
datname  |
---------+
postgres |
test_db  |
template1|
template0|
```
- описание таблиц (describe)
```sql
SELECT 
   table_name, 
   column_name, 
   data_type 
FROM 
   information_schema.COLUMNS
 WHERE 
 	table_name = 'orders'
 	OR table_name = 'clients';
```
```
table_name|column_name|data_type        |
----------+-----------+-----------------+
clients   |id         |integer          |
clients   |firstname  |character varying|
clients   |county     |character varying|
clients   |order      |integer          |
orders    |id         |integer          |
orders    |name       |character varying|
orders    |price      |integer          |
```
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
```sql

SELECT grantee, table_name, privilege_type
    FROM information_schema.role_table_grants
    WHERE
        table_schema = quote_ident('public')
        AND (table_name = 'orders' OR table_name = 'clients')
        AND (grantee = 'test_admin_user' OR grantee = 'test_simple_user')

```

- список пользователей с правами над таблицами test_db
```
grantee         |table_name|privilege_type|
----------------+----------+--------------+
test_admin_user |orders    |INSERT        |
test_admin_user |orders    |SELECT        |
test_admin_user |orders    |UPDATE        |
test_admin_user |orders    |DELETE        |
test_admin_user |orders    |TRUNCATE      |
test_admin_user |orders    |REFERENCES    |
test_admin_user |orders    |TRIGGER       |
test_simple_user|orders    |INSERT        |
test_simple_user|orders    |SELECT        |
test_simple_user|orders    |UPDATE        |
test_simple_user|orders    |DELETE        |
test_admin_user |clients   |INSERT        |
test_admin_user |clients   |SELECT        |
test_admin_user |clients   |UPDATE        |
test_admin_user |clients   |DELETE        |
test_admin_user |clients   |TRUNCATE      |
test_admin_user |clients   |REFERENCES    |
test_admin_user |clients   |TRIGGER       |
test_simple_user|clients   |INSERT        |
test_simple_user|clients   |SELECT        |
test_simple_user|clients   |UPDATE        |
test_simple_user|clients   |DELETE        |
```



## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|
```sql
INSERT INTO orders(name, price) VALUES('Шоколад', '10');
INSERT INTO orders(name, price) VALUES('Принтер', '3000');
INSERT INTO orders(name, price) VALUES('Книга', '500');
INSERT INTO orders(name, price) VALUES('Монитор', '7000');
INSERT INTO orders(name, price) VALUES('Гитара', '4000');
```
Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

``` 

INSERT INTO clients(firstname, county) VALUES('Иванов Иван Иванович', 'USA');
INSERT INTO clients(firstname, county) VALUES('Петров Петр Петрович', 'Canada');
INSERT INTO clients(firstname, county) VALUES('Иоганн Себастьян Бах', 'Japan');
INSERT INTO clients(firstname, county) VALUES('Ронни Джеймс Дио', 'Russia');
INSERT INTO clients(firstname, county) VALUES('Ritchie Blackmore', 'Russia');
```

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
```
  SELECT count(*) FROM orders;
  SELECT count(*) FROM clietns;
```


   - результаты их выполнения.

``` 

count|
-----+
    5|
```
``` 

count|
-----+
    5|
```


## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.
``` 
UPDATE clients 
SET "order" = (SELECT id FROM orders WHERE name = 'Книга')
WHERE firstname = 'Иванов Иван Иванович';

UPDATE clients 
SET "order" = (SELECT id FROM orders WHERE name = 'Монитор')
WHERE firstname = 'Петров Петр Петрович';

UPDATE clients 
SET "order" = (SELECT id FROM orders WHERE name = 'Гитара')
WHERE firstname = 'Иоганн Себастьян Бах';
```

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.

``` 
SELECT firstname FROM clients WHERE "order" > 0 ;
```
``` 
firstname           |
--------------------+
Иванов Иван Иванович|
Петров Петр Петрович|
Иоганн Себастьян Бах|
```
 
Подсказк - используйте директиву `UPDATE`.

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).
``` 
EXPLAIN SELECT firstname FROM clients WHERE "order" > 0 ;
```
Приведите получившийся результат и объясните что значат полученные значения.

``` 
QUERY PLAN                                               |
---------------------------------------------------------+
Seq Scan on clients  (cost=0.00..20.12 rows=270 width=32)|
  Filter: ("order" > 0)                                  |
```
> Выводит план выполнения задания. Seq Scan on clients - последовательное чтение данных из таблицы clients (блок за блоком).\ 
> Cost - оценка времени получение значения 0.00 - первой строки, 20.12 - затраты на получение всех строк.\
> rows — приблизительное количество возвращаемых строк при выполнении операции Seq Scan.\
> width — средний размер одной строки в байтах.\
> Filter: ("order" > 0)  - фильтр, каждое значение в столбце сравнивается и выводится только удовлетворящие условию значения.\ 


## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).
``` 
sudo docker exec  db1-db1-1 /bin/bash -c "/usr/bin/pg_dump  -U postgres test_db > /home/postgre/backup/1_test_db-backup.sql"
```
Остановите контейнер с PostgreSQL (но не удаляйте volumes).
``` 
sudo docker stop db1-db1-1
```
Поднимите новый пустой контейнер с PostgreSQL.
``` 
sudo docker compose -f docker-compose.yml up
```
Восстановите БД test_db в новом контейнере.
``` 
sudo docker exec -i db2-db2-1 /bin/bash -c "psql  -U postgres -c 'CREATE DATABASE test_db;'"
sudo docker exec -i db2-db2-1 /bin/bash -c "psql  -U postgres -c 'CREATE USER test_admin_user;'"
sudo docker exec -i db2-db2-1 /bin/bash -c "psql  -U postgres -c 'CREATE USER test_simple_user;'"
sudo docker exec -i db2-db2-1 /bin/bash -c "psql  -U postgres -d test_db -f /home/postgre/backup/1_test_db-backup.sql"
```
---