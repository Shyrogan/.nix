{ lib, ... }: with lib; {
  options = {
    programming = {
      rust.enable = mkEnableOption "Enable Rust programming.";
      web.enable = mkEnableOption "Enable Node programming.";
    };
  };
}
