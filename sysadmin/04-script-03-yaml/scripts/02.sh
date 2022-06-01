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
