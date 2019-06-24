FROM elixir:1.7.3-slim

ENV APP_DIR /var/opt/app

RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  ca-certificates \
  build-essential \
  erlang-dev \
  mysql-client \
  inotify-tools \
  git \
  imagemagick \
  pgcli \
  curl

RUN useradd -m -s /bin/bash elixir
RUN echo 'elixir:password' | chpasswd
RUN mkdir -p ${APP_DIR} && \
    chown -R elixir:elixir ${APP_DIR}

USER elixir

WORKDIR ${APP_DIR}

RUN set -x && \
  mix local.hex --force && \
  mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force

