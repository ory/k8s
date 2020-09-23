# ORY Kratos Helm Chart

The ORY Kratos Helm Chart helps you deploy ORY Kratos on Kubernetes using Helm.

## Installation

To install ORY Kratos, the following values must be set
([documentation](https://www.ory.sh/kratos/docs/reference/configuration)):

- `kratos.config.secrets.session`
- `kratos.config.dsn`

You can create a `values.yaml` file to set the required values, like so:

```yaml
kratos:
  config:
    dsn: postgres://foo:bar@pg-sqlproxy-gcloud-sqlproxy:5432/db
    secrets:
      session:
        - dolore occaecat nostrud Ut
        - sit et commodoaute ut voluptate consectetur Duis
```

Install ORY Kratos by running this command:

```bash
$ helm install \
    ...
    -f values.yaml \
    ory/kratos
```

## Configuration

You can pass your [ORY Kratos configuration file](https://www.ory.sh/kratos/docs/reference/configuration)
by creating a yaml file with key `kratos.config`

```yaml
# kratos-config.yaml

kratos:
  config:
    # e.g.:
    log:
      level: trace
   # ...
```

and passing that as a value override to helm:

```bash
$ helm install -f ./path/to/kratos-config.yaml ory/kratos
```

Additionally, the following extra settings are available:

- `kratos.autoMigrate` (bool): If enabled, an `initContainer` running `kratos migrate sql` will be created.
- `kratos.development` (bool): If enabled, kratos will run with `--dev` argument.
- `secret.enabled` (bool): If `true` (default), a Kubernetes Secret is created (contains `dsn`, `secretsCookie` and `secretsDefault`). Also generates `secertsCookie` and `secretsDefault` unless already set.
- `secret.nameOverride` (string): Let's you override the name of the secret to be used
- `ingress.admin.enabled` (bool): If enabled, an ingress is created on admin endpoint
- `ingress.public.enabled` (bool): If enabled, an ingress is created on public endpoint

Check values.yaml for more configuration options.
