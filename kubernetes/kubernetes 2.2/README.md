# Домашнее задание к занятию "Хранение в K8s. Часть 2"

### Цель задания

В тестовой среде Kubernetes необходимо создать PV и продемострировать запись и хранение файлов.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S)
2. Установленный локальный kubectl
3. Редактор YAML-файлов с подключенным github-репозиторием

------

### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция](https://microk8s.io/docs/nfs) по установке NFS в MicroK8S
2. [Описание](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) Persistent Volumes
3. [Описание](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) динамического провижининга
4. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool

------

### Задание 1. Создать Deployment приложения, использующего локальный PV, созданный вручную

1. Создать Deployment приложения состоящего из контейнеров busybox и multitool.
> [Deployment.config](config/2-2-1-deploy.yaml)
2. Создать PV и PVC для подключения папки на локальной ноде, которая будет использована в поде.
> [PersiistentVolume.config](config/2-2-1-pv.yaml)
>
> [PersiistentVolumeClaim.config](config/2-2-1-pvc.yaml)
3. Продемонстрировать, что multitool может читать файл, в который busybox пишет каждые 5 секунд в общей директории.
> [Состояние системы: pv, pvc, pods](src/2-2-1-3-pv-pvc-pod-status.png)
> 
> [screenshot multitool reading file](src/2-2-1-3-scr--mooltitool-reading-file.png)
>
4. Продемонстрировать, что файл сохранился на локальном диске ноды, а также что произойдет с файлом после удаления пода и deployment'а. Почему?
> Файл на локальном диске располагается по пути /tmp/vol1/ , называется busylog.txt 
> 
> Просмотр файла можно выполнить командой `tail -f /tmp/vol1/busylog.txt `
> 
> [Результат выполнения команды](src/2-2-1-4-tail-file.png)
>
> После удаления ресурсов (pod, pv, pvc) файл на дисковой системе по прежнему пути останется. 
> 
> [Файл после удаления ресурсов](src/2-2-1-4-file-after-removing.png)
> 
> Файлы остаются после удаления ресурсов потому что по сути при использовании PersistentVolume и PersistentVolumeClaim "диск монтируется", а не создается, поэтому после удаления по сути происходит "размонтирование". 
> 
> В обласных хранилищих при указании `persistentVolumeReclaimPolicy: Delete` данные будут удаляться после удаления ресурсов, но данное "поведение" - результат настройки облачных провайдеров.


5. Предоставить манифесты, а также скриншоты и/или вывод необходимых команд.
> Summary:  
>
> [Deployment.config](config/2-2-1-deploy.yaml)
> 
> [PersiistentVolume.config](config/2-2-1-pv.yaml)
>
> [PersiistentVolumeClaim.config](config/2-2-1-pvc.yaml)
> 
> [Состояние системы: pv, pvc, pods](src/2-2-1-3-pv-pvc-pod-status.png)
> 
> [screenshot multitool reading file](src/2-2-1-3-scr--mooltitool-reading-file.png)
> 
> [Результат выполнения команды](src/2-2-1-4-tail-file.png)
> 
> [Файл после удаления ресурсов](src/2-2-1-4-file-after-removing.png)
------

### Задание 2. Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV

1. Включить и настроить NFS-сервер на microK8S.
>Done.
2. Создать Deployment приложения состоящего из multitool и подключить к нему PV, созданный автоматически на сервере NFS
> [deployment multitool config](config/2-2-2-multitool.yaml)
>
> [StorageClass config](config/2-2-2-sc.yaml)
> 
> [PersistentVolumeClaim config](config/2-2-2-pvc-nfs.yaml)
> 
> [screenshot](src/2-2-2-2-sys.png)
> 
3. Продемонстрировать возможность чтения и записи файла изнутри пода.
>Из пода зашел и создал файл, записал в него. Прочитал.
>
> Параллельно зашел на диск, в папку, созданную автоматически, увидел файл и смог его прочитать. 
> 
> [Скриншот подтверждения написанного.](src/2-2-2-3-read-write.png)
> 
4. Предоставить манифесты, а также скриншоты и/или вывод необходимых команд.
> Summary: 
> 
> [deployment multitool config](config/2-2-2-multitool.yaml)
>
> [StorageClass config](config/2-2-2-sc.yaml)
> 
> [PersistentVolumeClaim config](config/2-2-2-pvc-nfs.yaml)
> 
> [screenshot](src/2-2-2-2-sys.png)
> 
> [Скриншот.](src/2-2-2-3-read-write.png)
> 

------
