#!/bin/bash

set -Eeuxo pipefail
cd "$( dirname "${BASH_SOURCE[0]}" )/.."

release=$(echo cci-$1-${CIRCLE_SHA1}| cut -c 1-50)

function cleanup {
    helm del --tiller-namespace helm-ci --purge ${release}
}
trap cleanup EXIT

helm install --tiller-namespace helm-ci --namespace helm-ci -f .circleci/values/oathkeeper.yaml -n ${release} ./helm/charts/$1

n=0
until [[ $n -ge 5 ]]; do
  helm test --tiller-namespace helm-ci ${release} && break  # substitute your command here
  n=$[$n+1]
  sleep 5
done
