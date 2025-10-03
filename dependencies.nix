pkgs:

{

  propagatedBuildInputs = [ pkgs.python3Packages.pygments ];

  passthru.tlDeps = with pkgs.texlive; [
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
    listings
    luacolor
    luatexbase
    mathdots
    mathtools
    mdframed
    microtype
    moloch
    ncctools # extdash
    needspace
    newfloat
    newtx
    oberdiek # ifdraft, iflang
    pgfopts # listings
    polyglossia
    relsize
    selnolig
    setspace
    stmaryrd
    tikz-cd
    todonotes
    tools # multicol, varioref
    txfonts # required by newtx
    upquote
    xcolor
    xurl
    zref
  ];

}
