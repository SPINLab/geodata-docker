#!/usr/bin/env bash
set -ex

curl -L -o /tmp/bag.backup https://data.nlextract.nl/bag/postgis/bag-laatst.backup

psql --dbname="geodata" -c "CREATE EXTENSION IF NOT EXISTS POSTGIS;"
psql --dbname="geodata" -c "CREATE USER kademo;"
psql --dbname="geodata" -c "ALTER DATABASE geodata OWNER TO kademo;"

echo "BAG database restore procedure started, wait for completion to connect to the database..."
time pg_restore \
  --dbname=geodata \
  --jobs=$(nproc) \
  --no-password \
  --verbose \
  "/tmp/bag.backup"
echo "BAG database restore procedure succeeded, you may now connect to the database."
rm /tmp/bag.backup
