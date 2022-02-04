# keto

![Version: 0.21.7](https://img.shields.io/badge/Version-0.21.7-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.7.0](https://img.shields.io/badge/AppVersion-v0.7.0-informational?style=flat-square)

Access Control Policies as a Server

**Homepage:** <https://www.ory.sh/keto/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ORY Team | hi@ory.sh | https://www.ory.sh/ |

## Source Code

* <https://github.com/ory/keto>
* <https://github.com/ory/k8s>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| automountServiceAccountToken | bool | `true` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| deployment | object | `{"annotations":{},"livenessProbe":{"failureThreshold":5,"initialDelaySeconds":30,"periodSeconds":10},"readinessProbe":{"failureThreshold":5,"initialDelaySeconds":30,"periodSeconds":10}}` | Configure the probes for when the deployment is considered ready and ongoing health check |
| deployment.annotations | object | `{}` | Add custom annotations to the deployment |
| extraEnv | list | `[]` | Array of extra Envs to be added to the deployment. K8s format expected - name: FOO   value: BAR |
| extraLabels | object | `{}` | Extra labels to be added to the deployment, and pods. K8s object format expected foo: bar my.special.label/type: value |
| extraVolumeMounts | list | `[]` | Array of extra VolumeMounts to be added to the deployment. K8s format expected - name: my-volume   mountPath: /etc/secrets/my-secret   readOnly: true |
| extraVolumes | list | `[]` | Array of extra Volumes to be added to the deployment. K8s format expected - name: my-volume   secret:     secretName: my-secret |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | Default image pull policy |
| image.repository | string | `"oryd/keto"` | Ory KETO image |
| image.tag | string | `"v0.7.0-alpha.1-sqlite"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.read.annotations | object | `{}` |  |
| ingress.read.className | string | `""` |  |
| ingress.read.enabled | bool | `false` |  |
| ingress.read.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.read.hosts[0].paths[0].path | string | `"/read"` |  |
| ingress.read.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.read.tls | list | `[]` |  |
| ingress.write.annotations | object | `{}` |  |
| ingress.write.className | string | `""` |  |
| ingress.write.enabled | bool | `false` |  |
| ingress.write.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.write.hosts[0].paths[0].path | string | `"/write"` |  |
| ingress.write.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.write.tls | list | `[]` |  |
| job.annotations | object | `{}` |  |
| keto.autoMigrate | bool | `false` |  |
| keto.config.dsn | string | `"memory"` |  |
| keto.config.namespaces[0].id | int | `0` |  |
| keto.config.namespaces[0].name | string | `"sample"` |  |
| keto.config.serve.read.port | int | `4466` |  |
| keto.config.serve.write.port | int | `4467` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| pdb | object | `{"enabled":false,"spec":{"minAvailable":1}}` | PodDistributionBudget configuration |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| secret.enabled | bool | `true` | Switch to false to prevent creating the secret |
| secret.nameOverride | string | `""` | Provide custom name of existing secret, or custom name of secret to be created |
| secret.secretAnnotations."helm.sh/hook" | string | `"pre-install, pre-upgrade"` |  |
| secret.secretAnnotations."helm.sh/hook-delete-policy" | string | `"before-hook-creation"` |  |
| secret.secretAnnotations."helm.sh/hook-weight" | string | `"0"` |  |
| secret.secretAnnotations."helm.sh/resource-policy" | string | `"keep"` |  |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"runAsUser":100}` | Default security context configuration |
| service.read.enabled | bool | `true` |  |
| service.read.name | string | `"http-read"` |  |
| service.read.port | int | `80` |  |
| service.read.type | string | `"ClusterIP"` |  |
| service.write.enabled | bool | `true` |  |
| service.write.name | string | `"http-write"` |  |
| service.write.port | int | `80` |  |
| service.write.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` |  |
| tracing | object | `{"datadog":{"enabled":false}}` | Configuration for tracing providers. Only datadog is currently supported through this block. If you need to use a different tracing provider, please manually set the configuration values via "keto.config" or via "extraEnv". |
| watcher | object | `{"enabled":false,"image":"oryd/k8s-toolbox:0.0.2","mountFile":""}` | Watcher sidecar configuration |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
