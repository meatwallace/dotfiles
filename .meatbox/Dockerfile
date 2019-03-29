###########################################################
# meatwallace/meatbox
##
FROM antergos/archlinux-base-devel:latest

# specific to antergos setup when using the `base` installation
ARG ANTERGOS_SUDOERS_FILE="10-installer"

# specific to this system's setup
ARG MEATBOX_USER="meatwallace"
ARG MEATBOX_PASSWORD
ARG MEATBOX_SETUP_SUDOERS_FILE="20-meatbox-setup"

# set up our system as close to what we'd get from a fresh Antergos install
# add our user account, ensuring it's in the `wheel` group for `sudo`
RUN \
  useradd -m -g users -G wheel -s /bin/bash "${MEATBOX_USER}" && \
  # set the account's password
  echo "${MEATBOX_USER}:${MEATBOX_PASSWORD}" | chpasswd && \ 
  # add a sudo config file that allows the `wheel` group to use `sudo`
  echo "${MEATBOX_USER} ALL=(ALL) ALL" >> "/etc/sudoers.d/${ANTERGOS_SUDOERS_FILE}" && \
  # update the file to have the correct permissions
  chmod 0440 "/etc/sudoers.d/${ANTERGOS_SUDOERS_FILE}" && \
  # add a temporary sudo config file allowing our user to use pacman & make without
  # a password so our setup script doesn't require a custom `askpass` just for
  # docker
  echo "${MEATBOX_USER} ALL=NOPASSWD: /usr/bin/bash, /usr/bin/pacman, /usr/bin/make, /usr/bin/nvidia-xconfig, /usr/bin/systemctl, /usr/bin/usermod, /usr/bin/ln" >> "/etc/sudoers.d/${MEATBOX_SETUP_SUDOERS_FILE}" && \
  chmod 0440 "/etc/sudoers.d/${MEATBOX_SETUP_SUDOERS_FILE}"

# swap into our user account
USER "${MEATBOX_USER}"

# we prevent caching of our setup script by injecting a timestamp ARG here
ARG CACHE_BUSTER=1

RUN \
  # run our system setup script from our staging alias
  curl https://meatbox.meatwallace.now.sh | bash && \
  # clean up any extraneous dependencies left over by our installation
  yay --clean --noconfirm && \
  # clean up pacman's package cache for installed & uninstalled packages
  sudo pacman -Scc --noconfirm && \
  # remove the sudo config we previously created to make our docker setup work
  echo "${MEATBOX_PASSWORD}" | sudo -S -i rm "/etc/sudoers.d/${MEATBOX_SETUP_SUDOERS_FILE}"

CMD ["/usr/bin/zsh"]
