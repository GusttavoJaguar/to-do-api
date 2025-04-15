#!/usr/bin/env bash
set -o errexit

# 1. Migrações principais
bundle exec rails db:migrate

# 2. Migrações do Solid Cache v0.4.x
bundle exec rails solid_cache:install:migrations
bundle exec rails db:migrate SCOPE=solid_cache

# 3. Migrações do Solid Queue v1.0+
bundle exec rails solid_queue:install:migrations
bundle exec rails db:migrate SCOPE=solid_queue