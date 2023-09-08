FROM golang:1.21.1-bookworm AS builder
RUN go install tailscale.com/cmd/derper@main

FROM debian:bookworm
RUN apt-get update && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /go/bin/derper /usr/local/bin/derper

ENTRYPOINT [ "/usr/local/bin/derper" ]
