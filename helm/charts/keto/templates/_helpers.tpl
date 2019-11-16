{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "keto.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "keto.fullname" -}}
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
{{- define "keto.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Ensure there is always a way to track down source of the deployment.
It is unlikely AppVersion will be missing, but we will fallback on the
chart's version in that case.
*/}}
{{- define "keto.version" -}}
{{- if .Chart.AppVersion }}
{{- .Chart.AppVersion -}}
{{- else -}}
{{- printf "v%s" .Chart.Version -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "keto.labels" -}}
"app.kubernetes.io/name": {{ include "keto.name" . | quote }}
"app.kubernetes.io/instance": {{ .Release.Name | quote }}
"app.kubernetes.io/version": {{ include "keto.version" . | quote }}
"app.kubernetes.io/managed-by": {{ .Release.Service | quote }}
"helm.sh/chart": {{ include "keto.chart" . | quote }}
{{- end -}}

{{/*
Generate the dsn value
*/}}
{{- define "keto.dsn" -}}
{{- if .Values.demo -}}
memory
{{- else if .Values.keto.config.dsn -}}
{{- .Values.keto.config.dsn }}
{{- end -}}
{{- end -}}

{{/*
Generate the secrets.system value
*/}}
{{- define "keto.secrets.system" -}}
{{- if .Values.keto.config.secrets.system -}}
{{- .Values.keto.config.secrets.system }}
{{- else if .Values.demo -}}
a-very-insecure-secret-for-checking-out-the-demo
{{- end -}}
{{- end -}}

{{/*
Generate the secrets.cookie value
*/}}
{{- define "keto.secrets.cookie" -}}
{{- if .Values.keto.config.secrets.cookie -}}
{{- .Values.keto.config.secrets.cookie }}
{{- else -}}
{{- include "keto.secrets.system" . }}
{{- end -}}
{{- end -}}

{{/*
Generate the configmap data, redacting secrets
*/}}
{{- define "keto.configmap" -}}
{{- $config := unset .Values.keto.config "dsn" -}}
{{- $config := unset $config "secrets" -}}
{{- toYaml $config -}}
{{- end -}}

{{/*
Generate the urls.issuer value
*/}}
{{- define "keto.config.urls.issuer" -}}
{{- if .Values.keto.config.urls.self.issuer -}}
{{- .Values.keto.config.urls.self.issuer }}
{{- else if .Values.ingress.public.enabled -}}
{{- $host := index .Values.ingress.public.hosts 0 -}}
http{{ if $.Values.ingress.public.tls }}s{{ end }}://{{ $host.host }}
{{- else if contains "ClusterIP" .Values.service.public.type -}}
http://127.0.0.1:{{ .Values.service.public.port }}/
{{- end -}}
{{- end -}}

{{- define "keto.utils.joinListWithComma" -}}
{{- $local := dict "first" true -}}
{{- range $k, $v := . -}}{{- if not $local.first -}},{{- end -}}{{- $v -}}{{- $_ := set $local "first" false -}}{{- end -}}
{{- end -}}