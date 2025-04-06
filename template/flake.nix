{
  description = "tbd";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    latex-setup = {
      url = "github:bmrips/latex-setup";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pre-commit.follows = "pre-commit";
    };
    pre-commit = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {

      imports = with inputs; [ pre-commit.flakeModule ];

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "i686-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem =
        {
          config,
          inputs',
          pkgs,
          self',
          ...
        }:
        {

          packages.default = pkgs.stdenvNoCC.mkDerivation {
            name = "tbd";
            src = ./.;
            nativeBuildInputs = [
              (pkgs.texliveBasic.withPackages (_: [ inputs'.latex-setup.packages.default ]))
            ];
            preBuild = "export TEXMFVAR=$(mktemp -d)";
          };

          devShells.default = pkgs.mkShell {
            inputsFrom = [ self'.packages.default ];
            packages = config.pre-commit.settings.enabledPackages ++ [
              config.pre-commit.settings.package
              pkgs.ltex-ls
              pkgs.texlab
            ];
            shellHook =
              config.pre-commit.installationScript
              + ''
                TEXMFVAR=.cache/texmf-var
                mkdir -p $TEXMFVAR
                export TEXMFVAR="$(realpath "$TEXMFVAR")"
              '';
          };

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
