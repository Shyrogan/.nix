{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
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
      # greetd = {
      #   enable = true;
      #   settings = rec {
      #     default_session = {
      #       command = "${programs.hyprland.package}/bin/Hyprland";
      #       user = "sebastien";
      #     };
      #     initial_session = default_session;
      #   };
      # };
      gvfs.enable = true;
      upower.enable = true;
      power-profiles-daemon.enable = true;
      accounts-daemon.enable = true;
    };

    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      morewaita-icon-theme
      papirus-icon-theme
      nautilus
      loupe
    ];

    security.polkit = mkIf cfg.enable {
      enable = true;
    };

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
