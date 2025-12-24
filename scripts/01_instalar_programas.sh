#!/bin/bash

LOG_FILE="log_instalacao.txt"
> "$LOG_FILE"

handle_error() {
    echo "Erro: $1" | tee -a "$LOG_FILE"
}

# garante dialog
sudo apt update 2>>"$LOG_FILE" || handle_error "Falha ao atualizar repositórios."
sudo apt install dialog -y 2>>"$LOG_FILE" || handle_error "Falha ao instalar dialog."

# -----------------------------
# APT
apt_choices=$(dialog --checklist "APT - Selecione o que instalar:" 35 100 28 \
openjdk-17-jre-headless "Java 17 (runtime, sem interface gráfica)" off \
synaptic "Gerenciador de pacotes gráfico" off \
gnome-software "Loja de aplicativos GNOME" off \
gnome-sushi "Pré-visualização rápida de arquivos no Nautilus" off \
folder-color "Permite colorir pastas no Nautilus" off \
nautilus-admin "Permite ações administrativas no Nautilus" off \
imagemagick "Ferramenta de edição e conversão de imagens" off \
nautilus-image-converter "Redimensiona/converte imagens pelo Nautilus" off \
chrome-gnome-shell "Integra GNOME Shell com o Chrome/Firefox" off \
gnome-shell-extensions "Extensões para customizar o GNOME Shell" off \
git "Sistema de controle de versão" off \
git-lfs "Extensão Git para arquivos grandes" off \
nodejs "JavaScript runtime (Node.js)" off \
qbittorrent "Cliente BitTorrent" off \
kdeconnect "Integração entre Linux e celular" off \
gparted "Editor de partições gráfico" off \
bat "Visualizador de arquivos com destaque de sintaxe" off \
grub-customizer "Ferramenta para editar o GRUB" off \
gnome-clocks "Relógio, cronômetro, alarme e fusos horários" off \
tree "Mostra estrutura de diretórios em árvore" off \
peek "Grava GIFs da tela" off \
exfat-fuse "Suporte a partições exFAT" off \
whois "Consulta informações de domínios" off \
net-tools "Ferramentas de rede clássicas (ifconfig, netstat)" off \
neofetch "Exibe informações do sistema no terminal" off \
python3-pip "Gerenciador de pacotes Python" off \
copyq "Gerenciador avançado de área de transferência" off \
flameshot "Ferramenta de screenshots avançada" off \
3>&1 1>&2 2>&3)

clear

if [ -n "$apt_choices" ]; then
    IFS=" " read -r -a packages <<< "$apt_choices"
    for pkg in "${packages[@]}"; do
        sudo apt install "$pkg" -y 2>>"$LOG_FILE" || handle_error "Falha ao instalar $pkg"
    done
fi


echo "Instalação concluída. Verifique o log em $LOG_FILE."
echo "Para ativar o Tiling Assistant, abra o GNOME Tweaks ou o Extension Manager."


# -----------------------------
# Flatpak
flatpak_choices=$(dialog --checklist "FLATPAK - Selecione o que instalar:" 25 80 12 \
com.calibre_ebook.calibre "Calibre" off \
com.valvesoftware.Steam "Steam" off \
com.obsproject.Studio "OBS Studio" off \
it.mijorus.gearlever "Gear Lever" off \
com.discordapp.Discord "Discord" off \
com.spotify.Client "Spotify" off \
org.videolan.VLC "VLC" off \
com.bitwarden.desktop "Bitwarden" off \
com.visualstudio.code "VS Code" off \
md.obsidian.Obsidian "Obsidian" off \
com.jetbrains.IntelliJ-IDEA-Community "IntelliJ Community" off \
org.apache.netbeans "NetBeans" off \
3>&1 1>&2 2>&3)

clear

if [ -n "$flatpak_choices" ]; then
    # Instalar Flatpak se não existir
    if ! command -v flatpak &>/dev/null; then sudo apt install flatpak -y; fi

    # Adicionar Flathub se não existir
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 2>>"$LOG_FILE" || handle_error "Falha ao adicionar Flathub."

    # Instalar os apps selecionados
    for app in $flatpak_choices; do
        app_clean=$(echo $app | tr -d '"')
        flatpak install --system "$app_clean" -y 2>>"$LOG_FILE" || handle_error "Falha ao instalar $app_clean via Flatpak."
    done
else
    echo "Nenhum aplicativo Flatpak selecionado." | tee -a "$LOG_FILE"
fi

# -----------------------------
# Snap
# -----------------------------
# Instalar Snap caso não esteja instalado
if ! command -v snap &> /dev/null; then
    sudo apt install snapd -y 2>>"$LOG_FILE" || handle_error "Falha ao instalar o Snap."
fi

# Lista de Snap sem duplicatas de apps já no Flatpak
snap_choices=$(dialog --checklist "SNAP - Selecione o que instalar:" 20 70 10 \
btop "btop" off \
tldr "tldr" off \
ncdu "ncdu" off \
ticktick "TickTick" off \
photogimp "PhotoGIMP" off \
wps-office-all-lang-no-internet "WPS Office" off \
3>&1 1>&2 2>&3)

clear

if [ -n "$snap_choices" ]; then
    # Remover aspas da saída do dialog
    snap_choices=$(echo "$snap_choices" | tr -d '"')
    
    for app in $snap_choices; do
        sudo snap install "$app" 2>>"$LOG_FILE" || handle_error "Falha ao instalar $app via Snap."
    done
fi

echo "Instalação concluída!"
# -----------------------------
# BROWSERS
browsers=$(dialog --checklist "Browsers:" 15 60 5 \
google-chrome "Google Chrome" off \
microsoft-edge-stable "Microsoft Edge" off \
anydesk "AnyDesk" off \
3>&1 1>&2 2>&3)

clear

for b in $browsers; do
    if [ "$b" = "google-chrome" ]; then
        wget -qO- ... | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/google.gpg | sudo apt-key add - || handle_error "Falha ao adicionar chave do Google Chrome"
        echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
        sudo apt update
        sudo apt install google-chrome-stable -y 2>>"$LOG_FILE" || handle_error "Falha ao instalar Google Chrome"
        sudo apt install dconf-editor -y 2>>"$LOG_FILE" || handle_error "Falha ao instalar Dconf Editor"
    fi

    if [ "$b" = "microsoft-edge-stable" ]; then
        wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - || handle_error "Falha ao adicionar chave do Microsoft Edge"
        sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" -y
        sudo apt update
        sudo apt install microsoft-edge-stable -y 2>>"$LOG_FILE" || handle_error "Falha ao instalar Microsoft Edge"
    fi

    if [ "$b" = "anydesk" ]; then
        curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/anydesk.gpg
        echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
        sudo apt update
        sudo apt install anydesk -y 2>>"$LOG_FILE" || handle_error "Falha ao instalar Anydesk"
    fi
done

# -----------------------------
# GitHub Desktop
github_desktop=$(dialog --yesno "Instalar GitHub Desktop?" 7 40; echo $?)
if [ "$github_desktop" = "0" ]; then
    wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
    sudo apt update 2>> "$LOG_FILE" || handle_error "Falha ao atualizar após adicionar repositório GitHub Desktop"
    sudo apt install github-desktop -y 2>> "$LOG_FILE" || handle_error "Falha ao instalar GitHub Desktop"
fi

# -----------------------------
# Extensão "Open in VSCode" no Nautilus
vscode_nautilus=$(dialog --yesno "Instalar extensão 'Open in VSCode' no Nautilus?" 7 50; echo $?)
if [ "$vscode_nautilus" = "0" ]; then
    sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/harry-cpp/code-nautilus/master/install.sh)"
fi

# -----------------------------
# CONFIGURAR PROMPT DO BASH
bash_prompt=$(dialog --yesno "Configurar prompt do Bash com Git branch?" 7 50; echo $?)
if [ "$bash_prompt" = "0" ]; then
    echo '
parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1)/"
}
PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]\$(parse_git_branch)\[\033[00m\]\$ "
' >> ~/.bashrc
    source ~/.bashrc
fi

# -----------------------------
# CONFIGURAR GIT
git_cfg=$(dialog --yesno "Configurar Git agora?" 7 40; echo $?)
if [ "$git_cfg" = "0" ]; then
    git config --global credential.helper store
    git config --global user.email "marlonprado04@gmail.com"
    git config --global user.name "Marlon Prado - Ubuntu"
    git config --global init.defaultBranch main
fi

# -----------------------------
# Templates para Nautilus
templates=$(dialog --yesno "Adicionar templates de documentos?" 7 40; echo $?)
if [ "$templates" = "0" ]; then
    mkdir -p ~/Modelos
    touch ~/Modelos/"novo_excel.xls"
    touch ~/Modelos/"gitkeep.gitkeep"
    touch ~/Modelos/"novo_markdown.md"
    touch ~/Modelos/"novo_txt.txt"
fi

# -----------------------------
# Montagem automática da partição NTFS
ntfs_cfg=$(dialog --yesno "Configurar montagem automática da partição NTFS?" 7 60; echo $?)
if [ "$ntfs_cfg" = "0" ]; then
    MOUNT_POINT="/media/NTFS"
    fstab_FILE="/etc/fstab"
    [ ! -d "$MOUNT_POINT" ] && sudo mkdir -p "$MOUNT_POINT"
    UUID=$(sudo blkid | grep ntfs | head -n 1 | awk -F 'UUID="' '{print $2}' | awk -F '"' '{print $1}')
    if [ -z "$UUID" ]; then
        echo "Nenhuma partição NTFS encontrada." | tee -a "$LOG_FILE"
    else
        if ! grep -q "$UUID" "$fstab_FILE"; then
            echo "# Adiciona partições NTFS na montagem do boot" | sudo tee -a "$fstab_FILE" > /dev/null
            echo "UUID=$UUID $MOUNT_POINT ntfs defaults,uid=1000,gid=1000 0 0" | sudo tee -a "$fstab_FILE"
        fi
        sudo mount -a
    fi
fi

# -----------------------------
# Aliases
aliases=$(dialog --yesno "Adicionar aliases para navegação rápida?" 7 50; echo $?)
if [ "$aliases" = "0" ]; then
    echo 'alias myntfs="cd /media/NTFS"' >> ~/.bashrc
    echo 'alias mygithub="cd /media/NTFS/00_MEUS_DOCUMENTOS_PC/00_PASTA_PC/03_ESTUDOS/GITHUB"' >> ~/.bashrc
    source ~/.bashrc
fi

# -----------------------------
# Limpeza final
sudo apt autoremove -y 2>>"$LOG_FILE" || handle_error "Falha ao remover pacotes"
sudo apt clean 2>>"$LOG_FILE" || handle_error "Falha ao limpar cache"

dialog --msgbox "Instalação finalizada!" 6 40
clear
