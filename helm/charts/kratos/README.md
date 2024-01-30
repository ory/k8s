# kratos

![Version: 0.39.1](https://img.shields.io/badge/Version-0.39.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.0.0](https://img.shields.io/badge/AppVersion-v1.0.0-informational?style=flat-square)

A ORY Kratos Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `3` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPU | object | `{}` |  |
| autoscaling.targetMemory | object | `{}` |  |
| cleanup | object | `{"batchSize":100,"enabled":false,"keepLast":"6h","sleepTables":"1m0s"}` | SQL cleanup cron job configuration |
| cleanup.batchSize | int | `100` | Configure how many records are cleaned per run |
| cleanup.enabled | bool | `false` | Enable cleanup of stale database rows by periodically running the cleanup sql command |
| cleanup.keepLast | string | `"6h"` | Configure the youngest records to keep |
| cleanup.sleepTables | string | `"1m0s"` | Configure how long to wait between each table cleanup |
| configmap.annotations | object | `{}` | If you do want to specify annotations for configmap, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| configmap.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| courier | object | `{"enabled":true}` | Configuration of the courier |
| cronjob.cleanup.affinity | object | `{}` | Configure node affinity |
| cronjob.cleanup.annotations | object | `{}` | Set custom cron job level annotations |
| cronjob.cleanup.customArgs | list | `[]` | Configure the arguments of the entrypoint, overriding the default value |
| cronjob.cleanup.extraEnv | list | `[]` | Array of extra envs to be passed to the cronjob. This takes precedence over deployment variables. Kubernetes format is expected - name: FOO   value: BAR |
| cronjob.cleanup.labels | object | `{}` | Set custom cron job level labels |
| cronjob.cleanup.nodeSelector | object | `{}` | Configure node labels for pod assignment |
| cronjob.cleanup.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| cronjob.cleanup.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| cronjob.cleanup.podMetadata.labels | object | `{}` | Extra pod level labels |
| cronjob.cleanup.resources | object | `{"limits":{},"requests":{}}` | We usually recommend not to specify default resources and to leave this as a conscious choice for the user.  This also increases chances charts run on environments with little  resources, such as Minikube. If you do want to specify resources, uncomment the following  lines, adjust them as necessary, and remove the curly braces after 'resources:'.  limits:    cpu: 100m    memory: 128Mi  requests:    cpu: 100m  memory: 128Mi |
| cronjob.cleanup.schedule | string | `"0 */1 * * *"` | Configure how often the cron job is ran |
| cronjob.cleanup.tolerations | list | `[]` | Configure node tolerations |
| deployment.affinity | object | `{}` | Configure node affinity |
| deployment.annotations | object | `{}` |  |
| deployment.automigration | object | `{"extraEnv":[]}` | Parameters for the automigration initContainer |
| deployment.automigration.extraEnv | list | `[]` | Array of extra envs to be passed to the initContainer. Kubernetes format is expected - name: FOO   value: BAR |
| deployment.automountServiceAccountToken | bool | `true` |  |
| deployment.customLivenessProbe | object | `{}` | Configure a custom livenessProbe. This overwrites the default object |
| deployment.customReadinessProbe | object | `{}` | Configure a custom readinessProbe. This overwrites the default object |
| deployment.customStartupProbe | object | `{}` | Configure a custom startupProbe. This overwrites the default object |
| deployment.dnsConfig | object | `{}` | Configure pod dnsConfig. |
| deployment.extraArgs | list | `[]` | Array of extra arguments to be passed down to the deployment. Kubernetes args format is expected - --foo - --sqa-opt-out |
| deployment.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| deployment.extraEnv | list | `[]` | Array of extra envs to be passed to the deployment. Kubernetes format is expected - name: FOO   value: BAR |
| deployment.extraInitContainers | string | `""` | If you want to add extra init containers. These are processed before the migration init container. |
| deployment.extraVolumeMounts | list | `[]` |  |
| deployment.extraVolumes | list | `[]` | If you want to mount external volume For example, mount a secret containing Certificate root CA to verify database TLS connection. |
| deployment.labels | object | `{}` |  |
| deployment.lifecycle | object | `{}` |  |
| deployment.livenessProbe | object | `{"failureThreshold":5,"initialDelaySeconds":5,"periodSeconds":10}` | Configure the livenessProbe parameters |
| deployment.nodeSelector | object | `{}` | Node labels for pod assignment. |
| deployment.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| deployment.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| deployment.podMetadata.labels | object | `{}` | Extra pod level labels |
| deployment.podSecurityContext.fsGroup | int | `65534` |  |
| deployment.podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| deployment.podSecurityContext.runAsGroup | int | `65534` |  |
| deployment.podSecurityContext.runAsNonRoot | bool | `true` |  |
| deployment.podSecurityContext.runAsUser | int | `65534` |  |
| deployment.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| deployment.priorityClassName | string | `""` | Pod priority https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/ |
| deployment.readinessProbe | object | `{"failureThreshold":5,"initialDelaySeconds":5,"periodSeconds":10}` | Configure the readinessProbe parameters |
| deployment.resources | object | `{}` | Set desired resource parameters  We usually recommend not to specify default resources and to leave this as a conscious  choice for the user. This also increases chances charts run on environments with little  resources, such as Minikube. If you do want to specify resources, uncomment the following  lines, adjust them as necessary, and remove the curly braces after 'resources:'. |
| deployment.revisionHistoryLimit | int | `5` | Number of revisions kept in history |
| deployment.serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provide specific permissions to Kratos deployments. Like for example installing Kratos on a cluster with a PosSecurityPolicy and Istio. Uncomment if it is needed to provide a ServiceAccount for the Kratos deployment. |
| deployment.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| deployment.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| deployment.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| deployment.startupProbe | object | `{"failureThreshold":60,"periodSeconds":1,"successThreshold":1,"timeoutSeconds":1}` | Configure the startupProbe parameters |
| deployment.terminationGracePeriodSeconds | int | `60` |  |
| deployment.tolerations | list | `[]` | Configure node tolerations. |
| deployment.topologySpreadConstraints | list | `[]` | Configure pod topologySpreadConstraints. |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"oryd/kratos"` | ORY KRATOS image |
| image.tag | string | `"v1.0.0"` | ORY KRATOS VERSION Alternative format: image: oryd/kratos:v0.6.3-alpha.1 |
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
| job.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation,hook-succeeded","helm.sh/hook-weight":"1"}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| job.automountServiceAccountToken | bool | `true` | Set automounting of the SA token |
| job.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| job.extraEnv | list | `[]` | Array of extra envs to be passed to the job. This takes precedence over deployment variables. Kubernetes format is expected - name: FOO   value: BAR |
| job.extraInitContainers | string | `""` | If you want to add extra init containers. |
| job.lifecycle | string | `""` | If you want to add lifecycle hooks. |
| job.nodeSelector | object | `{}` | Node labels for pod assignment. |
| job.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| job.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| job.podMetadata.labels | object | `{}` | Extra pod level labels |
| job.resources | object | `{}` | resource requests and limits for the job |
| job.serviceAccount | object | `{"annotations":{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provide specific permissions to Kratos deployments Like for example installing Kratos on a cluster with a PosSecurityPolicy and Istio. Uncomment if it is needed to provide a ServiceAccount for the Kratos deployment. |
| job.serviceAccount.annotations | object | `{"helm.sh/hook":"pre-install, pre-upgrade","helm.sh/hook-delete-policy":"before-hook-creation","helm.sh/hook-weight":"0"}` | Annotations to add to the service account |
| job.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| job.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| job.shareProcessNamespace | bool | `false` | Set sharing process namespace |
| job.spec.backoffLimit | int | `10` | Set job back off limit |
| job.tolerations | list | `[]` | Configure node tolerations. |
| kratos.automigration | object | `{"customArgs":[],"customCommand":[],"enabled":false,"resources":{},"type":"job"}` | Enables database migration |
| kratos.automigration.customArgs | list | `[]` | Ability to override arguments of the entrypoint. Can be used in-depended of customCommand eg: - sleep 5;   - kratos |
| kratos.automigration.customCommand | list | `[]` | Ability to override the entrypoint of the automigration container (e.g. to source dynamic secrets or export environment dynamic variables) |
| kratos.automigration.resources | object | `{}` | resource requests and limits for the automigration initcontainer |
| kratos.automigration.type | string | `"job"` | Configure the way to execute database migration. Possible values: job, initContainer When set to job, the migration will be executed as a job on release or upgrade. When set to initContainer, the migration will be executed when Kratos pod is created Defaults to job |
| kratos.config.courier.smtp | object | `{}` |  |
| kratos.config.secrets | object | `{}` |  |
| kratos.config.serve.admin.port | int | `4434` |  |
| kratos.config.serve.public.port | int | `4433` |  |
| kratos.development | bool | `false` |  |
| kratos.emailTemplates | object | `{}` | You can customize the emails Kratos is sending (also uncomment config.courier.template_override_path below) |
| kratos.identitySchemas | object | `{}` | You can add multiple identity schemas here. You can pass JSON schema using `--set-file` Helm CLI argument. |
| nameOverride | string | `""` |  |
| pdb.enabled | bool | `false` |  |
| pdb.spec.maxUnavailable | string | `""` |  |
| pdb.spec.minAvailable | string | `""` |  |
| replicaCount | int | `1` | Number of replicas in deployment |
| secret.enabled | bool | `true` | switch to false to prevent creating the secret |
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
| service.admin.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| service.admin.enabled | bool | `true` |  |
| service.admin.labels | object | `{}` | Provide custom labels. Use the same syntax as for annotations. |
| service.admin.loadBalancerIP | string | `""` | Load balancer IP |
| service.admin.metricsPath | string | `"/admin/metrics/prometheus"` | Path to the metrics endpoint |
| service.admin.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| service.admin.nodePort | string | `""` |  |
| service.admin.port | int | `80` |  |
| service.admin.type | string | `"ClusterIP"` |  |
| service.public.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| service.public.enabled | bool | `true` |  |
| service.public.labels | object | `{}` | Provide custom labels. Use the same syntax as for annotations. |
| service.public.loadBalancerIP | string | `""` | Load balancer IP |
| service.public.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| service.public.nodePort | string | `""` |  |
| service.public.port | int | `80` |  |
| service.public.type | string | `"ClusterIP"` |  |
| serviceMonitor.enabled | bool | `false` | switch to true to enable creating the ServiceMonitor |
| serviceMonitor.labels | object | `{}` | Provide additional labels to the ServiceMonitor ressource metadata |
| serviceMonitor.scheme | string | `"http"` | HTTP scheme to use for scraping. |
| serviceMonitor.scrapeInterval | string | `"60s"` | Interval at which metrics should be scraped |
| serviceMonitor.scrapeTimeout | string | `"30s"` | Timeout after which the scrape is ended |
| serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint |
| statefulSet.affinity | object | `{}` | Configure node affinity |
| statefulSet.annotations | object | `{}` |  |
| statefulSet.dnsConfig | object | `{}` | Configure pod dnsConfig. |
| statefulSet.extraArgs | list | `[]` | Array of extra arguments to be passed down to the StatefulSet. Kubernetes args format is expected |
| statefulSet.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| statefulSet.extraEnv | list | `[]` |  |
| statefulSet.extraInitContainers | string | `""` | If you want to add extra init containers. These are processed before the migration init container. |
| statefulSet.extraVolumeMounts | list | `[]` |  |
| statefulSet.extraVolumes | list | `[]` | If you want to mount external volume For example, mount a secret containing Certificate root CA to verify database TLS connection. |
| statefulSet.labels | object | `{}` | The secret specified here will be used to load environment variables with envFrom. This allows arbitrary environment variables to be provided to the application which is useful for sensitive values which should not be in a configMap. This secret is not created by the helm chart and must already exist in the namespace. https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/#configure-all-key-value-pairs-in-a-secret-as-container-environment-variables environmentSecretsName: |
| statefulSet.log.format | string | `"json"` |  |
| statefulSet.log.level | string | `"trace"` |  |
| statefulSet.nodeSelector | object | `{}` | Node labels for pod assignment. |
| statefulSet.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| statefulSet.podMetadata.labels | object | `{}` | Extra pod level labels |
| statefulSet.podSecurityContext.fsGroup | int | `65534` |  |
| statefulSet.podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| statefulSet.podSecurityContext.runAsGroup | int | `65534` |  |
| statefulSet.podSecurityContext.runAsNonRoot | bool | `true` |  |
| statefulSet.podSecurityContext.runAsUser | int | `65534` |  |
| statefulSet.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| statefulSet.priorityClassName | string | `""` | Pod priority https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/ |
| statefulSet.resources | object | `{}` |  |
| statefulSet.revisionHistoryLimit | int | `5` | Number of revisions kept in history |
| statefulSet.terminationGracePeriodSeconds | int | `60` |  |
| statefulSet.tolerations | list | `[]` | Configure node tolerations. |
| statefulSet.topologySpreadConstraints | list | `[]` | Configure pod topologySpreadConstraints. |
| strategy.rollingUpdate.maxSurge | string | `"25%"` |  |
| strategy.rollingUpdate.maxUnavailable | string | `"25%"` |  |
| strategy.type | string | `"RollingUpdate"` |  |
| test.busybox | object | `{"repository":"busybox","tag":1}` | use a busybox image from another repository |
| watcher.enabled | bool | `false` |  |
| watcher.image | string | `"oryd/k8s-toolbox:0.0.5"` |  |
| watcher.mountFile | string | `""` | Path to mounted file, which wil be monitored for changes. eg: /etc/secrets/my-secret/foo |
| watcher.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| watcher.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| watcher.podMetadata.labels | object | `{}` | Extra pod level labels |
| watcher.revisionHistoryLimit | int | `5` | Number of revisions kept in history |
| watcher.watchLabelKey | string | `"ory.sh/watcher"` | Label key used for managing applications |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
