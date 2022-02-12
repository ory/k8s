# keto

![Version: 0.21.8](https://img.shields.io/badge/Version-0.21.8-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.8.0](https://img.shields.io/badge/AppVersion-v0.8.0-informational?style=flat-square)

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
| autoscaling | object | `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | Autoscaling for keto deployment |
| deployment | object | `{"annotations":{},"livenessProbe":{"failureThreshold":5,"initialDelaySeconds":30,"periodSeconds":10},"readinessProbe":{"failureThreshold":5,"initialDelaySeconds":30,"periodSeconds":10}}` | Configure the probes for when the deployment is considered ready and ongoing health check |
| deployment.annotations | object | `{}` | Add custom annotations to the deployment |
| extraContainers | object | `{}` | If you want to add extra sidecar containers.  |
| extraEnv | list | `[]` | Array of extra Envs to be added to the deployment. K8s format expected - name: FOO   value: BAR |
| extraLabels | object | `{}` | Extra labels to be added to the deployment, and pods. K8s object format expected foo: bar my.special.label/type: value |
| extraVolumeMounts | list | `[]` | Array of extra VolumeMounts to be added to the deployment. K8s format expected - name: my-volume   mountPath: /etc/secrets/my-secret   readOnly: true |
| extraVolumes | list | `[]` | Array of extra Volumes to be added to the deployment. K8s format expected - name: my-volume   secret:     secretName: my-secret |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | Default image pull policy |
| image.repository | string | `"oryd/keto"` | Ory KETO image |
| image.tag | string | `"v0.8.0-alpha.0"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress | object | `{"read":{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"chart-example.local","paths":[{"path":"/read","pathType":"Prefix"}]}],"tls":[]},"write":{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"chart-example.local","paths":[{"path":"/write","pathType":"Prefix"}]}],"tls":[]}}` | Ingress definitions |
| job | object | `{"annotations":{},"extraContainers":{},"lifecycle":{},"shareProcessNamespace":false}` | Values for initialization job |
| job.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| job.extraContainers | object | `{}` | If you want to add extra sidecar containers.  |
| job.lifecycle | object | `{}` | If you want to add lifecycle hooks.  |
| keto | object | `{"autoMigrate":false,"config":{"dsn":"memory","namespaces":[{"id":0,"name":"sample"}],"serve":{"metrics":{"port":4468},"read":{"port":4466},"write":{"port":4467}}}}` | Main keto config. Full documentation can be found in https://www.ory.sh/keto/docs/reference/configuration |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| pdb | object | `{"enabled":false,"spec":{"minAvailable":1}}` | PodDistributionBudget configuration |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| secret | object | `{"enabled":true,"nameOverride":"","secretAnnotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0","helm.sh/resource-policy":"keep"}}` | Secret management |
| secret.enabled | bool | `true` | Switch to false to prevent creating the secret |
| secret.nameOverride | string | `""` | Provide custom name of existing secret, or custom name of secret to be created |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"runAsUser":100}` | Default security context configuration |
| service | object | `{"metrics":{"annotations":{},"enabled":false,"name":"http-metrics","port":80,"type":"ClusterIP"},"read":{"enabled":true,"name":"http-read","port":80,"type":"ClusterIP"},"write":{"enabled":true,"name":"http-write","port":80,"type":"ClusterIP"}}` | Service configurations |
| service.metrics | object | `{"annotations":{},"enabled":false,"name":"http-metrics","port":80,"type":"ClusterIP"}` | Metrics service |
| service.read | object | `{"enabled":true,"name":"http-read","port":80,"type":"ClusterIP"}` | Read service |
| service.write | object | `{"enabled":true,"name":"http-write","port":80,"type":"ClusterIP"}` | Write service |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` |  |
| tracing | object | `{"datadog":{"enabled":false}}` | Configuration for tracing providers. Only datadog is currently supported through this block. If you need to use a different tracing provider, please manually set the configuration values via "keto.config" or via "extraEnv". |
| watcher | object | `{"enabled":false,"image":"oryd/k8s-toolbox:0.0.2","mountFile":""}` | Watcher sidecar configuration |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
