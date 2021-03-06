world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      alcotest = opamSelection.alcotest or null;
      astring = opamSelection.astring;
      base-bytes = opamSelection.base-bytes;
      cmdliner = opamSelection.cmdliner;
      cstruct = opamSelection.cstruct;
      fmt = opamSelection.fmt;
      jbuilder = opamSelection.jbuilder;
      logs = opamSelection.logs;
      lwt = opamSelection.lwt;
      mirage-channel-lwt = opamSelection.mirage-channel-lwt;
      mirage-flow-lwt = opamSelection.mirage-flow-lwt;
      mirage-kv-lwt = opamSelection.mirage-kv-lwt;
      named-pipe = opamSelection.named-pipe;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      ppx_deriving = opamSelection.ppx_deriving;
      ppx_sexp_conv = opamSelection.ppx_sexp_conv;
      ppx_tools = opamSelection.ppx_tools;
      result = opamSelection.result;
      rresult = opamSelection.rresult;
      sexplib = opamSelection.sexplib;
      win-error = opamSelection.win-error;
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
  name = "protocol-9p-0.11.3";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "protocol-9p";
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
    sha256 = "06ljf18bajwnzvc5wwwhyg59cy4ynqw4gpvn0qlh3mx9gk38sqmr";
    url = "https://github.com/mirage/ocaml-9p/releases/download/v0.11.3/protocol-9p-0.11.3.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

