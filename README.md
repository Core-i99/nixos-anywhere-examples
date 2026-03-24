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

To update the NixOS configuration on your remote machine after making changes to the flake or configuration files:

```bash
nixos-rebuild switch --flake .#debian-vm --target-host root@IP_ADDRESS
```
If you want to bypass host key checking (useful for temporary VMs):

```bash
sshpass -p 'root' env NIX_SSHOPTS="-o StrictHostKeyChecking=no" nixos-rebuild switch --flake .#debian-vm --target-host root@IP_ADDRESS
```

Documentation:
https://github.com/nix-community/nixos-anywhere/blob/main/docs/quickstart.md
