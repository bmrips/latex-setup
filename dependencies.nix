pkgs: { texDeps ? _: [] }:

with pkgs; [

  python3Packages.pygments

  (texliveBasic.withPackages (tpkgs: with tpkgs; [
    amscls
    amsfonts
    beamer
    biber
    biblatex
    booktabs
    csquotes
    ellipsis
    enumitem
    etoolbox
    fancyvrb
    fontspec
    geometry
    hyperref
    hyphen-english
    hyphen-german
    inconsolata
    koma-script
    lastpage
    latexmk
    libertine
    luacolor
    luatexbase
    mathdots
    mathtools
    mdframed
    microtype
    minted
    ncctools # extdash
    needspace
    newfloat
    newtx
    oberdiek # ifdraft, iflang
    polyglossia
    relsize
    selnolig
    setspace
    tikz-cd
    todonotes
    tools # multicol, varioref
    txfonts # required by newtx
    upquote
    xcolor
    xurl
    zref
  ] ++ texDeps tpkgs))

]
