{ flake, ... }: 
let
  inherit (flake) inputs;
  inherit (inputs) niri;
in
{
  imports = [
    niri.homeModules.niri
  ];

  programs.niri = {
    settings = {
      environment."NIXOS_OZONE_WL" = "1";

      input = {
        keyboard = {
          xkb = {
            layout = "fr";
          };
        };
      };

      binds = {
        "Mod+Return".action.spawn = "ghostty";
        "Mod+Space".action.spawn = "fuzzel";
      };
    };
  };
}
