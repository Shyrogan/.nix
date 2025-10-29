{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) determinate;
in {
  imports = [
    determinate.nixosModules.default
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };
  nix = {
    # Cleans up some space on the machine
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings = {
      auto-optimise-store = true;
      allowed-users = ["sebastien"];
      trusted-users = ["root" "sebastien"];

      # For speeding up
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
        "https://install.determinate.systems"
        "https://walker.cachix.org"
      ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      ];
    };
  };
  programs.nix-ld.enable = true;
}
