FROM ubuntu:22.04

# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive

# Install/Update Deps
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl ca-certificates openssl locales \
    && apt-get dist-upgrade -y \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && adduser --disabled-password --home /home/container container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
