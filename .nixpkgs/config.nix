# ~/.nixpkgs/config.nix
{ pkgs }:
{
  allowUnfree = true;

  packageOverrides = self: rec {
    all = with self; buildEnv {
      name = "all";
      paths = [
        # Web stuff
        google-chrome
        slack
        tor-browser-bundle-bin

        # Develpoment tools
        binutils
        dos2unix
        gcc
        git
        gnumake
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

        # Rust
        pkgs.rustChannels.nightly.rust

        # System
        htop
        mosh
        p7zip
        tmate
        tmux
      ];
    };
  };
}
