#!/bin/bash

# Define a pasta onde estão localizados seus repositórios
repos_folder="."

# Loop para percorrer os subdiretórios (repositórios)
for repo in "$repos_folder"/*; do
    if [ -d "$repo/.git" ]; then
        repo_name=$(basename "$repo")
        echo "Repositório: $repo_name"
        (cd "$repo" && git status)
        echo
        echo "------------------------------------" 
        echo
    fi
done

