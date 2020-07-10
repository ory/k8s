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
Generate the dsn value
*/}}
{{- define "kratos.dsn" -}}
{{- .Values.kratos.config.dsn }}
{{- end -}}

{{/*
Generate the secrets.default value
*/}}
{{- define "kratos.secrets.default" -}}
{{- if .Values.kratos.config.secrets.default -}}
{{- .Values.kratos.config.secrets.default }}
{{- end -}}
{{- end -}}

{{/*
Generate the secrets.cookie value
*/}}
{{- define "kratos.secrets.cookie" -}}
{{- if .Values.kratos.config.secrets.cookie -}}
{{- .Values.kratos.config.secrets.cookie }}
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
Common labels
*/}}
{{- define "kratos.labels" -}}
app.kubernetes.io/name: {{ include "kratos.name" . }}
helm.sh/chart: {{ include "kratos.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
