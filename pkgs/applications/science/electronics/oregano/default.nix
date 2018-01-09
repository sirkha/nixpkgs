{stdenv, pkgconfig, fetchgit, gnome3, glib, goocanvas, groff
, gsettings_desktop_schemas, libxml2, intltool, python3, waf, makeWrapper}:
stdenv.mkDerivation rec {
  version = "v0.84.21";
  name = "oregano-${version}";

  src = fetchgit {
    url = "git://github.com/drahnr/oregano";
    rev = "refs/tags/${version}";
    sha256 = "1y4pskcf595llkf22ggcj26p651i6s4x2x8qn6hkd2syip89flj5";
  };
  
  nativeBuildInputs = [
    pkgconfig
    intltool
    makeWrapper
  ];
  
  buildInputs = [
    gnome3.gtk
    glib
    gnome3.gtksourceview
    gsettings_desktop_schemas
    goocanvas
    groff
    libxml2
    python3
  ];
  
  NIX_CFLAGS_COMPILE = "-I${glib.dev}/include/gio-unix-2.0";

  buildPhase = ''
    ./waf configure build --release --prefix="$out"
  '';

  installPhase = ''
    ./waf install
    for f in "$out"/bin/*; do
      wrapProgram "$f" --prefix XDG_DATA_DIRS : "$out/share/gsettings-schemas/$name/:$GSETTINGS_SCHEMAS_PATH"
    done
  '';

  meta = with stdenv.lib; {
    description = "An electrical engineering tool";
    longDescription = ''
      oregano is an application for schematic capture and simulation
      of electronic circuits. The actual simulation is performed by 
      Berkeley Spice, GNUcap or the new generation ngspice.
    '';
    homepage = "https://github.com/drahnr/oregano";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
