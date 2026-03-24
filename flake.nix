{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
  inputs.impermanence.url = "github:nix-community/impermanence";

  outputs =
    {
      nixpkgs,
      disko,
      nixos-facter-modules,
      impermanence,
      ...
    }:
    {
      # debian-vm for the user's specific VM
      nixosConfigurations.debian-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          { disko.devices.disk.disk1.device = "/dev/vda"; }
          ./configuration-vm.nix
          ./hardware-configuration-vm.nix
        ];
      };

      # pc for a physical machine
      nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          # Update this to your physical disk (e.g. /dev/nvme0n1 or /dev/sda)
          { disko.devices.disk.disk1.device = "/dev/nvme0n1"; }
          ./configuration-pc.nix
          ./hardware-configuration-pc.nix
        ];
      };
    };
}
