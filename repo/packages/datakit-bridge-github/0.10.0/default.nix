world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      asl = opamSelection.asl;
      cmdliner = opamSelection.cmdliner;
      conduit = opamSelection.conduit;
      datakit = opamSelection.datakit or null;
      datakit-client = opamSelection.datakit-client;
      datakit-github = opamSelection.datakit-github;
      datakit-server = opamSelection.datakit-server;
      fmt = opamSelection.fmt;
      github = opamSelection.github;
      github-hooks = opamSelection.github-hooks;
      hex = opamSelection.hex;
      hvsock = opamSelection.hvsock;
      jbuilder = opamSelection.jbuilder;
      logs = opamSelection.logs;
      lwt = opamSelection.lwt;
      mtime = opamSelection.mtime;
      nocrypto = opamSelection.nocrypto;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind or null;
      prometheus-app = opamSelection.prometheus-app;
      protocol-9p = opamSelection.protocol-9p;
      uri = opamSelection.uri;
      win-eventlog = opamSelection.win-eventlog;
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
  name = "datakit-bridge-github-0.10.0";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "datakit-bridge-github";
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
    sha256 = "0fkzpll4bbmwr21lk1xwzhnac9y8c3fwh83j0m73npcjassb1yqb";
    url = "https://github.com/moby/datakit/releases/download/0.10.0/datakit-0.10.0.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

