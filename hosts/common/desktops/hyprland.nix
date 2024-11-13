{ inputs, pkgs, lib, config, ... }: with lib; let
  inherit (inputs) hyprland;
  cfg = config.programs.hyprland;
  hyprPkgs = hyprland.packages.${pkgs.system};
in {
  # Enables Hyprland with version from flakes
  config = mkIf cfg.enable rec {
    programs.hyprland = {
      package = hyprPkgs.hyprland;
      portalPackage = hyprPkgs.xdg-desktop-portal-hyprland;
    };

    services = {
      greetd = {
        enable = true;
        settings = rec {
          default_session = {
            command = "${programs.hyprland.package}/bin/Hyprland";
            user = "sebastien";
          };
          initial_session = default_session;
        };
      };
      gvfs.enable = true;
      upower.enable = true;
      power-profiles-daemon.enable = true;
      accounts-daemon.enable = true;
    };
    
    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      morewaita-icon-theme
      nautilus
      loupe
    ];
  };
}
