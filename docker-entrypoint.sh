#!/bin/sh -e

if [ -f "/etc/nodename" ] then
  NODE_NAME=$(cat /etc/nodename)
  echo "node_meta{node_id=\"$NODE_ID\", container_label_com_docker_swarm_node_id=\"$NODE_ID\", node_name=\"$NODE_NAME\"} 1" > /etc/rpi_exporter/node-meta.prom

  set -- /bin/rpi_exporter "$@"

  exec "$@"
else
  echo "No /etc/nodename set."
fi
