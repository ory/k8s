#!/bin/bash

set -Eeuxo pipefail
cd "$( dirname "${BASH_SOURCE[0]}" )/.."

release=$(echo cci-$(date +%s)-$1-${CIRCLE_SHA1}| cut -c 1-50)

function cleanup {
    helm del --tiller-namespace ${TILLER_NAMESPACE} --purge ${release} || true
}
trap cleanup EXIT

helm install --tiller-namespace ${TILLER_NAMESPACE} --namespace helm-ci -f .circleci/values/$1.yaml -n ${release} ./helm/charts/$1

n=0
until [[ $n -ge 5 ]]; do
  helm test --timeout 90 --cleanup --tiller-namespace ${TILLER_NAMESPACE} ${release} && exit 0  # substitute your command here
  kubectl delete pods/${release}-test-connection --namespace ${TILLER_NAMESPACE}
  n=$[$n+1]
  sleep 5
done

exit 1
