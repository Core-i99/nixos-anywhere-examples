{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
          ./configuration.nix
          ./hardware-configuration.nix
        ];
      };
    };
}
