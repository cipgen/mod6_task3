# Используйте тот же базовый образ для сборки
FROM quay.io/projectquay/golang:1.20 as builder

ARG TARGETOS
ARG TARGETARCH

WORKDIR /go/src/app
COPY . .

# Компиляция вашего приложения
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -v -o kbot

# Используйте alpine вместо scratch для финального образа
FROM alpine:latest
WORKDIR /

# Копирование собранного приложения
COPY --from=builder /go/src/app/kbot /kbot

# Сертификаты уже включены в alpine
ENTRYPOINT ["/kbot"]
