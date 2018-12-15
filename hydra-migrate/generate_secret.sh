#!/usr/bin/env bash

secret=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | base64 | head -c 32)

cat > secret.yaml <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: hydra-system-secret
type: Opaque
stringData:
  HYDRA_SYSTEM_SECRET: $secret
EOF
