world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([ (pkgs.binutils or null) (pkgs.binutils-dev or null)
        (pkgs.boost or null) (pkgs."clang-3.4" or null)
        (pkgs."dev-libs/boost" or null) (pkgs.libboost-dev or null)
        (pkgs."libclang-3.4-dev" or null) (pkgs."llvm-3.4-dev" or null)
        (pkgs."sys-devel/binutils" or null)
        (pkgs."sys-devel/clang-3.4.0-r100" or null)
        (pkgs."sys-devel/llvm-3.4.1-r2" or null) ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      ANSITerminal = opamSelection.ANSITerminal;
      base-unix = opamSelection.base-unix;
      batteries = opamSelection.batteries;
      camlp4 = opamSelection.camlp4;
      deriving = opamSelection.deriving;
      ocaml = opamSelection.ocaml;
      ocamlbuild = opamSelection.ocamlbuild;
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
  name = "clangml-0.5.2";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = ./files;
    name = "clangml";
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
    sha256 = "1vdbp014k8samdrq8vb3kfz16z5h6sr3wzgsnv9rfagbl65sva43";
    url = "https://github.com/Antique-team/clangml/archive/v0.5.2.tar.gz";
  };
}

