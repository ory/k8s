#!/bin/bash

set -Eeuxo pipefail
cd "$( dirname "${BASH_SOURCE[0]}" )"

helm install --tiller-namespace helm-ci --namespace helm-ci -f .circleci/values/oathkeeper.yaml -n cci-$1-${CIRCLE_SHA1} ./helm/charts/$1
helm test --tiller-namespace helm-ci cci-$1-${CIRCLE_SHA1}
helm del --tiller-namespace helm-ci --purge cci-$1-${CIRCLE_SHA1}
