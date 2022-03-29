## Домашняя работа к занятию "3.3. Операционные системы, лекция 1"

1. ```chdir("/tmp")```
2. Находится по адресу: /usr/bin/file
```execve("/usr/bin/file", ["file", "/dev/sda"], 0x560b2f792020 /* 27 vars */) = 0```
3.  Если коротко - в дескриптор процесса нужно передать /dev/null, что обнулит его. Подробно листинг ниже. 
```
vagrant@vagrant:~$ echo "hello world" > /tmp/dont_touch
vagrant@vagrant:~$ python3 -c "import time;f=open('/tmp/dont_touch','r');time.sleep(600);"&
[1] 3676
vagrant@vagrant:~$ rm /tmp/dont_touch
vagrant@vagrant:~$ cat /proc/3676/fd/3
hello world
vagrant@vagrant:~$ lsof -p 3664|grep dont_touch
vagrant@vagrant:~$ lsof -p 3676|grep dont_touch
python3 3676 vagrant    3r   REG  253,0       12 1572879 /tmp/dont_touch (deleted)
vagrant@vagrant:~$ cat /proc/3676/fd/3
hello world
vagrant@vagrant:~$ cat /dev/null > /proc/3676/fd/3
vagrant@vagrant:~$ cat /proc/3676/fd/3
vagrant@vagrant:~$ lsof -p 3676 | grep dont_touch
python3 3676 vagrant    3r   REG  253,0        0 1572879 /tmp/dont_touch (deleted)
```
4. Нет, не занимают. 
5. 
```
   PID    COMM               FD ERR PATH
811    vminfo              4   0 /var/run/utmp
640    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
640    dbus-daemon        20   0 /usr/share/dbus-1/system-services
640    dbus-daemon        -1   2 /lib/dbus-1/system-services
640    dbus-daemon        20   0 /var/lib/snapd/dbus-1/system-services/
645    irqbalance          6   0 /proc/interrupts
645    irqbalance          6   0 /proc/stat
645    irqbalance          6   0 /proc/irq/20/smp_affinity
645    irqbalance          6   0 /proc/irq/0/smp_affinity
645    irqbalance          6   0 /proc/irq/1/smp_affinity
645    irqbalance          6   0 /proc/irq/8/smp_affinity
645    irqbalance          6   0 /proc/irq/12/smp_affinity
645    irqbalance          6   0 /proc/irq/14/smp_affinity
645    irqbalance          6   0 /proc/irq/15/smp_affinity
811    vminfo              4   0 /var/run/utmp
640    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
640    dbus-daemon        20   0 /usr/share/dbus-1/system-services
640    dbus-daemon        -1   2 /lib/dbus-1/system-services
640    dbus-daemon        20   0 /var/lib/snapd/dbus-1/system-services/
811    vminfo              4   0 /var/run/utmp
   ```
6. 
```
fstat(1, {st_mode=S_IFREG|0664, st_size=2710, ...}) = 0
uname({sysname="Linux", nodename="vagrant", ...}) = 0
uname({sysname="Linux", nodename="vagrant", ...}) = 0
write(1, "Linux vagrant 5.4.0-91-generic #"..., 106Linux vagrant 5.4.0-91-generic #102-Ubuntu SMP Fri Nov 5 16:31:28 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
) = 106
```
Из man uname(2): Part of the uname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}

7. Двойной амперсанд && используется для последовательного вызова команд, если одна из команд завершится ошибкой - следующие за ней не запустятся. 
Точка с запятой служит для записи нескольких команд в одной строке в независимости от результата обработки команд. 
set -e немедленное прервет команду в случае выхода не "0", дальнейшее выполнение команд не продолжится. Поэтому смысла нет. 
8. 