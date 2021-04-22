set -e
set -o pipefail

apk add curl netcat-openbsd coreutils
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/kubectl

export $NAME_ROOT
export $NAMESPACE

if [[ -f /etc/migration/migration.json ]]; then
  echo "---> Deleting ${NAMESPACE}/${NAME_ROOT}-migration"
  timeout 30s sh -c "until kubectl delete cm ${NAME_ROOT}-migration -n ${NAMESPACE}; do sleep 5; done"
fi

# DSN is always in the form DSN=DB_TYPE://DB_USER:PASSWORD@DB_URL/DB_NAME?sslmode=disable
# Extract DB_URL by cutting between @ and first /
DB_URL_PORT=$(echo $DSN | cut -d '@' -f2 | cut -d '/' -f 1 )
DB_TYPE=$(echo $DSN | cut -d ':' -f 1)
# DB_URL is expected to be mydb.mynamespace.svc.cluster.local:1234, but the port can be optional
# Check if it given by looking for :
if echo "$DB_URL_PORT" | grep -q ':'; then
  # Split URL and port by :
  DB_URL=$(echo $DB_URL_PORT | cut -d ':' -f 1)
  DB_PORT=$(echo $DB_URL_PORT | cut -d ':' -f 2)
else
  # Use the full url, since no port was given
  DB_URL=$DB_URL_PORT
  case $DB_TYPE in
  	"postgres" )
		DB_PORT="5432"
  		;;
    "cockroach" )
      DB_PORT="26257"
      ;;
    "mysql" )
      DB_PORT="3306"
      ;;
    * )
		DB_PORT="80"
		;;
  esac
fi

# If port was given, we use it, if not, empty var is expanded to 0
until nc -zv -w 5 $DB_URL $DB_PORT; do
  echo "$DB_URL not yet ready"
  sleep 5
done

hydra migrate sql -e --yes --config /etc/config/config.yaml
echo {\"timestamp\": \"$(date "+%Y%m%d-%H%M%S")\",\"completed\": true} > /tmp/migration.json
timeout 30s sh -c "until kubectl create cm ${NAME_ROOT}-migration -n ${NAMESPACE} --from-file=/tmp/migration.json --dry-run=client -o yaml | kubectl apply -f - ; do sleep 5; done"
