{ stdenv, composer, clamav }:

let
  version = "1.0.2";
  name = "phpfilemgr-${version}";
in stdenv.mkDerivation {
  inherit name;

  #custom builder
  builder = ./builder.sh;
  inherit composer;
  inherit clamav;

  meta = {
    homepage = https://github.com/hiokwee/Filemanager;
    description = "PHP file handling class";
  };
}
