# User configuration module
{ config, lib, ... }:
{
  options = {
    me = {
      username = lib.mkOption {
        type = lib.types.str;
        description = "Your username as shown by `id -un`";
      };
      fullname = lib.mkOption {
        type = lib.types.str;
        description = "Your full name for use in Git config";
      };
      email = lib.mkOption {
        type = lib.types.str;
        description = "Your email for use in Git config";
      };
      shell = lib.mkOption {
        type = lib.types.package;
        description = "Your shell for your user";
      };
    };
  };
  config = {
    home = {
      username = config.me.username;
      enableNushellIntegration = lib.mkDefault (
        config.me.shell.pname or null == "nushell"
      );
    };
  };
}
