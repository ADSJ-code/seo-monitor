#!/bin/bash
set -e

echo "=> Executing MongoDB index creation/update..."
bundle exec rails runner "Mongoid::Tasks::Database.create_indexes"

rm -f /rails/tmp/pids/server.pid

exec "$@" 