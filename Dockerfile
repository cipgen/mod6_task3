# Defining the base image for building with parameters for the platform
FROM quay.io/projectquay/golang:1.20 as builder

ARG TARGETOS
ARG TARGETARCH

WORKDIR /go/src/app
COPY . .

# Compilation in a single layer, reducing the overall size
RUN make build
# RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -v -o kbot

# Intermediate stage to get ca-certificates
FROM alpine:latest as certs
RUN apk --no-cache add ca-certificates


FROM scratch
WORKDIR /
# Copying only necessary files
COPY --from=builder /go/src/app/kbot /kbot
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/kbot"]
