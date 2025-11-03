{
  flake,
  pkgs,
  ...
}: let
  inherit (flake.inputs) stylix;
in {
  imports = [
    stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    image = ../../assets/wallpapers/wind-rises.png;
    fonts = {
      monospace = {
        name = "GeistMono Nerd Font";
        package = pkgs.nerd-fonts.geist-mono;
      };
    };
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    polarity = "dark";
  };
}
