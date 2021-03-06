world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      conf-pkg-config = opamSelection.conf-pkg-config;
      ocaml = opamSelection.ocaml;
      ocaml-src = opamSelection.ocaml-src;
      ocamlfind = opamSelection.ocamlfind;
      solo5-kernel-muen = opamSelection.solo5-kernel-muen or null;
      solo5-kernel-ukvm = opamSelection.solo5-kernel-ukvm or null;
      solo5-kernel-virtio = opamSelection.solo5-kernel-virtio or null;
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
  name = "ocaml-freestanding-0.2.3";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "ocaml-freestanding";
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
    sha256 = "0359q6c50xa96hzma55mcsbvp9ilkhyjk2p8czdw7rc5s5044j9c";
    url = "https://github.com/mirage/ocaml-freestanding/archive/v0.2.3.tar.gz";
  };
}

