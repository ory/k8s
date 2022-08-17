# kratos

![Version: 0.25.0](https://img.shields.io/badge/Version-0.25.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.10.1](https://img.shields.io/badge/AppVersion-v0.10.1-informational?style=flat-square)

A ORY Kratos Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Configure node affinity |
| autoscaling | object | `{"enabled":false,"maxReplicas":3,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | Horizontal pod autoscaling configuration |
| configmap.annotations | object | `{}` | If you do want to specify annotations for configmap, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| configmap.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| deployment | object | `{"annotations":{},"automountServiceAccountToken":true,"customLivenessProbe":{},"customReadinessProbe":{},"extraArgs":[],"extraContainers":{},"extraEnv":[],"extraInitContainers":{},"extraVolumeMounts":[],"extraVolumes":[],"labels":{},"livenessProbe":{"failureThreshold":5,"initialDelaySeconds":30,"periodSeconds":10},"nodeSelector":{},"readinessProbe":{"failureThreshold":5,"initialDelaySeconds":30,"periodSeconds":10},"resources":{},"serviceAccount":{"annotations":{},"create":true,"name":""},"tolerations":[],"tracing":{"datadog":{"enabled":false}}}` | Configuration options for the k8s deployment |
| deployment.customLivenessProbe | object | `{}` | Configure a custom livenessProbe. This overwrites the default object |
| deployment.customReadinessProbe | object | `{}` | Configure a custom readinessProbe. This overwrites the default object |
| deployment.extraArgs | list | `[]` | Array of extra arguments to be passed down to the deployment. Kubernetes args format is expected - --foo - --sqa-opt-out |
| deployment.extraContainers | object | `{}` | If you want to add extra sidecar containers. |
| deployment.extraEnv | list | `[]` | Array of extra envs to be passed to the deployment. Kubernetes format is expected - name: FOO   value: BAR |
| deployment.extraInitContainers | object | `{}` | If you want to add extra init containers. These are processed before the migration init container. |
| deployment.extraVolumes | list | `[]` | If you want to mount external volume For example, mount a secret containing Certificate root CA to verify database TLS connection. |
| deployment.livenessProbe | object | `{"failureThreshold":5,"initialDelaySeconds":30,"periodSeconds":10}` | Configure the livenessProbe parameters |
| deployment.nodeSelector | object | `{}` | Node labels for pod assignment. |
| deployment.readinessProbe | object | `{"failureThreshold":5,"initialDelaySeconds":30,"periodSeconds":10}` | Configure the readinessProbe parameters |
| deployment.serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provide specific permissions to Kratos deployments. Like for example installing Kratos on a cluster with a PosSecurityPolicy and Istio. Uncomment if it is needed to provide a ServiceAccount for the Kratos deployment. |
| deployment.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| deployment.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| deployment.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| deployment.tolerations | list | `[]` | Configure node tolerations. |
| deployment.tracing | object | `{"datadog":{"enabled":false}}` | Configuration for tracing providers. Only datadog is currently supported through this block. If you need to use a different tracing provider, please manually set the configuration values via "kratos.config" or via "deployment.extraEnv". |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"oryd/kratos"` | ORY KRATOS image |
| image.tag | string | `"v0.10.1"` | ORY KRATOS VERSION Alternative format: image: oryd/kratos:v0.6.3-alpha.1 |
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
| job | object | `{"annotations":{},"automountServiceAccountToken":true,"extraContainers":{},"lifecycle":{},"nodeSelector":{},"serviceAccount":{"annotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"},"create":true,"name":""},"shareProcessNamespace":false,"spec":{"backoffLimit":10}}` | Values for initialization job |
| job.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| job.automountServiceAccountToken | bool | `true` | Set automounting of the SA token |
| job.extraContainers | object | `{}` | If you want to add extra sidecar containers. |
| job.lifecycle | object | `{}` | If you want to add lifecycle hooks. |
| job.nodeSelector | object | `{}` | Node labels for pod assignment. |
| job.serviceAccount | object | `{"annotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provides specific permissions to Hydra deployments Like for example installing Hydra on a cluster with a PosSecurityPolicy and Istio. Uncoment if it is needed to provide a ServiceAccount for the Hydra deployment. |
| job.serviceAccount.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"}` | Annotations to add to the service account |
| job.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| job.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| job.shareProcessNamespace | bool | `false` | Set sharing process namespace |
| job.spec.backoffLimit | int | `10` | Set job back off limit |
| kratos.automigration | object | `{"enabled":false,"type":"job"}` | Enables database migration |
| kratos.automigration.type | string | `"job"` | Configure the way to execute database migration. Possible values: job, initContainer When set to job, the migration will be executed as a job on release or upgrade. When set to initContainer, the migration will be executed when kratos pod is created Defaults to job |
| kratos.config.courier.smtp | object | `{}` |  |
| kratos.config.secrets | object | `{}` |  |
| kratos.config.serve.admin.port | int | `4434` |  |
| kratos.config.serve.public.port | int | `4433` |  |
| kratos.development | bool | `false` |  |
| kratos.emailTemplates | object | `{"recovery":{"invalid":{"body":"Hi, you (or someone else) entered this email address when trying to recover access to an account.\n\nHowever, this email address is not on our database of registered users and therefore the attempt has failed.\nIf this was you, check if you signed up using a different address. If this was not you, please ignore this email.","plainBody":"Hi, you (or someone else) entered this email address when trying to recover access to an account.","subject":"Account access attempted"},"valid":{"body":"Hi, please recover access to your account by clicking the following link:\n\n<a href=\"{{ .RecoveryURL }}\">{{ .RecoveryURL }}</a>","plainBody":"Hi, please recover access to your account by clicking the following link: {{ .RecoveryURL }}","subject":"Recover access to your account"}},"verification":{"invalid":{"body":null,"plainBody":null,"subject":null},"valid":{"body":"Hi, please verify your account by clicking the following link:\n\n<a href=\"{{ .VerificationURL }}\">{{ .VerificationURL }}</a>","plainBody":"Hi, please verify your account by clicking the following link: {{ .VerificationURL }}","subject":"Please verify your email address"}}}` | You can customize the emails kratos is sending (also uncomment config.courier.template_override_path below) Note: If you are setting config.courier.template_override_path you need to supply overrides for all templates. It is currently not possible to overrides only selected methods. |
| kratos.identitySchemas | object | `{}` | You can add multiple identity schemas here |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | Node labels for pod assignment. |
| pdb | object | `{"enabled":false,"spec":{"minAvailable":1}}` | PodDistributionBudget configuration |
| replicaCount | int | `1` | Number of replicas in deployment |
| secret.enabled | bool | `true` | switch to false to prevent creating the secret |
| secret.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| secret.nameOverride | string | `""` | Provide custom name of existing secret, or custom name of secret to be created |
| secret.secretAnnotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0","helm.sh/resource-policy":"keep"}` | Annotations to be added to secret. Annotations are added only when secret is being created. Existing secret will not be modified. |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `100` |  |
| service.admin.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| service.admin.enabled | bool | `true` |  |
| service.admin.labels | object | `{}` | Provide custom labels. Use the same syntax as for annotations. |
| service.admin.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| service.admin.port | int | `80` |  |
| service.admin.type | string | `"ClusterIP"` |  |
| service.public.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| service.public.enabled | bool | `true` |  |
| service.public.labels | object | `{}` | Provide custom labels. Use the same syntax as for annotations. |
| service.public.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| service.public.port | int | `80` |  |
| service.public.type | string | `"ClusterIP"` |  |
| serviceMonitor | object | `{"enabled":true,"labels":{},"scheme":"http","scrapeInterval":"60s","scrapeTimeout":"30s","tlsConfig":{}}` | Parameters for the Prometheus ServiceMonitor objects. Reference: https://docs.openshift.com/container-platform/4.6/rest_api/monitoring_apis/servicemonitor-monitoring-coreos-com-v1.html |
| serviceMonitor.enabled | bool | `true` | switch to false to prevent creating the ServiceMonitor |
| serviceMonitor.labels | object | `{}` | Provide additionnal labels to the ServiceMonitor ressource metadata |
| serviceMonitor.scheme | string | `"http"` | HTTP scheme to use for scraping. |
| serviceMonitor.scrapeInterval | string | `"60s"` | Interval at which metrics should be scraped |
| serviceMonitor.scrapeTimeout | string | `"30s"` | Timeout after which the scrape is ended |
| serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint |
| statefulSet.annotations | object | `{}` |  |
| statefulSet.extraArgs | list | `[]` | Array of extra arguments to be passed down to the StatefulSet. Kubernetes args format is expected |
| statefulSet.extraContainers | object | `{}` | If you want to add extra sidecar containers. |
| statefulSet.extraEnv | list | `[]` |  |
| statefulSet.extraInitContainers | object | `{}` | If you want to add extra init containers. These are processed before the migration init container. |
| statefulSet.extraVolumeMounts | list | `[]` |  |
| statefulSet.extraVolumes | list | `[]` | If you want to mount external volume For example, mount a secret containing Certificate root CA to verify database TLS connection. |
| statefulSet.labels | object | `{}` |  |
| statefulSet.log.format | string | `"json"` |  |
| statefulSet.log.level | string | `"trace"` |  |
| statefulSet.nodeSelector | object | `{}` | Node labels for pod assignment. |
| statefulSet.resources | object | `{}` |  |
| strategy | object | `{"rollingUpdate":{"maxSurge":"30%","maxUnavailable":0},"type":"RollingUpdate"}` | Deployment update strategy |
| tolerations | list | `[]` | If you do want to specify node labels, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'.   foo: bar Configure node tolerations. |
| watcher | object | `{"enabled":false,"image":"oryd/k8s-toolbox:0.0.4","mountFile":""}` | Configuration of the watcher sidecar |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
