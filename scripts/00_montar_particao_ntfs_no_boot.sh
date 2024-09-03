#!/bin/bash

# Define o ponto de montagem e o diretório
MOUNT_POINT="/media/NTFS"
fstab_FILE="/etc/fstab"

# Cria o ponto de montagem se não existir
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Criando diretório de montagem $MOUNT_POINT"
    sudo mkdir -p "$MOUNT_POINT"
fi

# Encontra o UUID da partição NTFS
UUID=$(sudo blkid | grep ntfs | head -n 1 | awk -F 'UUID="' '{print $2}' | awk -F '"' '{print $1}')

if [ -z "$UUID" ]; then
    echo "Nenhuma partição NTFS encontrada."
    exit 1
fi

# Adiciona a entrada ao /etc/fstab se não estiver lá
if ! grep -q "$UUID" "$fstab_FILE"; then
    echo "Adicionando entrada ao $fstab_FILE"
    echo "# Adiciona partições NTFS na montagem do boot" | sudo tee -a "$fstab_FILE" > /dev/null
    echo "UUID=$UUID $MOUNT_POINT ntfs defaults,uid=1000,gid=1000 0 0" | sudo tee -a "$fstab_FILE"
else
    echo "A entrada já existe em $fstab_FILE"
fi

# Testa a montagem
sudo mount -a

