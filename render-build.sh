#!/usr/bin/env bash
set -eo pipefail

# 1. Configuração essencial de paths
export GEM_HOME="${GEM_HOME:-$HOME/.gems}"
export GEM_PATH="${GEM_PATH:-$GEM_HOME}"
export PATH="$GEM_HOME/bin:$PATH"
# Configuração temporária para o build
export PGHOST=localhost
export PGPORT=5432

# 2. Instalação segura de dependências
echo "--> Instalando dependências..."
bundle config set --local path 'vendor/bundle'
bundle install --jobs 4 --retry 3 --quiet

# 3. Verificação do ambiente
echo "--> Verificando instalação..."
bundle exec rails --version || { echo "❌ Rails não encontrado"; exit 1; }

# 4. Execução das migrações com tratamento de erros
echo "--> Executando migrações..."
{
  bundle exec rails db:migrate && \
  bundle exec rails solid_queue:install:migrations && \
  bundle exec rails db:migrate SCOPE=solid_queue && \
  bundle exec rails solid_cache:install:migrations && \
  bundle exec rails db:migrate SCOPE=solid_cache
} || {
  echo "❌ Falha nas migrações";
  exit 1;
}

echo "✅ Build concluído com sucesso!"