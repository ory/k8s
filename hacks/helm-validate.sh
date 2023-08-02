#!/bin/bash

set -Eeuo pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

schema_url="https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/"
k8s_version="1.27.2"

helm kubeconform "./helm/charts/${1}" --strict --schema-location "${schema_url}" -f "hacks/values/${1}.yaml" --kubernetes-version "${k8s_version}" --summary --verbose
