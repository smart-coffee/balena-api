#!/bin/sh

APP_PROCESSES=${APP_PROCESSES:-"4"}
APP_THREADS=${APP_THREADS:-"2"}

echo "Working directory: $WORK_DIR"
echo "Source directory: $SRC_DIR"
echo "App starts on host:'$APP_HOST' on port:'$APP_PORT'"
echo "For ports outside the container, checkout the 'docker-compose.yml' file."

if [[ ! -f "cert.pem" ]]; then
	echo "Linking cert.pem"
	ln -s /ssl/cert.pem $SRC_DIR/cert.pem
fi
if [[ ! -f "privkey.pem" ]]; then
	echo "Linking privkey.pem"
	ln -s /ssl/privkey.pem $SRC_DIR/privkey.pem
fi

cat <<EOF >$WORK_DIR/uwsgi.ini
[uwsgi]
https = $APP_HOST:$APP_PORT,src/$CERT_FILE,src/$PRIVKEY_FILE
chdir = src
socket = %n.sock
manage-script-name = true
mount =	/api=app.py
callable = app

threads = $APP_THREADS
processes = $APP_PROCESSES
master = true
safe-pidfile = %n.pid
EOF

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
