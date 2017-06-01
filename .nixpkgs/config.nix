# ~/.nixpkgs/config.nix

{
  packageOverrides = pkgs_: with pkgs_; {  # pkgs_ is the original set of packages
    all = with pkgs; buildEnv {  # pkgs is your overriden set of packages itself
      name = "all";
      paths = [
        dos2unix
        ghc
        git
        graphviz
        haskellPackages.hindent
        haskellPackages.hlint
#       haskellPackages.hsdev
        haskellPackages.stylish-haskell
        htop
        mosh
        nox
        p7zip
#       pijul
        rustup
        stack
        stoken
        tmate
        tmux
      ];
    };
  };
}
