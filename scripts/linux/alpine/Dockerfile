###############################################################################
# meatwallace/meatbox-alpine
###
FROM alpine:3.9

COPY APKFile ./

RUN \
      echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
      echo "@edgecommunity http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
      echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

COPY APKFile ./

RUN \
      export packages="$(grep -v '^\#' ./APKFile | grep .)" && \
      apk add --no-cache $packages && \
      rm -f ./APKFile && \
      rm -rf tmp/* /var/cache/apk/*

# TODO: enable when setup scripts can distinguish distros
# RUN \
#      curl https://meatbox.one | bash &&
#      meatbox setup

