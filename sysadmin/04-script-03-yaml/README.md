# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"

## Обязательные задания

1. Мы выгрузили JSON, который получили через API запрос к нашему сервису:
	```
   {
      "info":"Sample JSON output from our service\t",
      "elements":[
         {
            "name":"first",
            "type":"server",
            "ip":"7.1.7.5"
         },
         {
            "name":"second",
            "type":"proxy",
            "ip":"71.78.22.43"
         }
      ]
   }
	```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

2. В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: { "имя сервиса" : "его IP"}. Формат записи YAML по одному сервису: - имя сервиса: его IP. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.
```python
#!/usr/bin/env python3
import os
import sys
import time
import socket
import json
import yaml

stop = 0

servers = {'drive.google.com': 0, 'mail.google.com': 0, 'google.com': 0}
servers['drive.google.com'] = socket.gethostbyname('drive.google.com')
servers['mail.google.com'] = socket.gethostbyname('mail.google.com')
servers['google.com'] = socket.gethostbyname('google.com')


while stop != 1 :
  for k,v in servers.items():
    time.sleep(0.2)
    if  socket.gethostbyname(k) == str(v) :
      old_ip = v
      print(f"<{k}> - <{v}>")
      servers[k] = v
    else :
      stop = 1
      print(f"[ERROR] <{k}> IP mismatch: <{old_ip}> <{v}>")
      servers[k] = v

with open('services.json', 'w') as f:
  json.dump(servers, f, sort_keys=True, indent=2)
with open('services.yaml', 'w') as file:
  yaml.dump(servers, file)
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

---

### Как сдавать задания

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---