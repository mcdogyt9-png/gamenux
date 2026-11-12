# Build container for Gamenux ISO
FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    live-build debootstrap squashfs-tools xorriso \
    grub-pc-bin grub-efi-amd64-bin ca-certificates git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY . /src

ENV EDITION=standard

CMD ["bash", "-c", "./build.sh \"${EDITION}\" && cp build/*.iso /out/ 2>/dev/null || true"]