#!/bin/bash

# Função para renomear um arquivo ou pasta de acordo com as regras especificadas:
# - Converte o nome para letras minúsculas
# - Substitui espaços por underscores
# - Substitui hífens por underscores
# - Substitui múltiplos underscores consecutivos por um único underscore
rename_to_lowercase_and_underscore() {
  local source="$1"     # Armazena o nome original do arquivo ou pasta
  local destination     # Armazenará o novo nome após as transformações
  destination=$(echo "$source" | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | tr '-' '_' | tr -s '_')
  # Verifica se o nome original difere do novo nome após as transformações
  if [ "$source" != "$destination" ]; then
    mv -v "$source" "$destination"  # Renomeia o arquivo ou pasta
  fi
}

# Função para renomear arquivos e pastas recursivamente, tratando caracteres acentuados:
# - Converte o nome para letras minúsculas
# - Substitui espaços por underscores
# - Substitui hífens por underscores
# - Substitui múltiplos underscores consecutivos por um único underscore
rename_recursive() {
  local source="$1"     # Armazena o nome original do arquivo ou pasta
  local destination     # Armazenará o novo nome após as transformações
  destination=$(echo "$source" | iconv -t ASCII//TRANSLIT | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | tr '-' '_' | tr -s '_')
  # Verifica se o nome original difere do novo nome após as transformações
  if [ "$source" != "$destination" ]; then
    mv -v "$source" "$destination"  # Renomeia o arquivo ou pasta
  fi
}

# Encontra e renomeia arquivos e pastas recursivamente a partir do diretório atual
# Aplica as transformações especificadas nas funções acima
find . -depth | while read -r file; do
  rename_recursive "$file"
done

