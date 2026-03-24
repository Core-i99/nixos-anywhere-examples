{
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./base-configuration.nix
    ./disk-config-pc.nix
  ];
}
