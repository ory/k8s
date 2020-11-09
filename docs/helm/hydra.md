# ORY Hydra Helm Chart

The ORY Hydra Helm Chart helps you deploy ORY Hydra on Kubernetes using Helm.

## Installation

To install ORY Hydra, the following values must be set
([documentation](https://github.com/ory/hydra/blob/master/docs/config.yaml)):

* `hydra.config.dsn`
* `hydra.config.urls.self.issuer`
* `hydra.config.urls.login`
* `hydra.config.urls.consent`
* `hydra.config.secrets.system`

> **NOTE:** If no `hydra.config.secrets.system` secrets is supplied and `hydra.existingSecret` is empty, a secret is generated automatically. The generated secret is cryptographically secure, and 32 signs long.

If you wish to install ORY Hydra with an in-memory database, a cryptographically strong secret, a Login and Consent
provider located at `https://my-idp/` run:

```bash
$ helm install \
    --set 'hydra.config.secrets.system=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | base64 | head -c 32)' \
    --set 'hydra.config.dsn=memory' \
    --set 'hydra.config.urls.self.issuer=https://my-hydra/' \
    --set 'hydra.config.urls.login=https://my-idp/login' \
    --set 'hydra.config.urls.consent=https://my-idp/consent' \
    ory/hydra
```

You can optionally also set the cookie secrets:

```bash
$ helm install \
    ...
    --set 'hydra.config.secrets.cookie=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | base64 | head -c 32)' \
    ...
    ory/hydra
```

Alternatively, you can use an existing [Kubernetes Secret](https://kubernetes.io/docs/concepts/configuration/secret/) instead of letting the Helm Chart create one for you:

```bash

$ kubectl create secret generic my-secure-secret --from-literal=dsn=postgres://foo:bar@baz:1234/db \
    --from-literal=secretsCookie=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | base64 | head -c 32) \
    --from-literal=secretsSystem=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | base64 | head -c 32)

$ helm install \
    ...
    --set 'hydra.existingSecret=my-secure-secret' \
    ...
    ory/hydra
```

### With SQL Database

To run ORY Hydra against a SQL database, set the connection string. For example:

```bash
$ helm install \
    ...
    --set 'dsn=postgres://foo:bar@baz:1234/db' \
    ory/hydra
```

This chart does not require MySQL, PostgreSQL, or CockroachDB as dependencies because we strongly encourage
you not to run a database in Kubernetes but instead recommend to rely on a managed SQL database such as Google
Cloud SQL or AWS Aurora.

### With Google Cloud SQL

To connect to Google Cloud SQL, you could use
the [`gcloud-sqlproxy`](https://github.com/rimusz/charts/tree/master/stable/gcloud-sqlproxy) chart:

```bash
$ helm upgrade pg-sqlproxy rimusz/gcloud-sqlproxy --namespace sqlproxy \
    --set 'serviceAccountKey="$(cat service-account.json | base64 | tr -d '\n')"' \
    ...
```

When bringing up ORY Hydra, set the host to `pg-sqlproxy-gcloud-sqlproxy` as documented
[here](https://github.com/rimusz/charts/tree/master/stable/gcloud-sqlproxy#installing-the-chart):

```bash
$ helm install \
    ...
    --set 'dsn=postgres://foo:bar@pg-sqlproxy-gcloud-sqlproxy:5432/db' \
    ory/hydra
```

## Configuration

You can pass your [ORY Hydra configuration file](https://github.com/ory/hydra/blob/master/docs/config.yaml)
by creating a yaml file with key `hydra.config`

```yaml
# hydra-config.yaml

hydra:
  config:
    # e.g.:
    ttl:
      access_token: 1h
   # ...
```

and passing that as a value override to helm:

```bash
$ helm install -f ./path/to/hydra-config.yaml ory/hydra
```

Additionally, the following extra settings are available:

- `autoMigrate` (bool): If enabled, an `initContainer` running `hydra migrate sql` will be created.
- `dangerousForceHttp` (bool): If enabled, sets the `--dangerous-force-http` flag on `hydra serve all`.
- `dangerousAllowInsecureRedirectUrls` (string[]): Sets the `--dangerous-allow-insecure-redirect-urls` flag on `hydra serve all`.

## Examples
 
### Exemplary Login and Consent App

This tutorial assumes that you're running Minikube locally. If you're not
running Kubernetes locally, please adjust the hostnames accordingly.

Let's install the Login and Consent App first

```bash
$ helm install \
    --set 'hydraAdminUrl=http://hydra-example-admin:4445/' \
    --set 'hydraPublicUrl=http://public.hydra.localhost/' \
    --set 'ingress.enabled=true' \
    --name hydra-example-idp \
    ory/example-idp
```

with hostnames

- `http://hydra-example-admin:4445/` corresponding to deployment name `--name hydra-example` (see next code sample)
    with suffix `-admin` which is the hostname of the ORY Hydra Admin API Service.
- `https://public.hydra.localhost/` which is the default value for `ingress.public.hosts[0].host` from `ory/hydra` (
    see next code sample).

Next install ORY Hydra. Please note that SSL is disabled using `--set hydra.dangerousForceHttp=true`
which should never be done when working outside of `localhost` and only
for testing and demonstration purposes. Install the ORY Hydra Helm Chart

```bash
$ helm install \
    --set 'hydra.config.secrets.system=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | base64 | head -c 32)' \
    --set 'hydra.config.dsn=memory' \
    --set 'hydra.config.urls.self.issuer=http://public.hydra.localhost/' \
    --set 'hydra.config.urls.login=http://example-idp.localhost/login' \
    --set 'hydra.config.urls.consent=http://example-idp.localhost/consent' \
    --set 'hydra.config.urls.logout=http://example-idp.localhost/logout' \
    --set 'ingress.public.enabled=true' \
    --set 'ingress.admin.enabled=true' \
    --set 'hydra.dangerousForceHttp=true' \
    --name hydra-example \
    ory/hydra
```

with hostnames

- `example-idp.localhost` which is the default for `ingress.hosts[0].host` from `ory/example-idp`.

If running Minikube, enable the Ingress addon

```bash
$ minikube addons enable ingress
```

and get the IP addresses for the Ingress controllers with (you may need to wait a bit)

```bash
$ kubectl get ing
NAME                   HOSTS                    ADDRESS        PORTS   AGE
hydra-example-idp      example-idp.localhost    192.168.64.3   80      3m47s
hydra-example-public   public.hydra.localhost   192.168.64.3   80      35s
hydra-example-admin    admin.hydra.localhost    192.168.64.3   80      35s
```

or alternatively with

```bash
$ minikube ip192.168.64.3 

```

next route the hostnames to the IP Address from above by editing, for example `/etc/hosts`. The result should look something
like:

```bash
$ cat /etc/hosts
127.0.0.1	    localhost
255.255.255.255	broadcasthost
::1             localhost
# ...
192.168.64.3    example-idp.localhost
192.168.64.3    admin.hydra.localhost
192.168.64.3    public.hydra.localhost
```

Please note that file contents will be different on every operating system and network. Now, confirm that everything
is working:

```bash
$ curl http://example-idp.localhost/
http://public.hydra.localhost/.well-known/openid-configuration
``` 

Next, you can follow the [5 Minute Tutorial](https://www.ory.sh/docs/hydra/5min-tutorial),
skipping the `git` and `docker-compose` set up sections. Assuming
you have ORY Hydra installed locally, you can rewrite commands
from, for example,

```bash
$ docker-compose -f quickstart.yml exec hydra \
      hydra clients create \
      --endpoint http://127.0.0.1:4445/ \
      --id my-client \
      --secret secret \
      -g client_credentials
      
$ docker-compose -f quickstart.yml exec hydra \
      hydra token client \
      --endpoint http://127.0.0.1:4444/ \
      --client-id my-client \
      --client-secret secret
```

to

```bash
$ hydra clients create \
    --endpoint http://admin.hydra.localhost/ \
    --id my-client \
    --secret secret \
    -g client_credentials
    
$ hydra token client \
    --endpoint http://public.hydra.localhost/ \
    --client-id my-client \
    --client-secret secret
```

### Hydra Maester
This chart includes a helper chart in the form of [Hydra Maester](https://github.com/ory/k8s/blob/master/docs/helm/hydra-maester.md), a Kubernetes controller, which manages OAuth2 clients using the `oauth2clients.hydra.ory.sh` custom resource. By default, this component is enabled and installed together with Hydra. However, it can be disabled by setting the proper flag:

```bash
$ helm install \
    --set 'maester.enabled=false' \
    ory/hydra
```

#### Using fullnameOverride

If you use need to override the name of the hydra resources such as the deployment or services, the traditional `fullnameOverride` value is available.

If you use it and deploy maester as part of hydra, make sure you also set `maester.hydraFullnameOverride` with the same value, so that the admin service name used by maester is properly computed with the new value.

Should you forget, helm will fail and remind you to.
