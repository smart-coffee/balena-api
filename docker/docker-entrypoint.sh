#!/bin/bash

init-config prod

echo "Working directory: $WORK_DIR"
echo "Source directory: $SRC_DIR"
echo "App starts on host:'$APP_HOST' on port:'$APP_PORT'"
echo "For ports outside the container, checkout the 'docker-compose.yml' file."

if [[ ! -f "/ssl/cert.pem" ]]; then
	echo "Linking cert.pem"
	ln -s /ssl/cert.pem $SRC_DIR/$CERT_FILE
fi
if [[ ! -f "/ssl/privkey.pem" ]]; then
	echo "Linking privkey.pem"
	ln -s /ssl/privkey.pem $SRC_DIR/$PRIVKEY_FILE
fi

cat src/.env
cat uwsgi.ini

if [[ "$FLASK_ENV" = "production" ]]; then
	echo "Production mode."
	sh uwsgi-start
elif [[ "$FLASK_ENV" = "development" ]]; then
	echo "Development mode."
	cd "$SRC_DIR"
	python app.py
else
	echo "Unknown FLASK_ENV: $FLASK_ENV"
	exit 1
fi
