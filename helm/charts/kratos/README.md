# kratos

![Version: 0.19.3](https://img.shields.io/badge/Version-0.19.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.6.3-alpha.1](https://img.shields.io/badge/AppVersion-0.6.3--alpha.1-informational?style=flat-square)

A ORY Kratos Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `3` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| deployment.annotations | object | `{}` |  |
| deployment.automountServiceAccountToken | bool | `true` |  |
| deployment.extraEnv | list | `[]` |  |
| deployment.extraInitContainers | object | `{}` |  |
| deployment.extraVolumeMounts | list | `[]` |  |
| deployment.extraVolumes | list | `[]` |  |
| deployment.labels | object | `{}` |  |
| deployment.livenessProbe.failureThreshold | int | `5` |  |
| deployment.livenessProbe.httpGet.path | string | `"/health/alive"` |  |
| deployment.livenessProbe.httpGet.port | string | `"http-admin"` |  |
| deployment.livenessProbe.initialDelaySeconds | int | `30` |  |
| deployment.livenessProbe.periodSeconds | int | `10` |  |
| deployment.nodeSelector | object | `{}` |  |
| deployment.readinessProbe.failureThreshold | int | `5` |  |
| deployment.readinessProbe.httpGet.path | string | `"/health/ready"` |  |
| deployment.readinessProbe.httpGet.port | string | `"http-admin"` |  |
| deployment.readinessProbe.initialDelaySeconds | int | `30` |  |
| deployment.readinessProbe.periodSeconds | int | `10` |  |
| deployment.resources | object | `{}` |  |
| deployment.tolerations | list | `[]` |  |
| deployment.tracing.datadog.enabled | bool | `false` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"oryd/kratos"` |  |
| image.tag | string | `"v0.6.3-alpha.1"` |  |
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
| job.annotations | object | `{}` |  |
| job.ttlSecondsAfterFinished | int | `60` |  |
| kratos.autoMigrate | bool | `false` |  |
| kratos.config.courier.smtp | object | `{}` |  |
| kratos.config.secrets | object | `{}` |  |
| kratos.config.serve.admin.port | int | `4434` |  |
| kratos.config.serve.public.port | int | `4433` |  |
| kratos.development | bool | `false` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| pdb.enabled | bool | `false` |  |
| pdb.spec.minAvailable | int | `1` |  |
| replicaCount | int | `1` |  |
| secret.enabled | bool | `true` |  |
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
| service.admin.annotations | object | `{}` |  |
| service.admin.enabled | bool | `true` |  |
| service.admin.port | int | `80` |  |
| service.admin.type | string | `"ClusterIP"` |  |
| service.public.annotations | object | `{}` |  |
| service.public.enabled | bool | `true` |  |
| service.public.port | int | `80` |  |
| service.public.type | string | `"ClusterIP"` |  |
| statefulset.log.format | string | `"json"` |  |
| statefulset.log.level | string | `"trace"` |  |
| strategy.rollingUpdate.maxSurge | string | `"30%"` |  |
| strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| strategy.type | string | `"RollingUpdate"` |  |
| tolerations | list | `[]` |  |
| watcher.enabled | bool | `false` |  |
| watcher.image | string | `"oryd/k8s-toolbox:0.0.1"` |  |
| watcher.mountFile | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
