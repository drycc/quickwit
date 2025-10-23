ARG CODENAME
FROM registry.drycc.cc/drycc/base:${CODENAME}

ARG DRYCC_UID=1001 \
  DRYCC_GID=1001 \
  DRYCC_HOME_DIR=/data \
  JQ_VERSION="1.7.1" \
  RCLONE_VERSION="1.71.1" \
  QUICKWIT_VERSION="0.8.2"

ADD rootfs /

RUN groupadd drycc --gid ${DRYCC_GID} \
  && useradd drycc -u ${DRYCC_UID} -g ${DRYCC_GID} -s /bin/bash -m -d ${DRYCC_HOME_DIR} \
  && install-stack jq $JQ_VERSION \
  && install-stack rclone $RCLONE_VERSION \
  && install-stack quickwit $QUICKWIT_VERSION \
  && rm -rf \
      /usr/share/doc \
      /usr/share/man \
      /usr/share/info \
      /usr/share/locale \
      /var/lib/apt/lists/* \
      /var/log/* \
      /var/cache/debconf/* \
      /etc/systemd \
      /lib/lsb \
      /lib/udev \
      /usr/lib/`echo $(uname -m)`-linux-gnu/gconv/IBM* \
      /usr/lib/`echo $(uname -m)`-linux-gnu/gconv/EBC* \
  && bash -c "mkdir -p /usr/share/man/man{1..8}"

VOLUME ${DRYCC_HOME_DIR}

USER ${DRYCC_UID}

ENV QW_CONFIG=/opt/drycc/quickwit/config/quickwit.yaml
ENV QW_DATA_DIR=/data
ENV QW_LISTEN_ADDRESS=0.0.0.0

ENTRYPOINT ["init-quickwit"]
