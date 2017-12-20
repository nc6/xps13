# ~/.nixpkgs/config.nix
{ pkgs }:
{
  allowUnfree = true;

  packageOverrides = self: rec {

    haskellPackages = self.haskellPackages.override {
      overrides = hsSelf: hsSuper: {
        numhask = hsSelf.callPackage /home/nc/proj/numhask {};
        stackage2nix = hsSelf.callPackage /home/nc/proj/stackage2nix/nix/stackage2nix {};
      };
    };

    remacs = with pkgs; self.callPackage /home/nc/proj/remacs.nixpkg {
        libXaw = xorg.libXaw;
        Xaw3d = null;
        gconf = null;
        alsaLib = null;
        imagemagick = null;
        acl = null;
        gpm = null;
        rustPlatform = recurseIntoAttrs (makeRustPlatform pkgs.rustChannels.nightly);
        inherit (darwin.apple_sdk.frameworks) AppKit CoreWLAN GSS Kerberos ImageIO;
      };

    all = with self; buildEnv {
      name = "all";
      paths = [
        # Web stuff
        firefoxPackages.tor-browser
        google-chrome
        google-play-music-desktop-player
        konversation
        opera
        slack

        # Develpoment tools
        ag
        binutils
        gcc
        git
        gnumake
        gitAndTools.hub
#       remacs
        source-code-pro
        sublime3-dev
        zeal

        # Games
        steam

        # Haskell Packages
        ghc
        haskellPackages.hasktags
        haskellPackages.hindent
        haskellPackages.hlint
        haskellPackages.stackage2nix
        haskellPackages.stylish-haskell
        stack

        # Idris
        idris

        # Latex
        (texlive.combine {
          inherit (texlive) scheme-small listings glossaries mfirstuc parskip xfor;
        })
        texmaker

        # Nix tools
        nix-repl

        # Purescript
        #purescript
        #psc-package

        # R
        R

        # Rust
        pkgs.rustChannels.nightly.rust

        # System
        htop
        gnupg
        gwenview
        kdeconnect
        kgpg
        mosh
        p7zip
        remmina
        tmate
        tmux
      ];
    };
  };
}
