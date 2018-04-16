FROM debian:stretch

MAINTAINER Rubén López Gómez <me@rubeniskov.com>

ARG CROSS_ARCH
ARG TOOLCHAIN_VERSION=all

# Install gcc-6 compiler wget and ruby 
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    # Toolchain deps \
    curl \
    ca-certificates \
    gpg \
    xz-utils \
    --no-install-recommends  &&\
    rm -rf /var/lib/apt/lists/*

COPY ./assets/toolchain /usr/bin/toolchain

RUN toolchain install ${TOOLCHAIN_VERSION}

COPY ./assets/crossbuild /usr/bin/crossbuild

ENTRYPOINT ["/usr/bin/crossbuild"]
CMD ["/bin/bash"]
WORKDIR /workdir
