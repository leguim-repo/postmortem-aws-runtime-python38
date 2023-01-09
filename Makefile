#.DEFAULT_GOAL := start
SHELL=/bin/bash
NOW = $(shell date +"%Y%m%d%H%M%S")
UID = $(shell id -u)
PWD = $(shell pwd)
PYTHON=$(shell which python3)

.PHONY: help
help: ## prints all targets available and their description
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: how_run_python_http_server
how_run_python_http_server: ## Just a little help
	@echo "just run:"
	@echo "python3 -m http.server 7000"
	@echo ""

.PHONY: create_docker_image
create_docker_image: ## Create docker image of AWS Lambda Runtime Python38
	docker build -t aws-lambda-python38 -f Dockerfile .

.PHONY: run_container
run_container: ## Run container based on image
	docker run --rm -d -p 9000:8080 -p 7000:7000 aws-lambda-python38

.PHONY: invoke_from_docker
invoke_from_docker: ## Invoke lambda from Docker container
	curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"payload":"hello world!"}'

.PHONY: push_image_to_minikube
push_image_to_minikube: ## Push image to minikube repository
	minikube start; \
	echo "Pushing Docker image to minikube repository. Please wait..."; \
	minikube image load aws-lambda-python38

.PHONY: list_minikube_images
list_minikube_images: ## Images list from minikube
	minikube image ls --format table

.PHONY: run_pod
run_pod: ## Run pod with AWS Lambda Runtime Python38
	kubectl run aws-lambda-python38-container --image=aws-lambda-python38 --image-pull-policy=Never --restart=Never; \
	echo "Wating 5 seconds..."; \
	sleep 5; \
	echo "Open another terminal to invoke from pod"
	kubectl port-forward pod/aws-lambda-python38-container 8080:8080 7000:7000

.PHONY: invoke_from_pod
invoke_from_pod: ## Invoke Lambda from kubernetes pod
	curl -XPOST "http://localhost:8080/2015-03-31/functions/function/invocations" -d '{"payload":"hello world!"}'

.PHONY: shell_on_pod
shell_on_pod: ## Interactive shell on pod
	kubectl exec -it aws-lambda-python38-container -- bash

.PHONY: debug_pod
debug_pod: ## Debug pod
	kubectl debug -it aws-lambda-python38-container --image=ubuntu --target=aws-lambda-python38-container

