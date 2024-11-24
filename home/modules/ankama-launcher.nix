{ pkgs, config, lib, ... }: with lib;
let
  cfg = config.programs.ankama-launcher;
  name = "ankama-launcher";
  src = pkgs.fetchurl {
    url = "https://launcher.cdn.ankama.com/installers/production/Ankama%20Launcher-Setup-x86_64.AppImage";
    hash = "sha256-IWPpOSXMATzdWfmPUadadFcM0U+bxHZ7vrMqmvS+kMA=";
  };
  content = pkgs.appimageTools.extractType2 { inherit name src; };
in {
  options.programs.ankama-launcher.enable = mkEnableOption "Ankama's launcher";

  config.home.packages = optionals cfg.enable [ (pkgs.appimageTools.wrapType2 {
    inherit name src;

    extraInstallCommands = ''
      ls -la ${content}
      install -m 444 -D ${content}/zaap.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/zaap.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=ankama-launcher'
      cp -r ${content}/usr/share/icons $out/share
    '';

    meta = {
      description = "Official launcher for Ankama's games";
      platforms = [ "x86_64-linux" ];
    };
  })];
}
