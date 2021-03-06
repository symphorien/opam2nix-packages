world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      async = opamSelection.async;
      async_extended = opamSelection.async_extended;
      cohttp-async = opamSelection.cohttp-async;
      core = opamSelection.core;
      cryptokit = opamSelection.cryptokit;
      jbuilder = opamSelection.jbuilder;
      nocrypto = opamSelection.nocrypto;
      ocaml = opamSelection.ocaml;
      ocaml-inifiles = opamSelection.ocaml-inifiles;
      ocamlfind = opamSelection.ocamlfind or null;
      ounit = opamSelection.ounit;
      ppx_protocol_conv = opamSelection.ppx_protocol_conv;
      xml-light = opamSelection.xml-light;
      yojson = opamSelection.yojson;
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
  name = "aws-s3-1.1.1";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "aws-s3";
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
    sha256 = "0sdf6y5zn1bx2mymrzfyqjb5wg8lsxls7fdr055x22cn97spjkqi";
    url = "https://github.com/andersfugmann/aws-s3/archive/1.1.1.tar.gz";
  };
}

