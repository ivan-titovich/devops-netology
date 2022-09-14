
# Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

---

## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

> https://hub.docker.com/u/titovichia
> 

## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- Высоконагруженное монолитное java веб-приложение;
> Так как приложение монолдитное и высоконагруженное - на мой взгляд лучше подойдет физический сервер - исключаются потери производительности в связи с использованием гипервизора вирутальной машины. 
- Nodejs веб-приложение;
> Подходит использование Docker контейнеров, т.к. это веб-приложение.
- Мобильное приложение c версиями для Android и iOS;
> Виртуальная машина, т.к. в докере нет GUI.
- Шина данных на базе Apache Kafka;
> При хранении не критичных к потерям данных - можно использовать docker. Для продуктивной среды лучше использовать виртуальные машины.
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
>  Elasticsearch лучше вынести на виртуальную машину для отказоустойчивости, а logstash и  kibana можно вынести в docker или тоже на виртуальных машинах. 
- Мониторинг-стек на базе Prometheus и Grafana;
> Можно развернуть на Docker-е, что повысит скорость развертывания и удобства масштабирования. 
- MongoDB, как основное хранилище данных для java-приложения;
> Т.к. о высокой нагрузке не указано - лучше подойдет виртуальная машина с репликацией. Докер для хранения данных не подходит. 
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.
> Можно реализовать в Докере.

## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.


Centos
```bash

 lokli@lokli-VM  ~/docker-test/ex3/centos  docker run -d -v "/home/lokli/docker-test/ex3/data:/data" centos tail -f /dev/null
c795e0d8268967b8bcad078dc7a32396b35ca7850e65de7e853ff536cd73412c
 lokli@lokli-VM  ~/docker-test/ex3/centos  docker ps
CONTAINER ID   IMAGE     COMMAND               CREATED         STATUS         PORTS     NAMES
c795e0d82689   centos    "tail -f /dev/null"   6 seconds ago   Up 3 seconds             distracted_bassi
lokli@lokli-VM  ~/docker-test/ex3/centos  docker exec -it c795e0d82689 start-ubuntu.sh
[root@c795e0d82689 /]# ls
bin  data  dev	etc  home  lib	lib64  lost+found  media  mnt  opt  proc  root	run  sbin  srv	sys  tmp  usr  var
[root@c795e0d82689 /]# cd data
[root@c795e0d82689 data]# ls
123  431  from_centos
[root@c795e0d82689 data]# touch centos_detached
[root@c795e0d82689 data]# ls
123  431  centos_detached  from_centos
[root@c795e0d82689 data]# ls
123  431  centos_detached  from_centos	from_debian
[root@c795e0d82689 data]# 

```


Debian
```bash
 lokli@lokli-VM  ~/docker-test/ex3/data  docker run -d -v "/home/lokli/docker-test/ex3/data:/data" debian tail -f /dev/null

Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
1339eaac5b67: Pull complete 
Digest: sha256:859ea45db307402ee024b153c7a63ad4888eb4751921abbef68679fc73c4c739
Status: Downloaded newer image for debian:latest
9201fd18b75cd956e54f9e984e2147441d15d7aad0a0b73cb572655238acf935
 lokli@lokli-VM  ~/docker-test/ex3/data  docker ps
CONTAINER ID   IMAGE     COMMAND               CREATED          STATUS          PORTS     NAMES
9201fd18b75c   debian    "tail -f /dev/null"   15 seconds ago   Up 10 seconds             xenodochial_kilby
c795e0d82689   centos    "tail -f /dev/null"   2 minutes ago    Up 2 minutes              distracted_bassi
 lokli@lokli-VM  ~/docker-test/ex3/data  docker exec -it 9201fd18b75c start-ubuntu.sh
root@9201fd18b75c:/# cd data
root@9201fd18b75c:/data# ls
123  431  centos_detached  from_centos
root@9201fd18b75c:/data# touch from_debian
root@9201fd18b75c:/data# ls
123  431  centos_detached  from_centos	from_debian
root@9201fd18b75c:/data# 

```


## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

> https://hub.docker.com/u/titovichia

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---