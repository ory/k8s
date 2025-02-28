#!/bin/bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

progname=$(basename $0)
set -x
VERSION="$1"

charts=("example-idp" "hydra-maester" "hydra" "keto" "kratos" "kratos-selfservice-ui-node" "oathkeeper-maester" "oathkeeper")
charts_with_maesters=("hydra" "oathkeeper")

for chart in "${charts[@]}"
do
	yq -i ".version = \"${VERSION}\"" "helm/charts/${chart}/Chart.yaml" || {
    	echo "Failed to update version in 'helm/charts/${chart}/Chart.yaml'"
        exit 1
    }
done

for chart in "${charts_with_maesters[@]}"
do
	yq -i "(.dependencies[] | select(.name == \"${chart}-maester\")).version = \"${VERSION}\"" "helm/charts/${chart}/Chart.yaml" || {
    	echo "Failed to update version in 'helm/charts/${chart}/Chart.yaml'"
        exit 1
    }
done
