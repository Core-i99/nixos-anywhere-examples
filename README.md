# nixos-anywhere-examples

Checkout the [flake.nix](flake.nix) for examples tested on different hosters.

## Usage

Initial installation using nixos-anywhere:

```bash
nix run github:nix-community/nixos-anywhere -- --flake .#debian-vm --generate-hardware-config nixos-generate-config ./hardware-configuration.nix --ssh-option "StrictHostKeyChecking=no" root@IP_ADDRESS
```

To update the NixOS configuration on your remote machine after making changes to the flake or configuration files:

```bash
nixos-rebuild switch --flake .#debian-vm --target-host root@IP_ADDRESS
```
Alternatively, you can use sshpass
```bash
sshpass -p 'root' nixos-rebuild switch --flake .#debian-vm --target-host root@IP_ADDRESS
```

> [!NOTE]
> If you haven't added your SSH key to `configuration.nix`, you will be prompted for the root password.

Documentation:
https://github.com/nix-community/nixos-anywhere/blob/main/docs/quickstart.md
