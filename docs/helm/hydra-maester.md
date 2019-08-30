# ORY Hydra-maester Helm Chart

ORY Hydra Maester is a Kubernetes controller that watches for instances of `oauth2clients.hydra.ory.sh/v1alpha1` custom resource (CR) and creates, updates, or deletes corresponding OAuth2 clients by communicating with ORY Hydra's API. Apart from managing OAuth2 clients, the controller saves the credentials of the registered clients as Kubernetes Secrets. As a result, the client ID and password stored in the Secret can be used to interact with the corresponding OAuth2 client registered by ORY Hydra.

## Installation

Hydra Maester is a part of the Hydra chart and is installed together with it.

## Configuration

- `enabledNamespaces` defines the namespaces in which instances of `oauth2clients.hydra.ory.sh/v1alpha1` CR can be created. By default, users are allowed to create CR instances only in the controller's native namespace.

You can set the values in the `values.yaml` file or using the `--set` syntax of Helm during chart installation.

## Custom Resource Syntax

ORY Hydra Maester introduces its own Custom Resource Definition (CRD) of type `oauth2clients.hydra.ory.sh/v1alpha1`. Each CR instance corresponds to a registered OAuth2 client.

The syntax of the CR **Spec** fields is a simplified representation of the the ORY Hydra's OAuth2 client [scheme](https://www.ory.sh/docs/hydra/sdk/api#schemaoauth2client).

| Name              | Type     | Required | Description | Accepted values |
|-------------------|----------|----------|-------------|-----------------|
| **GrantTypes**    | [string] | yes      | Array of grant types the client is allowed to use. | *client_credentials*, *authorization_code*, *implicit*, *refresh_token*
| **ResponseTypes** | [string] | no       | Array of the OAuth 2.0 response type strings that the client can use at the authorization endpoint. | *id_token*, *code*, *token*
| **Scope**         | string   | yes      | String containing a space-separated list of scope values (as described in Section 3.3 of OAuth 2.0 [RFC6749]) that the client can use when requesting access tokens. | any string |

See the [OAuth 2.0 Authorization Framework RFC page](https://tools.ietf.org/html/rfc6749) to learn more about OAuth2 clients.

The JSON schema specified in the CRD provides definitions for all available attributes.
