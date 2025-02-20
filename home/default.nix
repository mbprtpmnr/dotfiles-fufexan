{ pkgs, inputs, colors, ... }:

# graphical session configuration
# includes programs and services that work on both Wayland and X

{
  imports = [
    ./cli.nix # base config
    ./terminals.nix
  ];

  home.packages = with pkgs; [
    # messaging
    (discord-plugged.override {
      discord-canary = (discord-canary.override rec {
        version = "0.0.130";
        src = fetchurl {
          url = "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
          sha256 = "sha256-UamSiwjR68Pfm3uyHaI871VaGwIKJ5DShl8uE3rvX+U=";
        };
      });
      plugins = [ inputs.discord-tweaks ];
    })
    discord-electron
    element-desktop
    tdesktop
    # torrents
    transmission-remote-gtk
    # misc
    libnotify
  ];

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Orchis-purple-dark-compact";
      package = (pkgs.orchis-theme.override { accentColor = "purple"; tweaks = "primary compact"; });
    };
  };

  programs = {
    firefox = {
      enable = true;
      profiles.mihai = { };
    };

    texlive = {
      enable = false;
      package = pkgs.texlive.combined.scheme-basic;
    };

    zathura = {
      enable = true;
      options = {
        recolor = true;
        recolor-darkcolor = "#${colors.fg}";
        recolor-lightcolor = "rgba(0,0,0,0)";
        default-bg = "rgba(0,0,0,0.7)";
        default-fg = "#${colors.fg}";
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 3600;
      defaultCacheTtlSsh = 3600;
      pinentryFlavor = "gnome3";
    };

    syncthing.enable = true;

    udiskie.enable = true;
  };
}
