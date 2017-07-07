# ~/.nixpkgs/config.nix
{ pkgs }:
{
  allowUnfree = true;

  packageOverrides = self: rec {
    all = with self; buildEnv {
      name = "all";
      paths = [
        # Web stuff
        firefoxPackages.tor-browser
        google-chrome
        google-play-music-desktop-player
        konversation
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

        # Purescript
        purescript
        psc-package

        # R
        R

        # Rust
        pkgs.rustChannels.beta.rust

        # System
        htop
        gnupg
        kgpg
        mosh
        p7zip
        tmate
        tmux
      ];
    };
  };
}
