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

{{- define "hydra.image" -}}
{{- $tag := .Values.image.tag -}}
{{- if kindIs "string" .Values.image.oryOS -}}
  {{- $tag = printf "%s_oryOS.%s" $tag .Values.image.oryOS -}}
{{- else if kindIs "float64" .Values.image.oryOS -}}
  {{- $tag = printf "%s_oryOS.%s" $tag (toString .Values.image.oryOS) -}}
{{- end -}}
{{- trimSuffix ":" (printf "%s:%s" .Values.image.repository $tag) | quote -}}
{{- end -}}

{{- define "hydra.env" -}}
{{- printf "%s-env" .Release.Name | quote -}}
{{- end -}}


{{- define "hydra.health" -}}
livenessProbe:
  httpGet:
    path: "/health/alive"
    port: "http"
readinessProbe:
  httpGet:
    path: "/health/ready"
    port: "http"
{{- end -}}

{{- define "hydra.secrets" -}}
- name: DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.db.secretName }}
      key: username
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.db.secretName }}
      key: password
- name: SYSTEM_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ required "Hydra Helm chart requires `systemSecretName` to be specifed and persisted in Kubernetes. See README for more information" .Values.systemSecretName }}
      key: system
{{- end -}}

{{- define "hydra.ports.public" -}}
{{ default 4444 .Values.publicPort }}
{{- end -}}
{{- define "hydra.ports.admin" -}}
{{ default 4445 .Values.adminPort }}
{{- end -}}
