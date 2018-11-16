#!/usr/bin/env bash
set -ex

curl -L -o /tmp/brt.backup https://data.nlextract.nl/brt/postgis/top10nl-latest.backup

psql -U postgres --dbname="geodata" -c "CREATE USER gis;"
echo "BRT database import procedure started, wait for completion to connect to the database..."

time pg_restore \
  --dbname=geodata \
  --user=postgres \
  --jobs=$(nproc) \
  --no-password \
  --verbose \
  "/tmp/brt.backup"
echo "BRT database restore procedure succeeded, you may now connect to the database."
rm /tmp/brt.backup
