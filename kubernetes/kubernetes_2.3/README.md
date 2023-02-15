# Домашнее задание к занятию "Конфигурация приложений"

### Цель задания

В тестовой среде Kubernetes необходимо создать конфигурацию и продемонстрировать работу приложения.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным github-репозиторием.

------

### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/concepts/configuration/secret/) Secret
2. [Описание](https://kubernetes.io/docs/concepts/configuration/configmap/) ConfigMap
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool

------

### Задание 1. Создать Deployment приложения и решить возникшую проблему с помощью ConfigMap. Добавить web-страницу

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.

> 
> [deploymen config (multitool and busybox) with ConfigMap](config/2-3-1-deploy.yaml)
>
> 
2. Решить возникшую проблему с помощью ConfigMap
>Busybox не конфликтует с multitool. Nginx конфликтует с multitool из-за использования одинакового номера порта. Поэтому я сделал deployment, ConfigMap, Service для стэка nginx-mooltitool: 
> 
> [deployment nginx-multitool](config/2-3-1-nginx_multitool.yaml)
> 
> [service nginx-multitool](config/2-3-1-nginx_multitool_svc.yaml)
> 
> [ConfigMap nginx-multitool](config/2-3-1-cm.yaml)
> 
> 

3. Продемонстрировать, что pod стартовал, и оба конейнера работают.
> ![screenshot работающего стэка](src/2-3-1-2-screenshot.png)
> 
4. Сделать простую web-страницу и подключить ее к Nginx с помощью ConfigMap. Подключить Service и показать вывод curl или в браузере.
>  Чтобы не плодить файлы на каждую пару конфигов в монтирующийся volume нужно создать отдельный ConfigMap со страницей: 
> 
> [ConfigMap for page](config/2-3-1-cm_page.yaml)
> 
> И подключить его как volume: 
> 
> [config nginx_multitool](config/2-3-1-nginx_multitool.yaml)
> 
> Сервис не изменится. 
> 
> Скриншот (по аналогии с предыдущим, но страница nginx изменена): 
> 
> ![screenshot](src/2-3-1-4-page_by_volume.png)
> 

5. Предоставить манифесты, а также скриншоты и/или вывод необходимых команд.
>Summary: 
> 
> 
> [deployment nginx-multitool](config/2-3-1-nginx_multitool.yaml)
> 
> [service nginx-multitool](config/2-3-1-nginx_multitool_svc.yaml)
> 
> [ConfigMap nginx-multitool](config/2-3-1-cm.yaml)
> 
> [ConfigMap for page](config/2-3-1-cm_page.yaml)
> 
> [config nginx_multitool](config/2-3-1-nginx_multitool.yaml)
> 
> [screenshot](src/2-3-1-4-page_by_volume.png)

------

### Задание 2. Создать приложение с вашей web-страницей, доступной по HTTPS 

1. Создать Deployment приложения состоящего из nginx.
2. Создать собственную web-страницу и подключить ее как ConfigMap к приложению.
3. Выпустить самоподписной сертификат SSL. Создать Secret для использования данного сертификата.
4. Создать Ingress и необходимый Service, подключить к нему SSL в вид. Продемонстировать доступ к приложению по HTTPS. 
4. Предоставить манифесты, а также скриншоты и/или вывод необходимых команд.

------

### Правила приема работы

1. Домашняя работа оформляется в своем Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, а также скриншоты результатов
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md

------