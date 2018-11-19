#!/usr/bin/env bash
set -ex

echo 'Creating database'
createdb geodata -U postgres -T template_postgis --no-password

IFS=',' read -r -a GDS <<< "$GEODATASETS"

for dataset in ${GDS[@]}; do
  bash /datasets/${dataset}.sh
done