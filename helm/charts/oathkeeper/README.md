# oathkeeper

![Version: 0.52.0](https://img.shields.io/badge/Version-0.52.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.40.9](https://img.shields.io/badge/AppVersion-v0.40.9-informational?style=flat-square)

A Helm chart for deploying ORY Oathkeeper in Kubernetes

**Homepage:** <https://www.ory.sh/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ORY Team | <office@ory.sh> | <https://www.ory.sh/> |

## Source Code

* <https://github.com/ory/oathkeeper>
* <https://github.com/ory/k8s>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../oathkeeper-maester | oathkeeper-maester(oathkeeper-maester) | 0.52.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Configure node affinity |
| configmap.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| demo | bool | `false` | If enabled, a demo deployment with exemplary access rules and JSON Web Key Secrets will be generated. |
| deployment.annotations | object | `{}` |  |
| deployment.automountServiceAccountToken | bool | `true` |  |
| deployment.autoscaling | object | `{"behavior":{},"enabled":false,"extraMetrics":[],"maxReplicas":5,"minReplicas":1,"targetCPU":{},"targetMemory":{}}` | Configure horizontal pod autoscaler for deployment |
| deployment.autoscaling.behavior | object | `{}` | Set custom behavior https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#configurable-scaling-behavior |
| deployment.autoscaling.extraMetrics | list | `[]` | Add extraContainer container resource metrics https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#container-resource-metrics |
| deployment.customLivenessProbe | object | `{}` | Configure a custom livenessProbe. This overwrites the default object |
| deployment.customReadinessProbe | object | `{}` | Configure a custom readinessProbe. This overwrites the default object |
| deployment.customStartupProbe | object | `{}` | Configure a custom startupProbe. This overwrites the default object |
| deployment.dnsConfig | object | `{}` | Configure pod dnsConfig. |
| deployment.extraArgs | list | `[]` | Array of extra arguments to be passed down to the Deployment. Kubernetes args format is expected |
| deployment.extraContainers | string | `""` | If you want to add extra sidecar containers. |
| deployment.extraEnv | list | `[]` | Array of extra envs to be passed to the deployment. Kubernetes format is expected. Value is processed with Helm `tpl` - name: FOO   value: BAR |
| deployment.extraInitContainers | string | `""` | If you want to add extra init containers. |
| deployment.extraVolumeMounts | list | `[]` | Extra volume mounts, allows mounting the extraVolumes to the container. |
| deployment.extraVolumes | list | `[]` | Extra volumes you can attach to the pod. |
| deployment.labels | object | `{}` |  |
| deployment.lifecycle | object | `{}` |  |
| deployment.nodeSelector | object | `{}` | Node labels for pod assignment. |
| deployment.podMetadata | object | `{"annotations":{},"labels":{}}` | Specify pod metadata, this metadata is added directly to the pod, and not higher objects |
| deployment.podMetadata.annotations | object | `{}` | Extra pod level annotations |
| deployment.podMetadata.labels | object | `{}` | Extra pod level labels |
| deployment.readinessProbe | object | `{"failureThreshold":5,"initialDelaySeconds":5,"periodSeconds":10}` | Configure the readinessProbe parameters |
| deployment.resources | object | `{}` |  |
| deployment.serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provides specific permissions to Hydra deployments Like for example installing Hydra on a cluster with a PosSecurityPolicy and Istio. Uncoment if it is needed to provide a ServiceAccount for the Hydra deployment.** |
| deployment.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| deployment.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| deployment.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| deployment.startupProbe | object | `{"failureThreshold":5,"initialDelaySeconds":1,"successThreshold":1,"timeoutSeconds":2}` | Configure the startupProbe parameters |
| deployment.strategy.rollingUpdate | object | `{}` |  |
| deployment.strategy.type | string | `"RollingUpdate"` |  |
| deployment.terminationGracePeriodSeconds | int | `60` |  |
| deployment.tolerations | list | `[]` | Configure node tolerations. |
| deployment.topologySpreadConstraints | list | `[]` | Configure pod topologySpreadConstraints. |
| fullnameOverride | string | `""` | Full chart name override |
| global.ory.oathkeeper.maester.mode | string | `"controller"` |  |
| image.initContainer | object | `{"repository":"busybox","tag":1}` | use a busybox image from another repository |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"oryd/oathkeeper"` | ORY Oathkeeper image |
| image.tag | string | `"v0.40.9"` | ORY Oathkeeper version |
| imagePullSecrets | list | `[]` | Image pull secrets |
| ingress.api.annotations | object | `{}` |  |
| ingress.api.className | string | `""` |  |
| ingress.api.enabled | bool | `false` | En-/Disable the api ingress. |
| ingress.api.hosts[0].host | string | `"api.oathkeeper.localhost"` |  |
| ingress.api.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.api.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.proxy | object | `{"annotations":{},"className":"","defaultBackend":{},"enabled":false,"hosts":[{"host":"proxy.oathkeeper.localhost","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]}` | Configure ingress for the proxy port. |
| ingress.proxy.defaultBackend | object | `{}` | Configuration for custom default service. This service will be used to handle the response when the configured service in the Ingress rule does not have any active endpoints |
| ingress.proxy.enabled | bool | `false` | En-/Disable the proxy ingress. |
| maester.enabled | bool | `false` |  |
| nameOverride | string | `""` | Chart name override |
| oathkeeper.accessRules | string | `""` | If set, uses the given access rules. |
| oathkeeper.config | object | `{"access_rules":{"repositories":["file:///etc/rules/access-rules.json"]},"serve":{"api":{"port":4456},"prometheus":{"port":9000},"proxy":{"port":4455}}}` | The ORY Oathkeeper configuration. For a full list of available settings, check:   https://github.com/ory/oathkeeper/blob/master/docs/config.yaml |
| oathkeeper.helmTemplatedConfigEnabled | bool | `false` | Runs the `tpl` function on the config object. Warrning! This may break configuration settings that use go templates, like https://github.com/ory/k8s/issues/707 |
| oathkeeper.managedAccessRules | bool | `true` | If you enable maester, the following value should be set to "false" to avoid overwriting the rules generated by the CDRs. Additionally, the value "accessRules" shouldn't be used as it will have no effect once "managedAccessRules" is disabled. |
| oathkeeper.mutatorIdTokenJWKs | string | `""` | If set, uses the given JSON Web Key Set as the signing key for the ID Token Mutator. Requires secret.enabled to be set `true`. |
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
| replicaCount | int | `1` | Number of ORY Oathkeeper members |
| revisionHistoryLimit | int | `5` | Number of revisions kept in history |
| secret.enabled | bool | `false` | Switch to false to prevent using mutatorIdTokenJWKs secret |
| secret.filename | string | `"mutator.id_token.jwks.json"` | default filename of JWKS (mounted as secret) |
| secret.hashSumEnabled | bool | `true` | switch to false to prevent checksum annotations being maintained and propogated to the pods |
| secret.mountPath | string | `"/etc/secrets"` | default mount path for the kubernetes secret |
| secret.nameOverride | string | `""` | Provide custom name of existing secret if oathkeeper.mutatorIdTokenJWKs is left empty, or custom name of secret to be created |
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
| service.api | object | `{"annotations":{},"enabled":true,"labels":{},"loadBalancerIP":"","name":"http","port":4456,"type":"ClusterIP"}` | Configures the Kubernetes service for the api port. |
| service.api.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. kubernetes.io/ingress.class: nginx kubernetes.io/tls-acme: "true" |
| service.api.enabled | bool | `true` | En-/disable the service |
| service.api.labels | object | `{}` | If you do want to specify additional labels, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'labels:'. e.g.  app: oathkeeper |
| service.api.loadBalancerIP | string | `""` | The load balancer IP |
| service.api.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| service.api.port | int | `4456` | The service port |
| service.api.type | string | `"ClusterIP"` | The service type |
| service.metrics | object | `{"annotations":{},"enabled":true,"labels":{},"loadBalancerIP":"","name":"http","port":80,"type":"ClusterIP"}` | Configures the Kubernetes service for the metrics port. |
| service.metrics.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. kubernetes.io/ingress.class: nginx kubernetes.io/tls-acme: "true" |
| service.metrics.enabled | bool | `true` | En-/disable the service |
| service.metrics.labels | object | `{}` | If you do want to specify additional labels, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'labels:'. e.g.  app: oathkeeper |
| service.metrics.loadBalancerIP | string | `""` | Load balancer IP |
| service.metrics.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| service.metrics.port | int | `80` | The service port |
| service.metrics.type | string | `"ClusterIP"` | The service type |
| service.proxy | object | `{"annotations":{},"enabled":true,"labels":{},"loadBalancerIP":"","name":"http","port":4455,"type":"ClusterIP"}` | Configures the Kubernetes service for the proxy port. |
| service.proxy.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. kubernetes.io/ingress.class: nginx kubernetes.io/tls-acme: "true" |
| service.proxy.enabled | bool | `true` | En-/disable the service |
| service.proxy.labels | object | `{}` | If you do want to specify additional labels, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'labels:'. e.g.  app: oathkeeper |
| service.proxy.loadBalancerIP | string | `""` | The load balancer IP |
| service.proxy.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| service.proxy.port | int | `4455` | The service port |
| service.proxy.type | string | `"ClusterIP"` | The service type |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.labels | object | `{}` | Provide additional labels to the ServiceMonitor resource metadata |
| serviceMonitor.metricRelabelings | list | `[]` | Provide additional metricRelabelings to apply to samples before ingestion. |
| serviceMonitor.relabelings | list | `[]` | Provide additional relabelings to apply to samples before scraping |
| serviceMonitor.scheme | string | `"http"` | HTTP scheme to use for scraping. |
| serviceMonitor.scrapeInterval | string | `"60s"` | Interval at which metrics should be scraped |
| serviceMonitor.scrapeTimeout | string | `"30s"` | Timeout after which the scrape is ended |
| serviceMonitor.targetLabels | list | `[]` | Additional metric labels |
| serviceMonitor.tlsConfig | object | `{}` | TLS configuration to use when scraping the endpoint |
| sidecar.envs | object | `{}` |  |
| sidecar.image.repository | string | `"oryd/oathkeeper-maester"` |  |
| sidecar.image.tag | string | `"v0.1.11"` |  |
| test.busybox | object | `{"repository":"busybox","tag":1}` | use a busybox image from another repository |
| test.labels | object | `{}` | Provide additional labels to the test pod |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
