{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    xkb = {
      layout = "fr";
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  programs.dconf.enable = true;
  environment = {
    systemPackages = with pkgs; [ adwaita-icon-theme ];
    gnome.excludePackages = with pkgs; [
      gnome-music gnome-chess gnome-maps gnome-music gnome-contacts
      gnome-boxes gnome-calendar gnome-calculator gnome-nibbles
      gnome-mines gnome-notes

      evince
      epiphany
      yelp
      geary
      seahorse
      gedit
    ];
  };
}
