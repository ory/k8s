# ORY Oathkeeper-maester Helm Chart

ORY Oathkeeper-maester is a Kubernetes controller that watches for instances of `rules.oathkeeper.ory.sh/v1alpha1` custom resource (CR) and creates or updates the Oathkeeper ConfigMap with Access Rules found in the CRs. The controller passes the Access Rules as an array in a format recognized by the Oathkeeper.
By mounting the ConfigMap to the Oathkeeper Pod, you can manage the list of Oathkeeper Rules through `rules.oathkeeper.ory.sh/v1alpha1` CR instances.

## Installation
Oathkeeper-maester is a part of the Oathkeeper chart, and it is installed together with it. 

## Configuration

These are the most important configuration values used to control ConfigMap creation:

- `rulesConfigmapNamespace` defines the Namespace in which the ConfigMap is stored. Defaults to the same Namespace as the ORY Maester Helm release.
- `rulesFileName` defines the name of the single root-level ConfigMap key used to store the entire array of Access Rules. When the ConfigMap is mounted in the Oathkeeper Pod, this becomes also the filename of the "rules file" to the Oathkeeper process. Defaults to `access-rules.json`.

You can set the values in `values.yaml` file or using `--set` syntax of Helm during chart installation.

## Custom Resource Syntax

ORY Maester introduces its own Custom Resource Definition (CRD) of type `rules.oathkeeper.ory.sh/v1alpha1`.
Each CR instance defines the rules for a single service.

The syntax of the CR **Spec** field reflects the Oathkeeper [Access Rule syntax](https://www.ory.sh/docs/next/oathkeeper/api-access-rules), with the following differences:
- The `id` field is auto-generated.
- The `upstream.preserveHost` property is camel cased.
- The `upstream.stripPath` property is camel cased.

The JSON schema specified in the CRD provides definitions for all available attributes.
All handlers such as authenticators, the authorizer, and the mutator are passed verbatim without any changes to the target Access Rules list.

The controller provides the following defaults for each Access Rule it creates:
- If `authenticators` are not defined, it defaults to a single `unauthorized` handler.
- If `authorizer` is not defined, it defaults to a `deny` handler.
- If `mutator` is not defined, it defaults to a `noop` handler.

These defaults implement a "disabled by default" policy for increased security.
