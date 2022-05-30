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