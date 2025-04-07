#!/bin/bash

set -Eeuo pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

CHART_NAME="${1}"

schema_url="https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/"
k8s_version="1.32.1"

if [[ "${CHART_NAME}" == "ory-commons" ]]; then
  echo "---> Library chart, exiting"
  exit 0
fi

for f in $(ls "hacks/values/${CHART_NAME}")
do
  echo "---> ${f}"
  helm kubeconform "./helm/charts/${CHART_NAME}" --strict --schema-location "${schema_url}"\
    --schema-location ./hacks/servicemonitor_v1.json \
    -f "${f}" \
    --kubernetes-version "${k8s_version}" \
    --summary --verbose
done
