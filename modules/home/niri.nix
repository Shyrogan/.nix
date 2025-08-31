{ config, flake, ... }: 
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
      
      layout = {
        preset-column-widths = [
	  { proportion = 1. / 3.; }
	  { proportion = 1. / 2.; }
	  { proportion = 2. / 3.; }
	  { proportion = 1.; }
	];
        default-column-width = {
	  proportion = 1.0;
	};
      };

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
	"Mod+Ampersand".action = focus-workspace 1;
	"Mod+Eacute".action = focus-workspace 2;
	"Mod+Quotedbl".action = focus-workspace 3;
	"Mod+Apostrophe".action = focus-workspace 4;
	"Mod+Parenleft".action = focus-workspace 5;
	"Mod+Minus".action = focus-workspace 6;
	"Mod+Egrave".action = focus-workspace 7;
	"Mod+Underscore".action = focus-workspace 8;
	"Mod+Ccedilla".action = focus-workspace 9;
	"Mod+Agrave".action = focus-workspace 10;
	"Mod+Shift+Ampersand".action.move-column-to-workspace = 1;
	"Mod+Shift+Eacute".action.move-column-to-workspace = 2;
	"Mod+Shift+Quotedbl".action.move-column-to-workspace = 3;
	"Mod+Shift+Apostrophe".action.move-column-to-workspace = 4;
	"Mod+Shift+Parenleft".action.move-column-to-workspace = 5;
	"Mod+Shift+Minus".action.move-column-to-workspace = 6;
	"Mod+Shift+Egrave".action.move-column-to-workspace = 7;
	"Mod+Shift+Underscore".action.move-column-to-workspace = 8;
	"Mod+Shift+Ccedilla".action.move-column-to-workspace = 9;
	"Mod+Shift+Agrave".action.move-column-to-workspace = 10;

	"Mod+V".action = toggle-window-floating;
      };
    };
  };
}
