IMAGE = rubeniskov/arm-linaro-toolchain
TOOLCHAIN_ARCHS = $(shell cat assets/arm_arch_types.txt | awk '{print $1}')
TOOLCHAIN_VERSIONS = $(shell cat assets/toolchain_versions.txt | awk '{print $1}')

.PHONY: build

default: build

build:
	@for TOOLCHAIN_ARCH in $(TOOLCHAIN_ARCHS); do\
	  echo "- Building TOOLCHAIN_ARCH: $$TOOLCHAIN_ARCH";\
	  docker build -t $(IMAGE):$$TOOLCHAIN_ARCH --build-arg CROSS_COMPILE=$$TOOLCHAIN_ARCH .;\
	  for TOOLCHAIN_VERSION in $(TOOLCHAIN_VERSIONS); do\
	  	echo "- Building TOOLCHAIN_VERSION: $$TOOLCHAIN_VERSION";\
	  	docker build -t $(IMAGE):$$TOOLCHAIN_ARCH-$$TOOLCHAIN_VERSION --build-arg TOOLCHAIN_VERSION=$$TOOLCHAIN_VERSION CROSS_COMPILE=$$TOOLCHAIN_ARCH .;\
	  done;\
	done

