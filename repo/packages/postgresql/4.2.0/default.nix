world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([ (pkgs."database/postgresql96-client" or null) (pkgs.libpq-dev or null)
        (pkgs.postgresql or null) (pkgs.postgresql-dev or null)
        (pkgs.postgresql-devel or null) (pkgs.postgresql96 or null) ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      base = opamSelection.base;
      base-bytes = opamSelection.base-bytes;
      configurator = opamSelection.configurator;
      jbuilder = opamSelection.jbuilder;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      stdio = opamSelection.stdio;
    };
    opamSelection = world.opamSelection;
    pkgs = world.pkgs;
in
pkgs.stdenv.mkDerivation 
{
  buildInputs = inputs;
  buildPhase = "${opam2nix}/bin/opam2nix invoke build";
  configurePhase = "true";
  installPhase = "${opam2nix}/bin/opam2nix invoke install";
  name = "postgresql-4.2.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "postgresql";
    ocaml-version = world.ocamlVersion;
    spec = ./opam;
  };
  passthru = 
  {
    opamSelection = opamSelection;
  };
  propagatedBuildInputs = inputs;
  src = fetchurl 
  {
    sha256 = "0qgdni9ac9nvjf1kp8lg59ysby1ncgvnd1x7wxhdjqrl16wrmhbb";
    url = "https://github.com/mmottl/postgresql-ocaml/releases/download/4.2.0/postgresql-4.2.0.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

