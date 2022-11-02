# hydra

![Version: 0.25.6](https://img.shields.io/badge/Version-0.25.6-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.0.1](https://img.shields.io/badge/AppVersion-v2.0.1-informational?style=flat-square)

A Helm chart for deploying ORY Hydra in Kubernetes

**Homepage:** <https://www.ory.sh/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ORY Team | <hi@ory.sh> | <https://www.ory.sh/> |

## Source Code

* <https://github.com/ory/hydra>
* <https://github.com/ory/k8s>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../hydra-maester | hydra-maester(hydra-maester) | 0.25.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Configure node affinity |
| configmap.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| cronjob | object | `{"janitor":{"affinity":{},"annotations":{},"customArgs":[],"labels":{},"nodeSelector":{},"podMetadata":{"annotations":{},"labels":{}},"resources":{"limits":{},"requests":{}},"schedule":"0 */1 * * *","securityContext":{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"runAsUser":100},"tolerations":[]}}` | CronJob configuration |
| cronjob.janitor.affinity | object | `{}` | Configure node affinity |
| cronjob.janitor.annotations | object | `{}` | Set custom cron job level annotations |
| cronjob.janitor.customArgs | list | `[]` | Configure the arguments of the entrypoint, overriding the default value |
| cronjob.janitor.labels | object | `{}` | Set custom cron job level labels |
| cronjob.janitor.nodeSelector | object | `{}` | Configure node labels for pod assignment |
| cronjob.janitor.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| cronjob.janitor.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| cronjob.janitor.podMetadata.labels | object | `{}` | Extra pod level labels |
| cronjob.janitor.resources | object | `{"limits":{},"requests":{}}` | We usually recommend not to specify default resources and to leave this as a conscious choice for the user.  This also increases chances charts run on environments with little  resources, such as Minikube. If you do want to specify resources, uncomment the following  lines, adjust them as necessary, and remove the curly braces after 'resources:'.  limits:    cpu: 100m    memory: 128Mi  requests:    cpu: 100m  memory: 128Mi |
| cronjob.janitor.schedule | string | `"0 */1 * * *"` | Configure how often the cron job is ran |
| cronjob.janitor.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsNonRoot":true,"runAsUser":100}` | Configure the containers' SecurityContext |
| cronjob.janitor.tolerations | list | `[]` | Configure node tolerations |
| deployment.annotations | object | `{}` | Set custom deployment level annotations |
| deployment.automigration | object | `{"extraEnv":[]}` | Parameters for the automigration initContainer |
| deployment.automigration.extraEnv | list | `[]` | Array of extra envs to be passed to the initContainer. Kubernetes format is expected - name: FOO   value: BAR |
| deployment.automountServiceAccountToken | bool | `true` |  |
| deployment.autoscaling | object | `{"enabled":false,"maxReplicas":3,"minReplicas":1}` | Configure HPA |
| deployment.customLivenessProbe | object | `{}` | Configure a custom livenessProbe. This overwrites the default object  |
| deployment.customReadinessProbe | object | `{}` | Configure a custom readinessProbe. This overwrites the default object   |
| deployment.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| deployment.extraEnv | list | `[]` | Array of extra envs to be passed to the deployment. Kubernetes format is expected - name: FOO   value: BAR |
| deployment.extraInitContainers | string | `""` | If you want to add extra init containers. |
| deployment.extraVolumeMounts | list | `[]` |  |
| deployment.extraVolumes | list | `[]` | If you want to mount external volume |
| deployment.labels | object | `{}` | Set custom deployment level labels |
| deployment.lifecycle | object | `{}` |  |
| deployment.livenessProbe | object | `{"failureThreshold":5,"initialDelaySeconds":30,"periodSeconds":10}` | Configure the probes for when the deployment is considered ready and ongoing health check |
| deployment.nodeSelector | object | `{}` | Node labels for pod assignment. |
| deployment.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| deployment.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| deployment.podMetadata.labels | object | `{}` | Extra pod level labels |
| deployment.readinessProbe.failureThreshold | int | `5` |  |
| deployment.readinessProbe.initialDelaySeconds | int | `30` |  |
| deployment.readinessProbe.periodSeconds | int | `10` |  |
| deployment.resources | object | `{}` | We usually recommend not to specify default resources and to leave this as a conscious choice for the user.  This also increases chances charts run on environments with little  resources, such as Minikube. If you do want to specify resources, uncomment the following  lines, adjust them as necessary, and remove the curly braces after 'resources:'.  limits:    cpu: 100m    memory: 128Mi  requests:    cpu: 100m  memory: 128Mi |
| deployment.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| deployment.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| deployment.securityContext.privileged | bool | `false` |  |
| deployment.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| deployment.securityContext.runAsNonRoot | bool | `true` |  |
| deployment.securityContext.runAsUser | int | `100` |  |
| deployment.serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provides specific permissions to Hydra deployments Like for example installing Hydra on a cluster with a PosSecurityPolicy and Istio. Uncoment if it is needed to provide a ServiceAccount for the Hydra deployment. |
| deployment.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| deployment.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| deployment.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| deployment.tolerations | list | `[]` | Configure node tolerations. |
| fullnameOverride | string | `""` | Full chart name override |
| hydra | object | `{"automigration":{"customArgs":[],"customCommand":[],"enabled":false,"type":"job"},"config":{"secrets":{},"serve":{"admin":{"port":4445},"public":{"port":4444},"tls":{"allow_termination_from":["10.0.0.0/8","172.16.0.0/12","192.168.0.0/16"]}},"urls":{"self":{}}},"dev":false}` | Configure ORY Hydra itself |
| hydra-maester | object | `{"adminService":{"name":"","port":null}}` | Values for the hydra admin service arguments to hydra-maester |
| hydra-maester.adminService.name | string | `""` | The service name value may need to be set if you use `fullnameOverride` for the parent chart |
| hydra-maester.adminService.port | string | `nil` | You only need to set this port if you change the value for `service.admin.port` in the parent chart |
| hydra.automigration.customArgs | list | `[]` | Ability to override arguments of the entrypoint. Can be used in-depended of customCommand eg: - sleep 5;   - kratos |
| hydra.automigration.customCommand | list | `[]` | Ability to override the entrypoint of the automigration container (e.g. to source dynamic secrets or export environment dynamic variables) |
| hydra.automigration.type | string | `"job"` | Configure the way to execute database migration. Possible values: job, initContainer When set to job, the migration will be executed as a job on release or upgrade. When set to initContainer, the migration will be executed when kratos pod is created Defaults to job |
| hydra.config | object | `{"secrets":{},"serve":{"admin":{"port":4445},"public":{"port":4444},"tls":{"allow_termination_from":["10.0.0.0/8","172.16.0.0/12","192.168.0.0/16"]}},"urls":{"self":{}}}` | The ORY Hydra configuration. For a full list of available settings, check:  https://www.ory.sh/docs/hydra/reference/configuration |
| hydra.config.secrets | object | `{}` | The secrets have to be provided as a string slice, example: system:   - "OG5XbmxXa3dYeGplQXpQanYxeEFuRUFa"   - "foo bar 123 456 lorem"   - "foo bar 123 456 lorem 1"   - "foo bar 123 456 lorem 2"   - "foo bar 123 456 lorem 3" |
| hydra.dev | bool | `false` | Enable dev mode, not secure in production environments  |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"oryd/hydra"` | ORY Hydra image |
| image.tag | string | `"v2.0.1"` | ORY Hydra version |
| imagePullSecrets | list | `[]` | Image pull secrets |
| ingress | object | `{"admin":{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"admin.hydra.localhost","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]},"public":{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"public.hydra.localhost","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]}}` | Configure ingress |
| ingress.admin.enabled | bool | `false` | En-/Disable the api ingress. |
| ingress.public | object | `{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"public.hydra.localhost","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]}` | Configure ingress for the proxy port. |
| ingress.public.enabled | bool | `false` | En-/Disable the proxy ingress. |
| janitor.batchSize | int | `100` |  |
| janitor.cleanupGrants | bool | `false` |  |
| janitor.cleanupRequests | bool | `false` |  |
| janitor.cleanupTokens | bool | `false` |  |
| janitor.enabled | bool | `false` | Enable cleanup of stale database rows by periodically running the janitor command |
| janitor.limit | int | `10000` |  |
| job | object | `{"annotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"1"},"automountServiceAccountToken":true,"extraContainers":"","extraEnv":[],"extraInitContainers":"","labels":{},"lifecycle":"","nodeSelector":{},"podMetadata":{"annotations":{},"labels":{}},"serviceAccount":{"annotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"},"create":true,"name":""},"shareProcessNamespace":false,"spec":{"backoffLimit":10}}` | Values for initialization job |
| job.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"1"}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| job.automountServiceAccountToken | bool | `true` | Set automounting of the SA token |
| job.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| job.extraEnv | list | `[]` | Array of extra envs to be passed to the job. This takes precedence over deployment variables. Kubernetes format is expected - name: FOO   value: BAR |
| job.extraInitContainers | string | `""` | If you want to add extra init containers. extraInitContainers: |  - name: ...    image: ... |
| job.labels | object | `{}` | Set custom deployment level labels |
| job.lifecycle | string | `""` | If you want to add lifecycle hooks. |
| job.nodeSelector | object | `{}` | Node labels for pod assignment. |
| job.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| job.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| job.podMetadata.labels | object | `{}` | Extra pod level labels |
| job.serviceAccount | object | `{"annotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provides specific permissions to Hydra deployments Like for example installing Hydra on a cluster with a PosSecurityPolicy and Istio. Uncoment if it is needed to provide a ServiceAccount for the Hydra deployment. |
| job.serviceAccount.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"}` | Annotations to add to the service account |
| job.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| job.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| job.shareProcessNamespace | bool | `false` | Set sharing process namespace |
| job.spec.backoffLimit | int | `10` | Set job back off limit |
| maester | object | `{"enabled":true}` | Configures controller setup |
| nameOverride | string | `""` |  |
| pdb | object | `{"enabled":false,"spec":{"minAvailable":1}}` | PodDistributionBudget configuration |
| replicaCount | int | `1` | Number of ORY Hydra members |
| secret.enabled | bool | `true` | switch to false to prevent creating the secret |
| secret.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| secret.nameOverride | string | `""` | Provide custom name of existing secret, or custom name of secret to be created |
| secret.secretAnnotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0","helm.sh/resource-policy":"keep"}` | Annotations to be added to secret. Annotations are added only when secret is being created. Existing secret will not be modified. |
| service | object | `{"admin":{"annotations":{},"enabled":true,"labels":{},"metricsPath":"/admin/metrics/prometheus","name":"http","port":4445,"type":"ClusterIP"},"public":{"annotations":{},"enabled":true,"labels":{},"name":"http","port":4444,"type":"ClusterIP"}}` | Configures the Kubernetes service |
| service.admin | object | `{"annotations":{},"enabled":true,"labels":{},"metricsPath":"/admin/metrics/prometheus","name":"http","port":4445,"type":"ClusterIP"}` | Configures the Kubernetes service for the api port. |
| service.admin.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| service.admin.enabled | bool | `true` | En-/disable the service |
| service.admin.metricsPath | string | `"/admin/metrics/prometheus"` | Path to the metrics endpoint |
| service.admin.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| service.admin.port | int | `4445` | The service port |
| service.admin.type | string | `"ClusterIP"` | The service type |
| service.public | object | `{"annotations":{},"enabled":true,"labels":{},"name":"http","port":4444,"type":"ClusterIP"}` | Configures the Kubernetes service for the proxy port. |
| service.public.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| service.public.enabled | bool | `true` | En-/disable the service |
| service.public.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| service.public.port | int | `4444` | The service port |
| service.public.type | string | `"ClusterIP"` | The service type |
| serviceMonitor | object | `{"enabled":true,"labels":{},"scheme":"http","scrapeInterval":"60s","scrapeTimeout":"30s","tlsConfig":{}}` | Parameters for the Prometheus ServiceMonitor objects. Reference: https://docs.openshift.com/container-platform/4.6/rest_api/monitoring_apis/servicemonitor-monitoring-coreos-com-v1.html |
| serviceMonitor.enabled | bool | `true` | switch to false to prevent creating the ServiceMonitor |
| serviceMonitor.labels | object | `{}` | Provide additionnal labels to the ServiceMonitor ressource metadata |
| serviceMonitor.scheme | string | `"http"` | HTTP scheme to use for scraping. |
| serviceMonitor.scrapeInterval | string | `"60s"` | Interval at which metrics should be scraped |
| serviceMonitor.scrapeTimeout | string | `"30s"` | Timeout after which the scrape is ended |
| serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint |
| watcher | object | `{"enabled":false,"image":"oryd/k8s-toolbox:0.0.4","mountFile":"","podMetadata":{"annotations":{},"labels":{}}}` | Sidecar watcher configuration |
| watcher.mountFile | string | `""` | Path to mounted file, which wil be monitored for changes. eg: /etc/secrets/my-secret/foo |
| watcher.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| watcher.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| watcher.podMetadata.labels | object | `{}` | Extra pod level labels |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
