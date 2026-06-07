# DevOps инфраструктура

Комплекс из пяти взаимосвязанных проектов, демонитрирующий полный цикл создания облачной инфраструктуры, развертывания Kubernetes, настройки CI/CD и реализации GitOps.

## Состав

| Проект | Назначение | Ссылка |
| :-- | :-- | :-- |
| **Bootstrap** | Создание сервисного аккаунта, бакета для State, Container Registry, Lockbox и миграция бэкенда Terraform | [devops-bootstrap](https://github.com/andrew-dibov/devops-bootstrap) |
| **Network** | VPC с публичными/приватными подсетями, NAT-шлюз, бастион и группы безопасности | [devops-network](https://github.com/andrew-dibov/devops-network) |
| **Kubernetes** | HA-кластер, установка Ingress NGINX, Prometheus Stack и Atlantis | [devops-kubernetes](https://github.com/andrew-dibov/devops-kubernetes) |
| **Application** | Flask-приложение с метриками, CI/CD на GitHub Actions | [devops-application](https://github.com/andrew-dibov/devops-application) |
| **Manifests** | GitOps манифесты Deployment, Service, Ingress, ServiceMonitor, применение через GitHub Actions | [devops-manifests](https://github.com/andrew-dibov/devops-manifests) |

## Зависимости и порядок развертывания

1. **Bootstrap** : создает базовую инфраструктуру
2. **Network** : опирается на Bootstrap и разворачивает сеть с бастионом
3. **Kubernetes** : использует сеть для развертывания кластера
4. **Application** : выполняет CI/CD в кластере
5. **Manifests** : полагается на образ приложения и кластер для GitOps

## Технологический стек

- **IaC** : Terraform, Yandex Cloud
- **Config Management** : Ansible, Bash
- **Коннейнеризация** : Docker, Container Registry
- **Оркестрация** : Kubernetes, Flannel
- **CI/CD** : GitHub Actions
- **Observability** : Prometheus, Grafana, Alertmanager
- **GitOps** : Atlantis

## Запуск

Каждый проект содержит `README.md` с подробной инструкцией по развертыванию. Как правило, развертывание происходит командой, запускающей Bash-скрипт.