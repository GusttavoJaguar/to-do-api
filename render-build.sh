#!/usr/bin/env bash
set -o errexit

# Instala TODAS as gems (incluindo development/test)
bundle config set --local without ''
bundle install

# Configura SSL para PostgreSQL
export PGSSLMODE=require

# Migrações principais
bundle exec rails db:migrate

# Migrações do Solid Cache
bundle exec rails solid_cache:install:migrations
bundle exec rails db:migrate

# Migrações do Solid Queue
bundle exec rails solid_queue:install:migrations
bundle exec rails db:migrate