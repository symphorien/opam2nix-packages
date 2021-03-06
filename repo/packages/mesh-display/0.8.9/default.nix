world:
let
    fetchurl = pkgs.fetchurl;
    inputs = lib.filter (dep: dep != true && dep != null)
    ([  ] ++ (lib.attrValues opamDeps));
    lib = pkgs.lib;
    opam2nix = world.opam2nix;
    opamDeps = 
    {
      configurator = opamSelection.configurator;
      graphics = opamSelection.graphics;
      jbuilder = opamSelection.jbuilder;
      mesh = opamSelection.mesh;
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
  name = "mesh-display-0.8.9";
  opamEnv = builtins.toJSON 
  {
    deps = opamDeps;
    files = null;
    name = "mesh-display";
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
    sha256 = "1k44l1yzclhydcdlzi99yml890nwp2jlixpy8pnw562lm6ys9gx8";
    url = "https://github.com/Chris00/mesh/releases/download/0.8.9/mesh-0.8.9.tbz";
  };
  unpackCmd = "tar -xf \"$curSrc\"";
}

