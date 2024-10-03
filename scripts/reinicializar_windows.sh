#!/bin/bash

# Lista as opções de entrada do grub
# grep menuentry /boot/grub/grub.cfg

# Seleciona a opção 2 (indice 1 do array) como opção para próxima reinicialização
sudo grub-reboot 1

# Reinicializa o sistema
sudo reboot
