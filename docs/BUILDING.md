# Building Gamenux

## Prerequisites

A Debian or Ubuntu host with:

```bash
sudo apt install live-build debootstrap squashfs-tools xorriso \
  grub-pc-bin grub-efi-amd64-bin
```

## Build

```bash
sudo ./build.sh standard   # or nvidia / minimal
```

## Testing in a VM

```bash
qemu-system-x86_64 -m 4096 -cdrom build/gamenux-standard.iso -enable-kvm
```

## Customizing

- Add packages: edit `config/package-lists/*.list.chroot`
- Add files to the image: place under `config/includes.chroot/`
- Post-install logic: edit `config/hooks/live/*.hook.chroot`
## Using Make

```bash
make build              # standard
make build EDITION=nvidia
make build-minimal
make clean
```

## Using Docker

```bash
# Build the image and run the build in a privileged container
make docker-build
# or
docker compose run builder
```

The resulting ISO is written to `./build/`.