world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      gmp-freestanding = opamSelection.gmp-freestanding;
      ocaml = opamSelection.ocaml;
      ocaml-freestanding = opamSelection.ocaml-freestanding;
      ocamlfind = opamSelection.ocamlfind;
      zarith = opamSelection.zarith;
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
  name = "zarith-freestanding-1.4.1";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = ./files;
    name = "zarith-freestanding";
    ocaml-version = world.ocamlVersion;
    spec = ./opam;
  };
  passthru = 
  {
    opamSelection = opamSelection;
  };
  prePatch = "cp -r ${./files}/* ./";
  propagatedBuildInputs = inputs;
  src = fetchurl 
  {
    sha256 = "0l36hzmfbvdai2kcgynh13vfdim5x2grnaw61fxqalyjm90c3di3";
    url = "https://forge.ocamlcore.org/frs/download.php/1574/zarith-1.4.1.tgz";
  };
}

