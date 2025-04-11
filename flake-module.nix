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
      let
        TEXMFHOME = ".cache";
        TEXMFVAR = "${TEXMFHOME}/texmf-var";
      in
      {
        options.latex = {
          extraPackages = mkOption {
            type = types.anything;
            description = ''
              A function on the Texlive package set that returns a list of extra
              packages that will be installed into the TeX environment.
            '';
            default = _: [ ];
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
            src = ./.;
            nativeBuildInputs = [
              (pkgs.texliveBasic.withPackages (
                tpkgs: [ self.packages.${system}.default ] ++ config.latex.extraPackages tpkgs
              ))
            ];
            env = { inherit TEXMFHOME TEXMFVAR; };
            preBuild = "mkdir -p $TEXMFVAR";
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
              env = { inherit TEXMFHOME TEXMFVAR; };
              shellHook =
                ''
                  mkdir -p $TEXMFVAR
                  [[ -e ./.gitignore ]] || cp ${./template/gitignore} ./.gitignore
                  [[ -e ./.latexmkrc ]] || cp ${./template/latexmkrc} ./.latexmkrc
                  [[ -e ./Makefile ]] || cp ${./template/Makefile} ./Makefile
                ''
                + optionalString withPreCommit config.pre-commit.installationScript;
            };

        };
      }
    );
  };
}
