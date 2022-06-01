#!/usr/bin/env python3

# flags:
# -b - name of new branch
# -c - text for commit message
# -prc - pull request commit. Without it didnt work.
# example
#./05.sh -b "branch_name" -c "Commit message." -prc "Pull request commit message."


import os
import sys
import time
import socket

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
  print(bash_command_branch)
  result_create_branch = os.popen(bash_command_branch + " 2>&1").read()
  for result_cb in result_create_branch.split('\n'):
    if result_cb.find("fatal") != -1 :
      print("[FATAL ERROR]: Wrong name for branch or branch already exists. Or something else FATAL. ")
      sys.exit()
    else :
      bash_command_commit = "git commit -a -m \"" + arg_commit + "\""
      print(bash_command_commit)
      result_create_commit= os.popen(bash_command_commit + " 2>&1").read()
      for result_commit in result_create_commit.split('\n'):
        if result_commit.find("fatal") != -1 :
          print("[FATAL ERROR]: in commit. ")
          sys.exit()
        else :
          bash_command_push = "git push --set-upstream github \"" + arg_branch + "\""
          print(bash_command_push)
          result_push = os.popen(bash_command_push + " 2>&1").read()
          for result_p in result_push.split('\n'):
            if result_p.find("fatal") != -1 :
              print("[FATAL ERROR]")
              sys.exit()



bash_command_pr = "gh pr create --title \"Pull request from script\" --body \"" + arg_pr_commit + "\""

result_os = os.popen(bash_command_pr).read()
for result in result_os.split('\n'):
  print(result)

#git switch -c new_dev
#git commit -a -m "new commit message"
#git push --set-upstream github new_dev
