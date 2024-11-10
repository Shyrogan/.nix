{ pkgs, config, lib, ... }: with lib;
let
  cfg = config.dconf;
in {
  options.dconf = {
    extensions = {
      enable = mkEnableOption "extensions";
      tiling-shell.enable = mkEnableOption "tiling-shell";
      blur-my-shell.enable = mkEnableOption "blur-my-shell";
    };
  };

  config = {
    dconf.settings = mkIf cfg.enable {
      "org/gnome/shell" = {
        disable-user-extensions = !cfg.extensions.enable;
        enabled-extensions = with pkgs.gnomeExtensions; []
          ++ optionals (cfg.extensions.tiling-shell.enable) [ tiling-shell.extensionUuid ]
          ++ optionals (cfg.extensions.blur-my-shell.enable) [ blur-my-shell.extensionUuid ];
      };
    };
    home.packages = with pkgs.gnomeExtensions; []
      ++ optionals cfg.extensions.tiling-shell.enable [ tiling-shell ]
      ++ optionals cfg.extensions.blur-my-shell.enable [ blur-my-shell ];
  };
}
