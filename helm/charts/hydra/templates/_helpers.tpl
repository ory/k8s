{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "hydra.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hydra.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "hydra.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Ensure there is always a way to track down source of the deployment.
It is unlikely AppVersion will be missing, but we will fallback on the
chart's version in that case.
*/}}
{{- define "hydra.version" -}}
{{- if .Chart.AppVersion }}
{{- .Chart.AppVersion -}}
{{- else -}}
{{- printf "v%s" .Chart.Version -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "hydra.labels" -}}
"app.kubernetes.io/name": {{ include "hydra.name" . | quote }}
"app.kubernetes.io/instance": {{ .Release.Name | quote }}
"app.kubernetes.io/version": {{ include "hydra.version" . | quote }}
"app.kubernetes.io/managed-by": {{ .Release.Service | quote }}
"helm.sh/chart": {{ include "hydra.chart" . | quote }}
{{- if $.Values.watcher.enabled }}
{{ printf "\"%s\": \"%s\"" $.Values.watcher.watchLabelKey (include "hydra.name" .) }}
{{- end }}
{{- end -}}

{{/*
Generate the dsn value
*/}}
{{- define "hydra.dsn" -}}
{{- if .Values.demo -}}
memory
{{- else if and .Values.secret.nameOverride (not .Values.secret.enabled) -}}
dsn-loaded-from-env
{{- else if not (empty (.Values.hydra.config.dsn)) -}}
{{- .Values.hydra.config.dsn }}
{{- end -}}
{{- end -}}

{{/*
Generate the name of the secret resource containing secrets
*/}}
{{- define "hydra.secretname" -}}
{{- if .Values.secret.nameOverride -}}
{{- .Values.secret.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{ include "hydra.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Generate the secrets.annotations value
*/}}
{{- define "hydra.secrets.annotations" -}}
  {{- $annotations := dict -}}
  {{- if .Values.secret.enableDefaultAnnotations }}
    {{- $annotations = .Values.secret.secretAnnotations -}}
  {{- end -}}
  {{- $annotations = merge $annotations .Values.secret.extraAnnotations -}}
  {{- toYaml $annotations }}
{{- end -}}

{{/*
Generate the secrets.system value
*/}}
{{- define "hydra.secrets.system" -}}
  {{- if (.Values.hydra.config.secrets).system -}}
    {{- if kindIs "slice" .Values.hydra.config.secrets.system -}}
      {{- if gt (len .Values.hydra.config.secrets.system) 1 -}}
        "{{- join "\",\"" .Values.hydra.config.secrets.system -}}"
      {{- else -}}
        {{- join "" .Values.hydra.config.secrets.system -}}
      {{- end -}}
    {{- else -}}
      {{- fail "Expected hydra.config.secrets.system to be a list of strings" -}}
    {{- end -}}
  {{- else if .Values.demo -}}
    a-very-insecure-secret-for-checking-out-the-demo
  {{- end -}}
{{- end -}}

{{/*
Generate the secrets.cookie value
*/}}
{{- define "hydra.secrets.cookie" -}}
  {{- if (.Values.hydra.config.secrets).cookie -}}
    {{- if kindIs "slice" .Values.hydra.config.secrets.cookie -}}
      {{- if gt (len .Values.hydra.config.secrets.cookie) 1 -}}
        "{{- join "\",\"" .Values.hydra.config.secrets.cookie -}}"
      {{- else -}}
        {{- join "" .Values.hydra.config.secrets.cookie -}}
      {{- end -}}
    {{- else -}}
      {{- fail "Expected hydra.config.secrets.cookie to be a list of strings" -}}
    {{- end -}}
  {{- else -}}
    {{- include "hydra.secrets.system" . }}
  {{- end -}}
{{- end -}}

{{/*
Generate the configmap data, redacting secrets
*/}}
{{- define "hydra.configmap" -}}
{{- $config := omit .Values.hydra.config "dsn" "secrets" -}}
{{- tpl (toYaml $config) . -}}
{{- end -}}

{{/*
Generate the urls.issuer value
*/}}
{{- define "hydra.config.urls.issuer" -}}
{{- if .Values.hydra.config.urls.self.issuer -}}
{{- tpl .Values.hydra.config.urls.self.issuer $ }}
{{- else if .Values.ingress.public.enabled -}}
{{- $host := index .Values.ingress.public.hosts 0 -}}
http{{ if $.Values.ingress.public.tls }}s{{ end }}://{{ tpl $host.host $ }}
{{- else if contains "ClusterIP" .Values.service.public.type -}}
http://127.0.0.1:{{ .Values.service.public.port }}/
{{- end -}}
{{- end -}}

{{/*
Check overrides consistency
*/}}
{{- define "hydra.check.override.consistency" -}}
{{- if and .Values.maester.enabled .Values.fullnameOverride -}}
{{- if not .Values.maester.hydraFullnameOverride -}}
{{ fail "hydra fullname has been overridden, but the new value has not been provided to maester. Set maester.hydraFullnameOverride" }}
{{- else if not (eq .Values.maester.hydraFullnameOverride .Values.fullnameOverride) -}}
{{ fail (tpl "hydra fullname has been overridden, but a different value was provided to maester. {{ .Values.maester.hydraFullnameOverride }} different of {{ .Values.fullnameOverride }}" . ) }}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "hydra.utils.joinListWithComma" -}}
{{- $local := dict "first" true -}}
{{- range $k, $v := . -}}{{- if not $local.first -}},{{- end -}}{{- $v -}}{{- $_ := set $local "first" false -}}{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "hydra.serviceAccountName" -}}
{{- if .Values.deployment.serviceAccount.create }}
{{- default (include "hydra.fullname" .) .Values.deployment.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.deployment.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account for the Job to use
*/}}
{{- define "hydra.job.serviceAccountName" -}}
{{- if .Values.job.serviceAccount.create }}
{{- printf "%s-job" (default (include "hydra.fullname" .) .Values.job.serviceAccount.name) }}
{{- else if .Values.job.serviceAccount.name }}
{{- default "default" .Values.job.serviceAccount.name }}
{{- else }}
{{- include "hydra.serviceAccountName" . }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account for the Job to use
*/}}
{{- define "hydra.cronjob.janitor.serviceAccountName" -}}
{{- if .Values.cronjob.janitor.serviceAccount.create }}
{{- printf "%s-cronjob-janitor" (default (include "hydra.fullname" .) .Values.cronjob.janitor.serviceAccount.name) }}
{{- else }}
{{- include "hydra.serviceAccountName" . }}
{{- end }}
{{- end }}

{{/*
Checksum annotations generated from configmaps and secrets
*/}}
{{- define "hydra.annotations.checksum" -}}
{{- if .Values.configmap.hashSumEnabled }}
checksum/hydra-config: {{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
{{- end }}
{{- if and .Values.secret.enabled .Values.secret.hashSumEnabled }}
checksum/hydra-secrets: {{ include (print $.Template.BasePath "/secrets.yaml") . | sha256sum }}
{{- end }}
{{- end }}

{{/*
Check the migration type value and fail if unexpected 
*/}}
{{- define "hydra.automigration.typeVerification" -}}
{{- if and .Values.hydra.automigration.enabled  .Values.hydra.automigration.type }}
  {{- if and (ne .Values.hydra.automigration.type "initContainer") (ne .Values.hydra.automigration.type "job") }}
    {{- fail "hydra.automigration.type must be either 'initContainer' or 'job'" -}}
  {{- end }}  
{{- end }}
{{- end }}

{{/*
Common labels for the janitor cron job
*/}}
{{- define "hydra.janitor.labels" -}}
"app.kubernetes.io/name": {{ printf "%s-janitor" (include "hydra.name" .) | quote }}
"app.kubernetes.io/instance": {{ .Release.Name | quote }}
"app.kubernetes.io/version": {{ include "hydra.version" . | quote }}
"app.kubernetes.io/managed-by": {{ .Release.Service | quote }}
"app.kubernetes.io/component": janitor
"helm.sh/chart": {{ include "hydra.chart" . | quote }}
{{- end -}}
