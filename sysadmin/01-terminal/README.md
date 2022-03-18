## Домашняя работа к занятию "3.1. Работа в терминале, лекция 1"

1. Установлено
2. Установлено
3. Т.к. хостовая система на windows 10  - установлен Windows Termianl
4. Изменен.
```
cat .\Vagrantfile
Vagrant.configure("2") do |config|
       config.vm.box = "bento/ubuntu-20.04"
end
```
```
vagrant status
Current machine states:

default                   running (virtualbox)

The VM is running. To stop this VM, you can run `vagrant halt` to
shut it down forcefully, or you can run `vagrant suspend` to simply
suspend the virtual machine. In either case, to restart it again,
simply run `vagrant up`.
```
5. Конфигурация виртуально машины по умолчанию.
``` 
Оперативная память: 1024 МБ
Процессоры: 2
```
6. Изменить параметры вирутальной машины можно прописав в Vagrantfile (Первые две и последняя строка относятся к конфигурации Vagrant, а не конфигурации вирутальной машины): 
```
 Vagrant.configure("2") do |config|
 	config.vm.box = "bento/ubuntu-20.04"
	config.vm.provider "virtualbox" do |v|
	  v.name = "devops-netology"
	  v.memory = 2048
	  v.cpus = 3
	end
 end
```
7. Сделано.
8. Команда: HISTFILESIZE. Описано на 620 строке мануала.

    Директива ignoreboth равносильна применению 2х директив:
 
        a) ignorespace - запрет записи в историю строк, начинающихся с пробела.
        b) ignoredups -запрет записи в историю строк, дублирующих предыдущую строку в истории.
9. Описываются варианты применения {} в разделе Parameter Expansion на странице 842. 
Еще фигурными скобками оборзначаются списки (list, на странице 205).
10. Например: ```touch filename-{000001..100000}.txt``` - создаст в текущей папке 100000 файлов.
Команда ```touch filename-{000001..300000}.txt``` завершится ошибкой: ```Argument list too long``` - превышение количество команд в 1 строке. 
Посмотреть данный параметр можно командой: 
```ARG_MAX limit```

11. Описание со строки 1340. Конструкция проверяет существует ли папка ( флаг -d ) `````/tmp````` по указанному пути.
12. Копируем в созданную папку файл bash
```
cp /bin/bash /tmp/new_path_directory/bash
# Изменяем переменную PATH
sudo vim /etc/environment
# на. Новую переменную нужно определить сначала, чтобы при выводе type -a bash она была сверху
PATH="/tmp/new_path_directory:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
```
14. 
