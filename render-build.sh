#!/usr/bin/env bash
set -o errexit

# 1. Instalação segura de gems
bundle config set --local without ''
bundle install

# 2. Configuração SSL para Render
export PGSSLMODE=require

# 3. Fluxo de migração seguro
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails solid_cache:install:migrations
bundle exec rails solid_queue:install:migrations
bundle exec rails db:migrate