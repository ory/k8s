#!/bin/bash

set -Eeuo pipefail
cd "$( dirname "${BASH_SOURCE[0]}" )/.."

CHART_NAME="${1}"
export TIMEOUT="180s"
export BASE_RELEASE=$(helm search repo "ory/${CHART_NAME}" | awk '{print $2}' | head -2 | tail -1)

if [[ "${CHART_NAME}" == "ory-commons" ]]; then
  echo "---> Library chart, exitting"
  exit 0
fi

helm dep update "./helm/charts/${CHART_NAME}"

for val in $(ls "hacks/values/${CHART_NAME}")
do
  echo "::group::Installing ${CHART_NAME}/${val}"
  export release=$(echo "${CHART_NAME}-${val%%.*}-$(date +%s)" | cut -c 1-51)
  export values_file="https://raw.githubusercontent.com/ory/k8s/v${BASE_RELEASE}/hacks/values/${CHART_NAME}/${val}"
  export status_code=$(curl -o /dev/null -s -w "%{http_code}" "${values_file}")

  if [ "$status_code" == "404" ]; then
      echo "Values file ${CHART_NAME}/${val} not present in ${BASE_RELEASE}, skipping"
      continue
  fi

  set +e
  helm install \
    -f  "${values_file}" \
    "${release}" "ory/${CHART_NAME}" \
    --wait --debug --atomic --timeout="${TIMEOUT}"

  export INSTALLATION_STATUS=$?
  set -e

  if [[ ${INSTALLATION_STATUS} -ne 0 ]]; then
    echo "Installation of ${CHART_NAME} failed"
    kubectl describe pods \
      -A -l "app.kubernetes.io/instance=${release}" || true
    kubectl logs \
      --all-containers=true \
      -A -l "app.kubernetes.io/instance=${release}" || true
    exit "${INSTALLATION_STATUS}"
  fi
  echo "::endgroup::"
  echo "::group::Upgrading ${CHART_NAME}/${val}"

  set +e
  helm upgrade \
    -f "hacks/values/${CHART_NAME}/${val}" \
    "${release}" "./helm/charts/${CHART_NAME}" \
    --wait --debug --timeout="${TIMEOUT}"
  export UPGRADE_STATUS=$?
  set -e

  if [[ ${UPGRADE_STATUS} -ne 0 ]]; then
    echo "Upgrade of ${CHART_NAME}/${val} failed"
    kubectl describe pods \
      -A -l "app.kubernetes.io/instance=${release}" || true
    kubectl logs \
      --all-containers=true \
      -A -l "app.kubernetes.io/instance=${release}" || true
    exit "${UPGRADE_STATUS}"
  fi
  echo "::endgroup::"
  echo "::group::Testing ${CHART_NAME}/${val}"

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
  echo "::endgroup::"
done
