{
  config,
  lib,
  ...
}: let
  hyprshotConfig = config.programs.hyprshot;
in {
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";

      general = {
        layout = "dwindle";
        resize_on_border = true;

        gaps_out = "37,20,20,20";
      };

      xwayland = {
        enabled = true;
        force_zero_scaling = true;
      };

      misc = {
        disable_splash_rendering = true;
        force_default_wallpaper = 1;
        focus_on_activate = true;
      };

      input = {
        kb_layout = "fr";
        # sensitivity = -0.5;
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      bind = let
        keys = [
          "ampersand"
          "eacute"
          "quotedbl"
          "apostrophe"
          "parenleft"
          "minus"
          "egrave"
          "underscore"
          "ccedilla"
          "agrave"
        ];
        mkWorkspace = n: key: "$mod, ${key}, workspace, ${toString n}";
        mkMoveToWorkspace = n: key: "SHIFT+$mod, ${key}, movetoworkspace, ${toString n}";
        workspaces = builtins.map (n: mkWorkspace n (builtins.elemAt keys (n - 1))) (
          builtins.genList (n: n + 1) 10
        );
        workspaceMovements = builtins.map (n: mkMoveToWorkspace n (builtins.elemAt keys (n - 1))) (
          builtins.genList (n: n + 1) 10
        );
        focusKeys = [
          "h"
          "j"
          "k"
          "l"
        ];
        directions = [
          "l"
          "d"
          "u"
          "r"
        ];
        focusMovements = builtins.map (
          i: "$mod, ${builtins.elemAt focusKeys i}, movefocus, ${builtins.elemAt directions i}"
        ) (builtins.genList (n: n) 4);
        resizeMovements = builtins.map (
          i: "SHIFT+$mod, ${builtins.elemAt focusKeys i}, resizeactive, ${
            builtins.elemAt ["-20 0" "0 20" "0 -20" "20 0"] i
          }"
        ) (builtins.genList (n: n) 4);
      in
        workspaces
        ++ workspaceMovements
        ++ focusMovements
        ++ resizeMovements
        ++ [
          "$mod, return, exec, ghostty"
          "$mod, space, exec, walker"
          "$mod, x, killactive"

          "$mod, f, fullscreen"
          "$mod, v, togglefloating"

          "SHIFT+ALT+$mod, q, exit"
        ]
        ++ lib.optionals hyprshotConfig.enable [
          "SHIFT+$mod, S, exec, hyprshot -m region --clipboard-only"
          "$mod, Print, exec, hyprshot -m window --clipboard-only"
          ", Print, exec, hyprshot -m monitor --clipboard-only"
        ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod, Control_L, movewindow"
        "$mod, ALT_L, resizewindow"
      ];

      bindl = [
        ", switch:lid:on, exec, systemctl hibernate"
      ];
      decoration = {
        rounding = 12;
        shadow = {
          range = 11;
          render_power = 0;
        };

        dim_inactive = false;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
          popups = true;
        };
      };

      animations = {
        enabled = "false";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 1, myBezier"
          "windowsOut, 1, 1, default, popin 80%"
          "border, 1, 4, default"
          "fade, 1, 2, default"
          "workspaces, 1, 1, default"
        ];
      };

      monitor = [
        "eDP-1,2880x1800@120,0x0,1.5"
        "HDMI-A-1,2560x1440@99.94600,auto-left,auto"
      ];

      device = [
        {
          name = "glorious-model-o-2-pro---4k/8khz-edition-1";
          sensitivity = -0.5;
        }
      ];
    };
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };
}
