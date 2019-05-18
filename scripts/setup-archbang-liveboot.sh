#!/bin/sh

setup-pacman-key
setup-mirror
sudo pacman -Syy \
  libvirt \
  qemu-headless \
  ebtables \
  dnsmasq \
  docker \
  docker-compose \
  docker-machine \
  nvidia-docker \
  docker-machine-driver-kvm2 \
  kubectl-bin \
  minikube-bin
