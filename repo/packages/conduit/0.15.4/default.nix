world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      async = opamSelection.async or null;
      async_ssl = opamSelection.async_ssl or null;
      ipaddr = opamSelection.ipaddr;
      launchd = opamSelection.launchd or null;
      logs = opamSelection.logs;
      lwt = opamSelection.lwt or null;
      lwt_ssl = opamSelection.lwt_ssl or null;
      mirage-dns = opamSelection.mirage-dns or null;
      mirage-flow-lwt = opamSelection.mirage-flow-lwt or null;
      mirage-types-lwt = opamSelection.mirage-types-lwt or null;
      ocaml = opamSelection.ocaml;
      ocamlbuild = opamSelection.ocamlbuild;
      ocamlfind = opamSelection.ocamlfind;
      ppx_deriving = opamSelection.ppx_deriving;
      ppx_driver = opamSelection.ppx_driver;
      ppx_optcomp = opamSelection.ppx_optcomp;
      ppx_sexp_conv = opamSelection.ppx_sexp_conv;
      result = opamSelection.result;
      sexplib = opamSelection.sexplib;
      ssl = opamSelection.ssl or null;
      stringext = opamSelection.stringext;
      tls = opamSelection.tls or null;
      uri = opamSelection.uri;
      vchan = opamSelection.vchan or null;
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
  name = "conduit-0.15.4";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "conduit";
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
    sha256 = "1mxjqggdgq1i6fg9dmw3gk83038h2qd0a9ll487qwksb0g6y262w";
    url = "https://github.com/mirage/ocaml-conduit/archive/v0.15.4.tar.gz";
  };
}

