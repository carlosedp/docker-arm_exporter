# docker-arm_exporter

[![Build Status](https://travis-ci.org/carlosedp/docker-arm_exporter.svg?branch=master)](https://travis-ci.org/carlosedp/docker-arm_exporter) [![](https://images.microbadger.com/badges/image/carlosedp/arm_exporter.svg)](https://microbadger.com/images/carlosedp/arm_exporter "Get your own image badge on microbadger.com")

ARM CPU temperature exporter for Prometheus. Exporter code by [Lukas Malkmus](https://github.com/lukasmalkmus/rpi_exporter)

Usage:

## Docker Run
Run the container in the same network as your Prometheus

    docker run -d \
      --name=arm_exporter \
      --restart always \
      --net=monitoring \
      -p 9243:9243 \
      -v /etc/hostname:/etc/nodename:ro
      -v /etc/localtime:/etc/localtime:ro
      -v /etc/timezone:/etc/TZ:ro
      carlosedp/arm_exporter

## Docker Compose File (yml)

    rpi-exporter:
        image: carlosedp/arm_exporter
        environment:
          - NODE_ID={{.Node.ID}}
        volumes:
          - /etc/hostname:/etc/nodename:ro
          - /etc/localtime:/etc/localtime:ro
          - /etc/timezone:/etc/TZ:ro
        command:
          - '--collector.textfile.directory=/etc/rpi_exporter/'
        ports:
          - 9243:9243
        networks:
          - monitoring
        deploy:
          mode: global
    
    networks:
      monitoring:
        driver: overlay

## Docker Stack
    docker stack deploy monitoring --compose-file docker-compose-monitoring.yml

## Add target to Prometheus:

    - job_name: 'node'
      scrape_interval: 10s
      dns_sd_configs:
      - names:
        - 'arm_exporter'
        type: 'A'
        port: 9243

Get images on [DockerHub](https://hub.docker.com/r/carlosedp/arm_exporter/)
