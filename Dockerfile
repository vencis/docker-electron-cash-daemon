FROM python:3.8-alpine

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
ENV ELECTRONCASH_VERSION $VERSION
ENV ELECTRONCASH_USER electroncash
ENV ELECTRONCASH_PASSWORD electroncashz    # XXX: CHANGE REQUIRED!
ENV ELECTRONCASH_HOME /home/$ELECTRONCASH_USER

RUN apk add --no-cache --virtual .build-deps build-base gcc musl-dev libffi-dev openssl-dev automake autoconf libtool git util-linux bash && \
  adduser -D $ELECTRONCASH_USER && \
  mkdir -p /data ${ELECTRONCASH_HOME} && \
  ln -sf /data ${ELECTRONCASH_HOME}/.electron-cash && \
  cd ${ELECTRONCASH_HOME}/ && git clone https://github.com/Electron-Cash/Electron-Cash.git && \
  chown ${ELECTRONCASH_USER} ${ELECTRONCASH_HOME}/.electron-cash /data && \
  cd ${ELECTRONCASH_HOME}/Electron-Cash/ && bash contrib/make_secp && \
  pip3 install --no-cache-dir ${ELECTRONCASH_HOME}/Electron-Cash && \
  rm -rf ${ELECTRONCASH_HOME}/Electron-Cash/ && \
  apk del --no-cache .build-deps

USER $ELECTRONCASH_USER
WORKDIR $ELECTRONCASH_HOME
VOLUME /data
EXPOSE 7000

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["electron-cash"]
