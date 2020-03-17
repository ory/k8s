# ORY Hydra-maester Helm Chart

ORY Hydra Maester is a Kubernetes controller that watches for instances of `oauth2clients.hydra.ory.sh/v1alpha1` custom resource (CR) and creates, updates, or deletes corresponding OAuth2 clients by communicating with ORY Hydra's API.

## Installation

Hydra Maester is a part of the Hydra chart and is installed together with it.

## Configuration

- `enabledNamespaces` defines the namespaces in which instances of `oauth2clients.hydra.ory.sh/v1alpha1` CR can be created. By default, users are allowed to create CR instances only in the controller's native namespace.

You can set the values in the `values.yaml` file or using the `--set` syntax of Helm during chart installation.

## Custom Resource Syntax

ORY Hydra Maester introduces its own Custom Resource Definition (CRD) of type `oauth2clients.hydra.ory.sh/v1alpha1`. Each CR instance corresponds to a registered OAuth2 client.

The syntax of the CR **Spec** fields is a simplified representation of the the ORY Hydra's OAuth2 client [scheme](https://www.ory.sh/docs/hydra/sdk/api#schemaoauth2client).

You can see an example CR manifest [here](https://github.com/ory/hydra-maester/blob/master/config/samples/hydra_v1alpha1_oauth2client.yaml)

| Name              | Type     | Required | Description | Accepted values |
|-------------------|----------|----------|-------------|-----------------|
| **GrantTypes**    | [string] | yes      | Array of grant types the client is allowed to use. | *client_credentials*, *authorization_code*, *implicit*, *refresh_token* |
| **ResponseTypes** | [string] | no       | Array of the OAuth 2.0 response type strings that the client can use at the authorization endpoint. | *id_token*, *code*, *token* |
| **Scope**         | string   | yes      | String containing a space-separated list of scope values (as described in Section 3.3 of OAuth 2.0 [RFC6749]) that the client can use when requesting access tokens. | any string |
| **SecretName**    | string   | yes      | Name of a Kubernetes Secret which stores the OAuth2 client credentials. See the **Credentials** section for more details. | any string that meets the Kubernetes [naming requirements](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/) |
| **RedirectUris**  | [string] | no       | A list of allowed redirect URIs for this client | An array of strings matching `\w+:/?/?[^\s]+` |
| **HydraAdmin**    | object   | no       | Optional configuration of the hydra admin service to be used for setting up the client | See **HydraAdmin** below |

### HydraAdmin

The optional `hydraAdmin` object is used to define the connection details for the hydra admin service on which the client will be created. Any values here will override values supplied on the command line.

| Name | Type | Description | Overridden Flag |
|-|-|-|-|
| `hydraAdmin.url` | string | The URL for the hydra instance | `--hydra-url` |
| `hydraAdmin.port` | integer | The port for the hydra instance | `--hydra-port` |
| `hydraAdmin.endpoint` | string | The endpoint for the client endpoints, defaults to `/clients` | `--endpoint` |
| `hydraAdmin.forwardedProto` | string | If specified, calls to the hydra API will have the `X-Forwarded-Proto` header specified with the supplied value | `--forwarded-proto` |

See the [OAuth 2.0 Authorization Framework RFC page](https://tools.ietf.org/html/rfc6749) to learn more about OAuth2 clients.

The JSON schema specified in the CRD provides definitions for all available attributes.

## Credentials

Apart from interacting with ORY Hydra's API, Hydra Maester controls Kubernetes Secrets that store credentials of the registered clients. You can use those credentials to interact with corresponding OAuth2 clients registered by ORY Hydra. For each client, you can either specify the client ID and secret or let Hydra OAuth2 server generate a random client ID and secret.

### Use your own credentials

To create a client with your own credentials, follow these steps:

1. Save your client ID and secret to a Kubernetes Secret.
2. Create an instance of the `oauth2clients.hydra.ory.sh/v1alpha1` CR with the **SecretName** property set to the name of the Secret that contains the credentials.

> **NOTE:** Both resources must exist in the same Namespace. 


### Use Hydra-generated credentials

If you don't need a specific client ID and password, use Hydra-generated credentials. Create an instance of the`oauth2clients.hydra.ory.sh/v1alpha1` CR with the **SecretName** property set to a string of your choice. The property is used by Hydra Maester to create a Kubernetes Secret that will store the credentials of the registered client.

> **NOTE:** Secrets created by Hydra Maester have `OwnerReference` set. It means that they will be removed when an appropriate `oauth2client` CR is removed. Secrets created by a user will not have `OwnerReference` set.

### Update the OAuth2 client secret
 
To change the password of your OAuth2 client, follow these steps:

1. Save the ID of your client and the updated password to a new Kubernetes Secret.
2. Edit the instance of the `oauth2clients.hydra.ory.sh/v1alpha1` CR by replacing the value of the **SecretName** property with the name of the new Secret.

## Troubleshooting

If the controller encounters en error while processing an instance of the `oauth2clients.hydra.ory.sh/v1alpha1` CR, it adds the **status** section which describes the cause of the error. This table lists the fields of the **status** section.

| Field                                      |  Description                                                       |
|--------------------------------------------|--------------------------------------------------------------------|
| **status.observedGeneration**              | The most recent generation observed by the OAuth2Client controller |
| **status.reconciliationError.statusCode**  | Status code of the reconciliation error                            |
| **status.reconciliationError.description** | Description of the reconciliation error                            |


### Status codes

These are the status codes used to describe reconciliation errors:

| Code                           |  Description                                                      |
|--------------------------------|-------------------------------------------------------------------|
| **CLIENT_REGISTRATION_FAILED** | Unable to register an OAuth2Client                               |
| **SECRET_CREATION_FAILED**     | Unable to create a secret with the name specified in the CR Spec |
| **CLIENT_UPDATE_FAILED**       | Unable to update an existing OAuth2 client                        |
| **INVALID_SECRET**             | The existing secret specified in the CR spec. is invalid           |

Refer to the **status.reconciliationError.description** field for further information. 
