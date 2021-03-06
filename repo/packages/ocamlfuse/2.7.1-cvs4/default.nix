world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([ (pkgs."Caskroom/cask/osxfuse" or null) (pkgs.fuse-dev or null)
        (pkgs.fuse-devel or null) (pkgs.libfuse-dev or null) ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      base-bigarray = opamSelection.base-bigarray;
      base-threads = opamSelection.base-threads;
      base-unix = opamSelection.base-unix;
      camlidl = opamSelection.camlidl;
      ocaml = opamSelection.ocaml;
      ocamlfind = opamSelection.ocamlfind;
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
  name = "ocamlfuse-2.7.1-cvs4";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "ocamlfuse";
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
    sha256 = "0kr9zdpfh7nj3ib0b7ddmln2b9ham41d2nvac30s7h6zpa9nb7c5";
    url = "https://forge.ocamlcore.org/frs/download.php/1663/ocamlfuse-2.7.1-cvs4.tar.gz";
  };
}

