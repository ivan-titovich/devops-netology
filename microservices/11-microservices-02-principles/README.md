
# Домашнее задание к занятию "Микросервисы: принципы"

Вы работаете в крупной компанию, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps специалисту необходимо выдвинуть предложение по организации инфраструктуры, для разработки и эксплуатации.

## Задача 1: API Gateway 

Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:
- Маршрутизация запросов к нужному сервису на основе конфигурации
- Возможность проверки аутентификационной информации в запросах
- Обеспечение терминации HTTPS

Обоснуйте свой выбор.

|                               | Centralized, Edge Gateway                                                                                                                                  | Two-Tier Gateway                                                                                                                                                                                                                      | Microgateway                                                                                                                                                                                                                                                                                                                                                                      | Per-Pod Gateways                                                                                                                                                                                                                                                                         | Sidecar Gateways and Service Mesh                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|-------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| SSL/TLS termination| +                                                                                                                                                          | +                                                                                                                                                                                                                                     | +| + for the application in the pod                                                                                                                                                                                                                                                         | +                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Authentication                | +                                                                                                                                                          | +                                                                                                                                                                                                                                     | + per API                                                                                                                                                                                                                                                                                                                                                                         | +                                                                                                                                                                                                                                                                                        | +                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Request routing               | +                                                                                                                                                          | +                                                                                                                                                                                                                                     | +                                                                                                                                                                                                                                                                                                                                                                                 | -                                                                                                                                                                                                                                                                                        | + only if it’s aware of the entire application topology                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| Conclusion                    | Наиболее подходящее решение для централизованно-управляемых монолитных приложений. <br/>Плохо подходит для часто обновляющихся приложений и микросервисов. | Двухуровневый шлюз болше всего подходит для гибкого управления распределеннных сервисов с возможностью масштабирования. Подходит для управления окружениями разными командами разработки. Не поддерживает распределенного управления. | Микрошлюзы спроектированы для управления микросервисами. С их помощью может быть сложно достичь согласованности и контроля.<br/> У каждого микрошлюза может быть свой набор правил безопасности и политик, а так же может агрегировать свой набор метрик и логово с множества микросервисов. Микрошлюзы конфигурируются в соответствии с требованиями бизнеса к API или ряду API. | Шаблон шлюза для каждого модуля не выполняет маршрутизацию или балансировку запросов. <br/> Шаблон шлюза для каждого модуля обычно легковесны и их конфигурация постоянна. Он просто перенаправляет трафик в нужный микросервис, и если нужно изменить настроки - пересоздается модуль.  | Этот шаблон довольно сложен в реализации, поскольку прокси-сервер должен прозрачно перехватывать все исходящие запросы от локального приложения. Этот шаблон проще всего реализовать с помощью сервисной сетки на основе sidecar, которая обеспечивает прокси-сервер sidecar, внедрение, захват трафика и интегрированную плоскость управления, требуемую шаблоном. <br/>Шаблон sidecar-прокси постепенно становится наиболее популярным (хотя и все еще развивающимся) подходом к сервисным сеткам, обеспечивая управление доступом на основе ролей для нескольких команд, которые настраивают отдельные прокси из плоскости управления сервисной сеткой. |


[source](https://www.nginx.com/blog/choosing-the-right-api-gateway-pattern/)

> Если проанализировать имеющиеся подходы к реализации API gateway, то наиболее подходящими подходами будут либо микрошлюзы (Microgateway), либо per-pod шлюз. 
> 
>Наиболее подходящим, на мой взгляд, будет подход с реализацией микрошлюзов, т.к. каждая команда разработки сможет настроить микрошлюз под себя. 

## Задача 2: Брокер сообщений

Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:
- Поддержка кластеризации для обеспечения надежности
- Хранение сообщений на диске в процессе доставки
- Высокая скорость работы
- Поддержка различных форматов сообщений
- Разделение прав доступа к различным потокам сообщений
- Протота эксплуатации

Обоснуйте свой выбор.

|                                        | RabbitMQ                        | Kafka | Redis | ActiveMQ|
|----------------------------------------|---------------------------------|-------|-------|---|
| Класетризация                          | +                               | +     | +     | +|
| Хранение сообщений на диске            | +                               | +     | -     |+|
| Высокая скорость работы                | + (Кроме очень больших объемов) | +     | +     |-|
| Поддержка различных форматов сообщений | +                               | +     | +     |-|
| Разделение прав доступа к потокам      | +                               | +     | +     | +|
| Простота эксплуатации                  | +                               | -     | +     | +|

>Если речь идет не о сильно нагруженном сервисе (например интернет-магазине не сильно большого размера и если очередность доставки сообщений не критична) - наиболее подходящим выбором может стать RabbitMQ - прост в эксплуатации, надежен, но при больших нагрузках проседает производительность.
>
>
>Если важна очередность доставки сообщений - лучший выбор Apache Kafka, к тому же производительный. 


## Задача 3: API Gateway * (необязательная)

### Есть три сервиса:

**minio**
- Хранит загруженные файлы в бакете images
- S3 протокол

**uploader**
- Принимает файл, если он картинка сжимает и загружает его в minio
- POST /v1/upload

**security**
- Регистрация пользователя POST /v1/user
- Получение информации о пользователе GET /v1/user
- Логин пользователя POST /v1/token
- Проверка токена GET /v1/token/validation

### Необходимо воспользоваться любым балансировщиком и сделать API Gateway:

**POST /v1/register**
- Анонимный доступ.
- Запрос направляется в сервис security POST /v1/user

**POST /v1/token**
- Анонимный доступ.
- Запрос направляется в сервис security POST /v1/token

**GET /v1/user**
- Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/
- Запрос направляется в сервис security GET /v1/user

**POST /v1/upload**
- Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/
- Запрос направляется в сервис uploader POST /v1/upload

**GET /v1/user/{image}**
- Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/
- Запрос направляется в сервис minio  GET /images/{image}

### Ожидаемый результат

Результатом выполнения задачи должен быть docker compose файл запустив который можно локально выполнить следующие команды с успешным результатом.
Предполагается что для реализации API Gateway будет написан конфиг для NGinx или другого балансировщика нагрузки который будет запущен как сервис через docker-compose и будет обеспечивать балансировку и проверку аутентификации входящих запросов.
Авторизаци
curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' http://localhost/token

**Загрузка файла**

curl -X POST -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' -H 'Content-Type: octet/stream' --data-binary @yourfilename.jpg http://localhost/upload

**Получение файла**
curl -X GET http://localhost/images/4e6df220-295e-4231-82bc-45e4b1484430.jpg

---

#### [Дополнительные материалы: как запускать, как тестировать, как проверить](https://github.com/netology-code/devkub-homeworks/tree/main/11-microservices-02-principles)
