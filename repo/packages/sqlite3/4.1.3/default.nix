world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([ (pkgs."database/sqlite3" or null) (pkgs.libsqlite3-dev or null)
        (pkgs.sqlite-dev or null) (pkgs.sqlite-devel or null)
        (pkgs.sqlite3 or null) (pkgs.sqlite3-devel or null) ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      conf-pkg-config = opamSelection.conf-pkg-config;
      ocaml = opamSelection.ocaml;
      ocamlbuild = opamSelection.ocamlbuild;
      ocamlfind = opamSelection.ocamlfind;
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
  name = "sqlite3-4.1.3";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "sqlite3";
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
    sha256 = "1g4qxhsihi3p97ay5cxmy4mwlqw1gkdxnpvnp4ffaji16zypq5vq";
    url = "https://github.com/mmottl/sqlite3-ocaml/releases/download/v4.1.3/sqlite3-ocaml-4.1.3.tar.gz";
  };
}

