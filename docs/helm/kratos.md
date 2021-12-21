# Ory Kratos Helm Chart

The Ory Kratos Helm Chart helps you deploy Ory Kratos on Kubernetes using Helm.

## Installation

To install Ory Kratos, the following values must be set
([documentation](https://www.ory.sh/kratos/docs/reference/configuration)):

- `kratos.config.secrets.default`
- `kratos.config.dsn`

You can create a `values.yaml` file to set the required values, like so:

```yaml
kratos:
  config:
    dsn: postgres://foo:bar@pg-sqlproxy-gcloud-sqlproxy:5432/db
    secrets:
      default:
        - dolore occaecat nostrud Ut
        - sit et commodoaute ut voluptate consectetur Duis
```

Install Ory Kratos by running this command:

```bash
$ helm install \
    ...
    -f values.yaml \
    ory/kratos
```

## Ory Kratos Configuration

You can pass your
[Ory Kratos configuration file](https://www.ory.sh/kratos/docs/reference/configuration)
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

## Helm Chart Configuration

For the full list of chart values, please refer to the [Ory Kratos Helm Chart README](https://github.com/ory/k8s/tree/master/helm/charts/kratos), or the [values.yaml](https://github.com/ory/k8s/blob/master/helm/charts/kratos/values.yaml) directly 

Additionally, the following extra settings are available:

- `kratos.autoMigrate` (bool): If enabled, an `initContainer` running
  `kratos migrate sql` will be created.
- `kratos.development` (bool): If enabled, kratos will run with `--dev`
  argument.
- `secret.enabled` (bool): If `true` (default), a Kubernetes Secret is created
  (contains `dsn`, `secretsCookie` and `secretsDefault`). Also generates
  `secretsCookie` and `secretsDefault` unless already set.
- `secret.nameOverride` (string): Lets you override the name of the secret to be
  used
- `ingress.admin.enabled` (bool): If enabled, an ingress is created on admin
  endpoint
- `ingress.public.enabled` (bool): If enabled, an ingress is created on public
  endpoint Check values.yaml for more configuration options.

### Custom Secrets

```
secret:
  # -- switch to false to prevent creating the secret
  enabled: false
  # -- Provide custom name of existing secret, or custom name of secret to be created
  nameOverride: "my-custom-secret"
```

> Remember: In this case, you are responsible for supplying the required values,
> which need to be in the same format that the created secret uses. For more
> details please take a look
> [here](https://github.com/ory/k8s/blob/master/helm/charts/kratos/templates/secrets.yaml#L15).

## Upgrade

### From `0.18.0`

Since this version we support only kubernetes >= v1.18 for the ingress
definition.

If you enabled ingresses you need to migrate values from:

```yaml
ingress:
  public:
    hosts:
      - host: kratos.public.local.com
        paths: ['/']
  admin:
    hosts:
      - host: kratos.admin.local.com
        paths: ['/']
```

to

```yaml
ingress:
  public:
    className: ''
    hosts:
      - host: kratos.public.local.com
        paths:
          - path: /
            pathType: ImplementationSpecific
  admin:
    className: ''
    hosts:
      - host: kratos.admin.local.com
        paths:
          - path: /
            pathType: ImplementationSpecific
```

where changes are on:

- introduce the `className` to specify the
  [ingress class documentation](https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/#extended-configuration-with-ingress-classes)
  that need to be used
- change `paths` definition from an array of strings to an array of objects,
  where each object include the `path` and the `pathType` (see
  [path matching documentation](https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/#better-path-matching-with-path-types))
