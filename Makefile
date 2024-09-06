PLUGIN_VERSION := 3.4.3
IMAGE_NAME := privacyidea-freeradius:${PLUGIN_VERSION}

BUILDER := docker build
CONTAINER_ENGINE := docker

build:
	${BUILDER} --no-cache -t ${IMAGE_NAME} --build-arg PLUGIN_VERSION=${PLUGIN_VERSION} .
