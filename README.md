# HomeLab

![MACOS](https://img.shields.io/badge/MacOS-f0f0f0?logo=apple&logoColor=black&style=for-the-badge)
![UBUNTU](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=Ubuntu&logoColor=white)

Specifications: Apple Mac Mini M1 2020

- 8 CPU - 8GPU
- 8GB RAM - 512 GB SSD
- OS: macOS Monterey

All infrastructure is hosted on Ubuntu Server 24.04 LTS within a Multipass virtual machine.

## Quick Links

- [Cloudflare Dashboard](https://dash.cloudflare.com/dd1a431d1dc8a74c5a2083262e2668b2/home)
- [K3s Quick-Start Guide](https://docs.k3s.io/quick-start)
- [ArgoCD Getting Started](https://argo-cd.readthedocs.io/en/stable/getting_started/)
- [Vault on Kubernetes deployment guide](https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-raft-deployment-guide)

### Others

- [K9s Installation](https://k9scli.io/topics/install/)
- [Installing Helm](https://helm.sh/docs/intro/install/)

### ArgoCD Redis Error: ImagePullBackOff

```shell
kubectl describe pod <pod-name> -n <namespace>
kubectl logs -n <pod-name>

# force Deployment to recreate
kubectl delete pod <pod-name> -n <namespace> --force --grace-period=0
```
