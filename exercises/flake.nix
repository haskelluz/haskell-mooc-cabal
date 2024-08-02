{
  description = "Haskell MOOC: Cabal Edition";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.default = pkgs.mkShell ({
        buildInputs = with pkgs; [
          haskell.compiler.ghc94
          cabal-install
          (haskell-language-server.override { supportedGhcVersions = [ "94" ]; })
          haskellPackages.cabal-fmt
          haskellPackages.fourmolu
          libz
        ];
      });
    }
  );
}
