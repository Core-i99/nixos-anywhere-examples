{ modulesPath, lib, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./base-configuration.nix
    ./disk-config-pc-bios-mutable.nix
  ];

  # Override base-configuration.nix defaults for BIOS boot
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  
  # Enable GRUB for legacy BIOS boot
  boot.loader.grub.enable = true;
  # This should match the device in disk-config-pc-bios-mutable.nix
  boot.loader.grub.device = lib.mkDefault "/dev/sda";

  # Note: "/" is now persistent on disk, so we don't need the impermanence module.
}
