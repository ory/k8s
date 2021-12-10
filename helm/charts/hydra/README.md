# hydra

![Version: 0.21.3](https://img.shields.io/badge/Version-0.21.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.10.5](https://img.shields.io/badge/AppVersion-v1.10.5-informational?style=flat-square)

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
| file://../hydra-maester | hydra-maester(hydra-maester) | 0.21.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Configure node affinity |
| deployment.annotations | object | `{}` |  |
| deployment.automountServiceAccountToken | bool | `true` |  |
| deployment.autoscaling.enabled | bool | `false` |  |
| deployment.autoscaling.maxReplicas | int | `3` |  |
| deployment.autoscaling.minReplicas | int | `1` |  |
| deployment.extraEnv | list | `[]` | If you want to use Jaeger with agents being deployed in a daemonset, you can -- use the following ENV vars to configure the right endpoints using the IP -- address of the node the pod has been deployed to. extraEnv:   - name: JAEGER_AGENT_HOST     valueFrom:       fieldRef:         fieldPath: status.hostIP   - name: TRACING_PROVIDERS_JAEGER_LOCAL_AGENT_ADDRESS     value: $(JAEGER_AGENT_HOST):6831   - name: TRACING_PROVIDERS_JAEGER_SAMPLING_SERVER_URL     value: http://$(JAEGER_AGENT_HOST):5778 |
| deployment.extraInitContainers | object | `{}` | If you want to add extra init containers. |
| deployment.extraVolumeMounts | list | `[]` |  |
| deployment.extraVolumes | list | `[]` | If you want to mount external volume |
| deployment.labels | object | `{}` |  |
| deployment.lifecycle | object | `{}` |  |
| deployment.livenessProbe | object | `{"failureThreshold":5,"initialDelaySeconds":30,"periodSeconds":10}` | Configure the probes for when the deployment is considered ready and ongoing health check |
| deployment.nodeSelector | object | `{}` |  |
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
| deployment.serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | Specify the serviceAccountName value. In some situations it is needed to provides specific permissions to Hydra deployments Like for example installing Hydra on a cluster with a PosSecurityPolicy and Istio. Uncoment if it is needed to provide a ServiceAccount for the Hydra deployment. -- Specify the serviceAccountName value. In some situations it is needed to provides specific permissions to Hydra deployments Like for example installing Hydra on a cluster with a PosSecurityPolicy and Istio. Uncoment if it is needed to provide a ServiceAccount for the Hydra deployment. |
| deployment.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| deployment.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| deployment.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| deployment.tolerations | list | `[]` | Configure node tolerations. |
| deployment.tracing | object | `{"datadog":{"enabled":false}}` | Configuration for tracing providers. Only datadog is currently supported through this block. -- If you need to use a different tracing provider, please manually set the configuration values via "hydra.config" or via "deployment.extraEnv". |
| fullnameOverride | string | `""` | Full chart name override |
| hydra | object | `{"autoMigrate":false,"config":{"secrets":{},"serve":{"admin":{"port":4445},"public":{"port":4444},"tls":{"allow_termination_from":["10.0.0.0/8","172.16.0.0/12","192.168.0.0/16"]}},"urls":{"self":{}}},"dangerousAllowInsecureRedirectUrls":false,"dangerousForceHttp":false}` | Configure ORY Hydra itself |
| hydra-maester | object | `{"adminService":{"name":"","port":null}}` | Values for the hydra admin service arguments to hydra-maester |
| hydra-maester.adminService.name | string | `""` | The service name value may need to be set if you use `fullnameOverride` for the parent chart |
| hydra-maester.adminService.port | string | `nil` | You only need to set this port if you change the value for `service.admin.port` in the parent chart |
| hydra.config | object | `{"secrets":{},"serve":{"admin":{"port":4445},"public":{"port":4444},"tls":{"allow_termination_from":["10.0.0.0/8","172.16.0.0/12","192.168.0.0/16"]}},"urls":{"self":{}}}` | The ORY Hydra configuration. For a full list of available settings, check:   https://github.com/ory/hydra/blob/master/docs/config.yaml |
| hydra.config.secrets | object | `{}` | The secrets have to be provided as a string slice, example: system:   - "OG5XbmxXa3dYeGplQXpQanYxeEFuRUFa"   - "foo bar 123 456 lorem"   - "foo bar 123 456 lorem 1"   - "foo bar 123 456 lorem 2"   - "foo bar 123 456 lorem 3" |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"oryd/hydra"` | ORY Hydra image |
| image.tag | string | `"v1.10.5"` | ORY Hydra version |
| imagePullSecrets | list | `[]` | Image pull secrets |
| ingress | object | `{"admin":{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"admin.hydra.localhost","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]},"public":{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"public.hydra.localhost","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]}}` | Configure ingress |
| ingress.admin.enabled | bool | `false` | En-/Disable the api ingress. |
| ingress.public | object | `{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"public.hydra.localhost","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]}` | Configure ingress for the proxy port. |
| ingress.public.enabled | bool | `false` | En-/Disable the proxy ingress. |
| job.annotations | object | `{}` |  |
| maester | object | `{"enabled":true}` | Configures controller setup |
| nameOverride | string | `""` |  |
| pdb | object | `{"enabled":false,"spec":{"minAvailable":1}}` | PodDistributionBudget configuration |
| replicaCount | int | `1` | Number of ORY Hydra members |
| secret.enabled | bool | `true` | switch to false to prevent creating the secret |
| secret.nameOverride | string | `""` | Provide custom name of existing secret, or custom name of secret to be created |
| secret.secretAnnotations."helm.sh/hook" | string | `"pre-install, pre-upgrade"` |  |
| secret.secretAnnotations."helm.sh/hook-delete-policy" | string | `"before-hook-creation"` |  |
| secret.secretAnnotations."helm.sh/hook-weight" | string | `"0"` |  |
| secret.secretAnnotations."helm.sh/resource-policy" | string | `"keep"` |  |
| service.admin | object | `{"annotations":{},"enabled":true,"labels":{},"name":"http","port":4445,"type":"ClusterIP"}` | Configures the Kubernetes service for the api port. |
| service.admin.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| service.admin.enabled | bool | `true` | En-/disable the service |
| service.admin.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| service.admin.port | int | `4445` | The service port |
| service.admin.type | string | `"ClusterIP"` | The service type |
| service.public | object | `{"annotations":{},"enabled":true,"labels":{},"name":"http","port":4444,"type":"ClusterIP"}` | Configures the Kubernetes service for the proxy port. |
| service.public.annotations | object | `{}` | If you do want to specify annotations, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'annotations:'. |
| service.public.enabled | bool | `true` | En-/disable the service |
| service.public.name | string | `"http"` | The service port name. Useful to set a custom service port name if it must follow a scheme (e.g. Istio) |
| service.public.port | int | `4444` | The service port |
| service.public.type | string | `"ClusterIP"` | The service type |
| watcher | object | `{"enabled":false,"image":"oryd/k8s-toolbox:0.0.2","mountFile":""}` | Sidecar watcher configuration |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
