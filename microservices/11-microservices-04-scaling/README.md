
# Домашнее задание к занятию "Микросервисы: масштабирование"

Вы работаете в крупной компанию, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps специалисту необходимо выдвинуть предложение по организации инфраструктуры, для разработки и эксплуатации.

## Задача 1: Кластеризация

Предложите решение для обеспечения развертывания, запуска и управления приложениями.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- Поддержка контейнеров;
- Обеспечивать обнаружение сервисов и маршрутизацию запросов;
- Обеспечивать возможность горизонтального масштабирования;
- Обеспечивать возможность автоматического масштабирования;
- Обеспечивать явное разделение ресурсов доступных извне и внутри системы;
- Обеспечивать возможность конфигурировать приложения с помощью переменных среды, в том числе с возможностью безопасного хранения чувствительных данных таких как пароли, ключи доступа, ключи шифрования и т.п.

Обоснуйте свой выбор.

### Ответ

| | Kubernetes | Docker Swarm                                                           | Apache Mesos (Maraphon и Apache Aurora ) | Nomad                                                                                   | OpenShift                                                                                       |
|---|------------|------------------------------------------------------------------------|------------------------------------------|-----------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------|
|Поддержка контейнеров;| +          | +                                                                      | +                                        | [+ driver](https://developer.hashicorp.com/nomad/docs/drivers/docker)                   | +                                                                                               | 
| Обеспечивать обнаружение сервисов и маршрутизацию запросов;| +          | +                                                                      | +                                        | - С помощью внешних инструментов, например consul                                       | [+](https://docs.openshift.com/container-platform/3.11/architecture/networking/networking.html) | 
|Обеспечивать возможность горизонтального масштабирования; | +          | [+](https://docs.docker.com/engine/swarm/swarm-tutorial/scale-service/) | +                                        | [+](https://developer.hashicorp.com/nomad/tools/autoscaling)                            | +                                                                                               |
|Обеспечивать возможность автоматического масштабирования; | +          | -                                                                      | +                                        | [+ только в enterprise версии](https://developer.hashicorp.com/nomad/tools/autoscaling) | [+](https://docs.openshift.com/container-platform/4.9/nodes/pods/nodes-pods-autoscaling.html)   |
|Обеспечивать явное разделение ресурсов доступных извне и внутри системы; | +          | [+](https://docs.docker.com/engine/swarm/configs/)                     | +                                        | +                                                                                       | +                                                                                               | 
|Обеспечивать возможность конфигурировать приложения с помощью переменных среды, в том числе с возможностью безопасного хранения чувствительных данных таких как пароли, ключи доступа, ключи шифрования и т.п. | +         | [+](https://docs.docker.com/engine/swarm/secrets/)                     | +                                                                                          | - С помощью внешних инструментов, например vault                                               | [+](https://docs.openshift.com/container-platform/3.11/dev_guide/secrets.html)                  |

Kubernetes удовлетворяет всем требованиям. Хоть и не прост в освоении, но с точки зрения перспектив, документированности и распространнености - лидер на рынке оркестраторов. Я бы предложил его для использования в проекте. 

## Задача 2: Распределенный кэш * (необязательная)

Разработчикам вашей компании понадобился распределенный кэш для организации хранения временной информации по сессиям пользователей.
Вам необходимо построить Redis Cluster состоящий из трех шард с тремя репликами.

### Схема:

![11-04-01](https://user-images.githubusercontent.com/1122523/114282923-9b16f900-9a4f-11eb-80aa-61ed09725760.png)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---