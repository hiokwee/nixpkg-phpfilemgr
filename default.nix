{ stdenv, fetchurl, composer, clamav }:

let
  version = "1.0.2";
  name = "phpfilemgr-${version}";
in stdenv.mkDerivation {
  inherit name;

  #custom builder
  builder = ./builder.sh;

  # Alternatively, pull composer.json from a remote repository
  #src = fetchurl {
  #  url = http://zalora.duckdns.org:31212/composer.json;
  #  sha256 = "dfd9dc3a571f9899e461033543672dbb8b9d4a584bb02c962c37aa55a76e4fff";
  #};

  inherit composer;
  inherit clamav;

  meta = {
    homepage = https://github.com/hiokwee/nixpkg-phpfilemgr;
    description = "PHP file handling class";
  };
}
