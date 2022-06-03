### Как сдавать задания

Вы уже изучили блок «Системы управления версиями», и начиная с этого занятия все ваши работы будут приниматься ссылками на .md-файлы, размещённые в вашем публичном репозитории.

Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-03-yaml/README.md). Заполните недостающие части документа решением задач (заменяйте `???`, ОСТАЛЬНОЕ В ШАБЛОНЕ НЕ ТРОГАЙТЕ чтобы не сломать форматирование текста, подсветку синтаксиса и прочее, иначе можно отправиться на доработку) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желани.

# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
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

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
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
      with open('services.json', 'w') as f:
        json.dump(servers, f, sort_keys=True, indent=2)
      with open('services.yaml', 'w') as file:
        yaml.dump(servers, file)

    else :
      stop = 1
      print(f"[ERROR] <{k}> IP mismatch: <{old_ip}> <{v}>")
      servers[k] = v
      with open('services.json', 'w') as f:
        json.dump(servers, f, sort_keys=True, indent=2)
      with open('services.yaml', 'w') as file:
        yaml.dump(servers, file)

```

### Вывод скрипта при запуске при тестировании:
```
<google.com> - <142.250.74.46>
<drive.google.com> - <64.233.163.194>
<mail.google.com> - <142.250.74.37>
<google.com> - <142.250.74.46>
<drive.google.com> - <64.233.163.194>
<mail.google.com> - <142.250.74.37>
<google.com> - <142.250.74.46>
<drive.google.com> - <64.233.163.194>
<mail.google.com> - <142.250.74.37>
<google.com> - <142.250.74.46>
<drive.google.com> - <64.233.163.194>
<mail.google.com> - <142.250.74.37>
<google.com> - <142.250.74.46>
<drive.google.com> - <64.233.163.194>
<mail.google.com> - <142.250.74.37>
<google.com> - <142.250.74.46>
<drive.google.com> - <64.233.163.194>
<mail.google.com> - <142.250.74.37>
<google.com> - <142.250.74.46>
<drive.google.com> - <64.233.163.194>
<mail.google.com> - <142.250.74.37>
<google.com> - <142.250.74.46>
<drive.google.com> - <64.233.163.194>
<mail.google.com> - <142.250.74.37>
<google.com> - <142.250.74.46>
<drive.google.com> - <64.233.163.194>
<mail.google.com> - <142.250.74.37>
<google.com> - <142.250.74.46>
<drive.google.com> - <64.233.163.194>
[ERROR] <mail.google.com> IP mismatch: <64.233.163.194> <142.250.74.37>

```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{
  "drive.google.com": "64.233.163.194",
  "google.com": "142.250.74.46",
  "mail.google.com": "142.250.74.37"
}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
drive.google.com: 64.233.163.194
google.com: 142.250.74.46
mail.google.com: 142.250.74.37
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

### Ваш скрипт:
```python
#!/usr/bin/env python3
import os
import sys
import time
import socket
import re
import json
import yaml

regex_json = ".json$"
regex_yaml = '.(.yml)|(.yaml)$'
regex_json_ident =  '^{'
regex_yaml_ident =  '^(?!{)'
jf = None
yf = None

if len(sys.argv) > 1:
  input_filename = sys.argv[1]
  if re.search( regex_json, input_filename) :
    filename_w_e = re.sub(regex_json, '', input_filename)
    try :
      with open(input_filename) as json_file:
        json_data = json.load(json_file)
        with open(sys.argv[1]) as file:
          for line in file:
            if re.match( regex_json_ident, line) :
              jf = True
              with open(filename_w_e + '.yaml', 'w') as file:
                yaml.dump(json_data, file)
        print(json.dumps(json_data, indent=2))
    except json.decoder.JSONDecodeError as error:
      print("[JSON validation ERROR] " + str(error))

  elif re.search( regex_yaml, input_filename) :
    filename_w_e = re.sub(regex_yaml, '', input_filename)
    try:
      with open(input_filename) as yaml_file:
        yaml_data = yaml.safe_load(yaml_file)
        with open(sys.argv[1]) as file:
          for line in file:
            if re.match( regex_yaml_ident, line) :
              yf = True
              with open(filename_w_e + '.json', 'w') as file:
                json.dump(yaml_data, file)
        print(yaml.dump(yaml_data, indent=2))
    except yaml.parser.ParserError as error:
      print("[YAML validation ERROR] " + str(error))
  else :
    print("Error: this is not json or yaml file!")
    sys.exit()
```

### Пример работы скрипта:
```
 $: ./03.sh services1.json
{
  "drive.google.com": "64.233.165.194",
  "google.com": "108.177.14.102",
  "mail.google.com": "64.233.161.19"
}
 $: ./03.sh services2.yaml
[YAML validation ERROR] while parsing a block mapping
  in "services2.yaml", line 1, column 1
expected <block end>, but found '-'
  in "services2.yaml", line 4, column 1
 $: ./03.sh services1.yaml
drive.google.com: 64.233.165.194
google.com: 108.177.14.102
mail.google.com: 64.233.161.19
$: ./03.sh services3.json
[JSON validation ERROR] Expecting ',' delimiter: line 2 column 29 (char 30)

```
['services'](/scripts/services.json)

