# vim: set noexpandtab ts=2 sw=2:
.PHONY: help dockerlint release build push

VERSION      ?= $(shell elixir ./version.exs)
RELEASE_NAME ?= dawdle_db_watcher
IMAGE_NAME   ?= hippware/$(shell echo $(RELEASE_NAME) | tr "_" "-")
IMAGE_TAG    ?= $(shell echo $(VERSION) | tr "+" "-")

help:
	@echo "Repo:    $(IMAGE_NAME)"
	@echo "Tag:     $(IMAGE_TAG)"
	@echo "Version: $(VERSION)"
	@echo ""
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

########################################################################
### Build release images

dockerlint: ## Run dockerlint on the Dockerfiles
	@echo "Checking Dockerfile..."
	@docker run -it --rm -v "${PWD}/Dockerfile":/Dockerfile:ro redcoolbeans/dockerlint:latest

build: ## Build the release Docker image
	@docker build . -t $(IMAGE_NAME):$(IMAGE_TAG) -t $(IMAGE_NAME):latest

push: ## Push the Docker image to the cloud
	@docker push $(IMAGE_NAME):$(IMAGE_TAG)
	@docker push $(IMAGE_NAME):latest

run: ## Run the docker image
	@docker run -it --rm $(IMAGE_NAME):latest ${ARGS}
