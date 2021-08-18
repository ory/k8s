#!/bin/bash

set -Eeuxo pipefail

cfg=$(mktemp)
export cfg
export KUBECONFIG="$cfg"
export TIMEOUT="120s"

kind get kubeconfig > "$cfg"

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

release=$(echo "cci-$(date +%s)-$1-${CIRCLE_SHA1}" | cut -c 1-15)r

helm dep update "./helm/charts/$1"

set +e
helm install -f ".circleci/values/$1.yaml" "${release}" "./helm/charts/$1" --wait --debug --timeout="${TIMEOUT}"
export INSTALLATION_STATUS=$?
set -e

if [[ ${INSTALLATION_STATUS} -ne 0 ]]; then
  echo "Installation failed"
  kubectl describe pods -A -l "app.kubernetes.io/instance=${release}" || true
  kubectl logs --all-containers=true -l "app.kubernetes.io/instance=${release}" || true
  exit "${INSTALLATION_STATUS}"
fi

n=0
until [[ $n -ge 15 ]]; do
  set +e
  helm test --timeout "${TIMEOUT}" "${release}"
  TEST_STATUS=$?
  set -e

  if [[ ${TEST_STATUS} -eq 0 ]]; then
    echo "Test Successful"
    exit ${TEST_STATUS}
  fi
  n=$(( n+1 ))
  sleep 10
done

echo "Something failed along the way"
exit 1
