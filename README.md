[![Docker](https://github.com/gpappsoft/privacyidea-freeradius/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/gpappsoft/privacyidea-freeradius/actions/workflows/docker-publish.yml)

# privacyIDEA-freeradius

Build a freeradius container, including the privacyIDEA plugin.

## Overview 

A simple freeradius server including the privacyIDEA-FreeRADIUS plugin. The radius authentication will be validated by a privacyIDEA server.

### Repository 

| Directory | Description |
|-----------|-------------|
| *raddb* | all files will copied to /etc/raddb/ in the build process|

Please refer to the  [privacyIDEA-plugin](https://privacyidea.readthedocs.io/en/latest/application_plugins/rlm_perl.html#configuration) documentation for more information about the files.

### Images
Sample images from this project can be found here: 
| registry | repository |
|----------|------------|
| [docker.io](https://hub.docker.com/r/gpappsoft/privacyidea-radius)|```docker pull docker.io/gpappsoft/privacyidea-radius:latest```

> [!Note] 
> ```latest``` tagged image is maybe a privacyidea-freeradius plugin pre- or development-release . Please use always a tag (like ```3.4.3```) 

### Prerequisites and requirements

- Installed container runtime engine (docker / podman).
- Installed [BuildKit](https://docs.docker.com/build/buildkit/), [buildx](https://github.com/docker/buildx) and [Compose V2](https://docs.docker.com/compose/install/linux/) (docker-compose-v2) components when using docker
- Installed [buildah](https://buildah.io/) when using podman
## Build image

##### Docker
```
make build PLUGIN_VERSION=3.4.3
```
##### Podman
```
make build PLUGIN_VERSION=3.4.3  CONTAINER_ENGINE=podman BUILDER="buildah bud"
```

## Run image

```
docker run --rm -dt -p 1812:1812/tcp -p 1812:1812/udp -p 1813:1813/udp -e PI_HOST=1.2.3.4:8443 privacyidea-freeradius:3.4.3
```
## Environment Variables

| Variable | Default | Description
|-----|---------|-------------
```RADIUS_PI_HOST``` |http://127.0.0.1| URL of privacyIDEA Api (with **http://** or **https://**)
```RADIUS_PI_REALM```|| Set the default realm
```RADIUS_PI_RESCONF``` || Set the default resolver
```RADIUS_PI_SSLCHECK```| false | Set to ```true``` to run with ssl check. **root CA certificate import is not yet implemented**
```RADIUS_PI_TIMEOUT```|10| Set timout for the request to the privacyIDEA server


## Frequently Asked Questions

#### How can I test or debug the RADIUS server?
- You can use the radtest command from the container.
```
docker exec -ti privacyidea-radius /opt/bin/radtest <username> <password> 127.0.0.1 1 testing123
```
- Start the debug mode with appending freeradius -X 
```
docker run --rm -dt -p 1812:1812/tcp -e ...  privacyidea-radius freeradius -X
```

#### How can I include my own clients.conf?
- Use a bind mount to */etc/raddb/clients.conf*

#### How can I modify the complete rlm_perl.ini?
- Use a bind mount to */etc/raddb/rlm_perl.ini*\
*Please note:* Do not change the [Default] section. Use the environment variables and include the following section:

```
[Default]
URL =
REALM =
RESCONF =
SSL_CHECK =
DEBUG =
TIMEOUT =
```
#### privacyIDEA-Freeradius plugin version x.x.x is not running, how to fix it?

- Don't know. The image was only testet latest version **3.4.3**

Any feedback are welcome! 

# Disclaimer

This project is my private project doing in my free time. This project is not from the NetKnights company. The project uses the open-source version of privacyIDEA. There is no official support from NetKnights for this project.
   
   
