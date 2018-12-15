# ORY Ecosystem on Kubernetes

An (experimental) collection of Kubernetes configuration files to install Hydra, Keto and Oathkeeper.

## Installation

Let's start with defining working directory.

```
$ HYDRA_K8S_DIR=$(pwd)
```

### PostgreSQL

```
$ cd postgres
$ kubectl create -f configmap.yaml
$ kubectl create -f persistent-volume.yaml
$ kubectl create -f deployment.yaml
$ kubectl create -f service.yaml
$ cd $HYDRA_K8S_DIR
```

### Migrations

#### Hydra

```
$ cd hydra-migrate
$ sh ./generate_secret.sh
$ kubectl create -f configmap.yaml
$ kubectl create -f secret.yaml
$ kubectl create -f job.yaml
$ cd $HYDRA_K8S_DIR
```

#### Keto
```
$ cd keto-migrate
$ kubectl create -f configmap.yaml
$ kubectl create -f job.yaml
$ cd $HYDRA_K8S_DIR
```

#### Oathkeeper
```
$ cd oathkeeper-migrate
$ kubectl create -f configmap.yaml
$ kubectl create -f job.yaml
$ cd $HYDRA_K8S_DIR
```

### Hydra
```
$ cd hydra
$ kubectl create -f configmap.yaml
$ kubectl create -f deployment.yaml
$ kubectl create -f service.yaml
$ cd $HYDRA_K8S_DIR
```
