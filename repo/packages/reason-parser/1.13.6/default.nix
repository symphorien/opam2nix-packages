world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      menhir = opamSelection.menhir;
      merlin-extend = opamSelection.merlin-extend;
      ocaml = opamSelection.ocaml;
      ocaml-migrate-parsetree = opamSelection.ocaml-migrate-parsetree;
      ocamlfind = opamSelection.ocamlfind;
      ppx_tools_versioned = opamSelection.ppx_tools_versioned;
      result = opamSelection.result;
      topkg = opamSelection.topkg;
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
  name = "reason-parser-1.13.6";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "reason-parser";
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
    sha256 = "0zha52nkj1mvnmk44njncrm55l3lzz9favqzg65ns0c76mld63kn";
    url = "https://github.com/facebook/reason/releases/download/1.13.6/reason-parser-1.13.6.tar.gz";
  };
}

