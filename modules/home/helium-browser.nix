{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.helium;
  pname = "helium-browser";
  version = "0.5.6.1";
  src = pkgs.fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
    hash = "sha256-J1hTquA47gim0H7TFMM+JabY5YRcL5snJTpM/elN1zI=";
  };
  content = pkgs.appimageTools.extractType2 {inherit pname version src;};
in {
  options.programs.helium.enable = mkEnableOption "Helium";
  config.home.packages = optionals cfg.enable [
    (pkgs.appimageTools.wrapType2 {
      inherit pname version src;
      extraInstallCommands = ''
        ls -la ${content}
        install -m 444 -D ${content}/helium.desktop -t $out/share/applications
        substituteInPlace $out/share/applications/helium.desktop \
          --replace-fail 'Exec=AppRun' 'Exec=helium-browser'
        cp -r ${content}/usr/share/icons $out/share
      '';
      meta = {
        description = "Best privacy and unbiased ad-blocking by default.";
        platforms = ["x86_64-linux"];
      };
    })
  ];
}
