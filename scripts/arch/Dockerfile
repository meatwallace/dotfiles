##############################################################################
# meatwallace/meatbox-arch
###
FROM archlinux:latest

# specific to antergos setup when using the `base` installation
ARG USER_SUDOERS_FILE="10-user"

# specific to this system's setup
ARG MEATBOX_USER="meatwallace"
ARG MEATBOX_PASSWORD
ARG MEATBOX_SETUP_SUDOERS_FILE="20-setup"

RUN \
  # generate locales prior to package compilation
  locale-gen && \
  # add core dependencies - includes the kernel, bash, gnu utils, shadow, sudo
  pacman -Sy --noconfirm --needed base base-devel git gnupg openssh zsh unzip >/dev/null && \
  # add our user account and set a passwordf
  useradd -m -g users -G wheel -s /bin/zsh "${MEATBOX_USER}" && \
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
SHELL ["/bin/bash", "-c"]

# copy in our repository - this is intended to be ran where we are in our git repo. this also acts as our
# cache busting layer.
WORKDIR "/home/${MEATBOX_USER}"
COPY --chown=${MEATBOX_USER} . .

ARG MEATBOX_CHECKOUT_SHA1

RUN \
  # make sure `meatbox` is available in our path
  export PATH="$HOME/bin:$PATH" && \
  meatbox bootstrap && \
  # source .bashrc to force load of asdf in this environment
  . "$HOME/.bashrc" && \
  meatbox setup && \
  # clean up any extraneous dependencies left over by our installation
  yay --clean --noconfirm && \
  # clean up pacman's package cache for installed & uninstalled packages
  sudo pacman -Scc --noconfirm && \
  # clean up our yarn offline mirror
  rm -rf "$HOME/.yarn-offline-mirror" \
  # remove the sudo config we previously created to make our docker setup work
  echo "${MEATBOX_PASSWORD}" | sudo -S -i rm "/etc/sudoers.d/${MEATBOX_SETUP_SUDOERS_FILE}"

SHELL ["/bin/zsh", "-c"]
CMD ["/bin/zsh"]
