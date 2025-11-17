#!/bin/bash
set -e

if [ -f /app/.env ]; then
   export $(cat /app/.env | xargs)
fi

echo "=> Executando a criação/atualização de índices do MongoDB..."
bundle exec rake db:mongoid:create_indexes

rm -f /app/tmp/pids/server.pid

exec "$@"