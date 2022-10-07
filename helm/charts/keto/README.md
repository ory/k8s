# keto

![Version: 0.25.4](https://img.shields.io/badge/Version-0.25.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.8.0-alpha.2](https://img.shields.io/badge/AppVersion-v0.8.0--alpha.2-informational?style=flat-square)

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
| configmap.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| deployment | object | `{"affinity":{},"annotations":{},"automountServiceAccountToken":true,"autoscaling":{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80},"extraContainers":"","extraEnv":[],"extraInitContainers":{},"extraLabels":{},"extraVolumeMounts":[],"extraVolumes":[],"livenessProbe":{"failureThreshold":5,"initialDelaySeconds":30,"periodSeconds":10},"nodeSelector":{},"podAnnotations":{},"podMetadata":{"annotations":{},"labels":{}},"podSecurityContext":{},"readinessProbe":{"failureThreshold":5,"initialDelaySeconds":30,"periodSeconds":10},"resources":{},"tolerations":[]}` | Configure the probes for when the deployment is considered ready and ongoing health check |
| deployment.annotations | object | `{}` | Add custom annotations to the deployment |
| deployment.autoscaling | object | `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | Autoscaling for keto deployment |
| deployment.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| deployment.extraEnv | list | `[]` | Array of extra Envs to be added to the deployment. K8s format expected - name: FOO   value: BAR |
| deployment.extraInitContainers | object | `{}` | If you want to add extra init containers. |
| deployment.extraLabels | object | `{}` | Extra labels to be added to the deployment, and pods. K8s object format expected foo: bar my.special.label/type: value |
| deployment.extraVolumeMounts | list | `[]` | Array of extra VolumeMounts to be added to the deployment. K8s format expected - name: my-volume   mountPath: /etc/secrets/my-secret   readOnly: true |
| deployment.extraVolumes | list | `[]` | Array of extra Volumes to be added to the deployment. K8s format expected - name: my-volume   secret:     secretName: my-secret |
| deployment.podAnnotations | object | `{}` | DEPRECATED Set custom pod annotations |
| deployment.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| deployment.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| deployment.podMetadata.labels | object | `{}` | Extra pod level labels |
| deployment.podSecurityContext | object | `{}` | Set custom security context for pods |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | Default image pull policy |
| image.repository | string | `"oryd/keto"` | Ory KETO image |
| image.tag | string | `"v0.8.0-alpha.2"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress | object | `{"read":{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"chart-example.local","paths":[{"path":"/read","pathType":"Prefix"}]}],"tls":[]},"write":{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"chart-example.local","paths":[{"path":"/write","pathType":"Prefix"}]}],"tls":[]}}` | Ingress definitions |
| job | object | `{"annotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation,hook-succeeded","helm.sh/hook-weight":"1"},"automountServiceAccountToken":true,"extraContainers":"","extraInitContainers":"","lifecycle":"","nodeSelector":{},"podMetadata":{"annotations":{},"labels":{}},"serviceAccount":{"annotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"},"create":true,"name":""},"shareProcessNamespace":false,"spec":{"backoffLimit":10}}` | Values for initialization job |
| job.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation,hook-succeeded","helm.sh/hook-weight":"1"}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| job.automountServiceAccountToken | bool | `true` | Set automounting of the SA token |
| job.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| job.extraInitContainers | string | `""` | If you want to add extra init containers. |
| job.lifecycle | string | `""` | If you want to add lifecycle hooks. |
| job.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| job.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| job.podMetadata.labels | object | `{}` | Extra pod level labels |
| job.serviceAccount | object | `{"annotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provides specific permissions to Hydra deployments Like for example installing Hydra on a cluster with a PosSecurityPolicy and Istio. Uncoment if it is needed to provide a ServiceAccount for the Hydra deployment. |
| job.serviceAccount.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"}` | Annotations to add to the service account |
| job.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| job.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| job.shareProcessNamespace | bool | `false` | Set sharing process namespace |
| job.spec.backoffLimit | int | `10` | Set job back off limit |
| keto | object | `{"automigration":{"customArgs":[],"customCommand":[],"enabled":false,"type":"job"},"config":{"dsn":"memory","namespaces":[{"id":0,"name":"sample"}],"serve":{"metrics":{"port":4468},"read":{"port":4466},"write":{"port":4467}}}}` | Main application config. |
| keto.automigration | object | `{"customArgs":[],"customCommand":[],"enabled":false,"type":"job"}` | Enables database migration |
| keto.automigration.customArgs | list | `[]` | Ability to override arguments of the entrypoint. Can be used in-depended of customCommand  eg: - sleep 5;   - keto |
| keto.automigration.customCommand | list | `[]` | Ability to override the entrypoint of the automigration container (e.g. to source dynamic secrets or export environment dynamic variables) |
| keto.automigration.type | string | `"job"` | Configure the way to execute database migration. Possible values: job, initContainer When set to job, the migration will be executed as a job on release or upgrade. When set to initContainer, the migration will be executed when kratos pod is created Defaults to job   |
| keto.config | object | `{"dsn":"memory","namespaces":[{"id":0,"name":"sample"}],"serve":{"metrics":{"port":4468},"read":{"port":4466},"write":{"port":4467}}}` | Direct keto config. Full documentation can be found in https://www.ory.sh/keto/docs/reference/configuration |
| nameOverride | string | `""` |  |
| pdb | object | `{"enabled":false,"spec":{"minAvailable":1}}` | PodDistributionBudget configuration |
| replicaCount | int | `1` |  |
| secret | object | `{"enabled":true,"hashSumEnabled":true,"nameOverride":"","secretAnnotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0","helm.sh/resource-policy":"keep"}}` | Secret management |
| secret.enabled | bool | `true` | Switch to false to prevent creating the secret |
| secret.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| secret.nameOverride | string | `""` | Provide custom name of existing secret, or custom name of secret to be created |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"runAsUser":100}` | Default security context configuration |
| service | object | `{"metrics":{"annotations":{},"enabled":false,"name":"http-metrics","port":80,"type":"ClusterIP"},"read":{"enabled":true,"name":"grpc-read","port":80,"type":"ClusterIP"},"write":{"enabled":true,"name":"grpc-write","port":80,"type":"ClusterIP"}}` | Service configurations |
| service.metrics | object | `{"annotations":{},"enabled":false,"name":"http-metrics","port":80,"type":"ClusterIP"}` | Metrics service |
| service.read | object | `{"enabled":true,"name":"grpc-read","port":80,"type":"ClusterIP"}` | Read service |
| service.write | object | `{"enabled":true,"name":"grpc-write","port":80,"type":"ClusterIP"}` | Write service |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceMonitor | object | `{"labels":{},"scheme":"http","scrapeInterval":"60s","scrapeTimeout":"30s","tlsConfig":{}}` | Parameters for the Prometheus ServiceMonitor objects. Reference: https://docs.openshift.com/container-platform/4.6/rest_api/monitoring_apis/servicemonitor-monitoring-coreos-com-v1.html |
| serviceMonitor.labels | object | `{}` | Provide additionnal labels to the ServiceMonitor ressource metadata |
| serviceMonitor.scheme | string | `"http"` | HTTP scheme to use for scraping. |
| serviceMonitor.scrapeInterval | string | `"60s"` | Interval at which metrics should be scraped |
| serviceMonitor.scrapeTimeout | string | `"30s"` | Timeout after which the scrape is ended |
| serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint |
| watcher | object | `{"enabled":false,"image":"oryd/k8s-toolbox:0.0.4","mountFile":"","podMetadata":{"annotations":{},"labels":{}}}` | Watcher sidecar configuration |
| watcher.mountFile | string | `""` | Path to mounted file, which wil be monitored for changes. eg: /etc/secrets/my-secret/foo |
| watcher.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| watcher.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| watcher.podMetadata.labels | object | `{}` | Extra pod level labels |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
