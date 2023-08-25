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

# Atualizar o sistema
sudo apt update 2>> "$LOG_FILE" || handle_error "Falha ao atualizar o sistema."
sudo apt upgrade -y 2>> "$LOG_FILE" || handle_error "Falha ao atualizar pacotes."
sudo apt dist-upgrade -y 2>> "$LOG_FILE" || handle_error "Falha ao atualizar pacotes da distribuicao."
sudo apt install ubuntu-restricted-extras -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar os complementos e codecs extras."

# Instalar programas via apt
sudo apt install gdebi -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar gdebi via apt."
sudo apt install synaptic -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar synaptic via apt."
sudo apt install gnome-software -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar gnome-software via apt."
sudo apt install gnome-sushi -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar gnome-sushi via apt."
sudo add-apt-repository ppa:costales/folder-color -y 2>> "$LOG_FILE" || handle_error "Falha ao adicionar repositorio do folder-color para via apt"
sudo apt install folder-color -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar folder-color via apt."
sudo apt install nautilus-admin -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar nautilus-admin via apt"
sudo apt install imagemagick nautilus-image-converter -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar imagemagick nautilus-image-converter via apt"
sudo apt install chrome-gnome-shell -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar chrome-gnome-shell via apt"
sudo apt install gnome-shell-extensions -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar gnome-shell-extensions via apt"

# Limpar cache e pacotes não necessários
sudo apt autoremove -y 2>> "$LOG_FILE" || handle_error "Falha ao remover pacotes não necessários."
sudo apt clean 2>> "$LOG_FILE" || handle_error "Falha ao limpar cache."

# Instalar Flatpak e adicionar o Flathub
sudo apt install flatpak -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar Flatpak."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 2>> "$LOG_FILE" || handle_error "Falha ao adicionar Flathub."

# Instalar programas via Flatpak
flatpak install flathub -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar flathub via Flatpak."
flatpak install com.jetbrains.IntelliJ-IDEA-Community -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar com.jetbrains.IntelliJ-IDEA-Community via Flatpak."
flatpak install com.calibre_ebook.calibre -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar com.calibre_ebook.calibre via Flatpak."
flatpak install com.valvesoftware.Steam -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar com.valvesoftware.Steam via Flatpak."
flatpak install org.eclipse.Java -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar org.eclipse.Java via Flatpak."

# Instalar Snap
sudo apt install snapd -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar o Snap."
sudo snap install snap-store 2>> "$LOG_FILE" || handle_error "Falha ao instalar snap-store via Snap."

# Instalar programas via Snap
sudo snap install code 2>> "$LOG_FILE" || handle_error "Falha ao instalar code via Snap."
sudo snap install curl 2>> "$LOG_FILE" || handle_error "Falha ao instalar curl via Snap."
sudo snap install discord 2>> "$LOG_FILE" || handle_error "Falha ao instalar discord via Snap."
sudo snap install gimp 2>> "$LOG_FILE" || handle_error "Falha ao instalar gimp via Snap."
sudo snap install netbeans 2>> "$LOG_FILE" || handle_error "Falha ao instalar netbeans via Snap."
sudo snap install vlc 2>> "$LOG_FILE" || handle_error "Falha ao instalar vlc via Snap."

# Limpar cache e pacotes não necessários
sudo apt autoremove -y 2>> "$LOG_FILE" || handle_error "Falha ao remover pacotes não necessários."
sudo apt clean 2>> "$LOG_FILE" || handle_error "Falha ao limpar cache."

echo "Instalação concluída!"

