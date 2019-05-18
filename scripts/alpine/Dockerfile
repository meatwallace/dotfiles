###############################################################################
# meatwallace/meatbox-alpine
###
FROM alpine:3.9

ARG USER_SUDOERS_FILE="10-user"

# specific to this system's setup
ARG MEATBOX_USER="meatwallace"
ARG MEATBOX_PASSWORD
ARG MEATBOX_SETUP_SUDOERS_FILE="20-setup"

RUN \
  apk add --no-cache \
    # replace busybox utils with standard linux utils
    binutils \
    coreutils \
    findutils \
    grep \
    pciutils \
    usbutils \
    util-linux \

    # required by our setup script
    bash \
    curl \
    git \
    gnupg \
    sudo \

    # specifically required to build packages by `asdf`
    build-base \
    bzip2-dev \
    linux-headers \
    libffi-dev \
    openssl-dev \
    readline-dev \
    sqlite-dev \
    unzip \
    zlib-dev && \
  # add our user account & set the password
  adduser -D -s /bin/bash "${MEATBOX_USER}" users && \
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
WORKDIR "/home/${MEATBOX_USER}"

# we prevent caching of our setup script by injecting our current commit SHA1 here
ARG MEATBOX_CHECKOUT_SHA1

RUN \
  # run our system setup script from our staging alias
  curl "https://meatbox.meatwallace.now.sh" | MEATBOX_CHECKOUT_SHA1="${MEATBOX_CHECKOUT_SHA1}" bash && \
  . "/home/${MEATBOX_USER}/.bashrc" && \
  meatbox bootstrap && \
  . "/home/${MEATBOX_USER}/.bashrc" && \
  meatbox setup && \
  . "/home/${MEATBOX_USER}/.bashrc" && \
  rm -rf tmp/* /var/cache/apk/*

CMD ["/bin/zsh"]
