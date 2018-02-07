# docker-arm_exporter

[![Build Status](https://travis-ci.org/carlosedp/docker-arm_exporter.svg?branch=master)](https://travis-ci.org/carlosedp/docker-arm_exporter) [![](https://images.microbadger.com/badges/image/carlosedp/arm_exporter.svg)](https://microbadger.com/images/carlosedp/arm_exporter "Get your own image badge on microbadger.com")

ARM CPU temperature exporter for Prometheus. Exporter code by [Lukas Malkmus](https://github.com/lukasmalkmus/rpi_exporter)

Usage:

Run the container in the same network as your Prometheus

    docker run -d \
      --name=arm_exporter \
      --restart always \
      --net=monitoring \
      -p 9243:9243 \
      carlosedp/arm_exporter


Add target to Prometheus:

    - job_name: 'node'
      scrape_interval: 10s
      dns_sd_configs:
      - names:
        - 'arm_exporter'
        type: 'A'
        port: 9243

Get images on [DockerHub](https://hub.docker.com/r/carlosedp/arm_exporter/)
