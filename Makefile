APP=$(basename $(git remote get-url origin))
REGISTRY=ghcr.io/cipgen
VERSION=$(git describe --tags --abbrev=0)-$(git rev-parse --short HEAD)

.PHONY: format lint test get clean build image push

# General commands
format:
    gofmt -s -w ./

lint:
    golint

test:
    go test -v

get:
    go get

clean:
    rm -rf kbot
    docker rmi ${REGISTRY}/${APP}:${VERSION} || true

# Build commands
build:
    CGO_ENABLED=0 GOOS=${GOOS} GOARCH=${GOARCH} go build -v -o kbot -ldflags "-X=github.com/scottishwidow/kbot/cmd.appVersion=${VERSION}"

linux mac windows arm:
    $(MAKE) build GOOS=$(if $(filter $@,mac),darwin,$(if $(filter $@,windows),windows,linux)) GOARCH=$(if $(filter $@,arm),arm64,amd64)

# Docker commands
image:
    echo "Building image for Version: ${VERSION}, Architecture: ${GOARCH}"
    docker build --platform ${GOOS:=linux}/${GOARCH:=amd64} . -t ${REGISTRY}/${APP}:${VERSION} -f Dockerfile

push:
    echo "Pushing image for Version: ${VERSION}, Architecture: ${GOARCH}"
    docker push ${REGISTRY}/${APP}:${VERSION}
