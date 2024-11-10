{ inputs, config, lib, pkgs, ... }: with lib;
let
  inherit (inputs) niri;
  cfg = config.programs.niri;
  stylix = config.stylix;
in {
  imports = [
    niri.homeModules.niri
  ];

  programs.niri = mkIf cfg.enable {
    settings = {
      binds = with config.lib.niri.actions; let
        workspaces = [
          ["Ampersand" 1] ["Eacute" 2] ["Quotedbl" 3] ["Apostrophe" 4] ["Parenleft" 5] ["Minus" 6] 
          ["Egrave" 7] ["Underscore" 8] ["Ccedilla" 9] ["Agrave" 10]
        ];
        # This function allows to easily create keybindings for a workspace.
        bindingForWorkspace = workspace: let
          key = builtins.elemAt workspace 0;
          workspace_id = builtins.elemAt workspace 1;
        in {
          "Mod+${key}".action = focus-workspace workspace_id;
          "Mod+Shift+${key}".action = move-window-to-workspace workspace_id;
        };
        ####
      in {
        "Mod+X".action = close-window;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+Shift+U".action = switch-preset-window-height;
        "Mod+Shift+I".action = switch-preset-column-width;

        "Mod+Return".action = spawn "wezterm";
        "Mod+B".action = spawn "firefox";
        "Mod+Space".action = spawn "fuzzel";
      }
      // foldl' (acc: workspace: acc // bindingForWorkspace workspace) {} workspaces
      # Motions
      // {
        "Mod+h".action = focus-column-or-monitor-left;
        "Mod+l".action = focus-column-or-monitor-right;
        "Mod+k".action = focus-window-or-workspace-up;
        "Mod+j".action = focus-window-or-workspace-down;
      }
      // {
        "Mod+Shift+S".action = screenshot;
        "Print".action = screenshot-screen;
        "Mod+Print".action = screenshot-window;
      };
      spawn-at-startup = [
        { command = ["swaybg" "-i" "${stylix.image}"]; }
        { command = ["xwayland-satellite"]; }
      ];
      window-rules = [
        {
          geometry-corner-radius = let r = 8.0; in {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
          clip-to-geometry = true;
          draw-border-with-background = false;
        }
      ];
      layout = {
        focus-ring = {
          width = 1;
        };
        always-center-single-column = true;
        preset-window-heights = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
          { proportion = 1.; }
        ];
        preset-column-widths = [
          {proportion = 1.0 / 6.0;}
          {proportion = 1.0 / 4.0;}
          {proportion = 1.0 / 3.0;}
          {proportion = 1.0 / 2.0;}
          {proportion = 2.0 / 3.0;}
          {proportion = 3.0 / 4.0;}
          {proportion = 5.0 / 6.0;}
        ];
        default-column-width.proportion = 1. / 2.;
      };
      input = {
        keyboard.xkb.layout = "fr";
      };
      environment = {
        DISPLAY = ":0";
      };
    };
  };

  home = {
    packages = with pkgs; optionals cfg.enable [
      # For wallpapers
      swaybg
      # For X11 apps
      xwayland-satellite 
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
