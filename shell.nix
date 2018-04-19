let
  pkgs = import (fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-18.03.tar.gz) {};
in
  pkgs.stdenv.mkDerivation {
    name = "nippo-builder";
    src = ./.;
    buildInputs = with pkgs; [
      pandoc
      nodePackages.serve
      inotifyTools
      optipng
      tmux
    ];
    shellHook = ''
      make watch -j4
    '';
  }
