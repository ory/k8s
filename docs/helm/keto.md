# ORY Keto Helm Chart

The ORY Keto Helm Chart helps you deploy ORY Keto on Kubernetes using Helm.

## Installation

To install ORY Keto, the following values must be set
([documentation](https://www.ory.sh/keto/docs/reference/configuration)):

* `keto.config.dsn`

If you wish to install ORY Keto with an in-memory database run:

```bash
$ helm install \
    --set 'keto.config.dsn=memory' \
    ory/keto
```

### With SQL Database

To run ORY Keto against a SQL database, set the connection string. For example:

```bash
$ helm install \
    ...
    --set 'dsn=postgres://foo:bar@baz:1234/db' \
    ory/keto
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

When bringing up ORY Keto, set the host to `pg-sqlproxy-gcloud-sqlproxy` as documented
[here](https://github.com/rimusz/charts/tree/master/stable/gcloud-sqlproxy#installing-the-chart):

```bash
$ helm install \
    ...
    --set 'dsn=postgres://foo:bar@pg-sqlproxy-gcloud-sqlproxy:5432/db' \
    ory/keto
```

## Configuration

You can pass your [ORY Keto configuration file](https://www.ory.sh/keto/docs/reference/configuration)
by creating a yaml file with key `keto.config`

```yaml
# keto-config.yaml
keto:
  config:
    # e.g.:
    serve:
      port: 8080
   # ...
```

and passing that as a value override to helm:

```bash
$ helm install -f ./path/to/keto-config.yaml ory/keto
```

Additionally, the following extra settings are available:

- `autoMigrate` (bool): If enabled, an `initContainer` running `keto migrate sql` will be created.

## Upgrade

### From `0.18.0`

Since this version we support only kubernetes >= v1.18 for the ingress definition.

If you enabled ingresses you need to migrate values from:
```yaml
ingress:
  read:
    hosts:
      - host: chart-example.local
        paths: ["/read"]
  write:
    hosts:
      - host: chart-example.local
        paths: ["/write"]
```

to

```yaml
ingress:
  read:
    className: ""
    hosts:
      - host: chart-example.local
        paths:
          - path: /read
            pathType: Prefix
  write:
    className: ""
    hosts:
      - host: chart-example.local
        paths:
          - path: /write
            pathType: Prefix
```

where changes are on:
- introduce the `className` to specify the [ingress class documentation](https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/#extended-configuration-with-ingress-classes) that need to be used
- change `paths` definition from an array of strings to an array of objects, where each object include the `path` and the `pathType` (see [path matching documentation](https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/#better-path-matching-with-path-types))
