APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=cipgen
#REGISTRY = ghcr.io/cipgen
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
VER=1.0.9
TARGETOS=linux #Linux darwin windows
TARGETARCH=amd64 #arm64 amd64
TARGET=linux-amd64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/cipgen/kbot/cmd.appVersion=${VER}

image:
	docker build . -t $(REGISTRY)/$(APP):$(VERSION)-$(TARGET)

push:
	docker push $(REGISTRY)/$(APP):$(VERSION)-$(TARGET)

clean:
	rm -rf kbot
	docker rmi $(REGISTRY)/$(APP):$(VERSION)-$(TARGET) || true
