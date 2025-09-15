{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.niri = {
    settings = {
      environment."NIXOS_OZONE_WL" = "1";
      xwayland-satellite = {
        enable = true;
        path = lib.getExe pkgs.xwayland-satellite-unstable;
      };

      input = {
        keyboard = {
          xkb = {
            layout = "fr";
          };
        };
        mouse = {
          accel-speed = 0.4;
        };
      };

      layout = {
        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
          { proportion = 1.0; }
        ];
        default-column-width = {
          proportion = 1.0 / 2.0;
        };
      };

      window-rules = [
        {
          geometry-corner-radius =
            let
              radius = 12.0;
            in
            {
              bottom-left = radius;
              bottom-right = radius;
              top-left = radius;
              top-right = radius;
            };
          clip-to-geometry = true;
          draw-border-with-background = false;
        }
        {
          matches = [ { app-id = "zen"; } ];
          open-on-workspace = "03-browser";
        }
        {
          matches = [ { app-id = "vesktop"; } ];
          open-on-workspace = "09-discord";
        }
        {
          matches = [ { app-id = "10-spotify"; } ];
          open-on-workspace = "10-spotify";
        }
      ];
      prefer-no-csd = true;

      binds = with config.lib.niri.actions; {
        "Mod+X".action = close-window;
        "Mod+O".action = toggle-overview;
        "Mod+R".action = switch-preset-window-width;
        "Mod+T".action = switch-preset-window-height;
        "Mod+F".action = fullscreen-window;

        # A few quick programs required all the time
        "Mod+Return".action.spawn = "ghostty";
        "Mod+Space".action.spawn = "fuzzel";

        # Windows + columns
        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+L".action = focus-column-right;
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+J".action = move-window-down;
        "Mod+Shift+K".action = move-window-up;
        "Mod+Shift+L".action = move-column-right;

        # Workspaces (TODO: refactor with loops)
        "Mod+Ampersand".action = focus-workspace "01-main-workspace";
        "Mod+Eacute".action = focus-workspace "02-secondary-workspace";
        "Mod+Quotedbl".action = focus-workspace "03-browser";
        "Mod+Apostrophe".action = focus-workspace 4;
        "Mod+Parenleft".action = focus-workspace 5;
        "Mod+Minus".action = focus-workspace 6;
        "Mod+Egrave".action = focus-workspace 7;
        "Mod+Underscore".action = focus-workspace 8;
        "Mod+Ccedilla".action = focus-workspace "09-discord";
        "Mod+Agrave".action = focus-workspace "10-spotify";
        "Mod+Shift+Ampersand".action.move-column-to-workspace = "01-main-workspace";
        "Mod+Shift+Eacute".action.move-column-to-workspace = "02-secondary-workspace";
        "Mod+Shift+Quotedbl".action.move-column-to-workspace = "03-browser";
        "Mod+Shift+Apostrophe".action.move-column-to-workspace = 4;
        "Mod+Shift+Parenleft".action.move-column-to-workspace = 5;
        "Mod+Shift+Minus".action.move-column-to-workspace = 6;
        "Mod+Shift+Egrave".action.move-column-to-workspace = 7;
        "Mod+Shift+Underscore".action.move-column-to-workspace = 8;
        "Mod+Shift+Ccedilla".action.move-column-to-workspace = "09-discord";
        "Mod+Shift+Agrave".action.move-column-to-workspace = "10-spotify";

        "Mod+V".action = toggle-window-floating;

        "Mod+Shift+S".action = screenshot-window { write-to-disk = true; };
        "Print".action = screenshot { show-pointer = true; };
      };

      workspaces = {
        "01-main-workspace" = {
        };
        "02-secondary-workspace" = {
        };
        "03-browser" = {
        };
        "09-discord" = {
        };
        "10-spotify" = {
        };
      };

      hotkey-overlay = {
        skip-at-startup = true;
      };
    };
  };
}
