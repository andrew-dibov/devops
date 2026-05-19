```bash
ansible-playbook -i inventory/terraform.yml playbooks/kubernetes-0*
ansible-playbook -i inventory/terraform.yml playbooks/kubernetes-helm.yml

kubectl port-forward -n monitoring svc/kube-prometheus-stack-grafana 8080:80
```
