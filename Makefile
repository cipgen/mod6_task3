APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=quay.io/smiling-rhythm-404620
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

# Common targets
.PHONY: all format lint test get clean build image push

# Build for all platforms
all: linux darwin windows arm

# Formatting, linting, testing, dependency downloading
format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

# Build commands for different platforms
linux: format get
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o kbot-linux -ldflags "-X main.appVersion=$(VERSION)"

darwin: format get
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -o kbot-mac -ldflags "-X main.appVersion=$(VERSION)"

windows: format get
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -v -o kbot-windows.exe -ldflags "-X main.appVersion=$(VERSION)"

arm: format get
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -v -o kbot-arm -ldflags "-X main.appVersion=$(VERSION)"

# Docker image creation
image:
	docker build --platform linux/amd64 -t $(REGISTRY)/$(APP):$(VERSION) .

# GCR authentication and Docker image pushing
push:
	docker push $(REGISTRY)/$(APP):$(VERSION)

# Clean up built artifacts
clean:
	rm -rf kbot-*
	docker rmi -f $(REGISTRY)/$(APP):$(VERSION) || true
