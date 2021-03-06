# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательные задания

1. Есть скрипт:
    ```python
    #!/usr/bin/env python3
    a = 1
    b = '2'
    c = a + b
    ```
    * Какое значение будет присвоено переменной c?

    Интерпретатор выдал ошибку о невозможность сложить int и str.

    * Как получить для переменной c значение 12?

    Изменить тип перепенной а на строковый ` a = str(a)` и выполнить сложение (нахождение переменной `с`)

    * Как получить для переменной c значение 3?

    Изменть тип переменных `a` и `b`: `a = int(a)`, `b = int(b)` и выполнить сложение. 


2 . Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/devops-netology/sysadmin", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
path = bash_command[0].replace('cd ', '')
for result in result_os.split('\n'):
  if result.find('изменено') != -1:
    prepare_result = result.replace('\tизменено:      ', '')
    print(f"{path}/{prepare_result}")
```

3. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.
```python
#!/usr/bin/env python3
import os
import sys

argument = None

bash_command = ["cd ~/devops-netology/sysadmin", "git status"]

path = bash_command[0].replace('cd ', '')

if len(sys.argv) > 1 :
  argument = sys.argv[1]
  if os.path.exists(argument+'.git'):
    bash_command[0] = 'cd '+argument
    result_os = os.popen(' && '.join(bash_command)).read()
    for result in result_os.split('\n'):
      if result.find('изменено') != -1:
        prepare_result = result.replace('\tизменено:      ', '')
        print(f"{path}/{prepare_result}")
  else:
    print('Репозитория гит в папке не существует')
else:
  print('Аргумент не задан - ищем по пути: ', path)
  result_os = os.popen(' && '.join(bash_command)).read()
  for result in result_os.split('\n'):
    if result.find('изменено') != -1:
      prepare_result = result.replace('\tизменено:      ', '')
      print(f"{path}/{prepare_result}")
```
4. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: drive.google.com, mail.google.com, google.com.
```python
#!/usr/bin/env python3
import os
import time
import socket

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
    else :
      stop = 1
      print(f"[ERROR] <{k}> IP mismatch: <{old_ip}> <{v}>")
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

5.Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз переносить архив с нашими изменениями с сервера на наш локальный компьютер, формировать новую ветку, коммитить в неё изменения, создавать pull request (PR) и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. Мы хотим максимально автоматизировать всю цепочку действий. Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым). При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. С директорией локального репозитория можно делать всё, что угодно. Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 
```python
#!/usr/bin/env python3

# flags:
# -b - name of new branch
# -c - text for commit message
# -prc - pull request commit. Without this argument, the script does not work.
# example
#./05.sh -b "branch_name" -c "Commit message." -prc "Pull request commit message."

import os
import sys
import time


arg_branch = None
arg_commit = None

if len(sys.argv) > 1 :
  for arg in sys.argv:
    if arg == "-prc":
      if (sys.argv.index(arg)+1) >= len(sys.argv):
        print("[ERROR] Must be commit message.")
        sys.exit()
      else:
        arg_pr_commit = sys.argv[sys.argv.index(arg)+1]
    elif arg == "-b":
      arg_branch = sys.argv[sys.argv.index(arg)+1]
    elif arg == "-c":
      arg_commit = sys.argv[sys.argv.index(arg)+1]

else :
  print("[ERROR] No arguments.")
  sys.exit()

if arg_branch != None :
  bash_command_branch = "git checkout -b \"" + arg_branch + "\""

  result_create_branch = os.popen(bash_command_branch + " 2>&1").read()
  for result_cb in result_create_branch.split('\n'):
    if result_cb.find("fatal") != -1 :
      print("[FATAL ERROR]: Wrong name for branch or branch already exists. Or something else FATAL. ")
      sys.exit()
    else :
      bash_command_commit = "git commit -a -m \"" + arg_commit + "\""

      result_create_commit= os.popen(bash_command_commit + " 2>&1").read()
      for result_commit in result_create_commit.split('\n'):
        if result_commit.find("fatal") != -1 :
          print("[FATAL ERROR]: in commit. ")
          sys.exit()
        else :
          bash_command_push = "git push --set-upstream github \"" + arg_branch + "\""

          result_push = os.popen(bash_command_push + " 2>&1").read()
          for result_p in result_push.split('\n'):
            if result_p.find("fatal") != -1 :
              print("[FATAL ERROR]")
              sys.exit()

bash_command_pr = "gh pr create --title \"Pull request from script\" --body \"" + arg_pr_commit + "\""

result_os = os.popen(bash_command_pr).read()
for result in result_os.split('\n'):
  print(result)
```

---

### Как сдавать задания

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
