# hydra

![Version: 0.19.3](https://img.shields.io/badge/Version-0.19.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.10.5](https://img.shields.io/badge/AppVersion-v1.10.5-informational?style=flat-square)

A Helm chart for deploying ORY Hydra in Kubernetes

**Homepage:** <https://www.ory.sh/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ORY Team | hi@ory.sh | https://www.ory.sh/ |

## Source Code

* <https://github.com/ory/hydra>
* <https://github.com/ory/k8s>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../hydra-maester | hydra-maester(hydra-maester) | 0.19.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| deployment.annotations | object | `{}` |  |
| deployment.automountServiceAccountToken | bool | `true` |  |
| deployment.autoscaling.enabled | bool | `false` |  |
| deployment.autoscaling.maxReplicas | int | `3` |  |
| deployment.autoscaling.minReplicas | int | `1` |  |
| deployment.extraEnv | list | `[]` |  |
| deployment.extraVolumeMounts | list | `[]` |  |
| deployment.extraVolumes | list | `[]` |  |
| deployment.labels | object | `{}` |  |
| deployment.lifecycle | object | `{}` |  |
| deployment.livenessProbe.failureThreshold | int | `5` |  |
| deployment.livenessProbe.initialDelaySeconds | int | `30` |  |
| deployment.livenessProbe.periodSeconds | int | `10` |  |
| deployment.nodeSelector | object | `{}` |  |
| deployment.readinessProbe.failureThreshold | int | `5` |  |
| deployment.readinessProbe.initialDelaySeconds | int | `30` |  |
| deployment.readinessProbe.periodSeconds | int | `10` |  |
| deployment.resources | object | `{}` |  |
| deployment.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| deployment.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| deployment.securityContext.privileged | bool | `false` |  |
| deployment.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| deployment.securityContext.runAsNonRoot | bool | `true` |  |
| deployment.securityContext.runAsUser | int | `100` |  |
| deployment.tolerations | list | `[]` |  |
| deployment.tracing.datadog.enabled | bool | `false` |  |
| fullnameOverride | string | `""` |  |
| hydra-maester.adminService | object | `{}` |  |
| hydra.autoMigrate | bool | `false` |  |
| hydra.config.secretAnnotations."helm.sh/hook" | string | `"pre-install"` |  |
| hydra.config.secretAnnotations."helm.sh/hook-delete-policy" | string | `"before-hook-creation"` |  |
| hydra.config.secrets | object | `{}` |  |
| hydra.config.serve.admin.port | int | `4445` |  |
| hydra.config.serve.public.port | int | `4444` |  |
| hydra.config.serve.tls.allow_termination_from[0] | string | `"10.0.0.0/8"` |  |
| hydra.config.serve.tls.allow_termination_from[1] | string | `"172.16.0.0/12"` |  |
| hydra.config.serve.tls.allow_termination_from[2] | string | `"192.168.0.0/16"` |  |
| hydra.config.urls.self | object | `{}` |  |
| hydra.dangerousAllowInsecureRedirectUrls | bool | `false` |  |
| hydra.dangerousForceHttp | bool | `false` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"oryd/hydra"` |  |
| image.tag | string | `"v1.10.5"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.admin.annotations | object | `{}` |  |
| ingress.admin.className | string | `""` |  |
| ingress.admin.enabled | bool | `false` |  |
| ingress.admin.hosts[0].host | string | `"admin.hydra.localhost"` |  |
| ingress.admin.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.admin.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.public.annotations | object | `{}` |  |
| ingress.public.className | string | `""` |  |
| ingress.public.enabled | bool | `false` |  |
| ingress.public.hosts[0].host | string | `"public.hydra.localhost"` |  |
| ingress.public.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.public.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| job.annotations | object | `{}` |  |
| maester.enabled | bool | `true` |  |
| nameOverride | string | `""` |  |
| pdb.enabled | bool | `false` |  |
| pdb.spec.minAvailable | int | `1` |  |
| replicaCount | int | `1` |  |
| service.admin.annotations | object | `{}` |  |
| service.admin.enabled | bool | `true` |  |
| service.admin.labels | object | `{}` |  |
| service.admin.port | int | `4445` |  |
| service.admin.type | string | `"ClusterIP"` |  |
| service.public.annotations | object | `{}` |  |
| service.public.enabled | bool | `true` |  |
| service.public.labels | object | `{}` |  |
| service.public.port | int | `4444` |  |
| service.public.type | string | `"ClusterIP"` |  |
| watcher.enabled | bool | `false` |  |
| watcher.image | string | `"oryd/k8s-toolbox:0.0.1"` |  |
| watcher.mountFile | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
