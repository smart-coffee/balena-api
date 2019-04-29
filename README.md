# Simple Balena API

[![Build Status](https://travis-ci.com/smart-coffee/balena-api.svg?branch=master)](https://travis-ci.com/smart-coffee/balena-api)

Small API that uses balena-sdk to get information about registered devices.

API: `http://<env:APP_HOST>:<env:APP_PORT>/<env:MOUNT_URL>/<env:URL_PREFIX>/<application_name>/devices`
(Application name = See in balena.io)

## Local installation

* Possible modes: `dev` or `prod`
* Installation: `sh scripts/init [mode]` (Choose one of the modes above)
* **Important**: Configure your environment variables: `src/.env`

## Docker usage

* **Note**: `src/.env` files is mandatory. Execute `sh scripts/init-env [mode]` (Choose a mode from the local installation) AND configure your environment variables according to your chosen mode
* Start development container: `docker-compose up webapi-dev`
* Start production container: `docker-compose up webapi-prod`

## Without docker

* **Hint**: Local installation is mandatory
* Start app in **development** mode: `sh scripts/start-app`
* Start app in **production** mode: `sh scripts/start-app prod`