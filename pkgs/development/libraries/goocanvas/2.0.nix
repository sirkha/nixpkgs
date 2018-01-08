{ stdenv, fetchurl, gnome3, cairo, python, pkgconfig }:

stdenv.mkDerivation rec {
  majVersion = "2.0";
  version = "${majVersion}.4";
  name = "goocanvas-${version}";

  src = fetchurl {
    url = "mirror://gnome/sources/goocanvas/${majVersion}/${name}.tar.xz";
    sha256 = "c728e2b7d4425ae81b54e1e07a3d3c8a4bd6377a63cffa43006045bceaa92e90";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ gnome3.gtk cairo python];

  meta = { 
    description = "Canvas widget for GTK+ based on the the Cairo 2D library";
    homepage = http://goocanvas.sourceforge.net/;
    license = ["GPL" "LGPL"];
    platforms = stdenv.lib.platforms.unix;
  };
}
