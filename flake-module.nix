self:
{ lib, flake-parts-lib, ... }:

{
  options.perSystem = flake-parts-lib.mkPerSystemOption (
    {
      config,
      options,
      pkgs,
      system,
      ...
    }:
    {
      options.latex = {
        src = lib.mkOption {
          type = lib.types.path;
          description = ''
            The source code for the documents.
          '';
          defaultText = "./.";
        };
        extraPackages = lib.mkOption {
          type = lib.types.anything;
          description = ''
            A function on the Texlive package set that returns a list of extra
            packages that will be installed into the TeX environment.
          '';
          default = _: [ ];
          defaultText = "(_: [])";
        };
        documents = lib.mkOption {
          type = lib.types.package;
          description = ''
            A derivation containing all documents that are built by the Makefile.
          '';
          readOnly = true;
        };
        devShell = lib.mkOption {
          type = lib.types.package;
          description = ''
            A development shell with Texlive installed and set up.
          '';
          readOnly = true;
        };
      };

      config = {

        latex.documents = pkgs.stdenvNoCC.mkDerivation {
          name = "documents";
          inherit (config.latex) src;
          nativeBuildInputs = [
            (pkgs.texliveBasic.withPackages (
              tpkgs: [ self.packages.${system}.default ] ++ config.latex.extraPackages tpkgs
            ))
          ];
          preBuild = "export TEXMFVAR=$(mktemp -d)";
        };

        latex.devShell =
          let
            withPreCommit = options ? pre-commit && config.pre-commit.settings.enable;
          in
          pkgs.mkShell {
            inputsFrom = [
              config.latex.documents
            ] ++ lib.optional withPreCommit config.pre-commit.devShell;
            packages = [
              pkgs.ltex-ls
              pkgs.texlab
            ];
            shellHook = ''
              TEXMFVAR=.cache/texmf-var
              mkdir -p $TEXMFVAR
              export TEXMFVAR="$(realpath "$TEXMFVAR")"
            '';
          };

      };
    }
  );
}
