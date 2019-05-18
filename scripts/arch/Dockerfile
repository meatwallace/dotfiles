###############################################################################
# meatwallace/meatbox-arch
###
FROM antergos/archlinux-base-devel:latest

# specific to antergos setup when using the `base` installation
ARG USER_SUDOERS_FILE="10-user"

# specific to this system's setup
ARG MEATBOX_USER="meatwallace"
ARG MEATBOX_PASSWORD
ARG MEATBOX_SETUP_SUDOERS_FILE="20-setup"

RUN \
  # add our user account and set a passwordf 
  useradd -m -g users -G wheel -s /bin/bash "${MEATBOX_USER}" && \
  echo "${MEATBOX_USER}:${MEATBOX_PASSWORD}" | chpasswd && \ 
  # add a sudoers config allowing our user to use `sudo` and fix permissions
  echo "${MEATBOX_USER} ALL=(ALL) ALL" | tee -a "/etc/sudoers.d/${USER_SUDOERS_FILE}" && \
  chmod 0440 "/etc/sudoers.d/${USER_SUDOERS_FILE}" && \
  # add a temporary sudoers config file allowing our user to `sudo` freely w/o
  # a password so we avoid the need for a custom `askpass` script inside the
  # docker environment
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
  # clean up any extraneous dependencies left over by our installation
  yay --clean --noconfirm && \
  # clean up pacman's package cache for installed & uninstalled packages
  sudo pacman -Scc --noconfirm && \
  # remove the sudo config we previously created to make our docker setup work
  echo "${MEATBOX_PASSWORD}" | sudo -S -i rm "/etc/sudoers.d/${MEATBOX_SETUP_SUDOERS_FILE}"

CMD ["/bin/zsh"]
