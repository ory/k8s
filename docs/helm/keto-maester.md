# ORY Keto-maester Helm Chart

ORY Keto Maester is a Kubernetes controller that watches for instances of `oauth2clients.keto.ory.sh/v1alpha1` custom resource (CR) and creates, updates, or deletes corresponding OAuth2 clients by communicating with ORY Keto's API.

## Installation

Keto Maester is a part of the Keto chart and is installed together with it.

## Configuration

You can set the values in the `values.yaml` file or using the `--set` syntax of Helm during chart installation.

## Custom Resource Syntax

ORY Keto Maester introduces its own Custom Resource Definitions (CRD) of types `oryaccesscontrolpolicy.keto.ory.sh/v1alpha1` and `oryaccesscontrolpolicyrole.keto.ory.sh/v1alpha1`. Each CR instance corresponds to a registered OAuth2 client.

The syntax of the `oryaccesscontrolpolicy.keto.ory.sh/v1alpha1` CR **Spec** fields is a representation of the the ORY Keto's ORYAccessControlPolicy

| Name               | Type      | Required  | Description                                | Accepted values                           |
|------------------- |---------- |---------- |---------------------------                 |-                                          |
| **Flavor**         | string    | yes       | Flavor of the policy                       | *exact*, *glob*, *regex*                  |
| **Effect**         | string    | yes       | Effect of the policy                       | *allow*, *deny*                           |
| **Description**    | string    | no        | Description of the policy                  | string                                    |
| **Actions**        | [string]  | yes       | Array of actions allowed                   | array of URN strings                      |
| **Resources**      | [string]  | yes       | Array of resources allowed                 | array of URN strings                      |
| **Subjects**       | [string]  | yes       | Array of subjects allowed                  | array of strings                          |
| **Conditions**     | object    | no        | Object defining conditions                 | Conditions object, see keto documentation |
| **Keto**           | object    | no        | Optional configuration of the keto service | See **Keto** below                        |

The syntax of the `oryaccesscontrolpolicyrole.keto.ory.sh/v1alpha1` CR **Spec** fields is a representation of the the ORY Keto's ORYAccessControlPolicyRole

| Name               | Type      | Required  | Description                                | Accepted values                           |
|------------------- |---------- |---------- |---------------------------                 |-                                          |
| **Flavor**         | string    | yes       | Flavor of the policy                       | *exact*, *glob*, *regex*                  |
| **Members**        | [string]  | yes       | Array of members                           | array of strings                          |
| **Keto**           | object    | no        | Optional configuration of the keto service | See **Keto** below                        |

### Keto

The optional `keto` object is used to define the connection details for the keto service on which the client will be created. Any values here will override values supplied on the command line.

| Name            | Type    | Description                                                   | Overridden Flag |
|-                |-        |-                                                              |-                |
| `keto.url`      | string  | The URL for the keto instance                                 | `--keto-url`    |
| `keto.port`     | integer | The port for the keto instance                                | `--keto-port`   |
| `keto.endpoint` | string  | The endpoint for the client endpoints, defaults to `/engines` | `--endpoint`    |

## Troubleshooting

If the controller encounters en error while processing an instance of the `oryaccesscontrolpolicy.keto.ory.sh/v1alpha1` CR, it adds the **status** section which describes the cause of the error. This table lists the fields of the **status** section.

| Field                                      |  Description                                                       |
|--------------------------------------------|--------------------------------------------------------------------|
| **status.observedGeneration**              | The most recent generation observed by the OAuth2Client controller |
| **status.reconciliationError.statusCode**  | Status code of the reconciliation error                            |
| **status.reconciliationError.description** | Description of the reconciliation error                            |

### Status codes

These are the status codes used to describe reconciliation errors:

| Code                           |  Description                                                      |
|--------------------------------|-------------------------------------------------------------------|
| **POLICY_UPSERT_FAILED**       | Unable to upsert an ORYAccessControlPolicy                        |
| **ROLE_UPSERT_FAILED**         | Unable to upsert an ORYAccessControlPolicyRole                    |

Refer to the **status.reconciliationError.description** field for further information. 
