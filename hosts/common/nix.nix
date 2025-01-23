{ inputs, pkgs, ... }: let
  inherit (inputs) fenix;
in
{
  nixpkgs = {
    overlays = [ fenix.overlays.default ];
    config.allowUnfree = true;
  };
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };
    extraOptions = ''
        trusted-users = root sebastien
    '';
  };
  environment.systemPackages = with pkgs; [
    nh
    devenv
    home-manager
  ];
  programs.nix-ld.enable = true;
}
