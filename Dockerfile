FROM node:11.5-alpine

# labels
LABEL maintainer="fujiba@fujiba.net"

# variables
ENV HUGO_VERSION 0.66.0
ENV HUGO_NAME="hugo_extended_${HUGO_VERSION}_Linux-64bit"
ENV HUGO_BASE_URL="https://github.com/gohugoio/hugo/releases/download"
ENV HUGO_URL="${HUGO_BASE_URL}/v${HUGO_VERSION}/${HUGO_NAME}.tar.gz"

# install hugo
RUN set -x && \
  apk add --update --upgrade --no-cache wget ca-certificates \
  git bash libc6-compat libstdc++ && \
  # make sure we have up-to-date certificates
  update-ca-certificates && \
  cd /tmp &&\
  wget "${HUGO_URL}" -O hugo.tar.gz && \
  tar xzf hugo.tar.gz && \
  mv hugo /usr/bin/hugo && \
  rm -r * && \
  # don't delete ca-certificates pacakge here since it remove all certs too
  apk del --purge wget && \
  # install firebase-cli
  # use --unsafe-perm to solve the issue: https://github.com/firebase/firebase-tools/issues/372
  npm install -g firebase-tools --unsafe-perm
