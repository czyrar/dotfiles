#!/bin/bash

if [ ! command -v ansible-playbook &> /dev/null ]; then
  sudo pacman -S ansible --noconfirm
  ansible-galaxy collection install kewlfft.aur
  ansible-playbook ~/.bootstrap/arch.yml --ask-become-pass
fi
