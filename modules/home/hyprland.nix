{
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";

      general = {
        layout = "dwindle";
        resize_on_border = true;
      };

      misc = {
        disable_splash_rendering = true;
        force_default_wallpaper = 1;
        focus_on_activate = true;
      };

      input = {
        kb_layout = "fr";
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_touch = true;
        workspace_swipe_use_r = true;
      };

      bind =
        let
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
          motions = builtins.map (n: mkMoveToWorkspace n (builtins.elemAt keys (n - 1))) (
            builtins.genList (n: n + 1) 10
          );
        in
        workspaces
        ++ motions
        ++ [
          "$mod, return, exec, ghostty"
          "$mod, space, exec, fuzzel"
          "$mod, x, killactive"
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
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 2, myBezier"
          "windowsOut, 1, 2, default, popin 80%"
          "border, 1, 3, default"
          "fade, 1, 3, default"
          "workspaces, 1, 2, default"
        ];
      };
    };
  };
}
