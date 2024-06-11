{{/*
Check if list contains object
*/}}
{{- define "ory.extraEnvContainsEnvName" -}}
  {{- $extraEnvs := index . 0 -}}
  {{- $envName := index . 1 -}}
  {{- range $k, $v := $extraEnvs -}}
    {{- if eq $v.name $envName -}}
      found
    {{- end -}}
  {{- end -}}
{{- end -}}
