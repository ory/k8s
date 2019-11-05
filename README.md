# Kubernetes Helm Charts for ORY

[![CircleCI](https://circleci.com/gh/ory/k8s.svg?style=shield)](https://circleci.com/gh/ory/k8s)

This repository contains helm charts for Kubernetes. All charts are in incubation phase and use is at your own risk.

Please go to [k8s.ory.sh/helm](https://k8s.ory.sh/helm/) for a list of helm charts and their configuration options.

## Development

You can test and develop charts locally using [Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).

To test a chart locally without applying it to kubernetes, do:

```sh
$ helm install --debug --dry-run .
```

```sh
$ name=<name>
$ helm install --name $name .
$ helm upgrade $name .
```

### Ingress

If you wish to test ingress, run:

```bash
$ minikube addons enable ingress
```

Next you need to set up `/etc/hosts` to route traffic from domains - in this example for ORY Oathkeeper:

- `api.oathkeeper.localhost`
- `proxy.oathkeeper.localhost`

to the ingress IP. You can find the ingress IP using:

```bash
$ kubectl get ingress
NAME                           HOSTS                        ADDRESS        PORTS     AGE
kilted-ibex-oathkeeper-api     api.oathkeeper.localhost     192.168.64.3   80        1d
kilted-ibex-oathkeeper-proxy   proxy.oathkeeper.localhost   192.168.64.3   80        1d
```

Then, append the following entries to your host file (`/etc/hosts`):

```bash
192.168.64.3    api.oathkeeper.localhost
192.168.64.3    proxy.oathkeeper.localhost
```

### Testing

To run helm test, to:

```sh
$ helm lint .
$ helm install .
$ helm test --cleanup <name>
```

### Remove all releases

To remove **all releases (only in test environments)**, do:

```sh
$ helm del $(helm ls --all --short) --purge
```
