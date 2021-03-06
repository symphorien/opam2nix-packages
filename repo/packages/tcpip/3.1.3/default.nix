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
      cstruct = opamSelection.cstruct;
      cstruct-lwt = opamSelection.cstruct-lwt;
      duration = opamSelection.duration;
      fmt = opamSelection.fmt;
      io-page = opamSelection.io-page;
      ipaddr = opamSelection.ipaddr;
      logs = opamSelection.logs;
      lwt = opamSelection.lwt;
      mirage-clock = opamSelection.mirage-clock;
      mirage-clock-lwt = opamSelection.mirage-clock-lwt;
      mirage-clock-unix = opamSelection.mirage-clock-unix or null;
      mirage-flow = opamSelection.mirage-flow or null;
      mirage-net = opamSelection.mirage-net;
      mirage-net-lwt = opamSelection.mirage-net-lwt;
      mirage-profile = opamSelection.mirage-profile;
      mirage-protocols = opamSelection.mirage-protocols;
      mirage-protocols-lwt = opamSelection.mirage-protocols-lwt;
      mirage-random = opamSelection.mirage-random;
      mirage-stack-lwt = opamSelection.mirage-stack-lwt;
      mirage-time-lwt = opamSelection.mirage-time-lwt;
      mirage-vnetif = opamSelection.mirage-vnetif or null;
      mirage-xen = opamSelection.mirage-xen or null;
      ocaml = opamSelection.ocaml;
      ocamlbuild = opamSelection.ocamlbuild;
      ocamlfind = opamSelection.ocamlfind;
      pcap-format = opamSelection.pcap-format or null;
      ppx_tools = opamSelection.ppx_tools;
      randomconv = opamSelection.randomconv;
      result = opamSelection.result;
      rresult = opamSelection.rresult;
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
  name = "tcpip-3.1.3";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "tcpip";
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
    sha256 = "0kbn9b4rgdlkv7559m6602sbx8drb5s5vzza34gz26rxn4ybvyjr";
    url = "https://github.com/mirage/mirage-tcpip/archive/v3.1.3.tar.gz";
  };
}

