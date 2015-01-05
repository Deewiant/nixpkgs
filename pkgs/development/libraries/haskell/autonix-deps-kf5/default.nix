# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, autonixDeps, conduit, filepath, lens, mtl, transformers }:

cabal.mkDerivation (self: {
  pname = "autonix-deps-kf5";
  version = "0.1.0.0";
  sha256 = "04lhp4gnzpa5r2wlbvm29ig87335b5ahnw19wkaychv54n0505xj";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    autonixDeps conduit filepath lens mtl transformers
  ];
  meta = {
    description = "Generate dependencies for KDE 5 Nix expressions";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})