# Домашнее задание к занятию "09.04 Jenkins"

## Подготовка к выполнению

1. Создать 2 VM: для jenkins-master и jenkins-agent.
2. Установить jenkins при помощи playbook'a.
3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.
> Сделано. 

## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.


[Screenshot with success status freestyle job](src/1.1_success_job.png)


На docker не удалось запустить molecule - ошибки. На podman тестирование успешно. Но чтобы устаносить и запустить podman нужно разрешить запуск sudo без ввода пароля (на тестовом стенде - допустимо, в реальных условиях - необходимо использовать другие методы). 

Но podman сразу не стартует, для устранения ошибки
```
cannot clone: Invalid argument
user namespaces are not enabled in /proc/sys/user/max_user_namespaces
Error: could not get runtime: cannot re-exec process
```
Необходимо ввести команду из под рута: `echo '63907' > /proc/sys/user/max_user_namespaces`

Команды shell для freestyle Job:

``` shell
pip3 install molecule molecule_podman
ansible-galaxy role init vector-role --force
molecule test -s ubuntu_podman
```
2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
[declarative pipeline](src/2.1_dec_pipeline.png)

```groovy
pipeline {
    agent {
        label 'linux'
    }

    stages {
        stage('Checkuot SCM') {
            steps {
                git branch: 'main', credentialsId: 'b8b09eaa-f7fe-4fc0-9f4b-e425da808365', url: 'git@github.com:ivan-titovich/vector-role.git'
            }
        }
        stage('Insatall molecule') {
            steps{
                sh "pip3 install molecule molecule_podman"
            }
        }
        stage('Init role') {
            steps{
                sh "ansible-galaxy role init vector-role --force"
            }
        }
        stage('Molecule test') {
            steps{
                sh "molecule test -s ubuntu_podman"
            }
        }

    }
}

```
3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.
>[Jenkinsfile]()
4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.
> [multibranch pipeline](src/4.1_multibranch_pipeline.png)
5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).

6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True), по умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
```groovy
node("linux"){
    def isProdRun = env.prod_run
    stage("Git checkout"){
        git credentialsId: '1886761a-cf53-417f-8f47-9259c3d1a684', url: 'git@github.com:ivan-titovich/click_vector_light.git'
    }

    if (isProdRun == 'true'){
    stage("Run playbook with -check and --diff"){
        sh 'ansible-playbook site.yml -i inventory/prod.yml --check --diff'
        }
    }
    else{
        stage("Run playbook without -check and --diff")
        sh 'ansible-playbook site.yml -i inventory/prod.yml'
        }
    }

```
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`. Цель: получить собранный стек ELK в Ya.Cloud.
8. Отправить две ссылки на репозитории в ответе: с ролью и Declarative Pipeline и c плейбукой и Scripted Pipeline.

> [Declarative Pipeline](https://github.com/ivan-titovich/vector-role.git)
> 
> [Scripted Pipeline](https://github.com/ivan-titovich/click_vector_light.git)


## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, которые завершились хотя бы раз неуспешно. Добавить скрипт в репозиторий с решеним с названием `AllJobFailure.groovy`.
2. Дополнить Scripted Pipeline таким образом, чтобы он мог сначала запустить через Ya.Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Тем самым, мы должны по нажатию кнопки получить готовую к использованию систему.
