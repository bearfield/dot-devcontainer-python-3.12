DOCKERHUB_REPONAME=ghcr.io/bearfield
CONTAINER_NAME=python
TAG_NAME=test.3.12

MAKEFILE_DIR=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))
WORK_DIR=$(MAKEFILE_DIR)

.PHONY:test.build
test.build:
	cd $(WORK_DIR)
	docker build --tag=$(DOCKERHUB_REPONAME)/$(CONTAINER_NAME):$(TAG_NAME) ./docker

.PHONY:test.rmi
test.rmi:
	docker rmi $(DOCKERHUB_REPONAME)/$(CONTAINER_NAME):$(TAG_NAME)

.PHONY:test
test: test.build test.rmi