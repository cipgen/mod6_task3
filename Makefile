APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=gcr.io/smiling-rhythm-404620
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

# Загальні цілі
.PHONY: all format lint test get clean build image push

# Збірка для всіх платформ
all: linux mac windows arm

# Форматування, лінтинг, тестування, завантаження залежностей
format lint test get:
	go $@ ./...

# Збірка з параметрами для різних платформ
build-%:
	CGO_ENABLED=0 GOOS=$(if $(findstring mac,$*),darwin,$(if $(findstring arm,$*),linux,$*)) GOARCH=$(if $(findstring windows,$*),amd64,$(if $(findstring mac,$*),amd64,$(if $(findstring arm,$*),arm64,amd64))) go build -v -o kbot -ldflags "-X main.appVersion=$(VERSION)"

linux mac windows arm: get
	$(MAKE) build-$@

# Створення Docker образу
image:
	docker build --platform linux/amd64 -t $(REGISTRY)/$(APP):$(VERSION) .

# Автентифікація в GCR та відправлення Docker образу
push:
	gcloud auth configure-docker
	docker push $(REGISTRY)/$(APP):$(VERSION)
# Очищення зібраних артефактів
clean:
	rm -rf kbot
	docker rmi -f $(REGISTRY)/$(APP):$(VERSION) || true
