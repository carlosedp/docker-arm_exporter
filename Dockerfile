# Builder container
FROM golang:1.14 AS builder

WORKDIR $GOPATH

ENV PROJECT github.com/lukasmalkmus/rpi_exporter
ENV CGO_ENABLED=0

RUN go get $PROJECT && \
    cd $GOPATH/src/$PROJECT && \
    go build -a -ldflags '-s -w -extldflags "-static"' -o main . && \
    mv main /

# Application Image
FROM alpine

ENV NODE_ID=none

# Required for GPU temperature scrape to work
RUN apk add raspberrypi

COPY --from=builder /main /bin/rpi_exporter
COPY ./docker-entrypoint.sh /etc/rpi_exporter/docker-entrypoint.sh
RUN chmod +x /etc/rpi_exporter/docker-entrypoint.sh

ENTRYPOINT [ "/etc/rpi_exporter/docker-entrypoint.sh" ]
EXPOSE 9243
CMD ["/bin/rpi_exporter"]
