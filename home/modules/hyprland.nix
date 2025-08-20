{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
  inherit (inputs) hyprland papertoy Hyprspace;
  hyprPkgs = hyprland.packages.${pkgs.system};
in {
  wayland.windowManager.hyprland = mkIf cfg.enable {
    package = hyprPkgs.hyprland;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    xwayland.enable = true;
    plugins = [
      Hyprspace.packages.${pkgs.system}.Hyprspace
    ];

    settings = let
      workspaces = [
        ["Ampersand" 1]
        ["Eacute" 2]
        ["Quotedbl" 3]
        ["Apostrophe" 4]
        ["Parenleft" 5]
        ["Minus" 6]
        ["Egrave" 7]
        ["Underscore" 8]
        ["Ccedilla" 9]
        ["Agrave" 10]
      ];
      motions = [["h" "l"] ["j" "d"] ["k" "u"] ["l" "r"]];
    in {
      "$mod" = "SUPER";

      general = {
        border_size = 0;
        gaps_out = "12,8,12,8";
      };

      bind =
        [
          "$mod, Return, exec, ghostty"
          "$mod, X, killactive"
          "$mod, Space, exec, walker"
          "$mod, F, fullscreen, active"
          "$mod, V, togglefloating"
          "$mod, O, overview:toggle"
        ]
        ++
        # For each workspaces, creates bindings
        foldl' (acc: w:
          acc
          ++ [
            "$mod, ${builtins.elemAt w 0}, workspace, ${toString (builtins.elemAt w 1)}"
            "Shift+$mod, ${builtins.elemAt w 0}, movetoworkspace, ${toString (builtins.elemAt w 1)}"
          ]) []
        workspaces
        ++ foldl' (acc: m:
          acc
          ++ [
            "$mod, ${builtins.elemAt m 0}, movefocus, ${builtins.elemAt m 1}"
            "Shift+$mod, ${builtins.elemAt m 0}, movewindow, ${builtins.elemAt m 1}"
          ]) []
        motions
        ++ [
          "Shift+$mod, S, exec, hyprshot --freeze -m region -o $HOME/Pictures/Screenshots/"
          "$mod, Print, exec, hyprshot --freeze -m output -o $HOME/Pictures/Screenshots/"
          ", Print, exec, hyprshot --freeze -m window -o $HOME/Pictures/Screenshots/"
          ", XF86MonBrightnessUp, exec, lightctl up"
          ", XF86MonBrightnessDown, exec, lightctl down"
          ", XF86AudioRaiseVolume, exec, volumectl -u up"
          ", XF86AudioLowerVolume, exec, volumectl -u down"
          ", XF86AudioMute, exec, volumectl toggle-mute"
          ", XF86AudioMicMute, exec, volumectl -m toggle-mute"
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

        blur = {
          enabled = false;
        };
      };

      bezier = [
        "myBezier, 0.05, 0.9, 0.1, 1.05"
        "easeOut, 0, 1, .2, 1"
        "overshot, 0.7, 0.6, 0.1, 1.1"
      ];

      animation = [
        "windows, 0"
        "workspaces, 0"
        "fade, 0"
      ];

      monitor = [
        "eDP-1,highres,auto,1.6"
        "HDMI-A-1,preferred,auto-center-left,1.0"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
        middle_click_paste = false;
        vfr = true;
        vrr = 1;
      };

      windowrulev2 = [
        "float, class:(it.mijorus.smile)"
      ];

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_forever = true;
        workspace_swipe_use_r = true;
        workspace_swipe_distance = 600;
        workspace_swipe_cancel_ratio = 0.1;
        workspace_swipe_min_speed_to_force = 15;
      };

      plugin = {
        overview = {
          overrideGaps = false;
          gapsIn = 10;
          gapsOut = 30;
          panelHeight = 300;
          reservedArea = 32;
          workspaceActiveBorder = "rgba(99999999)";
          workspaceInactiveBorder = "rgba(55555599)";
          drawActiveWorkspace = true;
          showOvelayLayers = true;
          hideRealLayers = false;
          affectStrut = false;
          panelBorderWidth = 0;
          panelBorderColor = "rgba(707070cc)";
          panelColor = "rgba(10101044)";
        };
      };

      exec-once = [
        # "papertoy ${../../assets/galaxy.glsl} --output 0"
        # "papertoy ${../../assets/galaxy.glsl} --output 1"
      ];
    };
  };
  services = mkIf cfg.enable {
    avizo.enable = true;
    mako.enable = true;
  };
  home = {
    sessionVariables = mkIf cfg.enable {
      NIXOS_OZONE_WL = "1";
    };
    packages = with pkgs;
      optionals cfg.enable [
        hyprshot
        wl-clipboard
        libdbusmenu
        brightnessctl
        pulseaudio
        smile
        mission-center
        myxer
        papertoy.packages.${pkgs.system}.default
      ];
  };
}
