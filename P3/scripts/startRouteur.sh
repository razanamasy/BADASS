#!/bin/bash

declare -A script_mapping1=(
  ["routeur_alilin-1"]="/scripts_p3/routeur_reflector.sh"
  ["routeur_alilin-2"]="/scripts_p3/routeur_1.sh"
  ["routeur_alilin-3"]="/scripts_p3/routeur_2.sh"
  ["routeur_alilin-4"]="/scripts_p3/routeur_3.sh"
)

for container in $(docker ps --filter "ancestor=routing" --format "{{.Names}}");
do
  hostname=$(docker inspect --format '{{.Config.Hostname}}' $container)
  script=${script_mapping[$hostname]}
  if [[ -z $script ]]; then
    echo "No script found for container: $container (hostname: $hostname)"
    continue
  fi
  echo "Running script on container: $container (hostname: $hostname)"
  docker exec -it $container bash -c "chmod +x /$script && /$script"
done