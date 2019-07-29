SHELL=/bin/bash -o pipefail

.PHONY: kind-start
kind-start:
	GO111MODULE=on go install sigs.k8s.io/kind
	kind create cluster --log-level=debug
	KUBECONFIG=$(shell kind get kubeconfig-path --name="kind")

# Stop KIND pseudo-cluster
.PHONY: kind-stop
kind-stop:
	GO111MODULE=on go install sigs.k8s.io/kind
	kind delete cluster --log-level=debug
