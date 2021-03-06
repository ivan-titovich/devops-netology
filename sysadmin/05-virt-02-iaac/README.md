# Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---

## Задача 1

- Опишите своими словами основные преимущества применения на практике IaaC паттернов.
> Однородность получаемых сред (зависимости и пр.), повторяемость (при запуске каждый раз результат будет одинаков, отсутствует "человеческий фактор" в подготовке окружения), ранее обнаружение ошибок, скорость развертывания сред.
- Какой из принципов IaaC является основополагающим?
> Идемпотентность - получаемый результат исполнения операции идентичен предыдущем и последующим.

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
> Не требует установки агентов - использует существующую SSH-инфраструктуру.
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?
> На мой взгляд - pull, т.к. хост сам запрашивает конфигурацию (как минимум он в рабочем состоянии и у него есть доступ к серверу). Push команды могут не доходить до адресата с бОльшей вероятностью (недоступность хоста).

## Задача 3

Установить на личный компьютер:

- VirtualBox
``` 
Oracle VM VirtualBox VM Selector v6.1.32_Ubuntu
(C) 2005-2022 Oracle Corporation
All rights reserved.

No special options.

If you are looking for --startvm and related options, you need to use VirtualBoxVM.
```
- Vagrant
```
Vagrant 2.2.6
```
- Ansible
```
ansible 2.9.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/lokli/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Mar 15 2022, 12:22:08) [GCC 9.4.0]

```

*Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.*

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

- Создать виртуальную машину.
- Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
```
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@server1:~$
```
