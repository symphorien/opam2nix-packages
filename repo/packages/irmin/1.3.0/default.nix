world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      astring = opamSelection.astring;
      cstruct = opamSelection.cstruct;
      fmt = opamSelection.fmt;
      hex = opamSelection.hex;
      jbuilder = opamSelection.jbuilder;
      jsonm = opamSelection.jsonm;
      logs = opamSelection.logs;
      lwt = opamSelection.lwt;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      ocamlgraph = opamSelection.ocamlgraph;
      result = opamSelection.result;
      uri = opamSelection.uri;
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
  name = "irmin-1.3.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "irmin";
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
    sha256 = "1cfwbg0xpavp25wnyyj66x1mnb7xb8kj3dajfafnskn3xmyyzapy";
    url = "https://github.com/mirage/irmin/releases/download/1.3.0/irmin-1.3.0.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

