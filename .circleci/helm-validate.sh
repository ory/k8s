#!/bin/bash

set -Eeuo pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

schema_url="https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/"

helm kubeval "./helm/charts/${1}" --exit-on-error --strict --schema-location "${schema_url}" -f ".circleci/values/${1}.yaml" --force-color
