# Домашняя работа к занятию "6.3. MySQL"

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.
``` 
sudo docker run -dp 3306:3306 --name test_mysql -v /mysql-db/:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=example test_db
```

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-03-mysql/test_data) и 
восстановитесь из него.
``` 
sudo docker exec -i test_mysql sh -c 'exec mysql -uroot -pexample test_db' < /home/test-data/test_dump.sql
```
Перейдите в управляющую консоль `mysql` внутри контейнера.
``` 
sudo docker exec -it test_mysql sh -c 'mysql -uroot -pexample'  
```
Используя команду `\h` получите список управляющих команд.
``` 
\s
```

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.
> ``` 
> Server version:		8.0.21 MySQL Community Server - GPL
> ```

Подключитесь к восстановленной БД и получите список таблиц из этой БД.
``` 
show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)

```
**Приведите в ответе** количество записей с `price` > 300.
```
mysql> select * from orders where price>300;
+----+----------------+-------+
| id | title          | price |
+----+----------------+-------+
|  2 | My little pony |   500 |
+----+----------------+-------+
1 row in set (0.00 sec)
 
```


## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"

```
CREATE USER IF NOT EXISTS 'test' IDENTIFIED WITH mysql_native_password BY 'test-pass' PASSWORD EXPIRE INTERVAL 180 DAY FAILED_LOGIN_ATTEMPTS 3 MAX_QUERIES_PER_HOUR 100 ATTRIBUTE'{"lastname": "Pretty", "firstname": "James"}';
```

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.
``` 
GRANT SELECT ON test_db.* TO 'test';
```
    
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.
``` 
SELECT  * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
+------+------+----------------------------------------------+
| USER | HOST | ATTRIBUTE                                    |
+------+------+----------------------------------------------+
| test | %    | {"lastname": "Pretty", "firstname": "James"} |
+------+------+----------------------------------------------+
1 row in set (0.00 sec)
```

## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.
``` 
mysql> SELECT TABLE_NAME, ENGINE FROM   information_schema.TABLES WHERE  TABLE_SCHEMA = 'test_db';
+------------+--------+
| TABLE_NAME | ENGINE |
+------------+--------+
| orders     | InnoDB |
+------------+--------+
1 row in set (0.00 sec)
```
Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`

``` 
|       18 | 0.04293750 | ALTER TABLE orders ENGINE MyISAM                                                                  |
|       19 | 0.06046375 | ALTER TABLE orders ENGINE InnoDb                                                                  |
+----------+------------+---------------------------------------------------------------------------------------------------+
```

## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных `innodb_flush_log_at_trx_commit = 2`
- Нужна компрессия таблиц для экономии места на диске `innodb_file_per_table=ON `
- Размер буффера с незакомиченными транзакциями 1 Мб `innodb_log_buffer_size = 1MB`
- Буффер кеширования 30% от ОЗУ `innodb_buffer_pool_size = 3305MB`
- Размер файла логов операций 100 Мб `innodb_buffer_pool_size = 100MB`

Приведите в ответе измененный файл `my.cnf`.
``` 
root@8ccb814588a1:/# cat /etc/mysql/my.cnf
# Стандартные комментарии конфига удалены для экономии места.

[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL


#HW config
innodb_flush_log_at_trx_commit	= 2
innodb_file_per_table		= ON
innodb_log_buffer_size		= 1MB
innodb_buffer_pool_size		= 3305MB
innodb_log_file_size		= 100MB

# Custom config should go here
!includedir /etc/mysql/conf.d/
```

---
