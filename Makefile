SHELL=/bin/bash -euo pipefail

export PATH := .bin:${PATH}
export PWD := $(shell pwd)
export VERSION=$(shell echo ${RELEASE_VERSION} | sed s/v//g)
export K3SIMAGE := docker.io/rancher/k3s:v1.26.1-k3s1

.bin/yq: go.mod
	go build -o .bin/yq github.com/mikefarah/yq/v3

.bin/helm: Makefile
	HELM_INSTALL_DIR=.bin bash <(curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3) -v v3.12.0 --no-sudo

.bin/ory: Makefile
	curl https://raw.githubusercontent.com/ory/meta/master/install.sh | bash -s -- -b .bin ory v0.1.48
	touch .bin/ory

.PHONY: release
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

.PHONY: k3d-up
k3d-up:
	k3d cluster create --image $${K3SIMAGE} ory-k8s -p "8080:80@server:0" \
		--k3s-arg=--kube-apiserver-arg="enable-admission-plugins=NodeRestriction,ServiceAccount@server:0" \
		--k3s-arg=feature-gates="NamespaceDefaultLabelName=true@server:0";

	kubectl apply -R -f hacks/manifests

.PHONY: k3d-run
k3d-run: k3d-up postgresql prometheus

.PHONY: k3d-down
k3d-down:
	k3d cluster delete ory-k8s || true

.PHONY: postgresql
postgresql:
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update
	helm install postgresql bitnami/postgresql -f hacks/values/postgres.yaml

.PHONY: prometheus
prometheus:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update
	kubectl create ns prometheus --dry-run=client -o yaml | kubectl apply -f -
	helm install prometheus prometheus-community/kube-prometheus-stack -f hacks/values/prometheus.yaml

.PHONY: ory-repo
ory-repo:
	helm repo add ory https://k8s.ory.sh/helm/charts
	helm repo update

.PHONY: helm-test
helm-test: k3d-up postgresql prometheus
	@if [ ! "${HELM_CHART}" ]; then \
		echo 'No helm chart specified, cancelling, please specify HELM_CHART'; \
		exit 1; \
	fi; \
	hacks/helm-test.sh ${HELM_CHART}
	make k3d-down

.PHONY: helm-upgrade
helm-upgrade: k3d-up postgresql ory-repo prometheus
	@if [ ! "${HELM_CHART}" ]; then \
		echo 'No helm chart specified, cancelling, please specify HELM_CHART'; \
		exit 1; \
	fi; \
	hacks/helm-upgrade.sh ${HELM_CHART}
	make k3d-down

.PHONY: helm-lint
helm-lint:
	@if [ ! "${HELM_CHART}" ]; then \
		echo 'No helm chart specified, cancelling, please specify HELM_CHART'; \
		exit 1; \
	fi; \
	helm lint ./helm/charts/${HELM_CHART}/

.PHONY: helm-validate
helm-validate:
	@if [ ! "${HELM_CHART}" ]; then \
		echo 'No helm chart specified, cancelling, please specify HELM_CHART'; \
		exit 1; \
	fi; \
	hacks/helm-validate.sh ${HELM_CHART}

.PHONY: helm-docs
helm-docs:
	helm-docs -c helm/charts/

.PHONY: format
format: .bin/goimports .bin/ory node_modules
	.bin/ory dev headers copyright --type=open-source
	.bin/goimports -w .
	npm exec -- prettier --write .

licenses: .bin/licenses node_modules  # checks open-source licenses
	.bin/licenses

.bin/goimports:
	GOBIN=$(shell pwd)/.bin go install golang.org/x/tools/cmd/goimports@latest

.bin/licenses: Makefile
	curl https://raw.githubusercontent.com/ory/ci/master/licenses/install | sh

node_modules: package-lock.json
	npm ci
	touch node_modules
