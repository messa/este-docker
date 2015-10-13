TAG=messa/este

default:
	@echo "Run 'make build' to build Docker image"

build:
	docker build --tag $(TAG) .

build-nc:
	docker build --no-cache --tag $(TAG) .

run:
	docker run --rm -p 8000:8000 $(TAG)

push:
	docker push $(TAG)
