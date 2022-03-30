## Домашняя работа к занятию "3.4. Операционные системы, лекция 2"

1. Копируем node_exporter в sbin: ```sudo cp node_exporter /usr/sbin/ ```
Создаем файл юнит node_exporter.service следующего содержания: 

```
[Unit]
Description=node_exporter

[Service]
ExecStart=/usr/sbin/node_exporter

[Install]
WantedBy=multi-user.target
```
Копируем юнит в systemd: ``` sudo cp node_exporter.service /etc/systemd/system/node_exporter.service ```
Теперь меняем сервис можно посмотреть в systemctl: ```systemctl -l status node_explorer```
Меняем статус на enable: ```systemctl enable node_explorer```
Можно управлять сервисом командами start и stop, после перезагрузки сервис стартует:
```
vagrant@vagrant:~$ systemctl -l status node_exporter
● node_exporter.service - node_exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2022-03-30 17:53:26 UTC; 10min ago
   Main PID: 1105 (node_exporter)
      Tasks: 5 (limit: 1071)
     Memory: 2.5M
     CGroup: /system.slice/node_exporter.service
             └─1105 /usr/sbin/node_exporter

Mar 30 17:53:26 vagrant node_exporter[1105]: ts=2022-03-30T17:53:26.267Z caller=node_exporter.go:115 level=info collector=thermal_zone
Mar 30 17:53:26 vagrant node_exporter[1105]: ts=2022-03-30T17:53:26.267Z caller=node_exporter.go:115 level=info collector=time
Mar 30 17:53:26 vagrant node_exporter[1105]: ts=2022-03-30T17:53:26.267Z caller=node_exporter.go:115 level=info collector=timex
Mar 30 17:53:26 vagrant node_exporter[1105]: ts=2022-03-30T17:53:26.267Z caller=node_exporter.go:115 level=info collector=udp_queues
Mar 30 17:53:26 vagrant node_exporter[1105]: ts=2022-03-30T17:53:26.267Z caller=node_exporter.go:115 level=info collector=uname
Mar 30 17:53:26 vagrant node_exporter[1105]: ts=2022-03-30T17:53:26.268Z caller=node_exporter.go:115 level=info collector=vmstat
Mar 30 17:53:26 vagrant node_exporter[1105]: ts=2022-03-30T17:53:26.268Z caller=node_exporter.go:115 level=info collector=xfs
Mar 30 17:53:26 vagrant node_exporter[1105]: ts=2022-03-30T17:53:26.268Z caller=node_exporter.go:115 level=info collector=zfs
Mar 30 17:53:26 vagrant node_exporter[1105]: ts=2022-03-30T17:53:26.268Z caller=node_exporter.go:199 level=info msg="Listening on" address=:9100
Mar 30 17:53:26 vagrant node_exporter[1105]: ts=2022-03-30T17:53:26.268Z caller=tls_config.go:195 level=info msg="TLS is disabled." http2=false

```