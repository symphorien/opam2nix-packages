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
      cohttp = opamSelection.cohttp;
      crunch = opamSelection.crunch;
      irmin = opamSelection.irmin;
      irmin-git = opamSelection.irmin-git or null;
      irmin-mem = opamSelection.irmin-mem or null;
      jbuilder = opamSelection.jbuilder;
      mtime = opamSelection.mtime or null;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      webmachine = opamSelection.webmachine;
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
  name = "irmin-http-1.3.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "irmin-http";
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

