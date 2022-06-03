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


#with open('services.json', 'w') as f:
#  json.dump(servers, f, sort_keys=True, indent=2)
#with open('services.yaml', 'w') as file:
#  yaml.dump(servers, file)




