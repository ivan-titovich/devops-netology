#!/usr/bin/env python3
import os
import time
import socket

drive = socket.gethostbyname('drive.google.com')
mail = socket.gethostbyname('mail.google.com')
google = socket.gethostbyname('google.com')

while 1 == 1 :
  print(socket.gethostbyname('drive.google.com'))

  time.sleep(1)
  print(mail)
  time.sleep(1)
  print(google)
  time.sleep(1)