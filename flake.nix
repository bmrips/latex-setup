{
  description = "My personal LaTeX setup";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    pre-commit.url = "github:bmrips/git-hooks.nix";
    pre-commit.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {

      imports = with inputs; [ pre-commit.flakeModule ];

      flake.templates.default = {
        description = "A LaTeX document with my setup.";
        path = ./template;
      };

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
          ...
        }:
        {

          packages.default = pkgs.stdenvNoCC.mkDerivation (
            {
              pname = "bmrips-latex-setup";
              version = "1.0.0";
              outputs = [ "tex" ];
              src = ./.;
              nativeBuildInputs = [
                # multiple-outputs.sh fails if $out is not defined
                (pkgs.writeShellScript "force-tex-output.sh" ''
                  out="''${tex-}"
                '')
              ];
              installPhase = ''
                runHook preInstall
                tgt="$tex/tex/latex"
                mkdir -p $tgt
                cp -r src/ $tgt/bmrips
                runHook postInstall
              '';
            }
            // import ./dependencies.nix pkgs
          );

          devShells.default = config.pre-commit.devShell;

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
            typos.enable = true;
          };

        };

    };
}
