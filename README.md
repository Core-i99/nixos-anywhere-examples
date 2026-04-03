# nixos-anywhere-examples

Checkout the [flake.nix](flake.nix) for examples tested on different hosters.

## Usage

Initial installation using nixos-anywhere:

```bash
nix run github:nix-community/nixos-anywhere -- --flake .#debian-vm --generate-hardware-config nixos-generate-config ./hardware-configuration-vm.nix --ssh-option "StrictHostKeyChecking=no" root@IP_ADDRESS
```
Or use sshpass
```bash
sshpass -p 'root' nix run github:nix-community/nixos-anywhere -- --flake .#debian-vm --generate-hardware-config nixos-generate-config ./hardware-configuration-vm.nix --ssh-option "StrictHostKeyChecking=no" root@IP_ADDRESS
```

### Installation from a NixOS Live USB (Skipping kexec)

If you have already booted the target machine into a NixOS Live USB (or a minimal NixOS environment), you can skip the `kexec` phase:

```bash
nix run github:nix-community/nixos-anywhere -- --flake .#pc-bios-mutable --phases disko,install,reboot root@IP_ADDRESS
```

> [!CAUTION]
> **Important**: When booting from a Live USB, the USB stick itself is often `/dev/sda`. If you try to wipe `/dev/sda`, `disko` will fail.
> Use `lsblk` on the target machine to identify your hard drive (e.g., `/dev/sdb`) and ensure the `device` path in `flake.nix` and the bootloader path in your configuration files match the correct drive.

*(This is recommended for older hardware like Core 2 Duo systems where `kexec` often fails during the BIOS transition).*

## Updating Configuration

```bash
nixos-rebuild switch --flake .#debian-vm --target-host root@IP_ADDRESS
```
If you want to bypass host key checking (useful for temporary VMs):

```bash
sshpass -p 'root' env NIX_SSHOPTS="-o StrictHostKeyChecking=no" nixos-rebuild switch --flake .#debian-vm --target-host root@IP_ADDRESS
```

Documentation:
https://github.com/nix-community/nixos-anywhere/blob/main/docs/quickstart.md
