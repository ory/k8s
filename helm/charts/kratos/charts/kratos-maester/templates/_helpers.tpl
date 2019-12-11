{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kratos-maester.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kratos-maester.fullname" -}}
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
{{- define "kratos-maester.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kratos-maester.labels" -}}
app.kubernetes.io/name: {{ include "kratos-maester.name" . }}
helm.sh/chart: {{ include "kratos-maester.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Get Kratos service name
*/}}
{{- define "kratos-maester.kratosService" -}}
{{- if .Values.kratosService.name -}}
{{- printf "%s" .Values.kratosService.name -}}
{{- else -}}
{{- $fullName := include "kratos-maester.fullname" . -}}
{{- $nameParts := split "-" $fullName -}}
{{- if eq $nameParts._0 $nameParts._1 -}}
{{- printf "%s-kratos" $nameParts._0 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-kratos" $nameParts._0 $nameParts._1 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}