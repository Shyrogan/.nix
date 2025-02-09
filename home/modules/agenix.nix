{ config, ... }: let
in {
  age.secretsDir = "${config.home.homeDirectory}/agenix";
}
