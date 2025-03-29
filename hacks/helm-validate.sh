#!/bin/bash

set -Eeuo pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

schema_url="https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/"
k8s_version="1.32.1"

if [[ "$1" == "ory-commons" ]]; then
  echo "---> Library chart, exiting"
  exit 0
fi

helm kubeconform "./helm/charts/${1}" --strict --schema-location "${schema_url}"\
  --schema-location ./hacks/servicemonitor_v1.json \
  -f "hacks/values/${1}.yaml" \
  --kubernetes-version "${k8s_version}" \
  --summary --verbose
