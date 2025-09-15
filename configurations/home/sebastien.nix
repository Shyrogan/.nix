{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self zen-browser;
in
{
  imports = [
    self.homeModules.default
  ];

  me = {
    username = "sebastien";
    fullname = "Sébastien VIAL";
    email = "sebastien@shyrogan.fr";
  };

  programs = {
    nushell.enable = true;
    ghostty.enable = true;
    fuzzel.enable = true;
    nvf.enable = true;
    vesktop.enable = true;
    obs-studio.enable = true;
    spicetify.enable = true;
    ankama-launcher.enable = true;
  };
  services = {
    hyprpaper.enable = true;
  };
  home.packages = with pkgs; [
    zen-browser.packages.${system}.default
    pavucontrol
    vlc
    nautilus
    lazygit
    (prismlauncher.override {
      jdks = [
        graalvm-ce
        jdk21
      ];
    })
    gimp
  ];

  home.stateVersion = "25.05";
}
