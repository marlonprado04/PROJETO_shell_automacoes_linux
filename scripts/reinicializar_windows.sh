#!/bin/bash

# Lista as opções de entrada do grub
# grep menuentry /boot/grub/grub.cfg

# Seleciona a opção menuentry do "Windows 11" como opção para próxima reinicialização
sudo grub-reboot "Windows 11"

# Reinicializa PC
sudo reboot
