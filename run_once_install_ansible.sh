#!/bin/bash

sudo pacman -S ansible --noconfirm
ansible-galaxy install mnussbaum.ansible-yay
ansible-playbook ~/.bootstrap/arch.yml --ask-become-pass
