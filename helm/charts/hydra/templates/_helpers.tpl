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
Common labels
*/}}
{{- define "hydra.labels" -}}
app.kubernetes.io/name: {{ include "hydra.name" . }}
helm.sh/chart: {{ include "hydra.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Generate the dsn value
*/}}
{{- define "hydra.dsn" -}}
{{- if .Values.demo -}}
memory
{{- else if .Values.hydra.config.dsn -}}
{{- .Values.hydra.config.dsn }}
{{- end -}}
{{- end -}}

{{/*
Generate the secrets.system value
*/}}
{{- define "hydra.secrets.system" -}}
{{- if .Values.hydra.config.secrets.system -}}
{{- required "Value secrets.system can not be empty!" .Values.hydra.config.secrets.system }}
{{- else if .Values.demo -}}
a-very-insecure-secret-for-checking-out-the-demo
{{- end -}}
{{- end -}}

{{/*
Generate the secrets.cookie value
*/}}
{{- define "hydra.secrets.cookie" -}}
{{- if .Values.hydra.config.secrets.cookie -}}
{{- .Values.hydra.config.secrets.cookie }}
{{- else -}}
{{- .Values.hydra.config.secrets.system }}
{{- end -}}
{{- end -}}
