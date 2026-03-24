{ lib, ... }:
{
  disko.devices = {
    disk.disk1 = {
      device = lib.mkDefault "/dev/sda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          persist = {
            name = "persist";
            size = "2G"; # Reduced from 5G to fit Nix store on 10G disk
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/persist";
            };
          };
          nix = {
            name = "nix";
            size = "100%"; # Use remaining space for Nix store
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
            };
          };
        };
      };
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "size=2G" "mode=755" ];
    };
  };

  fileSystems."/persist".neededForBoot = true;
}
