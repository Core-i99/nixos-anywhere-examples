# This is a generic hardware configuration for a physical machine.
# On a real machine, you should generate this with ‘nixos-generate-config’.
{ lib, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ]; # Or "kvm-amd" depending on your CPU
  boot.extraModulePackages = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # hardware.cpu.intel.updateMicrocode = lib.mkDefault true;
  # hardware.cpu.amd.updateMicrocode = lib.mkDefault true;
}
