{ pkgs, config, ... }:
{
  imports = [
    ./hardware.nix
  ];

  age.secrets = {
    sebastien_key = {
      file = ../../secrets/hi/sebastien_key.age;
      path = "/home/root/sebastien_key";
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "hi";

    interfaces.eth0.ipv4.addresses = [{
      address = builtins.readFile config.age.secrets.addr.path;
      prefixLength = 24;
    }];
    defaultGateway = builtins.readFile config.age.secrets.addr_gw.path;
    nameservers = [ "8.8.8.8" ];
  };

  services.openssh.enable = true;
  users.users.root = {
    shell = pkgs.nushell;
    packages = with pkgs; [ nushell ];
    openssh.authorizedKeys.key = [
    ];
  };
}
