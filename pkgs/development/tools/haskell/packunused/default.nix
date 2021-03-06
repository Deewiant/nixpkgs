# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, Cabal, filepath, haskellSrcExts, optparseApplicative
, split
}:

cabal.mkDerivation (self: {
  pname = "packunused";
  version = "0.1.1.3";
  sha256 = "1f8lc9lzqwyzdz1j8czdan04d4bj393xk1rxfhr39j4a56qskp1c";
  isLibrary = false;
  isExecutable = true;
  buildDepends = [
    Cabal filepath haskellSrcExts optparseApplicative split
  ];
  jailbreak = true;
  meta = {
    homepage = "https://github.com/hvr/packunused";
    description = "Tool for detecting redundant Cabal package dependencies";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
