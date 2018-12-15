# ORY Ecosystem on Kubernetes

An (experimental) collection of Kubernetes configuration files to install Hydra, Keto and Oathkeeper.

## Installation

### PostgreSQL
```
kubectl create -f postgres/configmap.yaml
kubectl create -f postgres/persistent-volume.yaml
kubectl create -f postgres/deployment.yaml
kubectl create -f postgres/service.yaml
```

### Migrations

#### Hydra
```
sh ./hydra-migrate/generate_secret.sh
kubectl create -f hydra-migrate/configmap.yaml
kubectl create -f hydra-migrate/secret.yaml
kubectl create -f hydra-migrate/job.yaml
```

#### Keto
```
kubectl create -f keto-migrate/configmap.yaml
kubectl create -f keto-migrate/job.yaml
```

#### Oathkeeper
```
kubectl create -f oathkeeper-migrate/configmap.yaml
kubectl create -f oathkeeper-migrate/job.yaml
```

### Hydra
```
kubectl create -f hydra/configmap.yaml
kubectl create -f hydra/deployment.yaml
kubectl create -f hydra/service.yaml
```
