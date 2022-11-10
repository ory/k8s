set -Eeuo pipefail
set -x

function rollOut() {
  DEPLOY=$(kubectl get deploy -n "${NAMESPACE}" -l "${1}" -o name)
  kubectl set env -n $NAMESPACE ${DEPLOY} sync=$(date "+%Y%m%d-%H%M%S")
  kubectl rollout status -n $NAMESPACE ${DEPLOY}
}

while true; do
    # After change in the CM the symlink is recreated, so we need to restart the monitor
    inotifywait --event DELETE_SELF "${WATCH_FILE}" |
        while read path _ file; do
           echo "---> $path$file modified"
           rollOut "${LABEL_SELECTOR}"
        done
done
