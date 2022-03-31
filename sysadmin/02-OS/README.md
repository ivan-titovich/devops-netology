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
3. Для CPU : 
```
node_cpu_seconds_total{cpu="0",mode="idle"} 177753.21 #время простоя
node_cpu_seconds_total{cpu="0",mode="iowait"} 26.49 #время ожидания I/O операций;
node_cpu_seconds_total{cpu="0",mode="irq"} 0 # время обработки аппаратных прерываний;
node_cpu_seconds_total{cpu="0",mode="nice"} 0.05 #время выполнения процессов с приоритетом nice, которые выполняются в режиме пользователя;
node_cpu_seconds_total{cpu="0",mode="softirq"} 0.06 # время обработки программных прерываний;
node_cpu_seconds_total{cpu="0",mode="steal"} 0 # время, которое используют другие операционные системы (при виртуализации);
node_cpu_seconds_total{cpu="0",mode="system"} 30.99 # время выполнения процессов, которые выполняются в режиме ядра (kernel mode)
node_cpu_seconds_total{cpu="0",mode="user"} 10.56 # время выполнения обычных процессов, которые выполняются в режиме пользователя (в user mode, userland);
```
Память: 
```
# HELP node_memory_MemTotal_bytes Memory information field MemTotal_bytes.
# TYPE node_memory_MemTotal_bytes gauge
node_memory_MemTotal_bytes 2.083852288e+09 # total memory 
# HELP node_memory_MemFree_bytes Memory information field MemFree_bytes.
# TYPE node_memory_MemFree_bytes gauge
node_memory_MemFree_bytes 8.90011648e+08 #free memory
# HELP node_memory_MemAvailable_bytes Memory information field MemAvailable_bytes.
# TYPE node_memory_MemAvailable_bytes gauge
node_memory_MemAvailable_bytes 1.710043136e+09 # available memory
```
Диск: 
```

# HELP node_filesystem_free_bytes Filesystem free space in bytes.
# TYPE node_filesystem_free_bytes gauge
node_filesystem_free_bytes{device="/dev/mapper/ubuntu--vg-ubuntu--lv",fstype="ext4",mountpoint="/"} 2.8665040896e+10
node_filesystem_free_bytes{device="/dev/sda2",fstype="ext4",mountpoint="/boot"} 9.12084992e+08
node_filesystem_free_bytes{device="tmpfs",fstype="tmpfs",mountpoint="/run"} 2.0738048e+08
node_filesystem_free_bytes{device="tmpfs",fstype="tmpfs",mountpoint="/run/lock"} 5.24288e+06
node_filesystem_free_bytes{device="tmpfs",fstype="tmpfs",mountpoint="/run/snapd/ns"} 2.0738048e+08
node_filesystem_free_bytes{device="tmpfs",fstype="tmpfs",mountpoint="/run/user/1000"} 2.08384e+08
node_filesystem_free_bytes{device="vagrant",fstype="vboxsf",mountpoint="/vagrant"} 5.50209753088e+11

# HELP node_filesystem_size_bytes Filesystem size in bytes.
# TYPE node_filesystem_size_bytes gauge
node_filesystem_size_bytes{device="/dev/mapper/ubuntu--vg-ubuntu--lv",fstype="ext4",mountpoint="/"} 3.315785728e+10
node_filesystem_size_bytes{device="/dev/sda2",fstype="ext4",mountpoint="/boot"} 1.02330368e+09
node_filesystem_size_bytes{device="tmpfs",fstype="tmpfs",mountpoint="/run"} 2.08388096e+08
node_filesystem_size_bytes{device="tmpfs",fstype="tmpfs",mountpoint="/run/lock"} 5.24288e+06
node_filesystem_size_bytes{device="tmpfs",fstype="tmpfs",mountpoint="/run/snapd/ns"} 2.08388096e+08
node_filesystem_size_bytes{device="tmpfs",fstype="tmpfs",mountpoint="/run/user/1000"} 2.08384e+08
node_filesystem_size_bytes{device="vagrant",fstype="vboxsf",mountpoint="/vagrant"} 1.000202039296e+12

```

Сеть
```
# HELP node_network_device_id device_id value of /sys/class/net/<iface>.
# TYPE node_network_device_id gauge
node_network_device_id{device="eth0"} 0
node_network_device_id{device="lo"} 0

# HELP node_network_info Non-numeric data from /sys/class/net/<iface>, value is always 1.
# TYPE node_network_info gauge
node_network_info{address="00:00:00:00:00:00",broadcast="00:00:00:00:00:00",device="lo",duplex="",ifalias="",operstate="unknown"} 1
node_network_info{address="08:00:27:b1:28:5d",broadcast="ff:ff:ff:ff:ff:ff",device="eth0",duplex="full",ifalias="",operstate="up"} 1

# HELP node_network_mtu_bytes mtu_bytes value of /sys/class/net/<iface>.
# TYPE node_network_mtu_bytes gauge
node_network_mtu_bytes{device="eth0"} 1500
node_network_mtu_bytes{device="lo"} 65536

# HELP node_network_receive_bytes_total Network device statistic receive_bytes.
# TYPE node_network_receive_bytes_total counter
node_network_receive_bytes_total{device="eth0"} 3.9237062e+07
node_network_receive_bytes_total{device="lo"} 258059

# HELP node_network_receive_drop_total Network device statistic receive_drop.
# TYPE node_network_receive_drop_total counter
node_network_receive_drop_total{device="eth0"} 144
node_network_receive_drop_total{device="lo"} 0
# HELP node_network_receive_errs_total Network device statistic receive_errs.
# TYPE node_network_receive_errs_total counter
node_network_receive_errs_total{device="eth0"} 0
node_network_receive_errs_total{device="lo"} 0

# HELP node_network_transmit_bytes_total Network device statistic transmit_bytes.
# TYPE node_network_transmit_bytes_total counter
node_network_transmit_bytes_total{device="eth0"} 1.656581e+06
node_network_transmit_bytes_total{device="lo"} 258059
```
4. Ознакомился. 
5. 

