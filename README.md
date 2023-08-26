# Automações

Meus scripts e automações pessoais para lidar com configurações do sistema Ubuntu

## Instruções

### Instalação automatizada de programas

Basta executar o arquivo `instalacao_automatizada` que ele fará o download de todos os programas que faço uso em meu computador, incluindo o suporte a `Flatpak` e `Snap`.

Para executar:

1. Abrir um terminal na pasta onde o arquivo se encontra
2. Utilizar o comando `sh instalacao_automatizada`
3. Aguardar a instalação ser concluída
4. Verificar o arquivo de log gerado em busca de falhas e aplicar as correções necessárias

Abaixo uma demonstração de uso:

![Demonstração de uso da instalação automatizada](./assets/demonstration.gif)

### Configuração automatizada das extensões Gnome

Para recuperar as `extensoes gnome e suas configurações` é necessário seguir os passos abaixo:

1. Instalar a extensão `extensions sync` do Gnome
2. Abrir meu `gist` do GitHub, [neste link](https://gist.github.com/)
3. Localizar o `gist` referente às extensões do Gnome
4. Copiar o `código id` do gist localizado
5. Adicionar o código id do gist às configurações da extensão `extensions sync`
6. Criar um `token` do GitHub que permite a criação de `gist`, [neste link](https://github.com/settings/tokens/new)
7. Adicionar o token criado nas configurações do `extensions sync`

Esses passos foram pegos [deste site](https://sempreupdate.com.br/como-sincronizar-extensoes-do-gnome-shell-entre-desktops/)

A extensão ficará configurada da seguinte forma:

![Exemplo da extensão Extension Sync](./assets/example_extensions_sync.png)
