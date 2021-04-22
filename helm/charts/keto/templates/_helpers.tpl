{{/*
Expand the name of the chart.
*/}}
{{- define "keto.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "keto.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a secret name which can be overridden.
*/}}
{{- define "keto.secretname" -}}
{{- if .Values.secret.nameOverride -}}
{{- .Values.secret.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{ include "keto.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "keto.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Generate the dsn value
*/}}
{{- define "keto.dsn" -}}
{{- .Values.keto.config.dsn }}
{{- end -}}

{{/*
Generate the configmap data, redacting secrets
*/}}
{{- define "keto.configmap" -}}
{{- $config := unset .Values.keto.config "dsn" -}}
{{- toYaml $config -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "keto.labels" -}}
helm.sh/chart: {{ include "keto.chart" . }}
{{ include "keto.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "keto.selectorLabels" -}}
app.kubernetes.io/name: {{ include "keto.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "keto.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "keto.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
