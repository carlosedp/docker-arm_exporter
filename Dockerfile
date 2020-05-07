ARG target=arm32v6
FROM $target/alpine

ARG arch=arm
ENV ARCH=$arch
ENV NODE_ID=none

# Required for GPU temperature to work
RUN apk add raspberrypi

# Trick docker build in case qemu binary is not in dir.
COPY .blank tmp/qemu-$ARCH-static* /usr/bin/

COPY ./rpi_exporter/rpi_exporter /bin/rpi_exporter
COPY ./docker-entrypoint.sh /etc/rpi_exporter/docker-entrypoint.sh
RUN chmod +x /etc/rpi_exporter/docker-entrypoint.sh

ENTRYPOINT [ "/etc/rpi_exporter/docker-entrypoint.sh" ]
EXPOSE 9243
CMD ["/bin/rpi_exporter"]
