SHELL=/bin/bash -o pipefail

.PHONY: init
init:
		git clone git@github.com:ory/charts.git .charts

.PHONY: commit-charts
commit-charts:
		cd .charts
		git status