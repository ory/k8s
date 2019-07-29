# ORY Maester Helm Chart

The ORY Maester Helm Chart helps you deploy ORY Maester on Kubernetes using Helm.

ORY Maester is a Kubernetes controller that watches for instances of Custom Resource `rules.oathkeeper.ory.sh/v1alpha1` and creates/updates a ConfigMap with an array of Rules in the format recognized by the Oathkeeper.
By mounting the map to Oathkeeper Pod, you can manage list of Oathkeeper Rules with the custom resource instances.


## Installation

Install ORY Maester using Helm with

```bash
$ helm install ory/maester
```

## Configuration

The most important configuration values are used to control ConfigMap creation:

- `configMapName` Name of the ConfigMap used to store Rule list. Defaults to `oathkeeper-rules`
- `rulesConfigmapNamespace` Namespace of the ConfigMap used to store Rule list (optional). Defaults to the Helm Release namespaces.
- `rulesFileName` Name of the single root-level ConfigMap key used to store entire array of Rules. When the ConfigMap is mounted in the Oathkeeper Pod, this becomes also the filename of the "rules file" to the Oathkeeper process. Defaults to `access_rules.json`

You can set the values in `values.yaml` file or using `--set` syntax of Helm during chart installation.

## Custom Resource Syntax

ORY Maester introduces it's own Custom Resource Definition of type `rules.oathkeeper.ory.sh/v1alpha1`.
Each custom resource instance describes a single Oathkeeper rule.

The syntax of the Custom Resource `Spec` reflects Oathkeeper Rule syntax, with the following differences:
- the `id` field is auto-generated
- the `upstream.preserveHost` property is camelCased.
- the `upstream.stripPath` property is camelCased.

The CRD Json Schema validation provides definitions for all available attributes.
Notice that all handlers (authenticators, authorizer, mutator) are passed verbatim without any changes to the Rule list.

The controller provides following defaults for each Rule it creates:
- If `authenticators` are not defined, it defaults to a single `unauthorized` handler
- If `authorizer` is not defined, it defaults to a `deny` handler
- If `mutator` is not defined, it defaults to a `noop` handler

