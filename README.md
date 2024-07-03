# ArgoCD-Starter
Get your Argo CD deployments up and running quickly with this toolkit. It includes necessary EKS Terraform configurations and CI/CD scripts, perfect for enhancing your DevOps process

# install ArgoCD in k8s
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# access ArgoCD UI
kubectl get svc -n argocd
kubectl port-forward svc/argocd-server -n argocd 8080:443
The API server can then be accessed using https://localhost:8080

# login with admin user and below token (as in documentation):
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode && echo

# you can change and delete init password
For security reasons, it is recommended to change the initial admin password immediately after your first login. You can change the password using the ArgoCD CLI or through the UI under user settings.
# Deleting the Initial Admin Secret
Optionally, for enhanced security, delete the initial admin secret after changing the password:

