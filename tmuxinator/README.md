# Guia de Uso do Tmuxinator para Desenvolvimento

Este guia fornece instruções detalhadas sobre como usar o Tmuxinator para gerenciar seus ambientes de desenvolvimento.

## Comandos Básicos

```bash
# Iniciar um projeto
tmuxinator start projeto
# ou usando o alias
mux start projeto

# Listar projetos
tmuxinator list
# ou usando o alias
txl

# Criar um novo projeto a partir de template
create-project web-frontend projeto-web ~/projetos/projeto-web

# Parar um projeto
tmuxinator stop projeto

# Editar configuração de projeto
tmuxinator edit projeto
```

## Templates Disponíveis

Os seguintes templates estão disponíveis:

- `web-frontend`: Para desenvolvimento web frontend (React, Vue, Angular)
- `mobile-react-native`: Para desenvolvimento mobile com React Native
- `backend-nodejs`: Para desenvolvimento backend com Node.js
- `fullstack-nextjs`: Para desenvolvimento fullstack com Next.js

## Ferramentas Utilitárias Incluídas

Este setup inclui duas ferramentas úteis:

- `create-project`: Cria novos projetos a partir de templates
  ```bash
  create-project <tipo> <nome> [caminho]
  ```

- `fix-tmuxinator-project`: Corrige problemas em projetos existentes
  ```bash
  fix-tmuxinator-project <nome-do-projeto>
  ```

## Atalhos do Tmux

Com o prefixo `Ctrl-a`:

- `Ctrl-a c`: Criar nova janela
- `Ctrl-a n`: Próxima janela
- `Ctrl-a p`: Janela anterior
- `Ctrl-a %`: Dividir painel verticalmente
- `Ctrl-a "`: Dividir painel horizontalmente
- `Ctrl-a h/j/k/l`: Navegar entre painéis
- `Ctrl-a d`: Desanexar da sessão
- `Ctrl-a [`: Entrar no modo de cópia
- `Ctrl-a ?`: Listar todos os atalhos

## Uso com WezTerm e Neovim

Para uma experiência perfeita entre WezTerm, Tmux e Neovim:

1. **WezTerm**: Gerencia a janela do terminal e configurações de aparência
2. **Tmux**: Gerencia sessões, janelas e painéis persistentes
3. **Neovim**: Editor de código com integração de navegação

Use `Ctrl-h/j/k/l` para navegar entre painéis do Tmux e janelas do Neovim.

## Personalização

Você pode modificar os templates em `~/.config/tmuxinator/` para adaptá-los às suas necessidades.

## Problemas Comuns e Soluções

### Erro "Your project file didn't specify a 'project_name'"

Se você encontrar este erro, utilize a ferramenta de correção:

```bash
fix-tmuxinator-project nome-do-projeto
```

### Problemas com YAML nos templates

Os templates são arquivos YAML com interpolação ERB. Se encontrar erros de sintaxe, certifique-se de que strings com interpolação ERB (`<%= ... %>`) estejam entre aspas simples.

### Problemas de navegação de teclado

Se os atalhos `Ctrl-h/j/k/l` para navegar entre painéis não estiverem funcionando, verifique:
1. Se o plugin vim-tmux-navigator está instalado no Neovim
2. Se a configuração de atalhos do Tmux está configurada corretamente no .tmux.conf

Para mais informações, consulte a [documentação oficial do Tmuxinator](https://github.com/tmuxinator/tmuxinator).
