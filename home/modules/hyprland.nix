{ inputs, config, lib, pkgs, ... }: with lib;
let
  cfg = config.wayland.windowManager.hyprland;
  inherit (inputs) hyprland;
  hyprPkgs = hyprland.packages.${pkgs.system};
in {
  wayland.windowManager.hyprland = mkIf cfg.enable {
    package = hyprPkgs.hyprland;
    systemd.enable = true;
    xwayland.enable = true;

    plugins = [
    ];

    settings = let
      workspaces = [
        ["Ampersand" 1] ["Eacute" 2] ["Quotedbl" 3] ["Apostrophe" 4] ["Parenleft" 5] ["Minus" 6] 
        ["Egrave" 7] ["Underscore" 8] ["Ccedilla" 9] ["Agrave" 10]
      ];
      motions = [["h" "l"] ["j" "d"] ["k" "u"] ["l" "r"]];
    in {
      "$mod" = "SUPER";

      bind = [
        "$mod, Return, exec, wezterm"
        "$mod, X, killactive"
        "$mod, Space, exec, fuzzel"
      ] ++
        # For each workspaces, creates bindings
        foldl' (acc: w: acc ++ [
          "$mod, ${builtins.elemAt w 0}, workspace, ${toString (builtins.elemAt w 1)}"
          "Shift+$mod, ${builtins.elemAt w 0}, movetoworkspace, ${toString (builtins.elemAt w 1)}"
        ]) [] workspaces
        ++
        foldl' (acc: m: acc ++ [
          "$mod, ${builtins.elemAt m 0}, movefocus, ${builtins.elemAt m 1}"
          "Shift+$mod, ${builtins.elemAt m 0}, movewindow, ${builtins.elemAt m 1}"
        ]) [] motions;

      input = {
        kb_layout = "fr";
      };

      decoration = {
        rounding = 2;
      };
      
      monitor = [
        "eDP-1,highres,auto,2"
      ];
      
      xwayland = {
        force_zero_scaling = true;
      };
    };
  };
  services.hyprpaper = mkIf cfg.enable {
    enable = true;
  };
  stylix.targets.hyprland.enable = false;
  home.sessionVariables = mkIf cfg.enable {
    NIXOS_OZONE_WL = "1";
  };
}
