#!/bin/bash

install_on_fedora() {
  sudo dnf install -y ansible
  ansible-playbook ~/.bootstrap/fedora.yml --ask-become-pass
}

install_on_arch() {
  sudo pacman -S ansible --noconfirm
  ansible-galaxy install mnussbaum.ansible-yay
  ansible-playbook ~/.bootstrap/arch.yml --ask-become-pass
}

. /usr/lib/os-release
if [ -z "$ID_LIKE" ]; then
  DISTRO=$ID
else
  DISTRO=$ID_LIKE
fi

case "${DISTRO}" in
  fedora)
    install_on_fedora
    ;;
  arch)
    install_on_arch
    ;;
  *)
    echo "Unsupported linux distro: ${ID}"
    exit 1
    ;;
esac

ansible-playbook ~/.bootstrap/common.yml --ask-become-pass
