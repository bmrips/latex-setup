self:
{ lib, flake-parts-lib, ... }:

let
  inherit (lib)
    mkOption
    optionals
    optionalString
    types
    ;

in
{
  options = {
    perSystem = flake-parts-lib.mkPerSystemOption (
      {
        config,
        options,
        pkgs,
        system,
        ...
      }:
      {
        options.latex = {
          src = mkOption {
            type = types.path;
            description = ''
              The source code for the documents.
            '';
            defaultText = "./.";
          };
          extraPackages = mkOption {
            type = types.anything;
            description = ''
              A function on the Texlive package set that returns a list of extra
              packages that will be installed into the TeX environment.
            '';
            default = (_: [ ]);
            defaultText = "(_: [])";
          };
          documents = mkOption {
            type = types.package;
            description = ''
              A derivation containing all documents that are built by the Makefile.
            '';
            readOnly = true;
          };
          devShell = mkOption {
            type = types.package;
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
              withPreCommit = options ? pre-commit;
            in
            pkgs.mkShell {
              inputsFrom = [ config.packages.default ];
              packages =
                [
                  pkgs.ltex-ls
                  pkgs.texlab
                ]
                ++ optionals withPreCommit (
                  config.pre-commit.settings.enabledPackages ++ [ config.pre-commit.settings.package ]
                );
              shellHook =
                ''
                  TEXMFVAR=.cache/texmf-var
                  mkdir -p $TEXMFVAR
                  export TEXMFVAR="$(realpath "$TEXMFVAR")"
                ''
                + optionalString withPreCommit config.pre-commit.installationScript;
            };

        };
      }
    );
  };
}
