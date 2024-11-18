{ inputs, config, lib, pkgs, ... }: with lib;
let
  cfg = config.wayland.windowManager.hyprland;
  inherit (inputs) hyprland hyprscroller;
  hyprPkgs = hyprland.packages.${pkgs.system};
in {
  wayland.windowManager.hyprland = mkIf cfg.enable {
    package = hyprPkgs.hyprland;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    xwayland.enable = true;

    plugins = [
      hyprscroller.packages.${pkgs.system}.default
    ];

    settings = let
      workspaces = [
        ["Ampersand" 1] ["Eacute" 2] ["Quotedbl" 3] ["Apostrophe" 4] ["Parenleft" 5] ["Minus" 6] 
        ["Egrave" 7] ["Underscore" 8] ["Ccedilla" 9] ["Agrave" 10]
      ];
      motions = [["h" "l"] ["j" "d"] ["k" "u"] ["l" "r"]];
    in {
      "$mod" = "SUPER";

      general = {
        layout = "scroller";
      };

      bind = [
        "$mod, Return, exec, wezterm"
        "$mod, X, killactive"
        "$mod, Space, exec, fuzzel"
        "$mod, F, scroller:fitsize, active"
        "Shift+$mod, F, fullscreen"
        ", XF86Launch1, scroller:toggleoverview"
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
      ]) [] motions
      ++ [
        "Shift+$mod, S, exec, hyprshot -m region -o $HOME/Pictures/Screenshots/"
        "$mod, Print, exec, hyprshot -m output -o $HOME/Pictures/Screenshots/"
        ", Print, exec, hyprshot -m window -o $HOME/Pictures/Screenshots/"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      input = {
        kb_layout = "fr";
      };

      decoration = {
        rounding = 8;
      };

      animation = [
        "workspaces, 1, 2, default, slidevert"
        "windows, 1, 2, default, slide"
        "fade, 0"
      ];

      monitor = [
        "eDP-1,highres,auto-left,1.6"
        "HDMI-A-1,preferred,auto,1.333333"
        "DP-1,preferred,auto-right,1.0,transform,1"
      ];
      
      xwayland = {
        force_zero_scaling = true;
      };

      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };

      exec-once = [
        "cb"
      ];
    };
  };
  services= mkIf cfg.enable {
    hyprpaper.enable = true;
    copyq.enable = true;
  };
  stylix.targets.hyprland.enable = false;
  home = {
    sessionVariables = mkIf cfg.enable {
      NIXOS_OZONE_WL = "1";
    };
    packages = with pkgs; optionals cfg.enable [
      hyprshot 
    ];
  };
}
