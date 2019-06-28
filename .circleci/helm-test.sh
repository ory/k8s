#!/bin/bash

set -Eeuxo pipefail
cd "$( dirname "${BASH_SOURCE[0]}" )/.."

release=$(echo cci-$1-${CIRCLE_SHA1}| cut -c 1-50)

helm install --tiller-namespace helm-ci --namespace helm-ci -f .circleci/values/oathkeeper.yaml -n ${release} ./helm/charts/$1
helm test --tiller-namespace helm-ci ${release}
helm del --tiller-namespace helm-ci --purge ${release}
