#!/bin/bash

declare -A script_mapping=(
  ["router_hrazanam-1"]="/scripts_p3/router_reflector.sh"
  ["router_hrazanam-2"]="/scripts_p3/router_1.sh"
  ["router_hrazanam-3"]="/scripts_p3/router_2.sh"
  ["router_hrazanam-4"]="/scripts_p3/router_3.sh"
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
