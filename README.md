# ORY Ecosystem on Kubernetes

An (experimental) collection of Kubernetes configuration files to install Hydra, Keto and Oathkeeper.

## Installation

Let's start with defining working directory.

```
$ HYDRA_K8S_DIR=$(pwd)
```

### PostgreSQL

```
$ cd $HYDRA_K8S_DIR/postgres
$ kubectl create -f configmap.yaml
$ kubectl create -f persistent-volume.yaml
$ kubectl create -f deployment.yaml
$ kubectl create -f service.yaml
```

### Migrations

#### Hydra

```
$ cd $HYDRA_K8S_DIR/hydra-migrate
$ sh ./generate_secret.sh
$ kubectl create -f configmap.yaml
$ kubectl create -f secret.yaml
$ kubectl create -f job.yaml
```

#### Keto
```
$ cd $HYDRA_K8S_DIR/keto-migrate
$ kubectl create -f configmap.yaml
$ kubectl create -f job.yaml
```

#### Oathkeeper
```
$ cd $HYDRA_K8S_DIR/oathkeeper-migrate
$ kubectl create -f configmap.yaml
$ kubectl create -f job.yaml
```

### Hydra
```
$ cd $HYDRA_K8S_DIR/hydra
$ kubectl create -f configmap.yaml
$ kubectl create -f deployment.yaml
$ kubectl create -f service.yaml
```

### Keto
```
$ cd $HYDRA_K8S_DIR/keto
$ kubectl create -f configmap.yaml
$ kubectl create -f deployment.yaml
$ kubectl create -f service.yaml
```

### Oathkeeper API
```
$ cd $HYDRA_K8S_DIR/oathkeeper-api
$ kubectl create -f configmap.yaml
$ kubectl create -f deployment.yaml
$ kubectl create -f service.yaml
```

### Oathkeeper Proxy
```
$ cd $HYDRA_K8S_DIR/oathkeeper-proxy
$ kubectl create -f configmap.yaml
$ kubectl create -f deployment.yaml
$ kubectl create -f service.yaml
```
