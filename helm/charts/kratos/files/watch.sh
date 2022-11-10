set -Eeuo pipefail
set -x

function rollOutDeploy() {
  DEPLOY=$(kubectl get deploy -n "${NAMESPACE}" -l "${1}" -o name)
  kubectl set env -n "${NAMESPACE}" "${DEPLOY}" sync=$(date "+%Y%m%d-%H%M%S")
  kubectl rollout status -n "${NAMESPACE}" "${DEPLOY}"
}

function rollOutSts() {
  STS=$(kubectl get statefulset -n "${NAMESPACE}" -l "${1}" -o name)
  kubectl set env -n "${NAMESPACE}" "${STS}" sync=$(date "+%Y%m%d-%H%M%S")
  kubectl rollout status -n "${NAMESPACE}" ${STS}
}

while true; do
    # After change in the CM the symlink is recreated, so we need to restart the monitor
    inotifywait --event DELETE_SELF "${WATCH_FILE}" |
        while read path _ file; do
           echo "---> $path$file modified"
           rollOutDeploy "${LABEL_SELECTOR}"
           rollOutSts "${LABEL_SELECTOR}"
        done
done
