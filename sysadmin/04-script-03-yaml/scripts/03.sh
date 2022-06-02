#!/usr/bin/env python3
import os
import sys
import time
import socket
import re
import json
import yaml

regex_json = ".json$"
regex_yaml = '.(yml)|(yaml)$'
regex_json_ident =  '^{'


if len(sys.argv) > 1:
  input_filename = sys.argv[1]
  print(input_filename)
  if re.search( regex_json, input_filename) :
    print('json file is: ' + input_filename )
    with open(input_filename) as json_file:
      json_data = json.load(json_file)
      print(type(json_data))
      print(json.dumps(json_data, indent=2))
#      if re.findall( regex_json_ident, json_data[0]) :
#        print('This is json-file')
  elif re.search( regex_yaml, input_filename) :
    print('yaml file is: ' + input_filename )
    with open(input_filename) as yaml_file:
      yaml_data = yaml.safe_load(yaml_file)
      print(type(yaml_data))
      print(yaml.dump(yaml_data, indent=2))
  else :
    print("Error: this is not json or yaml file!")
    sys.exit()



#bash_command = ["cd ~/devops-netology/sysadmin", "git status"]
#
#path = bash_command[0].replace('cd ', '')
#
#if len(sys.argv) > 1 :
#  argument = sys.argv[1]
#  if os.path.exists(argument+'.git'):
#    bash_command[0] = 'cd '+argument
#    result_os = os.popen(' && '.join(bash_command)).read()
#    for result in result_os.split('\n'):
#      if result.find('изменено') != -1:
#        prepare_result = result.replace('\tизменено:      ', '')
#        print(f"{path}/{prepare_result}")
#  else:
#    print('Репозитория гит в папке не существует')
#else:
#  print('Аргумент не задан - ищем по пути: ', path)
#  result_os = os.popen(' && '.join(bash_command)).read()
#  for result in result_os.split('\n'):
#    if result.find('изменено') != -1:
#      prepare_result = result.replace('\tизменено:      ', '')
#      print(f"{path}/{prepare_result}")