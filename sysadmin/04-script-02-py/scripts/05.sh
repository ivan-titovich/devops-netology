#!/usr/bin/env python3
import os
import sys
import time
import socket
bash_command1 = ["gh pr create --title \"The bug is fixed\" --body \"Everything works again\""]
#path = bash_command[0].replace('cd ', '')
if len(sys.argv) > 1 :
  for arg in sys.argv:
#    print(sys.argv.index(arg)+1)
#    print(arg)
    if arg == "--title":
      arg_title = sys.argv[sys.argv.index(arg)+1]
    elif arg == "--body":
      arg_body = sys.argv[sys.argv.index(arg)+1]
#    elif arg == "--title" || arg == "--body" :
#      print("Wrong arguments! Must be, for example, something like this: -- title \"title here\" --body \"body here\"")
else :
  print("[ERROR] No arguments.")

bash_command = "gh pr create --title \""+arg_title+"\" --body \""+arg_body+"\""

print(arg_title)
print(arg_body)
print(bash_command)