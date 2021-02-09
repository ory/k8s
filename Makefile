SHELL=/bin/bash -euxo pipefail

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
