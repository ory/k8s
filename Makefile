SHELL=/bin/bash -o pipefail

.PHONY: init
init:
		git clone git@github.com:ory/charts.git .charts

.PHONY: commit-charts
commit-charts:
		cd .charts; git status; git hack chart-$$(date +%s); cp -R ../helm/ory-oathkeeper ./incubator/ory-oathkeeper; git add -A; git commit -s -a -m "[incubator/ory-oathkeeper] Propagate changes from upstream"; git npr
