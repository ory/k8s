SHELL=/bin/bash -euo pipefail

export PATH := .bin:${PATH}
export PWD := $(shell pwd)
export CIRCLE_TAG := ${CIRCLE_TAG}
export VERSION=$(shell echo ${CIRCLE_TAG} | sed s/v//g)

.bin/yq: go.mod
	go build -o .bin/yq github.com/mikefarah/yq/v3

.bin/helm: Makefile
	HELM_INSTALL_DIR=.bin bash <(curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3) -v v3.3.4 --no-sudo

release: .bin/yq .bin/helm
	yq w -i helm/charts/example-idp/Chart.yaml version "${VERSION}"
		yq w -i helm/charts/hydra-maester/Chart.yaml version "${VERSION}"; \
		yq w -i helm/charts/hydra/Chart.yaml version "${VERSION}"; \
		yq w -i helm/charts/hydra/Chart.yaml "dependencies.(name==hydra-maester).version" "${VERSION}"; \
		yq w -i helm/charts/keto/Chart.yaml version "${VERSION}"; \
		yq w -i helm/charts/kratos/Chart.yaml version "${VERSION}"; \
		yq w -i helm/charts/kratos-selfservice-ui-node/Chart.yaml version "${VERSION}"; \
		yq w -i helm/charts/oathkeeper-maester/Chart.yaml version "${VERSION}"; \
		yq w -i helm/charts/oathkeeper/Chart.yaml version "${VERSION}"; \
		yq w -i helm/charts/oathkeeper/Chart.yaml "dependencies.(name==oathkeeper-maester).version" "${VERSION}"; \
		helm dep update ./helm/charts/oathkeeper/; \
		helm package -d docs/helm/charts/ ./helm/charts/oathkeeper/ --version "${VERSION}"; \
		helm package -d docs/helm/charts/ ./helm/charts/oathkeeper-maester/ --version "${VERSION}"; \
		helm dep update ./helm/charts/hydra/; \
		helm package -d docs/helm/charts/ ./helm/charts/hydra/ --version "${VERSION}"; \
		helm package -d docs/helm/charts/ ./helm/charts/hydra-maester/ --version "${VERSION}"; \
		helm package -d docs/helm/charts/ ./helm/charts/example-idp/ --version "${VERSION}"; \
		helm package -d docs/helm/charts/ ./helm/charts/kratos/ --version "${VERSION}"; \
		helm package -d docs/helm/charts/ ./helm/charts/keto/ --version "${VERSION}"; \
		helm package -d docs/helm/charts/ ./helm/charts/kratos-selfservice-ui-node/ --version "${VERSION}"; \
		helm repo index docs/helm/charts/

kind-start:
	kind create cluster --wait 2m

kind-stop:
	kind delete cluster

postgresql:
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update
	helm install postgresql bitnami/postgresql -f .circleci/values/postgres.yaml

ory-repo:
	helm repo add ory https://k8s.ory.sh/helm/charts
	helm repo update

kind-test: kind-start postgresql
	.circleci/helm-test.sh oathkeeper
	.circleci/helm-test.sh oathkeeper-maester
	.circleci/helm-test.sh hydra
	.circleci/helm-test.sh hydra-maester
	.circleci/helm-test.sh kratos
	.circleci/helm-test.sh keto
	.circleci/helm-test.sh kratos-selfservice-ui-node

kind-upgrade: kind-start postgresql ory-repo
	.circleci/helm-upgrade.sh oathkeeper
	.circleci/helm-upgrade.sh oathkeeper-maester
	.circleci/helm-upgrade.sh hydra
	.circleci/helm-upgrade.sh hydra-maester
	.circleci/helm-upgrade.sh kratos
	.circleci/helm-upgrade.sh keto
	.circleci/helm-upgrade.sh kratos-selfservice-ui-node

lint:
	helm lint ./helm/charts/oathkeeper/
	helm lint ./helm/charts/oathkeeper-maester/
	helm lint ./helm/charts/keto/
	helm lint ./helm/charts/hydra/
	helm lint ./helm/charts/hydra-maester/
	helm lint ./helm/charts/kratos/
	helm lint ./helm/charts/example-idp/
	helm lint ./helm/charts/kratos-selfservice-ui-node/

validate:
	.circleci/helm-validate.sh oathkeeper
	.circleci/helm-validate.sh oathkeeper-maester
	.circleci/helm-validate.sh keto
	.circleci/helm-validate.sh hydra
	.circleci/helm-validate.sh hydra-maester
	.circleci/helm-validate.sh kratos
	.circleci/helm-validate.sh example-idp
	.circleci/helm-validate.sh kratos-selfservice-ui-node

