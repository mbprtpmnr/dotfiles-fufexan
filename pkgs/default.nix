{ inputs }:
inputs.nixpkgs.lib.composeExtensions
  inputs.osu-nix.overlay
  (final: prev: {
    discord-electron = prev.callPackage ./discord {
      branch = "stable";
      pkgs = prev;
    };

    kakoune-cr = prev.callPackage ./kakoune.cr { inherit (inputs) kakoune-cr; };

    picom-jonaburg = prev.picom.overrideAttrs (
      old: { src = inputs.picom-jonaburg; }
    );

    rocket-league = prev.callPackage ./rocket-league {
      wine = prev.wine-tkg;
      inherit (prev) winestreamproxy;
    };

    technic-launcher = prev.callPackage ./technic-launcher { };
  })
