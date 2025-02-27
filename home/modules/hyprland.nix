{ inputs, config, lib, pkgs, ... }: with lib;
let
  cfg = config.wayland.windowManager.hyprland;
  inherit (inputs) hyprland swts;
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
        border_size = 0;
        gaps_out = "12,8,12,8";
      };

      bind = [
        "$mod, Return, exec, ghostty"
        "$mod, X, killactive"
        "$mod, Space, exec, fuzzel"
        "$mod, F, fullscreen, active"
        "$mod, V, togglefloating"
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
        ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +10%"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -10%"
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle && brightnessctl -d platform::micmute set $((1 - $(brightnessctl -d platform::micmute g)))"
          #", XF86Launch1, hyprexpo:expo, toggle"
        "$mod, Colon, exec, smile"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod, Control_L, movewindow"
        "$mod, ALT_L, resizewindow"
      ];

      bindl = [
        '', switch:on:Lid Switch, exec, hyprctl keyword monitor "eDP-1, disable"''
        '', switch:off:Lid Switch, exec, hyprctl keyword monitor "eDP-1,highres,auto-left,1.6"''
        
      ];

      input = {
        kb_layout = "fr";
      };

      decoration = {
        rounding = 12;

        shadow = {
          range = 12;
          render_power = 3;
          color = lib.mkForce "rgba(00000045)";
        };
      };

      animation = [
        "workspaces, 1, 2, default, slidevert"
        "windows, 1, 2, default, slide"
        "fade, 0"
      ];

      monitor = [
        "eDP-1,highres,auto-left,1.6"
        "HDMI-A-1,preferred,auto,1.0"
        "DP-1,preferred,auto-right,1.0,transform,1"
      ];
      
      xwayland = {
        force_zero_scaling = true;
      };

      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
        middle_click_paste = false;
      };

      windowrulev2 = [
        "float, class:(it.mijorus.smile)"
      ];

      gestures = {
        workspace_swipe = true;
      };

      exec-once = ["swts"];
    };
  };
  services = mkIf cfg.enable {
    hyprpaper.enable = true;
  };
  home = {
    sessionVariables = mkIf cfg.enable {
      NIXOS_OZONE_WL = "1";
    };
    packages = with pkgs; optionals cfg.enable [
      hyprshot wl-clipboard libdbusmenu
      brightnessctl pulseaudio smile 
      mission-center myxer
      swts.packages.${pkgs.system}.default
    ];
  };
}
