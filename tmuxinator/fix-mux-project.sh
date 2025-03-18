#!/bin/bash

# Script para corrigir projetos Tmuxinator existentes
# Verifica e adiciona o campo 'name' se estiver faltando

# Cores para melhor legibilidade
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Verifica se foi fornecido um nome de projeto
if [ "$#" -lt 1 ]; then
  echo -e "${YELLOW}Uso: fix-tmuxinator-project.sh <nome-do-projeto>${NC}"
  echo "  Exemplo: fix-tmuxinator-project.sh meu-projeto"
  echo ""
  echo -e "${BLUE}Projetos disponíveis:${NC}"
  ls -1 "$HOME/.config/tmuxinator/"*.yml | xargs -n1 basename | sed 's/\.yml$//'
  exit 1
fi

nome="$1"
projeto_config="$HOME/.config/tmuxinator/$nome.yml"

# Verifica se o arquivo de projeto existe
if [ ! -f "$projeto_config" ]; then
  echo -e "${RED}Erro: Projeto '$nome' não encontrado em $projeto_config${NC}"
  echo -e "${BLUE}Projetos disponíveis:${NC}"
  ls -1 "$HOME/.config/tmuxinator/"*.yml | xargs -n1 basename | sed 's/\.yml$//'
  exit 1
fi

echo -e "${BLUE}Analisando projeto '$nome'...${NC}"

# Verificar se o arquivo contém o campo 'name'
if grep -q "^name: $nome" "$projeto_config"; then
  echo -e "${GREEN}✓ Campo 'name: $nome' encontrado no arquivo.${NC}"
else
  echo -e "${YELLOW}Campo 'name: $nome' não encontrado. Adicionando...${NC}"
  # Fazer backup do arquivo original
  cp "$projeto_config" "$projeto_config.bak"
  echo -e "${BLUE}Backup salvo em $projeto_config.bak${NC}"

  # Adicionar campos name e project_name no início do arquivo
  sed -i "1i name: $nome\nproject_name: $nome" "$projeto_config"

  echo -e "${GREEN}✓ Campos 'name' e 'project_name' adicionados ao arquivo.${NC}"
fi

# Verificar se o campo 'project_name' existe (para compatibilidade máxima)
if grep -q "^project_name: $nome" "$projeto_config"; then
  echo -e "${GREEN}✓ Campo 'project_name: $nome' encontrado no arquivo.${NC}"
else
  echo -e "${YELLOW}Campo 'project_name: $nome' não encontrado. Adicionando...${NC}"
  # Fazer backup se ainda não foi feito
  if [ ! -f "$projeto_config.bak" ]; then
    cp "$projeto_config" "$projeto_config.bak"
    echo -e "${BLUE}Backup salvo em $projeto_config.bak${NC}"
  fi

  # Adicionar campo project_name após o campo name
  sed -i "/^name:/a project_name: $nome" "$projeto_config"

  echo -e "${GREEN}✓ Campo 'project_name' adicionado ao arquivo.${NC}"
fi

echo -e "${GREEN}Projeto '$nome' agora deve iniciar corretamente!${NC}"
echo -e "${BLUE}Para iniciar: tmuxinator start $nome${NC}"

# Opção para iniciar o projeto imediatamente
read -p "Deseja iniciar o projeto agora? (s/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]; then
  echo -e "${BLUE}Iniciando projeto $nome...${NC}"
  tmuxinator start $nome
fi
