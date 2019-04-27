FROM python:3.7-alpine

RUN apk --update add gcc libffi-dev musl-dev openssl-dev linux-headers gettext bash

ENV WORK_DIR /usr/src/app
ENV SRC_DIR ${WORK_DIR}/src

WORKDIR ${WORK_DIR}
COPY requirements.txt .
RUN pip install --upgrade pip setuptools && pip install -r requirements.txt

# add app
COPY ./src ${SRC_DIR}
COPY ./uwsgi-start ${WORK_DIR}/uwsgi-start
COPY ./scripts/* /usr/local/bin/
COPY ./templates ${WORK_DIR}/templates

COPY docker/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
