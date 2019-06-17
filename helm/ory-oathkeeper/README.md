# ORY Oathkeeper Helm Chart

The ORY Oathkeeper Helm Chart helps you deploy ORY Oathkeeper on Kubernetes using Helm.

## Installation

Installing ORY Oathkeeper using Helm with

```sh
$ helm install ory-oathkeeper
```

which sets up a very basic configuration with no access rules and no enabled authenticators, authorizers, or
credentials issuers.

This Helm Chart supports a demo mode which deploys access rules for urls

- http://<oathkeeper-reverse-proxy-host>/authenticator/noop/authorizer/allow/mutator/noop
- http://<oathkeeper-reverse-proxy-host>//authenticator/anonymous/authorizer/allow/mutator/header

that point to [httpbin.org](https://httpbin.org). To install ORY Oathkeeper in demo-mode, run:

```sh
$ helm install --set demo=true ory-oathkeeper
```

Be aware that this mode uses JSON Web Keys and other secrets that are publicly accessible via GitHub.
These secrets are publicly known and should never be used anywhere. **Do not use demo-mode for anything
other than experimenting**.

## Configuration

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

```sh
$ helm install -f ./path/to/config.yaml ory-oathkeeper
```

Values such as the proxy / api port will be automatically propagated to the service and ingress definitions.

### JSON Web Key Set for Mutator `id_token`

The `id_token` mutator requires a secret JSON Web Key Set. This helm chart supports loading the JSON Web Key Set
from disk and deploying it as a Kubernetes Secret:

```
$ helm install \
    --set-file oathkeeper.import.jwks=./path/to/jwks.json \
    ory-oathkeeper
```

Please note that any configuration values set for `oathkeeper.config.mutators.id_token.jwks_url` using e.g.
a configuration file will be overwritten by this setting.

## Develop

To test this chart locally without applying it to kubernetes, do:

```sh
$ helm install --debug --dry-run .
```

### Testing

```sh
$ helm install .
$ helm test  --cleanup <name>
```

### Remove all releases

This will remove all releases:

```sh
$ helm del $(helm ls --all --short) --purge
```