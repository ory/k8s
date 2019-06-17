# ORY Oathkeeper Helm Chart

The ORY Oathkeeper Helm Chart helps you deploy ORY Oathkeeper on Kubernetes using Helm.

## Installation

Installing ORY Oathkeeper using Helm with:

```sh
$ helm install ory-oathkeeper
```

This will set up a very basic configuration with no access rules and no enabled authenticators, authorizers, or
credentials issuers.

You can pass your [ORY Oathkeeper configuration file](https://github.com/ory/oathkeeper/blob/master/docs/config.yaml)
using:

```sh
$ helm install --set-file oathkeeper.config=./path/to/config.yml ory-oathkeeper
```

### Demo-mode

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
