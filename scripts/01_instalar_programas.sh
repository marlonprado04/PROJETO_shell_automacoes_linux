#!/bin/bash

# Nome do arquivo de log
LOG_FILE="log_de_instalacao.txt"

# Função para registrar mensagem de erro no arquivo de log e no terminal
handle_error() {
    echo "Erro: $1" >> "$LOG_FILE"
    echo "Erro: $1"
    exit 1
}

# Limpar o arquivo de log, se ele existir
> "$LOG_FILE"

echo "Iniciando instalação..."

# ---------------------------------------------------
# Adicionando repositórios necessários
sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y 2>> "$LOG_FILE" || handle_error "Falha ao adicionar o repositório do grub-customizer"
sudo add-apt-repository universe -y 2>> "$LOG_FILE" || handle_error "Falha ao adicionar o repositório universe"

# Atualizar o sistema
sudo apt update 2>> "$LOG_FILE" || handle_error "Falha ao atualizar o sistema."
sudo apt upgrade -y 2>> "$LOG_FILE" || handle_error "Falha ao atualizar pacotes."
sudo apt dist-upgrade -y 2>> "$LOG_FILE" || handle_error "Falha ao atualizar pacotes da distribuição."
sudo apt install ubuntu-restricted-extras -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar os complementos e codecs extras."

# ---------------------------------------------------
# Instalar programas via apt
declare -a APT_PACKAGES=(
    openjdk-17-jre-headless
    synaptic
    gnome-software
    gnome-sushi
    folder-color
    nautilus-admin
    imagemagick
    nautilus-image-converter
    chrome-gnome-shell
    gnome-shell-extensions
    git
    git-lfs
    nodejs
    qbittorrent
    kdeconnect
    gparted
    bat
    grub-customizer
    gnome-clocks
    tree
    peek
    exfat-fuse
    whois
    net-tools
    neofetch
    python3-pip
    copyq
    npm
    flameshot
)

for PACKAGE in "${APT_PACKAGES[@]}"; do
    sudo apt install "$PACKAGE" -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar $PACKAGE via apt."
done

# ---------------------------------------------------
# Instalar Flatpak e adicionar o Flathub
sudo apt install flatpak -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar Flatpak."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 2>> "$LOG_FILE" || handle_error "Falha ao adicionar Flathub."

# Instalar programas via Flatpak
declare -a FLATPAK_APPS=(
    com.calibre_ebook.calibre
    com.valvesoftware.Steam
    com.obsproject.Studio
    it.mijorus.gearlever
)

for APP in "${FLATPAK_APPS[@]}"; do
    flatpak install --system "$APP" -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar $APP via Flatpak."
done

# ---------------------------------------------------
# Instalar Snap e programas via Snap
sudo apt install snapd -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar o Snap."
sudo snap install snap-store 2>> "$LOG_FILE" || handle_error "Falha ao instalar snap-store via Snap."

# Instalar aplicativos com o Snap
declare -a SNAP_APPS=(
    code
    curl
    discord
    photogimp
    btop
    vlc
    wps-office-all-lang-no-internet
    tldr
    ncdu
    ticktick
    spotify
    bitwarden
)

for APP in "${SNAP_APPS[@]}"; do
    sudo snap install "$APP" 2>> "$LOG_FILE" || handle_error "Falha ao instalar $APP via Snap."
done

# Instalar aplicativos Snap com o parâmetro --classic
declare -a SNAP_CLASSIC_APPS=(
    code
    netbeans
    obsidian
)

for APP in "${SNAP_CLASSIC_APPS[@]}"; do
    sudo snap install "$APP" --classic 2>> "$LOG_FILE" || handle_error "Falha ao instalar $APP via Snap com --classic."
done


# ---------------------------------------------------
# Instalar Anydesk
curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/anydesk.gpg
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo apt update
sudo apt install anydesk -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar Anydesk via apt"

# Instalar Microsoft Edge
sudo apt install software-properties-common apt-transport-https wget -y || handle_error "Falha ao instalar os itens necessários para Microsoft Edge"
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - || handle_error "Falha ao adicionar a chave do Microsoft Edge"
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" -y
sudo apt update
sudo apt install microsoft-edge-stable -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar Microsoft Edge via apt"

# Instalar Google Chrome
sudo apt install -y wget
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - || handle_error "Falha ao adicionar a chave do Google Chrome"
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install google-chrome-stable -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar o Google Chrome via apt"
sudo apt install dconf-editor -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar o Dconf Editor via apt"

# Instalar GitHub Desktop
wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
sudo apt update 2>> "$LOG_FILE" || handle_error "Falha ao atualizar o sistema após adicionar o repositório do GitHub Desktop."
sudo apt install github-desktop -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar GitHub Desktop."

# Instalar extensão para "open in VSCode" no Nautilus
sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/harry-cpp/code-nautilus/master/install.sh)"


# ---------------------------------------------------
# Configurar prompt do Bash
echo '
# Função para obter o nome do branch Git
parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1)/"
}

# Definir o prompt do Bash com o nome do branch Git destacado em vermelho e negrito
PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]\$(parse_git_branch)\[\033[00m\]\$ "
' >> ~/.bashrc

# Recarregar o arquivo .bashrc
source ~/.bashrc

echo "Instalação concluída."

# ---------------------------------------------------
# Limpar cache e pacotes não necessários
sudo apt autoremove -y 2>> "$LOG_FILE" || handle_error "Falha ao remover pacotes não necessários."
sudo apt clean 2>> "$LOG_FILE" || handle_error "Falha ao limpar cache."

echo "Instalação concluída!"

# ---------------------------------------------------
# Configurar o git
echo "Iniciando configuração do git"
git config --global credential.helper store
git config --global user.email "marlonprado04@gmail.com"
git config --global user.name "Marlon Prado - Ubuntu"
git config --global init.defaultBranch main
echo "Git configurado com sucesso!"

# ---------------------------------------------------
# Adicionar templates de documentos para o contexto do nautilus
echo "Adicionando templates de documentos"
mkdir -p ~/Modelos
touch ~/Modelos/"novo_excel.xls"
touch ~/Modelos/"gitkeep.gitkeep"
touch ~/Modelos/"novo_markdown.md"
touch ~/Modelos/"novo_txt.txt"
echo "Templates de documentos adicionados"

# ---------------------------------------------------
# Configurar montagem automatica da partição NTFS
echo "Iniciando configuração de montagem da partição NTFS"

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

echo "Configuração de montagem automática finalizada com sucesso"

# ---------------------------------------------------
# Adicionar alias para navegação via terminal
echo "Adicionando aliases"
alias myntfs="cd /media/NTFS"
alias mygithub="cd /media/NTFS/00_MEUS_DOCUMENTOS_PC/00_PASTA_PC/03_ESTUDOS/GITHUB"
echo "Aliases adicionados com sucesso"
