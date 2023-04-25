# Prerequisites 
* Install microk8s
```bash
sudo snap install microk8s --classic
```
* Configure firewall
```bash
sudo ufw allow in on ens4 && sudo ufw allow out on ens4
sudo ufw default allow routed
```
* Enable addons
```bash
microk8s enable dns 
microk8s enable dashboard
microk8s enable storage
microk8s enable ingress
```
# Run project in a Kubernetes 
* Database setup
```bash
git clone https://github.com/it21998/ptyxiakh.git
cd ptyxiakh/k8s/db
mircok8s.kubectl create secret generic pg-user --from-literal=PGUSER=<<your_username>>> --from-literal=PGPASSWORD=<<your_passwd>>
microk8s.kubectl apply -f postgres-pvc.yaml
microk8s.kubectl apply -f postgres-deployment.yaml
microk8s.kubectl apply -f postgres-clip.yaml
```
* Keycloak setup
```bash
cd ptyxiakh/k8s/keycloak
microk8s.kubectl apply -f keycloak_db-pvc.yaml
microk8s.kubectl apply -f key_deploy.yaml
```
* MailHog setup
```bash
cd ptyxiakh/k8s/django
microk8s.kubectl apply -f mailhog.yaml
```
* Edit newkeycloak/.env file to define
```vim
SECRET_KEY=test123
DATABASE_URL=postgres://myprojectuser:password@pg-cluster-ip/test_db
ALLOWED_HOSTS=34.142.43.193
```
* Django setup
```bash
microk8s.kubectl create configmap django-config --from-env-file=newkeycloak/.env
cd ptyxiakh/k8s/django
microk8s.kubectl apply -f django-deployment.yaml
microk8s.kubectl apply -f django-clip.yaml
microk8s.kubectl apply -f django-ingress.yaml
```
# Kong and Konga setup
* Prerequisites
```bash
sudo snap install helm --classic
```
* Kong helm repo
```bash
helm repo add kong https://charts.konghq.com
helm repo update
```
* Konga helm repo
```bash
git clone https://github.com/pantsel/konga.git
cd konga/charts/konga
```
* Edit both values.yaml file to define db and admin(for kong only)
* Kong Installation 
```bash
helm install mykong kong/kong --version="2.7.0" -f values.yaml
```
* Konga Installation 
```bash
helm install konga ./  -f values.yaml
```
# Optional Keycloak Theme
```bash
microk8s.kubectl cp Cyboinsect <<Keycloak_pod_name>>:opt/jboss/keycloak/themes -c keycloak
```
