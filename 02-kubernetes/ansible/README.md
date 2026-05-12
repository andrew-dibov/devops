```bash
ansible-playbook -i inventory/terraform.yml playbooks/kubernetes-stage-0*
```




```bash
export KUBECONFIG=~/.kube/config:$(pwd)/playbooks/admin.conf

kubectl config get-contexts
kubectl config use-context kubernetes-admin@kubernetes
```
