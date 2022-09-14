# Домашняя работа к занятию "08.01 Введение в Ansible"

## Подготовка к выполнению
1. Установите ansible версии 2.10 или выше.
 ```bash 
ansible --version
ansible [core 2.13.3]
  python version = 3.8.10 (default, Jun 22 2022, 20:18:18) [GCC 9.4.0]
  jinja version = 3.1.2
  libyaml = True
```
2. Создайте свой собственный публичный репозиторий на github с произвольным именем.
3. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
> [Репозиторий Ansible](https://github.com/ivan-titovich/devops-netology/tree/main/ansible)

## Основная часть
1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте какое значение имеет факт `some_fact` для указанного хоста при выполнении playbook'a.
> `some_fact = 12`
``` 
ansible-playbook -i inventory/test.yml site.yml 

...
TASK [Print fact] ****************************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": 12
}
...
```
2. Найдите файл с переменными (group_vars) в котором задаётся найденное в первом пункте значение и поменяйте его на 'all default fact'.
> Значение задано в файле `group_vars/all/examp.yml`. Сделано. 
3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
> local
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
``` 
TASK [Print fact] ****************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}
```
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились следующие значения: для `deb` - 'deb default fact', для `el` - 'el default fact'.
> Сделано. 
6. Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
``` 
TASK [Print fact] ****************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
```
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
> `ansible-vault encrypt ./group_vars/deb/examp.yml `
> 
> `ansible-vault encrypt ./group_vars/el/examp.yml `
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
> `ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass`
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
> Спиок плагинов для подключения: `ansible-doc -t connection -l` 
>
> Подходящий для работы на control node: `ansible-doc -t connection local`
> 
> `  This connection plugin allows ansible to execute tasks on the Ansible 'controller' instead of on a remote host.`
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
``` 
---
  el:
    hosts:
      centos7:
        ansible_connection: local
  deb:
    hosts:
      ubuntu:
        ansible_connection: local
  local:
    hosts:
      localhost:
        ansible_connection: local
```
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
``` 
TASK [Print fact] ****************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "all default fact"
}
```
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
> `ansible-vault decrypt ./group_vars/deb/examp.yml`
> 
> `ansible-vault decrypt ./group_vars/el/examp.yml`
>
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
> ` ansible-vault encrypt_string 'PaSSw0rd' --name 'some_fact'`
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
``` 
TASK [Print fact] ****************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}
```
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот](https://hub.docker.com/r/pycontribs/fedora).
> Сделано: 
``` 

TASK [Gathering Facts] ******************************************************************************
ok: [localhost]
ok: [fedora]
ok: [ub1-ssh]
ok: [centos7]

TASK [Print OS] *************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [fedora] => {
    "msg": "Fedora"
}
ok: [ub1-ssh] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***********************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [fedora] => {
    "msg": "fed default fact"
}
ok: [ub1-ssh] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}

PLAY RECAP ******************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
fedora                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ub1-ssh                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
> [create ubuntu image](https://github.com/ivan-titovich/devops-netology/blob/main/ansible/08-ansible-01-base/docker/create-ubuntu-image.sh)
> 
> [start ubuntu](https://github.com/ivan-titovich/devops-netology/blob/main/ansible/08-ansible-01-base/docker/start-ubuntu.sh)
> 
> [stop ubuntu](https://github.com/ivan-titovich/devops-netology/blob/main/ansible/08-ansible-01-base/docker/stop-ubuntu.sh)
> 
> [create centos image](https://github.com/ivan-titovich/devops-netology/blob/main/ansible/08-ansible-01-base/docker/create-centos-image.sh)
> 
> [start centos](https://github.com/ivan-titovich/devops-netology/blob/main/ansible/08-ansible-01-base/docker/start-centos.sh)
> 
> [stop centos](https://github.com/ivan-titovich/devops-netology/blob/main/ansible/08-ansible-01-base/docker/stop-centos.sh)
> 
> [create fedora image](https://github.com/ivan-titovich/devops-netology/blob/main/ansible/08-ansible-01-base/docker/create-fedora-image.sh)
> 
> [start fedora](https://github.com/ivan-titovich/devops-netology/blob/main/ansible/08-ansible-01-base/docker/start-fedora.sh)
> 
> [stop fedora](https://github.com/ivan-titovich/devops-netology/blob/main/ansible/08-ansible-01-base/docker/stop-fedora.sh)
> 
6. Все изменения должны быть зафиксированы и отправлены в вашей личный репозиторий.
> [Репозиторий](https://github.com/ivan-titovich/devops-netology/tree/main/ansible/08-ansible-01-base)

