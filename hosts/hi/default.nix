{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware.nix
    ./k3s.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  virtualisation.docker.enable = true;
  services.k3s.enable = true;

  networking = {
    hostName = "hi";

    interfaces.eth0.ipv4.addresses = [
      {
        address = builtins.readFile config.age.secrets.addr.path;
        prefixLength = 24;
      }
    ];
    defaultGateway = builtins.readFile config.age.secrets.addr_gw.path;
    nameservers = ["8.8.8.8"];
    firewall.allowedTCPPorts = [22];
  };

  services.openssh.enable = true;
  users.users.root = {
    shell = pkgs.nushell;
    packages = with pkgs; [nushell];
    openssh.authorizedKeys.key = [
    ];
    extraGroups = ["docker"];
  };
}
