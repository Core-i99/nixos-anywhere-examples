{
  lib,
  pkgs,
  ...
} @ args:
{
  # Bootloader setup
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  users.users.root.initialPassword = "root";
  
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Set keyboard layout to Belgian
  console.keyMap = "be-latin1";
  services.xserver.xkb.layout = "be";

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "nixos";

  environment.systemPackages = [
    pkgs.curl
    pkgs.gitMinimal
    pkgs.btop
    pkgs.htop
    pkgs.wget
    pkgs.ungoogled-chromium
  ];

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    initialPassword = "nixos";
  };

  users.users.root.openssh.authorizedKeys.keys =
    [
      # change this to your ssh key
      "# CHANGE"
    ] ++ (args.extraPublicKeys or []); # this is used for unit-testing this module and can be removed if not needed

  system.stateVersion = "25.11";
}
