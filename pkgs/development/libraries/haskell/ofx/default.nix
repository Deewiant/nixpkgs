# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, parsec, time }:

cabal.mkDerivation (self: {
  pname = "ofx";
  version = "0.4.0.2";
  sha256 = "0vhr2pydnfc0ma7w1qdn5p5yylzlj3n47fnm16mlbhlb5ydnjshg";
  buildDepends = [ parsec time ];
  jailbreak = true;
  meta = {
    homepage = "http://www.github.com/massysett/ofx";
    description = "Parser for OFX data";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})