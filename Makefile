.PHONY: help build build-nvidia build-minimal clean docker-build

EDITION ?= standard

help:
	@echo "Gamenux build targets:"
	@echo "  make build            Build standard edition ISO"
	@echo "  make build-nvidia     Build nvidia edition ISO"
	@echo "  make build-minimal    Build minimal edition ISO"
	@echo "  make build EDITION=x  Build a specific edition"
	@echo "  make clean            Remove build artifacts"
	@echo "  make docker-build     Build ISO inside Docker"

build:
	sudo ./build.sh $(EDITION)

build-nvidia:
	sudo ./build.sh nvidia

build-minimal:
	sudo ./build.sh minimal

clean:
	rm -rf build/

docker-build:
	docker build -t gamenux-builder .
	docker run --privileged --rm -v $$(pwd):/src -v $$(pwd)/build:/out gamenux-builder $(EDITION)