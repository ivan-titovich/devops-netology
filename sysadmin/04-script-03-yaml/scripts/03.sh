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