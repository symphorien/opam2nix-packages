world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      ocaml = opamSelection.ocaml;
      ocamlbuild = opamSelection.ocamlbuild;
      ocamlfind = opamSelection.ocamlfind;
      ppx_compare = opamSelection.ppx_compare;
      ppx_core = opamSelection.ppx_core;
      ppx_driver = opamSelection.ppx_driver;
      ppx_here = opamSelection.ppx_here;
      ppx_sexp_conv = opamSelection.ppx_sexp_conv;
      ppx_tools = opamSelection.ppx_tools;
      ppx_type_conv = opamSelection.ppx_type_conv;
      sexplib = opamSelection.sexplib;
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
  name = "ppx_assert-113.24.00";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "ppx_assert";
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
    sha256 = "18qd0kq69zdg4gnijn3c4v624g8538445nj005xnzzc5g8kjwa1a";
    url = "https://ocaml.janestreet.com/ocaml-core/113.24/files/ppx_assert-113.24.00.tar.gz";
  };
}

