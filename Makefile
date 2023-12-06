PROJECT_PATH=$(shell pwd)
version=8.11.1
image=kibana
container=kibana
network=elastic
ex_port=5110

.PHONY: all
all: deploy

.PHONY: create-network
network:
	-docker network create $(network)

.PHONY: remove-container
remove-container:
	-docker rm -f $(container)

.PHONY: build
build:
	docker build -t $(image):$(version) -t $(image) $(PROJECT_PATH)

.PHONY: deploy
deploy: network remove-container build
	docker run --name $(container) --net $(network) -p $(ex_port):5601 -it -d $(image)