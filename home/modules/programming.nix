{ lib, config, pkgs, ... }: with lib; let
  rust = config.programming.rust;
  web = config.programming.web;
in
{
  options = {
    programming = {
      rust.enable = mkEnableOption "Enable Rust programming.";
      web.enable = mkEnableOption "Enable Node programming.";
    };
  };
  config.home.packages = with pkgs; optionals rust.enable [ cargo rustc clippy rust-analyzer ];
}
