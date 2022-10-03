# Домашнее задание к занятию "08.05 Тестирование Roles"

## Подготовка к выполнению
1. Установите molecule: `pip3 install "molecule==3.5.2"`
> molecule 3.5.2 using python 3.8 
> 
> ansible:2.13.4
> 
> delegated:3.5.2 from molecule

2. Выполните `docker pull aragast/netology:latest` -  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри
> Сделано.

## Основная часть

Наша основная цель - настроить тестирование наших ролей. Задача: сделать сценарии тестирования для vector. Ожидаемый результат: все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s centos_8` внутри корневой директории clickhouse-role, посмотрите на вывод команды.
2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.
3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.
4. Добавьте несколько assert'ов в verify.yml файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска, etc). Запустите тестирование роли повторно и проверьте, что оно прошло успешно.
5. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

> [vector-role v0.1.0](https://github.com/ivan-titovich/vector-role/tree/0.1.0)

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example)
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo - путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.
6. Пропишите правильную команду в `tox.ini` для того чтобы запускался облегчённый сценарий.
8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Ссылка на репозиторий являются ответами на домашнее задание. Не забудьте указать в ответе теги решений Tox и Molecule заданий.

## Необязательная часть

1. Проделайте схожие манипуляции для создания роли lighthouse.
2. Создайте сценарий внутри любой из своих ролей, который умеет поднимать весь стек при помощи всех ролей.
3. Убедитесь в работоспособности своего стека. Создайте отдельный verify.yml, который будет проверять работоспособность интеграции всех инструментов между ними.
4. Выложите свои roles в репозитории. В ответ приведите ссылки.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---


CREATE DATABASE IF NOT EXISTS nginxlogs

CREATE TABLE nginxlogs.logs (Host IPv4, User String, timestamp DateTime, method String, path String, status String, bytes_out UInt64) ENGINE = Log

SELECT COUNT(*) FROM nginxlogs.logs
 
CREATE TABLE nginxlogs.systemd1 (
PRIORITY UInt16,
SYSLOG_FACILITY UInt16,
SYSLOG_IDENTIFIER String,
_AUDIT_LOGINUID String,
_AUDIT_SESSION String,
_BOOT_ID String,
_CAP_EFFECTIVE String,
_CMDLINE String,
_COMM String,
_EXE String,
_GID String,
_MACHINE_ID String,
_PID String,
_SELINUX_CONTEXT String,
_SOURCE_REALTIME_TIMESTAMP String,
_SYSTEMD_CGROUP String,
_SYSTEMD_OWNER_UID String,
_SYSTEMD_SESSION String,
_SYSTEMD_SLICE String,
_SYSTEMD_UNIT String,
_TRANSPORT String,
_UID String,
__MONOTONIC_TIMESTAMP String,
__REALTIME_TIMESTAMP String,
host String,
message String,
source_type String,
timestamp String) ENGINE = Log


clickhouse-client --query "INSERT INTO nginxlogs.systemd1 FORMAT JSONEachRow
"PRIORITY":"6",
"SYSLOG_FACILITY":"10",
"SYSLOG_IDENTIFIER":"sudo",
"_AUDIT_LOGINUID":"1000",
"_AUDIT_SESSION":"12",
"_BOOT_ID":"53796cbc5f344c4a8280cbade5c1e6b3",
"_CAP_EFFECTIVE":"1fffffffff",
"_CMDLINE":"sudo vector",
"_COMM":"sudo",
"_EXE":"/usr/bin/sudo",
"_GID":"0",
"_MACHINE_ID":"23000007c6cfab77aaffe8fca8e8523a",
"_PID":"14200",
"_SELINUX_CONTEXT":"unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023",
"_SOURCE_REALTIME_TIMESTAMP":"1664827514640558",
"_SYSTEMD_CGROUP":"/user.slice/user-1000.slice/session-12.scope",
"_SYSTEMD_OWNER_UID":"1000",
"_SYSTEMD_SESSION":"12",
"_SYSTEMD_SLICE":"user-1000.slice",
"_SYSTEMD_UNIT":"session-12.scope",
"_TRANSPORT":"syslog","_UID":"0",
"__MONOTONIC_TIMESTAMP":"13568984587",
"__REALTIME_TIMESTAMP":"1664827514640905",
"host":"vector-01.ru-central1.internal",
"message":"pam_unix(sudo:session): session closed for user root",
"source_type":"journald",
"timestamp":"2022-10-03T20:05:14.640558Z"



"PRIORITY":"6","SYSLOG_FACILITY":"10","SYSLOG_IDENTIFIER":"sudo","_AUDIT_LOGINUID":"1000","_AUDIT_SESSION":"12","_BOOT_ID":"53796cbc5f344c4a8280cbade5c1e6b3","_CAP_EFFECTIVE":"1fffffffff","_CMDLINE":"sudo vector","_COMM":"sudo","_EXE":"/usr/bin/sudo","_GID":"0","_MACHINE_ID":"23000007c6cfab77aaffe8fca8e8523a","_PID":"14256","_SELINUX_CONTEXT":"unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023","_SOURCE_REALTIME_TIMESTAMP":"1664828391221207","_SYSTEMD_CGROUP":"/user.slice/user-1000.slice/session-12.scope","_SYSTEMD_OWNER_UID":"1000","_SYSTEMD_SESSION":"12","_SYSTEMD_SLICE":"user-1000.slice","_SYSTEMD_UNIT":"session-12.scope","_TRANSPORT":"syslog","_UID":"0","__MONOTONIC_TIMESTAMP":"14445565238","__REALTIME_TIMESTAMP":"1664828391221556","host":"vector-01.ru-central1.internal","message":"pam_unix(sudo:session): session closed for user root","source_type":"journald","timestamp":"2022-10-03T20:19:51.221207Z"}
{"PRIORITY":"5","SYSLOG_FACILITY":"10","SYSLOG_IDENTIFIER":"sudo","_AUDIT_LOGINUID":"1000","_AUDIT_SESSION":"12","_BOOT_ID":"53796cbc5f344c4a8280cbade5c1e6b3","_CAP_EFFECTIVE":"1fffffffff","_CMDLINE":"sudo vi /etc/vector/vector.toml","_COMM":"sudo","_EXE":"/usr/bin/sudo","_GID":"1000","_MACHINE_ID":"23000007c6cfab77aaffe8fca8e8523a","_PID":"14267","_SELINUX_CONTEXT":"unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023","_SOURCE_REALTIME_TIMESTAMP":"1664828554462243","_SYSTEMD_CGROUP":"/user.slice/user-1000.slice/session-12.scope","_SYSTEMD_OWNER_UID":"1000","_SYSTEMD_SESSION":"12","_SYSTEMD_SLICE":"user-1000.slice","_SYSTEMD_UNIT":"session-12.scope","_TRANSPORT":"syslog","_UID":"0","__MONOTONIC_TIMESTAMP":"14608806258","__REALTIME_TIMESTAMP":"1664828554462576","host":"vector-01.ru-central1.internal","message":"   lokli : TTY=pts/2 ; PWD=/var/log/nginx ; USER=root ; COMMAND=/bin/vi /etc/vector/vector.toml","source_type":"journald","timestamp":"2022-10-03T20:22:34.462243Z"}
{"PRIORITY":"6","SYSLOG_FACILITY":"10","SYSLOG_IDENTIFIER":"sudo","_AUDIT_LOGINUID":"1000","_AUDIT_SESSION":"12","_BOOT_ID":"53796cbc5f344c4a8280cbade5c1e6b3","_CAP_EFFECTIVE":"1fffffffff","_CMDLINE":"sudo vi /etc/vector/vector.toml","_COMM":"sudo","_EXE":"/usr/bin/sudo","_GID":"0","_MACHINE_ID":"23000007c6cfab77aaffe8fca8e8523a","_PID":"14267","_SELINUX_CONTEXT":"unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023","_SOURCE_REALTIME_TIMESTAMP":"1664828554464102","_SYSTEMD_CGROUP":"/user.slice/user-1000.slice/session-12.scope","_SYSTEMD_OWNER_UID":"1000","_SYSTEMD_SESSION":"12","_SYSTEMD_SLICE":"user-1000.slice","_SYSTEMD_UNIT":"session-12.scope","_TRANSPORT":"syslog","_UID":"0","__MONOTONIC_TIMESTAMP":"14608808266","__REALTIME_TIMESTAMP":"1664828554464584","host":"vector-01.ru-central1.internal","message":"pam_unix(sudo:session): session opened for user root by lokli(uid=0)","source_type":"journald","timestamp":"2022-10-03T20:22:34.464102Z"}
{"PRIORITY":"6","SYSLOG_FACILITY":"10","SYSLOG_IDENTIFIER":"sudo","_AUDIT_LOGINUID":"1000","_AUDIT_SESSION":"12","_BOOT_ID":"53796cbc5f344c4a8280cbade5c1e6b3","_CAP_EFFECTIVE":"1fffffffff","_CMDLINE":"sudo vi /etc/vector/vector.toml","_COMM":"sudo","_EXE":"/usr/bin/sudo","_GID":"0","_MACHINE_ID":"23000007c6cfab77aaffe8fca8e8523a","_PID":"14267","_SELINUX_CONTEXT":"unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023","_SOURCE_REALTIME_TIMESTAMP":"1664828569137668","_SYSTEMD_CGROUP":"/user.slice/user-1000.slice/session-12.scope","_SYSTEMD_OWNER_UID":"1000","_SYSTEMD_SESSION":"12","_SYSTEMD_SLICE":"user-1000.slice","_SYSTEMD_UNIT":"session-12.scope","_TRANSPORT":"syslog","_UID":"0","__MONOTONIC_TIMESTAMP":"14623481641","__REALTIME_TIMESTAMP":"1664828569137959","host":"vector-01.ru-central1.internal","message":"pam_unix(sudo:session): session closed for user root","source_type":"journald","timestamp":"2022-10-03T20:22:49.137668Z"}
{"PRIORITY":"5","SYSLOG_FACILITY":"10","SYSLOG_IDENTIFIER":"sudo","_AUDIT_LOGINUID":"1000","_AUDIT_SESSION":"12","_BOOT_ID":"53796cbc5f344c4a8280cbade5c1e6b3","_CAP_EFFECTIVE":"1fffffffff","_CMDLINE":"sudo vector","_COMM":"sudo","_EXE":"/usr/bin/sudo","_GID":"1000","_MACHINE_ID":"23000007c6cfab77aaffe8fca8e8523a","_PID":"14270","_SELINUX_CONTEXT":"unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023","_SOURCE_REALTIME_TIMESTAMP":"1664828571502589","_SYSTEMD_CGROUP":"/user.slice/user-1000.slice/session-12.scope","_SYSTEMD_OWNER_UID":"1000","_SYSTEMD_SESSION":"12","_SYSTEMD_SLICE":"user-1000.slice","_SYSTEMD_UNIT":"session-12.scope","_TRANSPORT":"syslog","_UID":"0","__MONOTONIC_TIMESTAMP":"14625846599","__REALTIME_TIMESTAMP":"1664828571502918","host":"vector-01.ru-central1.internal","message":"   lokli : TTY=pts/2 ; PWD=/var/log/nginx ; USER=root ; COMMAND=/bin/vector","source_type":"journald","timestamp":"2022-10-03T20:22:51.502589Z"}
{"PRIORITY":"6","SYSLOG_FACILITY":"10","SYSLOG_IDENTIFIER":"sudo","_AUDIT_LOGINUID":"1000","_AUDIT_SESSION":"12","_BOOT_ID":"53796cbc5f344c4a8280cbade5c1e6b3","_CAP_EFFECTIVE":"1fffffffff","_CMDLINE":"sudo vector","_COMM":"sudo","_EXE":"/usr/bin/sudo","_GID":"0","_MACHINE_ID":"23000007c6cfab77aaffe8fca8e8523a","_PID":"14270","_SELINUX_CONTEXT":"unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023","_SOURCE_REALTIME_TIMESTAMP":"1664828571504306","_SYSTEMD_CGROUP":"/user.slice/user-1000.slice/session-12.scope","_SYSTEMD_OWNER_UID":"1000","_SYSTEMD_SESSION":"12","_SYSTEMD_SLICE":"user-1000.slice","_SYSTEMD_UNIT":"session-12.scope","_TRANSPORT":"syslog","_UID":"0","__MONOTONIC_TIMESTAMP":"14625848495","__REALTIME_TIMESTAMP":"1664828571504813","host":"vector-01.ru-central1.internal","message":"pam_unix(sudo:session): session opened for user root by lokli(uid=0)","source_type":"journald","timestamp":"2022-10-03T20:22:51.504306Z"}

