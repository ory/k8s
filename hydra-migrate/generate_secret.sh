#!/usr/bin/env bash

secret=$(LC_ALL=C tr -dc A-Za-z0-9 </dev/urandom | head -c 64 | base64)

cat > secret.yaml <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: hydra-system-secret
type: Opaque
data:
  hydra_system_secret: $secret
EOF
