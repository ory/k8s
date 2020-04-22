#!/bin/bash

set -Eeuxo pipefail

cfg=$(mktemp)
kind get kubeconfig > $cfg
export KUBECONFIG="$cfg"

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

release=$(echo cci-$(date +%s)-$1-${CIRCLE_SHA1} | cut -c 1-15)r

function cleanup {
    # kubectl describe pods -A -l "app.kubernetes.io/instance=${release}" || true
    # kubectl logs --all-containers=true -l "app.kubernetes.io/instance=${release}" || true
    helm del ${release} || true
    exit 0
}
trap cleanup EXIT

helm dep update ./helm/charts/$1
helm install -f .circleci/values/$1.yaml ${release} ./helm/charts/$1 --wait --debug

n=0
until [[ $n -ge 15 ]]; do
  helm test --timeout 90s --cleanup ${release} && exit 0  # substitute your command here
  kubectl delete pod ${release}-test-connection
  n=$[$n+1]
  sleep 10
done

exit 1
