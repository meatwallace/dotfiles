# dotfiles

[![CircleCI](https://circleci.com/gh/meatwallace/dotfiles/tree/master.svg?style=svg)](https://circleci.com/gh/meatwallace/dotfiles/tree/master)

> **!!! READ ME !!!**
> there's currently a lot of outstanding issues with just about everything in
> this config & surrounding tooling due to some long-term neglect. I'm working
> to resolve everything, however, I recommend additional caution if referencing
> anything in this repository as it may be outdated and/or broken.

my personal configuration for both Arch Linux based & Mac systems, available as
both an Arch Linux and Alpine Linux based docker image, or installable via the
script hosted at [https://meatbox.one](https://meatbox.one)

i recommend **not** using this, but feel free to take a gander or a gamble.

## Overview

an over-engineered system configuration and related tooling that aims to be
pragmatic for me to use, but is built upon needless complexity, change, and
technology; it serves as a personal playground to facilitate my day to day as
well as ongoing learning & mastery of various workflows & tools.

- `.vimrc`, a new and ongoing venture into the world of `(neo)vim`
- `.zshrc` and associated config files, using `zplugin` for plugin management
- `.config/` with my setup for `awesome`, `rofi`, `compton`, etc. for a full
  desktop environment for Linux based systems, aiming for a complete yet
  no-frills getting-shit-done workflow orientated around the terminal
- `.zfuncs/` and `bin/`, containing an array of ZSH and POSIX `sh` functions,
  respectively
- `scripts/`, containing all of the setup scripts, cooirdinated by `meatbox`, a
  simplistic CLI for managing setup & upgrades of the configuration
- `projects/meatlab`, a work in progress config for my home media server,
  currently a whopping 2 containers glued together with `docker-compose`
- automatic linting, testing, and building of the config into various docker
  images via CircleCI

## Usage

to boot into latest docker image with simple terminal access:

```sh
docker run -it --rm meatwallace/meatbox-alpine:latest
docker run -it --rm meatwallace/meatbox-arch:latest
```

to run the latest setup script, execute the following in your terminal:

```sh
curl https://meatbox.one | bash
meatbox bootstrap
meatbox setup
```

if you're feeling adventurous/daring and are on linux w/ docker, you can grab
[x11docker](https://github.com/mviereck/x11docker) and run the images with the
full desktop environment. **warning: this is insecure for a lot of reasons**.

- [example Alpine x11docker script](./scripts/alpine/run-x11.sh)
- [example Arch x11docker script](./scripts/arch/run-x11.sh)

### VirtualBox

if running in VirtualBox, ensure that the _Graphics Controller_ for the virtual
machine is set to **VBoxSGA**. if this is set to any other value, Kitty (the
default terminal) will not start.

## Post-Setup Notes

SSH & PGP:

```sh
# 1. put public and private SSH keys in ~/.ssh/id_rsa.pub and ~/.ssh/id_rsa, respectively
# 2. load the ssh agent
eval "$(ssh-agent -s)"

# 3. put private PGP key into ~/pgp_private_key.asc
# 4. load the key then remove it from disk
gpg --import ~/pgp_private_key.asc
rm ~/pgp_private_key.asc

# 5. restart the gpg agent
killall gpg-agent
gpg-agent --daemon
```

Google Cloud Platform CLI:

```sh
gcloud auth login
gcloud config set project meatcloud
gcloud config set computer/zone australia-southeast1
```

Yabai (Tiling WM for Mac):

```sh
sudo yubai --install-sa
```
