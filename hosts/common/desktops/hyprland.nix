{ inputs, pkgs, ... }: let
  inherit (inputs) hyprland;
  hyprPkgs = hyprland.packages.${pkgs.system};
in rec {
  # Enables Hyprland with version from flakes
  programs.hyprland = {
    enable = true;
    package = hyprPkgs.hyprland;
    portalPackage = hyprPkgs.xdg-desktop-portal-hyprland;
  };

  services.greetd = {
    enable = true;
    settings = rec {
      default_session = {
        command = "${programs.hyprland.package}/bin/Hyprland";
        user = "sebastien";
      };
      initial_session = default_session;
    };
  };
}
