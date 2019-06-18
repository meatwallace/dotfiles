###############################################################################
# meatwallace/meatbox-alpine
###
FROM mhart/alpine-node:latest

ARG USER_SUDOERS_FILE="10-user"

# specific to this system's setup
ARG MEATBOX_USER="meatwallace"
ARG MEATBOX_PASSWORD
ARG MEATBOX_SETUP_SUDOERS_FILE="20-setup"

RUN \
  # required by our setup script
  apk add --no-cache \
    bash \
    curl \
    git \
    gnupg \
    sudo >/dev/null && \
  # add our user account & set the password
  adduser -D -s /bin/zsh "${MEATBOX_USER}" users && \
  echo "${MEATBOX_USER}:${MEATBOX_PASSWORD}" | chpasswd && \
  # add a sudo config file that allows our user to use `sudo`
  echo "${MEATBOX_USER} ALL=(ALL) ALL" | tee -a "/etc/sudoers.d/${USER_SUDOERS_FILE}" && \
  # update the file to have the correct permissions
  chmod 0440 "/etc/sudoers.d/${USER_SUDOERS_FILE}" && \
  # add a temporary sudo config file allowing our user to use pacman & make without
  # a password so our setup script doesn't require a custom `askpass` just for
  # docker
  echo "${MEATBOX_USER} ALL=NOPASSWD: ALL" | tee -a "/etc/sudoers.d/${MEATBOX_SETUP_SUDOERS_FILE}" && \
  chmod 0440 "/etc/sudoers.d/${MEATBOX_SETUP_SUDOERS_FILE}"

# swap into our user account
USER "${MEATBOX_USER}"
SHELL ["/bin/bash", "-c"]

# we prevent caching of our setup script by injecting our current commit SHA1 here
ARG MEATBOX_CHECKOUT_SHA1

RUN \
  # replace busybox utils with standard linux utils
  echo "${MEATBOX_PASSWORD}" | sudo -S apk add --no-cache \
    binutils \
    coreutils \
    findutils \
    grep \
    pciutils \
    usbutils \
    util-linux >/dev/null && \
  # packages required by `asdf` we'll clean up later
  echo "${MEATBOX_PASSWORD}" | sudo -S apk add --no-cache --virtual .build-dependencies \
    build-base \
    bzip2-dev \
    linux-headers \
    libffi-dev \
    openssl-dev \
    readline-dev \
    sqlite-dev \
    unzip \
    zlib-dev >/dev/null && \
  # run our system setup script from our staging alias
  curl "https://meatbox.meatwallace.now.sh" | MEATBOX_CHECKOUT_SHA1="${MEATBOX_CHECKOUT_SHA1}" bash && \
  . "$HOME/.bashrc" && \
  meatbox bootstrap && \
  . "$HOME/.bashrc" && \
  meatbox setup && \
  # remove our build dependencies
  echo "${MEATBOX_PASSWORD}" | sudo -S apk del .build-dependencies >/dev/null && \
  # clean up our any temp files that may have been created
  rm -rf tmp/* >/dev/null && \
  # clean up our yarn offline mirror
  rm -rf "$HOME/.yarn-offline-mirror" \
  # remove the sudo config we previously created to make our docker setup work
  echo "${MEATBOX_PASSWORD}" | sudo -S rm "/etc/sudoers.d/${MEATBOX_SETUP_SUDOERS_FILE}"

SHELL ["/bin/zsh", "-c"]
CMD ["/bin/zsh"]
