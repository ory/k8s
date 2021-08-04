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
- `secret.enabled` (bool): If `true` (default), a Kubernetes Secret is created (contains `dsn`, `secretsCookie` and `secretsDefault`). Also generates `secretsCookie` and `secretsDefault` unless already set.
- `secret.nameOverride` (string): Lets you override the name of the secret to be used
- `ingress.admin.enabled` (bool): If enabled, an ingress is created on admin endpoint
- `ingress.public.enabled` (bool): If enabled, an ingress is created on public endpoint
- `deployment.environmentSecretsName` (string): Allows you to set arbitrary environment variables from [a secret containing a list of keys and values](https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/#configure-all-key-value-pairs-in-a-secret-as-container-environment-variables). (This secret is not created by the Helm chart)

Check values.yaml for more configuration options.

## Upgrade

### From `0.18.0`

Since this version we support only kubernetes >= v1.18 for the ingress definition.

If you enabled ingresses you need to migrate values from:
```yaml
ingress:
  public:
    hosts:
      - host: kratos.public.local.com
        paths: ["/"]
  admin:
    hosts:
      - host: kratos.admin.local.com
        paths: ["/"]
```

to

```yaml
ingress:
  public:
    className: ""
    hosts:
      - host: kratos.public.local.com
        paths:
          - path: /
            pathType: ImplementationSpecific
  admin:
    className: ""
    hosts:
      - host: kratos.admin.local.com
        paths:
          - path: /
            pathType: ImplementationSpecific
```

where changes are on:
- introduce the `className` for specify the [ingress class documentation](https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/#extended-configuration-with-ingress-classes) that need to be used
- change `paths` definition from array of string to array of object, where each object include the `path` and the `pathType` (see [path matching documentation](https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/#better-path-matching-with-path-types))
