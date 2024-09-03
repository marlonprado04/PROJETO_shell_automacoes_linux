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

# Adicionando repositorios necessarios
sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y 2>> "$LOG_FILE" || handle_error "Falha ao adicionar o repositorio do grub-customizer"
sudo add-apt-repository universe -y 2>> "$LOG_FILE" || handle_error "Falha ao adicionar o repositorio universe"

# Atualizar o sistema
sudo apt update 2>> "$LOG_FILE" || handle_error "Falha ao atualizar o sistema."
sudo apt upgrade -y 2>> "$LOG_FILE" || handle_error "Falha ao atualizar pacotes."
sudo apt dist-upgrade -y 2>> "$LOG_FILE" || handle_error "Falha ao atualizar pacotes da distribuicao."
sudo apt install ubuntu-restricted-extras -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar os complementos e codecs extras."

# ---------------------------------------------------

# Instalar programas via apt
sudo apt install synaptic -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar synaptic via apt."
sudo apt install gnome-software -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar gnome-software via apt."
sudo apt install gnome-sushi -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar gnome-sushi via apt."
sudo add-apt-repository ppa:costales/folder-color -y 2>> "$LOG_FILE" || handle_error "Falha ao adicionar repositorio do folder-color para via apt"
sudo apt install folder-color -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar folder-color via apt."
sudo apt install nautilus-admin -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar nautilus-admin via apt"
sudo apt install imagemagick nautilus-image-converter -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar imagemagick nautilus-image-converter via apt"
sudo apt install chrome-gnome-shell -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar chrome-gnome-shell via apt"
sudo apt install gnome-shell-extensions -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar gnome-shell-extensions via apt"
sudo apt install git -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar git via apt"
sudo apt install git-lfs -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar git-lfs via apt"
sudo apt install nodejs -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar nodejs via apt"
sudo apt install qbittorrent -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar qbitorrent via apt"
sudo apt install kdeconnect -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar KDE Connect via apt."
sudo apt install gparted -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar gparted via apt."
sudo apt install bat -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar bat via apt."
sudo apt install grub-customizer -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar grub-customizer via apt."
sudo apt install gnome-clocks -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar gnome-clocks via apt."
sudo apt install tree -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar tree via apt."
sudo apt install peek -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar peek via apt."
sudo apt install exfat-utils -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar exfat-utils via apt."
sudo apt install exfat-fuse -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar exfat-fuse via apt."
sudo apt install whois -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar whois via apt."
sudo apt install net-tools -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar net-tools via apt."
sudo apt install neofetch -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar neofetch via apt."
sudo apt install python3-pip -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar python3-pip via apt."
sudo apt install copyq -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar copyq via apt."
sudo snap install intellij-idea-community --classic -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar intellij-idea-community via apt."
sudo apt install npm -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar npm via apt."

# -----------------------------------------------------------

# Instalar Flatpak e adicionar o Flathub
sudo apt install flatpak -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar Flatpak."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 2>> "$LOG_FILE" || handle_error "Falha ao adicionar Flathub."

# Instalar programas via Flatpak
flatpak install --system flathub -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar flathub via Flatpak."
flatpak install --system com.calibre_ebook.calibre -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar com.calibre_ebook.calibre via Flatpak."
flatpak install --system com.valvesoftware.Steam -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar com.valvesoftware.Steam via Flatpak."
flatpak install --system com.obsproject.Studio -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar com.obsproject.Studio via Flatpak."
flatpak install --system it.mijorus.gearlever -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar it.mijorus.gearlever via Flatpak."

# -----------------------------------------------------------

# Instalar Snap
sudo apt install snapd -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar o Snap."
sudo snap install snap-store 2>> "$LOG_FILE" || handle_error "Falha ao instalar snap-store via Snap."

# Instalar programas via Snap
sudo snap install code --classic 2>> "$LOG_FILE" || handle_error "Falha ao instalar code via Snap."
sudo snap install curl 2>> "$LOG_FILE" || handle_error "Falha ao instalar curl via Snap."
sudo snap install discord 2>> "$LOG_FILE" || handle_error "Falha ao instalar discord via Snap."
sudo snap install photogimp 2>> "$LOG_FILE" || handle_error "Falha ao instalar photogimp via Snap."
sudo snap install netbeans --classic 2>> "$LOG_FILE" || handle_error "Falha ao instalar netbeans via Snap."
sudo snap install btop 2>> "$LOG_FILE" || handle_error "Falha ao instalar btop via Snap."
sudo snap install vlc 2>> "$LOG_FILE" || handle_error "Falha ao instalar vlc via Snap."
sudo snap install wps-office-all-lang-no-internet 2>> "$LOG_FILE" || handle_error "Falha ao instalar wps-office-all-lang-no-internet via Snap."
sudo snap install tldr 2>> "$LOG_FILE" || handle_error "Falha ao instalar tldr via Snap."
sudo snap install ncdu 2>> "$LOG_FILE" || handle_error "Falha ao instalar ncdu via Snap."
sudo snap install authy 2>> "$LOG_FILE" || handle_error "Falha ao instalar authy via Snap."
sudo snap install ticktick 2>> "$LOG_FILE" || handle_error "Falha ao instalar ticktick via Snap."
sudo snap install okular 2>> "$LOG_FILE" || handle_error "Falha ao instalar okular via Snap."
sudo snap install spotify 2>> "$LOG_FILE" || handle_error "Falha ao instalar spotify via Snap."
sudo snap install obsidian --classic 2>> "$LOG_FILE" || handle_error "Falha ao instalar obsidian via Snap."
sudo snap install flameshot 2>> "$LOG_FILE" || handle_error "Falha ao instalar flameshot via Snap."
sudo snap install bitwarden 2>> "$LOG_FILE" || handle_error "Falha ao instalar bitwarden via Snap."

# -----------------------------------------------------------

# Instalar Anydesk

curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/anydesk.gpg
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo apt update
sudo apt install anydesk -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar anydesk via apt"

# Instalar Microsoft Edge
sudo apt install software-properties-common apt-transport-https wget -y || handle_error "Falha ao instalar os itens necessários para microsoft-edge"
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - || handle_error "Falha ao adicionar a chave do microsoft-edge"
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" -y
sudo apt update
sudo apt install microsoft-edge-edge -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar microsoft-edge via apt"

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

# Instalando One Driver 
# Link caso de erro: https://software.opensuse.org/download.html?project=home%3Ajstaf&package=onedriver
echo 'deb http://download.opensuse.org/repositories/home:/jstaf/xUbuntu_22.04/ /' | sudo tee /etc/apt/sources.list.d/home:jstaf.list
curl -fsSL https://download.opensuse.org/repositories/home:jstaf/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_jstaf.gpg > /dev/null
sudo apt update
sudo apt install onedriver

# -----------------------------------------------------------

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

# -----------------------------------------------------------

# Limpar cache e pacotes não necessários
sudo apt autoremove -y 2>> "$LOG_FILE" || handle_error "Falha ao remover pacotes não necessários."
sudo apt clean 2>> "$LOG_FILE" || handle_error "Falha ao limpar cache."

echo "Instalação concluída!"

# -----------------------------------------------------------------------

echo "Iniciando configuração do git"

git config --global credential.helper store
git config --global user.email "marlonprado04@gmail.com"
git config --global user.name "Marlon Prado - Ubuntu"
git config --global init.defaultBranch main

echo "Git configurado com sucesso!"

# -----------------------------------------------------------------------

echo "Adicionando templates de documentos"

touch ~/Modelos/"novo_excel.xls"
touch ~/Modelos/"gitkeep.gitkeep"
touch ~/Modelos/"novo_markdown.md"
touch ~/Modelos/"novo_txt.txt"

echo "Templates de documentos adicionados"

# -----------------------------------------------------------------------

echo "Inicia configuração de montagem da partição ntfs"

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


# -----------------------------------------------------------------------

echo "Adicionando alias"

alias myntfs="cd /media/NTFS"
alias mygithub = "cd /media/NTFS/00_MEUS_DOCUMENTOS_PC/00_PASTA_PC/03_ESTUDOS/GITHUB"

echo "Alias adicionados com sucesso