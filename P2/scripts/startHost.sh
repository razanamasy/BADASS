#!/bin/sh

declare -A script_mapping="host_alilin-1:/scripts_p2/host/host_1.sh host_alilin-2:/scripts_p2/host/host_2.sh"

for container in $(docker ps --filter "ancestor=busybox" --format "{{.Names}}");
do
  hostname=$(docker inspect --format '{{.Config.Hostname}}' $container)
  script=${script_mapping[$hostname]}
  if [[ -z $script ]]; then
    echo "No script found for container: $container (hostname: $hostname)"
    continue
  fi
  echo "Running script on container: $container (hostname: $hostname)"
  docker exec -it $container $script
done