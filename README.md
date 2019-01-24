# Simple Balena API
Small API that uses balena-sdk to get information about registered devices.

API: `http://localhost:<port>/balena/<application_name>/devices`
(Application name = sandbox-test)

## Local installation
* Possible modes: `dev` or `prod`
* Installation: `sh scripts/init [mode]` (Choose one of the modes above)
* **Important**: Configure your environment variables: `src/.env`

## Docker usage
* **Note**: `src/.env` files is mandatory. Execute `sh scripts/init-env [mode]` (Choose a mode from the local installation) AND configure your environment variables according to your chosen mode
* Start development container: `docker-compose up webapi-dev`
* Start production container: `docker-compose up webapi-prod`

# Without docker
* **Hint**: Local installation is mandatory
* Start app in **development** mode: `sh scripts/start-app`
* Start app in **production** mode: `sh scripts/start-app prod`