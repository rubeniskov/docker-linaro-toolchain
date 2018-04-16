IMAGE = rubeniskov/arm-linaro-toolchain
CROSS_TARGETS = $(shell cat assets/arm_arch_types.txt | awk '{print $1}')

.PHONY: build

default: build

build:
	for CROSS_TARGET in $(CROSS_TARGETS); do\
	  echo "Building CROSS_TARGET: $$CROSS_TARGET";\
	  docker build -t $(IMAGE):$$CROSS_TARGET --build-arg CROSS_COMPILE=$$CROSS_TARGET .;\
	done