#!/bin/bash

# Define variável para armazenar a pasta atual, onde estão localizados os repositórioss
repos_folder="."

# Cria loop para percorrer cada subdiretório da pasta atual
# Sintaxe: para cada repositório, faça:
for repo in "$repos_folder"/*; do
    # Verifica se o diretório atualmente percorrido possui um subdiretório ".git"
    # Sintaxe: se subdiretório ".git" existir, então:
    if [ -d "$repo/.git" ]; then
        # Se sim, cria nova variável para armazenar o nome da pasta atual
        # Sintaxe: variável recebe o nome base do repositório / pasta atual
        repo_name=$(basename "$repo")
        # Imprime mensagem com "Repositório: <nome_do_repositório>"
        echo "Repositório: $repo_name"
        # Entra na pasta específica e em seguida usa "git Status"
        (cd "$repo" && git status)
        echo
        echo "------------------------------------" 
        echo
    fi
done
