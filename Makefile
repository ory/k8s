SHELL=/bin/bash -o pipefail

.PHONY: kind-start
kind-start:
	GO111MODULE="on" go get sigs.k8s.io/kind@v0.4.0
	kind --loglevel=debug create cluster
	KUBECONFIG=$(shell kind get kubeconfig-path --name="kind")

# Stop KIND pseudo-cluster
.PHONY: kind-stop
kind-stop:
	GO111MODULE=on go install sigs.k8s.io/kind
	kind --loglevel=debug delete cluster
