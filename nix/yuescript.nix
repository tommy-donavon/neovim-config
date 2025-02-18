{
  stdenv,
  lib,
  fetchurl,
  fetchFromGitHub,
}:
let
in
# inherit (pkgs.stdenv) mkDerivation;
# inherit (pkgs) fetchFromGitHub;
stdenv.mkDerivation {
  name = "yue";
  version = "v0.27.0";

  src = fetchFromGitHub {
    owner = "IppClub";
    repo = "YueScript";
    rev = "d1878f2b8eb1644205c5e0b641fd092e8b222766";
    sha256 = "08056vf4jb2n98l5n4bif5va05nw26zmpjpaiifx49fcq2bmdcgw";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp bin/release/yue $out/bin/yue
  '';
}
