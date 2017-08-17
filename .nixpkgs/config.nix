# ~/.nixpkgs/config.nix
{ pkgs }:
{
  allowUnfree = true;

  packageOverrides = self: rec {

    haskellPackages = self.haskellPackages.override {
      overrides = hsSelf: hsSuper: {
        numhask = hsSelf.callPackage /home/nc/proj/numhask {};
      };
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
        binutils
        gcc
        git
        gnumake
        gitAndTools.hub
        sublime3-dev
        zeal

        # Games
        steam

        # Haskell Packages
        ghc
        haskellPackages.hindent
        haskellPackages.hlint
#        haskellPackages.hsdev
        haskellPackages.stylish-haskell
        stack

        # Nix tools
        nix-repl

        # Purescript
#       purescript
        psc-package

        # R
        R

        # Rust
        pkgs.rustChannels.beta.rust

        # System
        htop
        gnupg
        gwenview
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
