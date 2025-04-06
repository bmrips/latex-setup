{
  description = "tbd";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    latex-setup.url = "github:bmrips/latex-setup";
    latex-setup.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
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

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "i686-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem =
        { config, ... }:
        {
          packages.default = config.latex.documents;
          devShells.default = config.latex.devShell;
          pre-commit.settings.hooks = {
            check-added-large-files.enable = true;
            check-merge-conflicts.enable = true;
            check-symlinks.enable = true;
            check-vcs-permalinks.enable = true;
            convco.enable = true;
            detect-private-keys.enable = true;
            mixed-line-endings.enable = true;
            nixfmt-rfc-style.enable = true;
            trim-trailing-whitespace.enable = true;
          };
        };

    };
}
