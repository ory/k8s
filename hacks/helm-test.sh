#!/bin/bash

set -Eeuo pipefail

export TIMEOUT="180s"

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

CHART_NAME="${1}"

if [[ "${CHART_NAME}" == "ory-commons" ]]; then
  echo "---> Library chart, exitting"
  exit 0
fi

helm dep update "./helm/charts/${CHART_NAME}"

for val in $(ls "hacks/values/${CHART_NAME}")
do
  echo "---> Installing ${CHART_NAME}/${val}"
  set -x
  export release=$(echo "${CHART_NAME}-${val%%.*}-$(date +%s)" | cut -c 1-51)
  set +e
  helm install \
    -f "hacks/values/${CHART_NAME}/${val}" "${release}" \
    "./helm/charts/${CHART_NAME}" \
    --wait --debug --atomic --timeout="${TIMEOUT}"
  
  export INSTALLATION_STATUS=$?
  set -e

  if [[ ${INSTALLATION_STATUS} -ne 0 ]]; then
    echo "Installation of ${CHART_NAME} failed"
    kubectl describe pods \
      -l "app.kubernetes.io/instance=${release}" || true
    kubectl logs \
      --all-containers=true \
      -l "app.kubernetes.io/instance=${release}" || true
    exit "${INSTALLATION_STATUS}"
  fi

  echo "---> Testing ${CHART_NAME}/${val}"

  n=0
  until [[ $n -ge 15 ]]; do
    set +e
    helm test \
      --timeout "${TIMEOUT}" "${release}"
    TEST_STATUS=$?
    set -e

    if [[ ${TEST_STATUS} -eq 0 ]]; then
      echo "---> Test Successful"
      break
    fi
    n=$(( n+1 ))
    sleep 10
  done
done
