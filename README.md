# DevOps

Комплекс взаимосвязанных проектов, демонстрирующий полный цикл создания облачной инфраструктуры с нуля до развертывания Kubernetes, настройки CI/CD и GitOps.

## Проекты

| # | Проект | Назначение |
| :-: | :-- | :-- |
| 1 | **[Bootstrap](https://github.com/andrew-dibov/devops-bootstrap)** | Создание сервисного аккаунта Terraform, бакета для удаленного хранения состояния, реестра контейнеров, хранилища секретов и автоматическая миграция бэкенда |
| 2 | **[Network](https://github.com/andrew-dibov/devops-network)** | Создание виртуальной сети с публичными и приватными подсетями, NAT-шлюза с таблицей маршрутизации, бастион-хоста и соответствующей ему группы безопасности |
| 3 | **[Kubernetes](https://github.com/andrew-dibov/devops-kubernetes)** | Развертывание high availability Kubernetes кластера из четырех хостов в разных подсетях и зонах доступности, деплой Ingress NGINX, Prometheus Stack и Atlantis |
| 4 | **[Application](https://github.com/andrew-dibov/devops-application)** | Автоматическая сборка и отправка в реестр контейнеров Flask-приложения с реализацией CI/CD-пайплайнов на GitHub Actions |
| 5 | **[Manifests](https://github.com/andrew-dibov/devops-manifests)** | Использование GitHub Actions для применения Kubernetes-манифестов : Deployment, Service, ServiceMonitor, Ingress |

## Технологии

- **Infrastructure as Code, IaC** : Terraform, Yandex Cloud
- **Automation & Scripting** : Bash, Ansible
- **Containerization** : Docker
- **Orchestration** : Kubernetes, Flannel
- **CI/CD** : GitHub Actions
- **Observability** : Prometheus, Grafana, Alertmanager, Flask Exporter
- **GitOps** : Atlantis

## Развертывание

Проекты развертываются последовательно, потому что каждый следующий этап является надстройкой над предыдущим. Подробное описание каждого проекта и способ его развертывания находятся в `README.md` репозиториев. Как правило, развертывание выполняется одной командой :

```bash
sudo chmod +x bash/* && ./bash/init.sh
```
