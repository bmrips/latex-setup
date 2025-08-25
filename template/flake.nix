{
  description = "tbd";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    latex-setup.url = "github:bmrips/latex-setup";
    latex-setup.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit.url = "github:cachix/git-hooks.nix";
    pre-commit.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {

      imports = with inputs; [
        latex-setup.flakeModule
        pre-commit.flakeModule
      ];

      systems = inputs.nixpkgs.lib.platforms.all;

      perSystem =
        { config, ... }:
        {
          packages.default = config.latex.documents;
          devShells.default = config.latex.devShell;
          latex = {
            src = ./.;
            extraPackages = _texPkgs: [ ];
          };
          pre-commit.settings.hooks = {
            check-added-large-files.enable = true;
            check-merge-conflicts.enable = true;
            check-symlinks.enable = true;
            check-vcs-permalinks.enable = true;
            chktex.enable = true;
            convco.enable = true;
            deadnix.enable = true;
            detect-private-keys.enable = true;
            mixed-line-endings.enable = true;
            nixfmt-rfc-style.enable = true;
            statix.enable = true;
            statix.settings.format = "stderr";
            trim-trailing-whitespace.enable = true;
          };
        };

    };
}
