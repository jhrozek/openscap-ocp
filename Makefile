APP_NAME=openscap-ocp

REPO?=quay.io/jhrozek
CNT_RUNTIME?=podman

.PHONY: build build-nocache tag-latest tag-branch push-latest push-branch

all: build

build:
	$(CNT_RUNTIME) build -f Dockerfile -t $(APP_NAME)

build-nocache:
	$(CNT_RUNTIME) build --no-cache -f Dockerfile -t $(APP_NAME)

tag-latest: 
	$(CNT_RUNTIME) tag $(APP_NAME) $(REPO)/$(APP_NAME):latest

tag-branch:
	$(CNT_RUNTIME) tag $(APP_NAME) $(REPO)/$(APP_NAME):$(shell git rev-parse --abbrev-ref HEAD)

push-latest:
	$(CNT_RUNTIME) push $(REPO)/$(APP_NAME):latest

push-branch:
	$(CNT_RUNTIME) push $(APP_NAME) $(REPO)/$(APP_NAME):$(shell git rev-parse --abbrev-ref HEAD)
