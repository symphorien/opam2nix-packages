world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      cohttp-lwt-unix = opamSelection.cohttp-lwt-unix;
      lwt_ssl = opamSelection.lwt_ssl;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      wcs-lib = opamSelection.wcs-lib;
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
  name = "wcs-api-2017-05-26.01";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "wcs-api";
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
    sha256 = "1ql0w56687bcg6xjbfnspq4rvqbv0a59zd13kycrigv99agnzqn2";
    url = "https://github.com/IBM/wcs-ocaml/archive/2017-05-26.01.tar.gz";
  };
}

