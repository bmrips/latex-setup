\RequirePackage{bmrips/prelude}

\LoadClassWithOptions[
    10pt,
    xcolor = x11names
]{beamer}
\LoadPackage{
    bmrips/font,
    bmrips/language,
    bmrips/textflow,
    bmrips/hyperlinks.d/email,
    bmrips/miscellaneous
}

\hypersetup{
    unicode,
    bookmarksnumbered % Include section and chapter numbers in the bookmarks
}

\LoadPackage{luacolor}

\definecolor{darkred}{rgb}{0.8,0,0}
\setbeamercolor{alerted text}{fg=darkred!80!gray}

\setbeamertemplate{section in toc}[sections numbered]

% frame numbers in the lower right corner, nothing else
\setbeamercolor{navigation symbols}{
    use = structure,
    fg = structure.fg
}
\setbeamertemplate{navigation symbols}{
    \small
    \insertframenumber
    \hspace{0.3em}\vspace{1ex}
}

\setbeamercolor{block title}{
    use = structure,
    fg = white,
    bg = structure.fg!75!black
}
\setbeamercolor{block body}{
    parent = normal text,
    use = block title,
    bg = block title.bg!10!bg
}

% To set minor items in lists smaller and grey
\LoadPackage{relsize}
\newcommand*{\minor}[1]{
    \textcolor{black!50}{\smaller #1}
}
