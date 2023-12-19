APP=$(shell basename $(shell git remote get-url origin))
#REGISTRY=cipgen
REGISTRY=ghcr.io/cipgen
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux #Linux darwin windows
TARGETARCH=amd64 #arm64 amd64
TARG=linux-amd64 #test

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/cipgen/kbot/cmd.appVersion=${VERSION}

image:
	docker build . -t $(REGISTRY_DOCKER):$(VERSION)-$(TARGETOS)$(TARGETARCH)

push:
	docker push $(REGISTRY_DOCKER):$(VERSION)-$(TARGETOS)$(TARGETARCH)

clean:
	rm -rf kbot
	docker rmi $(REGISTRY_DOCKER):$(VERSION)-$(TARGETOS)$(TARGETARCH) || true