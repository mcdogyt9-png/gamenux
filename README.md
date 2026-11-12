# Gamenux

**Gamenux** is a gaming-focused Linux distribution with Steam, Wine/Proton, and a curated set of gaming tools preinstalled. It is built on top of Debian/Ubuntu using `live-build`, so it boots as a live ISO and can be installed to disk.

> Status: scaffolding. The build must be run on a Debian/Ubuntu host (or in a container/VM). See [Building](docs/BUILDING.md).

## Highlights

- Steam preinstalled with Proton-GE bootstrap helper
- Wine (stable + staging) with winetricks and DXVK/VKD3D
- Lutris, Heroic Games Launcher, Bottles available
- GameMode, MangoHud, GOverlay for performance tuning
- KDE Plasma desktop (Wayland + X11) with gaming-friendly defaults
- NVIDIA (proprietary) + Mesa (AMD/Intel) graphics stacks
- Low-latency audio via PipeWire
- NetworkManager, Bluetooth, Flatpak/AppImage support
- Discord & OBS Studio preinstalled
- Gamenux Hub: control center for power limits, fan speed, FPS overlay, GPU tools

## Editions

| Edition   | Base          | Desktop | Notes                          |
|-----------|---------------|---------|--------------------------------|
| standard  | Debian 12     | KDE     | Stable, recommended            |
| nvidia    | Debian 12     | KDE     | Adds NVIDIA proprietary driver |
| minimal   | Debian 12     | (none)  | Server/headless gaming host    |

## Building

Requirements (on a Debian/Ubuntu host):

```bash
sudo apt install live-build debootstrap squashfs-tools xorriso grub-pc-bin grub-efi-amd64-bin
```

Then:

```bash
sudo ./build.sh standard
```

The resulting ISO is written to `build/gamenux-*.iso`.

## Project layout

```
.
+¦¦ build.sh
+¦¦ config/
-   +¦¦ package-lists/
-   +¦¦ hooks/
-   L¦¦ includes.chroot/
+¦¦ scripts/
+¦¦ assets/
L¦¦ .github/workflows/
```

## License

MIT for project scaffolding. Individual packages retain their own licenses.