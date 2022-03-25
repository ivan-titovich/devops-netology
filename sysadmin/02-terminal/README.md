## Домашняя работа к занятию "3.2. Работа в терминале, лекция 2"

1. ```cd is a shell builtin``` Вероятно из-за того, что данная команда не изменяет никаких данных и не участвует в процессах с вводом/выводом информации.
2. Команда ```grep <some_string> <some_file> | wc -l``` выводит количество найденных вхождений строк в файле.
Аналогичного результата можно добиться ключем "-с" в команде "grep": ```grep <some_string> <some_file> -c```
3. Посмотреть список всех процессов можно командой ps -e:  
```
   vagrant@vagrant:~$ ps -e
   PID TTY          TIME CMD
   1    ?        00:00:12 systemd
   ```
   Процесс с PID - systemd. 
4. ```ls rder > /dev/tty1 2>&1```  
Где:
"rder" - имя несуществующего файла, вызывающее ошибку. 
"> /dev/tty1" - перенаправление вывода в соседний терминал (в моем случае - tty1)
"2>&1" - перенаправление вывода stderr в stdout, иначе не перенаправится вывод ошибки терминала.
5. ```cat <1.txt >from_1.txt.log```
Это ли имелось ввиду в задании?
6. Получится. Например ```echo "hello tty1 > /dev/pts/1``` передаст в tty1 приветствие. 
7. ```bash 5>&1 ``` создаст еще один дескриптор под номером 5 (другим PID) и перенаправлением вывода в stdout.
Если выполнить ```echo netology > /proc/$$/fd/5``` мы получим вывод равносильный команде ```echo netology```.
Почему - описал выше. 
8. Создадим дескриптор 4 ```bash 4>&1```
Команда ```ls -la /tmp 2>&1 >/proc/$$/fd/4 | cat>>file_out.text``` через поток stdout выведет содержимое папки /tmp
Если задать в команде неверный каталог, то ошибка будет записана через дескриптор 4 в файл file_out.txt, в обычный stdout ничего не попадет.
Таким образом в случае ошибки данные будут направелены из stdout на stdin pipe через 4 дескриптор. 
9. Выведет данные окружения текущего процесса.
```
       /proc/[pid]/environ
              This  file  contains  the initial environment that was set when the currently executing program was started via execve(2).  The entries are separated by null bytes ('\0'), and there may be a
              null byte at the end.  Thus, to print out the environment of process 1, you would do:

                  $ cat /proc/1/environ | tr '\000' '\n'

              If, after an execve(2), the process modifies its environment (e.g., by calling functions such as putenv(3) or modifying the environ(7) variable directly), this file will  not  reflect  those
              changes.

              Furthermore, a process may change the memory location that this file refers via prctl(2) operations such as PR_SET_MM_ENV_START.

              Permission to access this file is governed by a ptrace access mode PTRACE_MODE_READ_FSCREDS check; see ptrace(2).
``` 
Аналогичный вывод можно получить командой ```printenv```
10. /proc/[pid]/cmdline - В этом файле хранится командная строка, которой был запущен данный процесс:
```
      /proc/[pid]/cmdline
      This read-only file holds the complete command line for the process, unless the process is a zombie.  In the latter case, there is nothing in this file: that is, a read on this file will re‐
      turn 0 characters.  The command-line arguments appear in this file as a set of strings separated by null bytes ('\0'), with a further null byte after the last string.
```
/proc/[pid]/exe - представляет собой символическую ссылку на исполняемый файл, который инициировал запуск процесса;
```
      /proc/[pid]/exe
      Under  Linux  2.2 and later, this file is a symbolic link containing the actual pathname of the executed command.  This symbolic link can be dereferenced normally; attempting to open it will
      open the executable.  You can even type /proc/[pid]/exe to run another copy of the same executable that is being run by process [pid].  If the pathname has been unlinked, the  symbolic  link
      will contain the string '(deleted)' appended to the original pathname.  In a multithreaded process, the contents of this symbolic link are not available if the main thread has already termi‐
      nated (typically by calling pthread_exit(3)).
      
      Permission to dereference or read (readlink(2)) this symbolic link is governed by a ptrace access mode PTRACE_MODE_READ_FSCREDS check; see ptrace(2).
      
      Under Linux 2.0 and earlier, /proc/[pid]/exe is a pointer to the binary which was executed, and appears as a symbolic link.  A readlink(2) call on this file under Linux 2.0 returns a  string
      in the format:
      
      [device]:inode
      
      For example, [0301]:1502 would be inode 1502 on device major 03 (IDE, MFM, etc. drives) minor 01 (first partition on the first drive).
      
      find(1) with the -inum option can be used to locate the file.

```
11. SSE v 4.2: 
```
sudo cat /proc/cpuinfo | grep -i sse
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni ssse3 cx16 pcid sse4_1 sse4_2 hypervisor lahf_lm invpcid_single pti fsgsbase invpcid md_clear flush_l1d arch_capabilities

```
12. По умолчанию, когда создается сессия ssh для выполнения команды (указывается после адреса подключения, в нашем случае это tty) tty не назначается удаленной сессии (по сути -упрощенный режим для передачи информации, получать вывод в командной строке в данном случае не предполагается, насколько я понял). 

А когда создается соединение - TTY назначается, т.к. это равносильно запуску сессии. 
Поведение "по умолчанию" можно изменить, добавив ключ -t - тогда tty будет назначаться на время выполенения переданной команды. 
13.