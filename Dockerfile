FROM arm32v7/alpine:3.11 as builder
COPY qemu-arm-static /usr/bin

RUN apk update && apk add \
    g++ \
    gcc \
    libc-dev \
    make \
    git \
    openssl-dev \
    curl-dev \
    libconfig-dev \
    boost-dev && \
    git clone https://github.com/team-exor/generic-seeder.git && \
    cd generic-seeder && \
    make

FROM arm32v7/alpine:3.11
COPY qemu-arm-static /usr/bin

RUN apk --no-cache add    \
      libgcc              \
      libstdc++ \
      libconfig-dev \
      curl-dev

RUN mkdir -p /data

VOLUME ["/data"]

COPY --from=builder /generic-seeder/dnsseed /usr/local/bin/

EXPOSE 53 5353

ENTRYPOINT ["dnsseed"]
CMD ["--help"]
