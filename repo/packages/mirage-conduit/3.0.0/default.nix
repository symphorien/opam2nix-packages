world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      conduit-lwt = opamSelection.conduit-lwt;
      cstruct = opamSelection.cstruct;
      jbuilder = opamSelection.jbuilder;
      mirage-dns = opamSelection.mirage-dns;
      mirage-flow-lwt = opamSelection.mirage-flow-lwt;
      mirage-types-lwt = opamSelection.mirage-types-lwt;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      ppx_sexp_conv = opamSelection.ppx_sexp_conv;
      tls = opamSelection.tls;
      vchan = opamSelection.vchan;
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
  name = "mirage-conduit-3.0.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "mirage-conduit";
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
    sha256 = "1k6iqg6b4yvrgrqyfm7sci5z3b812j4di08g3snbckzqiacp8g1b";
    url = "https://github.com/mirage/ocaml-conduit/releases/download/v1.0.0/conduit-1.0.0.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

