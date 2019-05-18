###############################################################################
# meatwallace/meatbox-alpine
###
FROM alpine:3.9

ARG USER_SUDOERS_FILE="10-user"

# specific to this system's setup
ARG MEATBOX_USER="meatwallace"
ARG MEATBOX_PASSWORD
ARG MEATBOX_SETUP_SUDOERS_FILE="20-meatbox-setup"

RUN \
  # add our user account, ensuring it's in the `wheel` group for `sudo`
  adduser -D -s /bin/sh "${MEATBOX_USER}" users && \
  # set the account's password
  echo "${MEATBOX_USER}:${MEATBOX_PASSWORD}" | chpasswd && \ 
  # add a sudo config file that allows our user to use `sudo`
  echo "${MEATBOX_USER} ALL=(ALL) ALL" >> "/etc/sudoers.d/${USER_SUDOERS_FILE}" && \
  # update the file to have the correct permissions
  chmod 0440 "/etc/sudoers.d/${USER_SUDOERS_FILE}" && \
  # add a temporary sudo config file allowing our user to use pacman & make without
  # a password so our setup script doesn't require a custom `askpass` just for
  # docker
  echo "${MEATBOX_USER} ALL=NOPASSWD: /bin/sh, /bin/ln, /sbin/apk, /usr/sbin/addgroup, /sbin/rc-update, /sbin/rc-service" >> "/etc/sudoers.d/${MEATBOX_SETUP_SUDOERS_FILE}" && \
  chmod 0440 "/etc/sudoers.d/${MEATBOX_SETUP_SUDOERS_FILE}" && \
  apk update && \
  apk add --no-cache curl

# swap into our user account
USER "${MEATBOX_USER}"
WORKDIR "/home/${MEATBOX_USER}"

# we prevent caching of our setup script by injecting our current commit SHA1 here
ARG MEATBOX_CHECKOUT_SHA1

RUN \
      curl https://meatbox.one | sh && \
      meatbox bootstrap && \
      meatbox setup && \
      rm -rf tmp/* /var/cache/apk/*
