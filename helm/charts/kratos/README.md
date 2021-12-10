# kratos

![Version: 0.21.3](https://img.shields.io/badge/Version-0.21.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.8.0-alpha.3](https://img.shields.io/badge/AppVersion-v0.8.0--alpha.3-informational?style=flat-square)

A ORY Kratos Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Configure node affinity |
| autoscaling | object | `{"enabled":false,"maxReplicas":3,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | Horizontal pod autoscaling configuration |
| deployment.annotations | object | `{}` |  |
| deployment.automountServiceAccountToken | bool | `true` |  |
| deployment.extraArgs | list | `[]` | Array of extra argumetns to be passed down to the deployment. Kubernetes args format is expected - --foo - --sqa-opt-out |
| deployment.extraEnv | list | `[]` | Array of extra envs to be passed to the deployment. Kubernetes format is expected - name: FOO   value: BAR |
| deployment.extraInitContainers | object | `{}` |  |
| deployment.extraVolumeMounts | list | `[]` |  |
| deployment.extraVolumes | list | `[]` | If you want to mount external volume For example, mount a secret containing Certificate root CA to verify database TLS connection. |
| deployment.labels | object | `{}` |  |
| deployment.livenessProbe | object | `{"failureThreshold":5,"httpGet":{"path":"/health/alive","port":"http-admin"},"initialDelaySeconds":30,"periodSeconds":10}` | Configure the probes for when the deployment is considered ready and ongoing health check |
| deployment.nodeSelector | object | `{}` | Node labels for pod assignment. |
| deployment.readinessProbe.failureThreshold | int | `5` |  |
| deployment.readinessProbe.httpGet.path | string | `"/health/ready"` |  |
| deployment.readinessProbe.httpGet.port | string | `"http-admin"` |  |
| deployment.readinessProbe.initialDelaySeconds | int | `30` |  |
| deployment.readinessProbe.periodSeconds | int | `10` |  |
| deployment.resources | object | `{}` |  |
| deployment.serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | The secret specified here will be used to load environment variables with envFrom. This allows arbitrary environment variables to be provided to the application which is useful for sensitive values which should not be in a configMap. This secret is not created by the helm chart and must already exist in the namespace. https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/#configure-all-key-value-pairs-in-a-secret-as-container-environment-variables environmentSecretsName: -- Specify the serviceAccountName value. In some situations it is needed to provides specific permissions to Hydra deployments Like for example installing Hydra on a cluster with a PosSecurityPolicy and Istio. Uncoment if it is needed to provide a ServiceAccount for the Hydra deployment. |
| deployment.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| deployment.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| deployment.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| deployment.tolerations | list | `[]` | Configure node tolerations. |
| deployment.tracing | object | `{"datadog":{"enabled":false}}` | Configuration for tracing providers. Only datadog is currently supported through this block. If you need to use a different tracing provider, please manually set the configuration values via "kratos.config" or via "deployment.extraEnv". |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"oryd/kratos"` | ORY KRATOS image |
| image.tag | string | `"v0.8.0-alpha.3"` | ORY KRATOS VERSION Alternative format: image: oryd/kratos:v0.6.3-alpha.1 |
| imagePullSecrets | list | `[]` |  |
| ingress.admin.annotations | object | `{}` |  |
| ingress.admin.className | string | `""` |  |
| ingress.admin.enabled | bool | `false` |  |
| ingress.admin.hosts[0].host | string | `"kratos.admin.local.com"` |  |
| ingress.admin.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.admin.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.admin.tls | list | `[]` |  |
| ingress.public.annotations | object | `{}` |  |
| ingress.public.className | string | `""` |  |
| ingress.public.enabled | bool | `false` |  |
| ingress.public.hosts[0].host | string | `"kratos.public.local.com"` |  |
| ingress.public.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.public.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.public.tls | list | `[]` |  |
| job | object | `{"annotations":{},"ttlSecondsAfterFinished":60}` | Values for initialization job |
| kratos.autoMigrate | bool | `false` | Enable the initialization job. Required to work with a DB |
| kratos.config | object | `{"courier":{"smtp":{}},"secrets":{},"serve":{"admin":{"port":4434},"public":{"port":4433}}}` | You can customize the emails kratos is sending (also uncomment config.courier.template_override_path below)  Note: If you are setting config.courier.template_override_path you need to supply overrides for all templates.        It is currently not possible to overrides only selected methods.  emailTemplates:    recovery:      valid:        subject: Recover access to your account        body: |-          Hi, please recover access to your account by clicking the following link:          <a href="{{ .RecoveryURL }}">{{ .RecoveryURL }}</a>        plainBody: Hi, please recover access to your account by clicking the following link: {{ .RecoveryURL }}      invalid:        subject: Account access attempted        body: |-          Hi, you (or someone else) entered this email address when trying to recover access to an account.          However, this email address is not on our database of registered users and therefore the attempt has failed. If this was you, check if you signed up using a different address. If this was not you, please ignore this email.        plainBody: Hi, you (or someone else) entered this email address when trying to recover access to an account.    verification:      valid:        subject: Please verify your email address        body: |-          Hi, please verify your account by clicking the following link:          <a href="{{ .VerificationURL }}">{{ .VerificationURL }}</a>        plainBody: Hi, please verify your account by clicking the following link: {{ .VerificationURL }}      invalid:        subject:        body:        plainBody: |
| kratos.development | bool | `false` |  |
| kratos.identitySchemas | object | `{}` | You can add multiple identity schemas here |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | Node labels for pod assignment. |
| pdb | object | `{"enabled":false,"spec":{"minAvailable":1}}` | PodDistributionBudget configuration |
| replicaCount | int | `1` |  |
| secret.enabled | bool | `true` | switch to false to prevent creating the secret |
| secret.nameOverride | string | `""` | Provide custom name of existing secret, or custom name of secret to be created |
| secret.secretAnnotations."helm.sh/hook" | string | `"pre-install, pre-upgrade"` |  |
| secret.secretAnnotations."helm.sh/hook-delete-policy" | string | `"before-hook-creation"` |  |
| secret.secretAnnotations."helm.sh/hook-weight" | string | `"0"` |  |
| secret.secretAnnotations."helm.sh/resource-policy" | string | `"keep"` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `100` |  |
| service.admin.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| service.admin.enabled | bool | `true` |  |
| service.admin.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| service.admin.port | int | `80` |  |
| service.admin.type | string | `"ClusterIP"` |  |
| service.public.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| service.public.enabled | bool | `true` |  |
| service.public.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| service.public.port | int | `80` |  |
| service.public.type | string | `"ClusterIP"` |  |
| statefulset.log.format | string | `"json"` |  |
| statefulset.log.level | string | `"trace"` |  |
| strategy | object | `{"rollingUpdate":{"maxSurge":"30%","maxUnavailable":0},"type":"RollingUpdate"}` | Deployment update strategy |
| tolerations | list | `[]` | If you do want to specify node labels, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'.   foo: bar Configure node tolerations. |
| watcher.enabled | bool | `false` |  |
| watcher.image | string | `"oryd/k8s-toolbox:0.0.2"` |  |
| watcher.mountFile | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
