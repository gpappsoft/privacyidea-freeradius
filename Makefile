PLUGIN_VERSION := 3.4.3
IMAGE_NAME := privacyidea-freeradius:${PLUGIN_VERSION}

BUILDER := docker build
CONTAINER_ENGINE := docker

REGISTRY := localhost:5000
PORT := 8080
TAG := prod

build:
	${BUILDER} --no-cache -t ${IMAGE_NAME} --build-arg PLUGIN_VERSION=${PLUGIN_VERSION} .

push:
	${CONTAINER_ENGINE} tag ${IMAGE_NAME} ${REGISTRY}/${IMAGE_NAME}
	${CONTAINER_ENGINE} push ${REGISTRY}/${IMAGE_NAME}

run:
	@${CONTAINER_ENGINE} run -d --rm --name ${TAG}-privacyidea-radius \
		 -p 1812:1812/tcp \
		 -p 1812:1812/udp \
		 -p 1813:1813/udp \
		 -e PI_HOST=localhost:8443 \
		 ${IMAGE_NAME} 

	@echo Access to privacyIDEA Web-UI: http://localhost:${PORT}
	@echo Username/Password: admin / admin
