# keto

![Version: 0.50.2](https://img.shields.io/badge/Version-0.50.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.12.0](https://img.shields.io/badge/AppVersion-v0.12.0-informational?style=flat-square)

Access Control Policies as a Server

**Homepage:** <https://www.ory.sh/keto/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ORY Team | <hi@ory.sh> | <https://www.ory.sh/> |

## Source Code

* <https://github.com/ory/keto>
* <https://github.com/ory/k8s>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../ory-commons | ory(ory-commons) | 0.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| configmap.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| deployment.affinity | object | `{}` |  |
| deployment.annotations | object | `{}` |  |
| deployment.automigration | object | `{"extraEnv":[]}` | Parameters for the automigration initContainer |
| deployment.automigration.extraEnv | list | `[]` | Array of extra envs to be passed to the initContainer. Kubernetes format is expected. Value is processed with Helm `tpl` - name: FOO   value: BAR |
| deployment.automountServiceAccountToken | bool | `true` |  |
| deployment.autoscaling | object | `{"behavior":{},"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPU":{},"targetMemory":{}}` | Autoscaling for keto deployment |
| deployment.autoscaling.behavior | object | `{}` | Set custom behavior https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#configurable-scaling-behavior |
| deployment.customLivenessProbe | object | `{}` |  |
| deployment.customReadinessProbe | object | `{}` |  |
| deployment.customStartupProbe | object | `{}` |  |
| deployment.dnsConfig | object | `{}` | Configure pod dnsConfig. |
| deployment.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| deployment.extraEnv | list | `[]` | Array of extra Envs to be added to the deployment. Kubernetes format expected. Value is processed with Helm `tpl` - name: FOO   value: BAR |
| deployment.extraInitContainers | object | `{}` | If you want to add extra init containers. These are processed before the migration init container. |
| deployment.extraLabels | object | `{}` | Extra labels to be added to the deployment, and pods. K8s object format expected foo: bar my.special.label/type: value |
| deployment.extraPorts | list | `[]` | Extra ports to be exposed by the main deployment |
| deployment.extraVolumeMounts | list | `[]` | Array of extra VolumeMounts to be added to the deployment. K8s format expected - name: my-volume   mountPath: /etc/secrets/my-secret   readOnly: true |
| deployment.extraVolumes | list | `[]` | Array of extra Volumes to be added to the deployment. K8s format expected - name: my-volume   secret:     secretName: my-secret |
| deployment.lifecycle | object | `{}` |  |
| deployment.minReadySeconds | int | `0` |  |
| deployment.nodeSelector | object | `{}` |  |
| deployment.podAnnotations | object | `{}` |  |
| deployment.podMetadata.annotations | object | `{}` |  |
| deployment.podMetadata.labels | object | `{}` |  |
| deployment.podSecurityContext | object | `{}` |  |
| deployment.readinessProbe.failureThreshold | int | `5` |  |
| deployment.readinessProbe.initialDelaySeconds | int | `5` |  |
| deployment.readinessProbe.periodSeconds | int | `10` |  |
| deployment.resources | object | `{}` |  |
| deployment.revisionHistoryLimit | int | `5` | Number of revisions kept in history |
| deployment.startupProbe.failureThreshold | int | `5` |  |
| deployment.startupProbe.initialDelaySeconds | int | `0` |  |
| deployment.startupProbe.periodSeconds | int | `1` |  |
| deployment.startupProbe.successThreshold | int | `1` |  |
| deployment.startupProbe.timeoutSeconds | int | `1` |  |
| deployment.strategy.rollingUpdate.maxSurge | string | `"25%"` |  |
| deployment.strategy.rollingUpdate.maxUnavailable | string | `"25%"` |  |
| deployment.strategy.type | string | `"RollingUpdate"` |  |
| deployment.terminationGracePeriodSeconds | int | `60` |  |
| deployment.tolerations | list | `[]` |  |
| deployment.topologySpreadConstraints | list | `[]` | Configure pod topologySpreadConstraints. |
| extraServices | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | Default image pull policy |
| image.repository | string | `"oryd/keto"` | Ory KETO image |
| image.tag | string | `"v0.12.0"` | Ory KETO version |
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
| job.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation,hook-succeeded","helm.sh/hook-weight":"1"}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| job.automountServiceAccountToken | bool | `false` | Set automounting of the SA token |
| job.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| job.extraEnv | list | `[]` | Array of extra envs to be passed to the job. This takes precedence over deployment variables. Kubernetes format is expected. Value is processed with Helm `tpl` - name: FOO   value: BAR |
| job.extraInitContainers | string | `""` | If you want to add extra init containers. |
| job.lifecycle | string | `""` | If you want to add lifecycle hooks. |
| job.nodeSelector | object | `{}` | Node labels for pod assignment. |
| job.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| job.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| job.podMetadata.labels | object | `{}` | Extra pod level labels |
| job.resources | object | `{}` | Job resources |
| job.serviceAccount | object | `{"annotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provides specific permissions to Hydra deployments Like for example installing Hydra on a cluster with a PosSecurityPolicy and Istio. Uncoment if it is needed to provide a ServiceAccount for the Hydra deployment. |
| job.serviceAccount.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"}` | Annotations to add to the service account |
| job.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| job.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| job.shareProcessNamespace | bool | `false` | Set sharing process namespace |
| job.spec.backoffLimit | int | `10` | Set job back off limit |
| job.tolerations | list | `[]` | Configure node tolerations. |
| keto.automigration | object | `{"customArgs":[],"customCommand":[],"enabled":false,"resources":{},"type":"job"}` | Enables database migration |
| keto.automigration.customArgs | list | `[]` | Ability to override arguments of the entrypoint. Can be used in-depended of customCommand eg: - sleep 5;   - keto |
| keto.automigration.customCommand | list | `[]` | Ability to override the entrypoint of the automigration container (e.g. to source dynamic secrets or export environment dynamic variables) |
| keto.automigration.resources | object | `{}` | resource requests and limits for the automigration initcontainer |
| keto.automigration.type | string | `"job"` | Configure the way to execute database migration. Possible values: job, initContainer When set to job, the migration will be executed as a job on release or upgrade. When set to initContainer, the migration will be executed when kratos pod is created Defaults to job |
| keto.command | list | `["keto"]` | Ability to override the entrypoint of keto container (e.g. to source dynamic secrets or export environment dynamic variables) |
| keto.config | object | `{"dsn":"memory","namespaces":[{"id":0,"name":"sample"}],"serve":{"metrics":{"port":4468},"read":{"port":4466},"write":{"port":4467}}}` | Direct keto config. Full documentation can be found in https://www.ory.sh/keto/docs/reference/configuration |
| keto.customArgs | list | `[]` | Ability to override arguments of the entrypoint. Can be used in-depended of customCommand |
| nameOverride | string | `""` |  |
| pdb.enabled | bool | `false` |  |
| pdb.spec.maxUnavailable | string | `""` |  |
| pdb.spec.minAvailable | string | `""` |  |
| podSecurityContext.fsGroup | int | `65534` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| podSecurityContext.runAsGroup | int | `65534` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `65534` |  |
| podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| priorityClassName | string | `""` | Pod priority https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/ |
| replicaCount | int | `1` | Number of replicas in deployment |
| secret.enabled | bool | `true` | Switch to false to prevent creating the secret |
| secret.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| secret.nameOverride | string | `""` | Provide custom name of existing secret, or custom name of secret to be created |
| secret.secretAnnotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0","helm.sh/resource-policy":"keep"}` | Annotations to be added to secret. Annotations are added only when secret is being created. Existing secret will not be modified. |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsGroup | int | `65534` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `65534` |  |
| securityContext.seLinuxOptions.level | string | `"s0:c123,c456"` |  |
| securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| service.metrics.annotations | object | `{}` |  |
| service.metrics.enabled | bool | `false` |  |
| service.metrics.loadBalancerIP | string | `""` |  |
| service.metrics.name | string | `"http-metrics"` |  |
| service.metrics.port | int | `80` |  |
| service.metrics.type | string | `"ClusterIP"` |  |
| service.read.appProtocol | string | `"grpc"` |  |
| service.read.clusterIP | string | `""` |  |
| service.read.enabled | bool | `true` |  |
| service.read.headless.enabled | bool | `true` |  |
| service.read.loadBalancerIP | string | `""` |  |
| service.read.name | string | `"grpc-read"` |  |
| service.read.port | int | `80` |  |
| service.read.type | string | `"ClusterIP"` |  |
| service.write.appProtocol | string | `"grpc"` |  |
| service.write.clusterIP | string | `""` |  |
| service.write.enabled | bool | `true` |  |
| service.write.headless.enabled | bool | `true` |  |
| service.write.loadBalancerIP | string | `""` |  |
| service.write.name | string | `"grpc-write"` |  |
| service.write.port | int | `80` |  |
| service.write.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceMonitor.labels | object | `{}` | Provide additionnal labels to the ServiceMonitor ressource metadata |
| serviceMonitor.scheme | string | `"http"` | HTTP scheme to use for scraping. |
| serviceMonitor.scrapeInterval | string | `"60s"` | Interval at which metrics should be scraped |
| serviceMonitor.scrapeTimeout | string | `"30s"` | Timeout after which the scrape is ended |
| serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint |
| test.busybox | object | `{"repository":"busybox","tag":1}` | use a busybox image from another repository |
| test.labels | object | `{}` | Provide additional labels to the test pod |
| watcher.automountServiceAccountToken | bool | `true` |  |
| watcher.enabled | bool | `false` |  |
| watcher.image | string | `"oryd/k8s-toolbox:v0.0.7"` |  |
| watcher.mountFile | string | `""` | Path to mounted file, which wil be monitored for changes. eg: /etc/secrets/my-secret/foo |
| watcher.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| watcher.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| watcher.podMetadata.labels | object | `{}` | Extra pod level labels |
| watcher.resources | object | `{}` |  |
| watcher.revisionHistoryLimit | int | `5` | Number of revisions kept in history |
| watcher.watchLabelKey | string | `"ory.sh/watcher"` | Label key used for managing applications |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
