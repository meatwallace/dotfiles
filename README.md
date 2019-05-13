# dotfiles

[![CircleCI](https://circleci.com/gh/meatwallace/dotfiles/tree/master.svg?style=svg)](https://circleci.com/gh/meatwallace/dotfiles/tree/master)

my personal configuration for both Arch Linux based & Mac systems, available as
an [Antergos](https://antergos.com) based docker image, or through an automated
setup script hosted via the URL below.

i recommend **not** using this, but feel free to take a gander or a gamble.

## Usage

to boot into the Antergos-based docker image with simple terminal access:

```
docker run -it meatwallace/meatbox:latest
```

to run the latest setup script, execute the following in your terminal:

```sh
curl https://meatbox.one | sh
meatbox bootstrap
meatbox setup
```

if you're feeling adventurous/daring and are on linux w/ docker, you can grab
[x11docker](https://github.com/mviereck/x11docker) (included in my config),
and try running the docker image as a full desktop environment: 

```sh
# !! WARNING !!
# TL;DR: don't try this at home. really.
# 
# to allow the desktop environment & apps to work seamlessly, the following
# script opens up a bunch of security holes, allowing the booted container
# to hijack the host environment via a variety of vectors. in short, I do
# not recommend running this (with my image or any others) unless you're aware
# of what `x11docker` is doing or you're me.
# !! WARNING !!

x11docker \
  --desktop \
  --fullscreen \
  --init=systemd \
  --dbus-system \
  --user=RETAIN \
  --sudouser \
  --clipboard \
  --pulseaudio \
  --cap-default \
  -- \
  --cap-add=SYS_ADMIN \
  -- \
  meatwallace/meatbox:latest /usr/bin/xinitrcsession-helper
```

## Overview

this repository contains an over-engineered system configuration that aims to
be pragmatic for me to use, but is built upon needless complexity, prone to
changing, and a mix of technologies; it serves as a personal playground for
my learning & mastery of a variety of workflows, tools, languages, and just
generally, sharpening the saw.

some of what you'll find:

- `.vimrc`, a new and ongoing venture into the world of `(neo)vim`
- `.zshrc` and associated config files, using `zplugin` for plugin management
- `.config/` with my setup for `awesome`, `rofi`, `compton`, etc. for a full
  desktop environment for Linux based systems, aiming for a complete yet
  no-frills getting shit done workflow orientated around the terminal
- `scripts/`, containing all of  the setup scripts, cooirdinated by `meatbox`,
  a simplistic CLI for managing setup & upgrades of the configuration
- `projects/meatlab`, a work in progress config for my home media server,
  currently a whopping 2 containers glued together with `docker-compose`
- automatic linting, testing, and building the entire setup as a docker image
  via CircleCI

