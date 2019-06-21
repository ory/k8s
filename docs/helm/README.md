# ORY Helm Charts

Add this repository using:

```bash
$ helm repo add ory https://k8s.ory.sh/helm/charts
$ helm repo update
```

## ORY Hydra Helm Chart

### Installation

This chart supports a demo flag which, if set, sets up a demo environment. No further configuration is needed for this.
Be aware that the demo environment is *highly insecure* and must not be used for anything other than testing:

```bash
$ helm install --set demo=true ory/hydra
```

To install ORY Hydra, the following values must be set
([documentation](https://github.com/ory/hydra/blob/master/docs/config.yaml)):

* `hydra.config.dsn`
* `hydra.config.urls.self.issuer`
* `hydra.config.urls.login`
* `hydra.config.urls.consent`
* `hydra.config.secrets.system`

If you wish to install ORY Hydra with an in-memory database, a cryptographically strong secret, a Login and Consent
provider located at `https://my-idp/` run:

```bash
$ helm install \
    --set hydra.config.secrets.system=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | base64 | head -c 32) \
    --set hydra.config.dsn=memory \
    --set hydra.config.urls.self.issuer=https://my-hydra/ \
    --set hydra.config.login=https://my-idp/login \
    --set hydra.config.consent=https://my-idp/consent \
    ory/hydra
```

You can optionally also set the cookie secrets:

```bash
$ helm install \
    ...
    hydra.config.secrets.cookie=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | base64 | head -c 32) \
    ...
    ory/hydra
```

#### With SQL Database

To run ORY Hydra against a SQL database, set the connection string. For example:

```bash
$ helm install \
    ...
    --set dsn=postgres://foo:bar@baz:1234/db \
    ory/hydra
```

This chart does not require MySQL, PostgreSQL, or CockroachDB as dependencies because we strongly encourage
you not to run a database in Kubernetes but instead recommend to rely on a managed SQL database such as Google
Cloud SQL or AWS Aurora.

#### With Google Cloud SQL

To connect to Google Cloud SQL, you could use
the [`gcloud-sqlproxy`](https://github.com/rimusz/charts/tree/master/stable/gcloud-sqlproxy) chart:

```bash
$ helm upgrade pg-sqlproxy rimusz/gcloud-sqlproxy --namespace sqlproxy \
    --set serviceAccountKey="$(cat service-account.json | base64 | tr -d '\n')" \
    ...
```

When bringing up ORY Hydra, set the host to `pg-sqlproxy-gcloud-sqlproxy` as documented
[here](https://github.com/rimusz/charts/tree/master/stable/gcloud-sqlproxy#installing-the-chart):

```bash
$ helm install \
    ...
    --set dsn=postgres://foo:bar@pg-sqlproxy-gcloud-sqlproxy:5432/db \
    ory/hydra
```

### Configuration

You can pass your [ORY Hydra configuration file](https://github.com/ory/hydra/blob/master/docs/config.yaml)
by creating a yaml file with key `hydra.config`

```yaml
# hydra-config.yaml

oathkeeper:
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

## ORY Oathkeeper Helm Chart

The ORY Oathkeeper Helm Chart helps you deploy ORY Oathkeeper on Kubernetes using Helm.

### Installation

Installing ORY Oathkeeper using Helm with

```bash
$ helm install ory/oathkeeper
```

which sets up a very basic configuration with no access rules and no enabled authenticators, authorizers, or
credentials issuers.

This Helm Chart supports a demo mode which deploys access rules for urls

- `http://<oathkeeper-reverse-proxy-host>/authenticator/noop/authorizer/allow/mutator/noop`
- `http://<oathkeeper-reverse-proxy-host>//authenticator/anonymous/authorizer/allow/mutator/header`

that point to [httpbin.org](https://httpbin.org). To install ORY Oathkeeper in demo-mode, run:

```bash
$ helm install --set demo=true ory/oathkeeper
```

Be aware that this mode uses JSON Web Keys and other secrets that are publicly accessible via GitHub.
These secrets are publicly known and should never be used anywhere. **Do not use demo-mode for anything
other than experimenting**.

### Configuration

You can pass your [ORY Oathkeeper configuration file](https://github.com/ory/oathkeeper/blob/master/docs/config.yaml)
by creating a yaml file with key `oathkeeper.config`

```yaml
# oathkeeper-config.yaml

oathkeeper:
  config:
    # e.g.:
    authenticators:
      noop:
        enabled: true
   # ...
```

and passing that as a value override to helm:

```bash
$ helm install -f ./path/to/oathkeeper-config.yaml ory/oathkeeper
```

Values such as the proxy / api port will be automatically propagated to the service and ingress definitions.
The following table lists the configurable parameters of the ORY Oathkeeper chart and their default values.

For a detailed list of configuration items

#### JSON Web Key Set for Mutator `id_token`

The `id_token` mutator requires a secret JSON Web Key Set. This helm chart supports loading the JSON Web Key Set
from disk and deploying it as a Kubernetes Secret:

```bash
$ helm install \
    --set-file oathkeeper.mutatorIdTokenJWKs=./path/to/jwks.json \
    ory/oathkeeper
```

Please note that any configuration values set for `oathkeeper.config.mutator.id_token.jwks_url` using e.g.
a configuration file will be overwritten by this setting.

#### Access Rules

Instead of fetching access rules from remote locations, you can set your access rules directly with `--set-file`:

```bash
$ helm install \
    --set-file oathkeeper.accessRules=./path/to/access-rules.json \
    ory/oathkeeper
```

Please note that any configuration values set for `oathkeeper.config.access_rules.repositories` using e.g.
a configuration file will be overwritten by this setting.
