{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kratos.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kratos.fullname" -}}
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
{{- define "kratos.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Ensure there is always a way to track down source of the deployment.
It is unlikely AppVersion will be missing, but we will fallback on the
chart's version in that case.
*/}}
{{- define "kratos.version" -}}
{{- if .Chart.AppVersion }}
{{- .Chart.AppVersion -}}
{{- else -}}
{{- printf "v%s" .Chart.Version -}}
{{- end -}}
{{- end -}}
{{/*
Common labels
*/}}
{{- define "kratos.labels" -}}
"app.kubernetes.io/name": {{ include "kratos.name" . | quote }}
"app.kubernetes.io/instance": {{ .Release.Name | quote }}
"app.kubernetes.io/version": {{ include "kratos.version" . | quote }}
"app.kubernetes.io/managed-by": {{ .Release.Service | quote }}
"helm.sh/chart": {{ include "kratos.chart" . | quote }}
{{- end -}}
{{/*
Generate the dsn value
*/}}
{{- define "kratos.dsn" -}}
{{- if .Values.demo -}}
memory
{{- else if .Values.kratos.config.dsn -}}
{{- .Values.kratos.config.dsn }}
{{- end -}}
{{- end -}}
{{/*
Generate the secrets.system value
*/}}
{{- define "kratos.secrets.system" -}}
{{- if .Values.kratos.config.secrets.system -}}
{{- .Values.kratos.config.secrets.system }}
{{- else if .Values.demo -}}
a-very-insecure-secret-for-checking-out-the-demo
{{- end -}}
{{- end -}}
{{/*
Generate the secrets.cookie value
*/}}
{{- define "kratos.secrets.cookie" -}}
{{- if .Values.kratos.config.secrets.cookie -}}
{{- .Values.kratos.config.secrets.cookie }}
{{- else -}}
{{- include "kratos.secrets.system" . }}
{{- end -}}
{{- end -}}
{{/*
Generate the configmap data, redacting secrets
*/}}
{{- define "kratos.configmap" -}}
{{- $config := unset .Values.kratos.config "dsn" -}}
{{- $config := unset $config "secrets" -}}
{{- toYaml $config -}}
{{- end -}}
{{/*
Generate the urls.issuer value
*/}}
{{- define "kratos.config.urls.issuer" -}}
{{- if .Values.kratos.config.urls.self.issuer -}}
{{- .Values.kratos.config.urls.self.issuer }}
{{- else if .Values.ingress.public.enabled -}}
{{- $host := index .Values.ingress.public.hosts 0 -}}
http{{ if $.Values.ingress.public.tls }}s{{ end }}://{{ $host.host }}
{{- else if contains "ClusterIP" .Values.service.public.type -}}
http://127.0.0.1:{{ .Values.service.public.port }}/
{{- end -}}
{{- end -}}
{{- define "kratos.utils.joinListWithComma" -}}
{{- $local := dict "first" true -}}
{{- range $k, $v := . -}}{{- if not $local.first -}},{{- end -}}{{- $v -}}{{- $_ := set $local "first" false -}}{{- end -}}
{{- end -}}