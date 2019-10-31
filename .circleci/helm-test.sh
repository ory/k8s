#!/bin/bash

set -Eeuxo pipefail
cd "$( dirname "${BASH_SOURCE[0]}" )/.."

release=$(echo cci-$(date +%s)-$1-${CIRCLE_SHA1}| cut -c 1-20)

function cleanup {
    kubectl describe pods -A -l "app.kubernetes.io/instance=${release}" || true
    kubectl logs --all-containers=true -l "app.kubernetes.io/instance=${release}" || true
    helm del --purge ${release} || true
}
trap cleanup EXIT

helm install -f .circleci/values/$1.yaml -n ${release} ./helm/charts/$1 --wait

n=0
until [[ $n -ge 5 ]]; do
  helm test --timeout 90 --cleanup ${release} && exit 0  # substitute your command here
  kubectl delete pod ${release}-test-connection
  n=$[$n+1]
  sleep 10
done

exit 1
