# Build with: docker buildx build -t carlosedp/arm_exporter:latest --platform linux/arm,linux/arm64 -f Dockerfile --push .
# Builder container
FROM --platform=$BUILDPLATFORM golang:1.17 AS builder
ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH

WORKDIR $GOPATH

ENV PROJECT github.com/lukasmalkmus/rpi_exporter
ENV CGO_ENABLED=0

RUN mkdir -p $GOPATH/src/github.com/lukasmalkmus && \
    git clone https://$PROJECT $GOPATH/src/$PROJECT  && \
    cd $GOPATH/src/$PROJECT && \
    GOOS=$TARGETOS GOARCH=$TARGETARCH go build -a -ldflags '-s -w -extldflags "-static"' -o main . && \
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
