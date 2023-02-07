# Домашнее задание к занятию "Хранение в K8s. Часть 1"

### Цель задания

В тестовой среде Kubernetes необходимо обеспечить обмен файлами между контейнерам пода и доступ к логам ноды.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S)
2. Установленный локальный kubectl
3. Редактор YAML-файлов с подключенным github-репозиторием



### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция](https://microk8s.io/docs/getting-started) по установке MicroK8S
2. [Описание](https://kubernetes.io/docs/concepts/storage/volumes/) Volumes
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool

------

### Задание 1. Создать Deployment приложения, состоящего из двух контейнеров и обменивающихся данными

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
> [deployment.config](config/2-1-1-deploy.yaml)
>
2. Сделать так, чтобы busybox писал каждые 5 секунд в некий файл в общей директории.
> Команда, исполняющаяся в busybox в бесконечном цикле:`j=0; while true; do echo Container alive $j seconds; j=$((j+5)) && sleep 5;done > /output/busylog.txt`
>
> Чтобы было показательнее - со счетчиком времени жизни контейнера (обновление каждые 5 секунд, по условию.)
3. Обеспечить возможность чтения файла контейнером multitool.
> `kubectl exec deploy-869b5bb5c7-k7sth  -c multitool -- cat /input/busylog.txt`
>
> [screenshot](src/2-1-1-3.png)
4. Продемонстрировать, что multitool может читать файл, который периодоически обновляется.
> `kubectl exec deploy-869b5bb5c7-k7sth -it  -c multitool -- tail -f /input/busylog.txt`
>
> [screenshot](src/2-1-1-4.png)
5. Предоставить манифесты Deployment'а в решении, а также скриншоты или вывод команды п.4
> Summary:
> 
>[deployment.config](config/2-1-1-deploy.yaml)
> 
> [screenshot](src/2-1-1-3.png)
> 
> [screenshot](src/2-1-1-4.png)
------

### Задание 2. Создать DaemonSet приложения, которое может прочитать логи ноды

1. Создать DaemonSet приложения состоящего из multitool.
> [DaemonSet.config](config/2-1-2-ds.yaml)

2. Обеспечить возможность чтения файла `/var/log/syslog` кластера microK8S.
> ` kubectl exec ds-lz7k8 -it  -c multitool -- tail -f /var/log/syslog`
3. Продемонстрировать возможность чтения файла изнутри пода.
> [Screenshot. Сверху вывод лога с материнской системы, в нижней части - вывод из подаа.](src/2-1-2-2.png)
4. Предоставить манифесты Deployment, а также скриншоты или вывод команды п.2
> Summary:
> 
> [DaemonSet.config](config/2-1-2-ds.yaml)
> 
> [Screenshot. Сверху вывод лога с материнской системы, в нижней части - вывод из подаа.](src/2-1-2-2.png)

------
