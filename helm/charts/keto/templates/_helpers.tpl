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
{{- $config := omit .Values.keto.config "dsn" -}}
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
{{- if $.Values.watcher.enabled }}
{{ printf "\"%s\": \"%s\"" $.Values.watcher.watchLabelKey (include "keto.name" .) }}
{{- end }}
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

{{/*
Create the name of the service account for the Job to use
*/}}
{{- define "keto.job.serviceAccountName" -}}
{{- if .Values.job.serviceAccount.create }}
{{- printf "%s-job" (default (include "keto.fullname" .) .Values.job.serviceAccount.name) }}
{{- else }}
{{- include "keto.serviceAccountName" . }}
{{- end }}
{{- end }}


{{/*
Checksum annotations generated from configmaps and secrets
*/}}
{{- define "keto.annotations.checksum" -}}
{{- if .Values.configmap.hashSumEnabled }}
checksum/keto-config: {{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
{{- end }}
{{- if and .Values.secret.enabled .Values.secret.hashSumEnabled }}
checksum/keto-secrets: {{ include (print $.Template.BasePath "/secrets.yaml") . | sha256sum }}
{{- end }}
{{- end }}

{{/*
Check the migration type value and fail if unexpected 
*/}}
{{- define "keto.automigration.typeVerification" -}}
{{- if and .Values.keto.automigration.enabled  .Values.keto.automigration.type }}
  {{- if and (ne .Values.keto.automigration.type "initContainer") (ne .Values.keto.automigration.type "job") }}
    {{- fail "keto.automigration.type must be either 'initContainer' or 'job'" -}}
  {{- end }}  
{{- end }}
{{- end }}
