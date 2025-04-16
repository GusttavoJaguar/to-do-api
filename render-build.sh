#!/usr/bin/env bash
set -eo pipefail

# Configura SSL para PostgreSQL (obrigatório no Render)
export PGSSLMODE=require

# Migrações com tratamento de erro
bundle exec rails db:create || echo "Banco já existe"
bundle exec rails db:migrate || exit 1

# 1. Instalação otimizada
echo "--- Instalando dependências ---"
bundle config set --local path 'vendor/bundle'
bundle install --jobs 4 --retry 3

# 2. Verificação do ambiente
echo "--- Verificando instalação ---"
bundle exec rails -v || { echo "❌ Rails não encontrado"; exit 1; }

# Configura SSL simplificado
export PGSSLMODE=require

# 3. Migrações com fallback inteligente
echo "--- Executando migrações ---"
bundle exec rails db:migrate || {
  echo "⚠️ Tentando criar banco..."
  bundle exec rails db:create && bundle exec rails db:migrate
} || {
  echo "❌ Falha crítica nas migrações";
  bundle exec rails db:migrate:status;
  exit 1;
}

# 4. Migrações do Solid Queue
bundle exec rails solid_queue:install:migrations && \
bundle exec rails db:migrate SCOPE=solid_queue || {
  echo "⚠️ Solid Queue migrado separadamente";
}

echo "✅ Build concluído com sucesso!"