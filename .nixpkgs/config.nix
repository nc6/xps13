# ~/.nixpkgs/config.nix

{
  allowUnfree = true;
  
  packageOverrides = pkgs_: with pkgs_; {  # pkgs_ is the original set of packages
    all = with pkgs; buildEnv {  # pkgs is your overriden set of packages itself
      name = "all";
      paths = [
        # Web stuff
        chromium
        slack
        tor-browser-bundle-bin

        # Develpoment tools
        binutils
        dos2unix
        gcc
        git
        gnumake
        sublime3
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
        rustChannels.nightly.rust

        # System
        htop
        mosh
        nox
        p7zip
        tmate
        tmux
      ];
    };
  };
}
