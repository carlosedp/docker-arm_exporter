ARG target=arm32v6
FROM $target/alpine

ARG arch=arm
ENV ARCH=$arch

# Trick docker build in case qemu binary is not in dir.
COPY .blank tmp/qemu-$ARCH-static* /usr/bin/

COPY rpi_exporter /bin/rpi_exporter

EXPOSE      9243
ENTRYPOINT  [ "/bin/rpi_exporter" ]
