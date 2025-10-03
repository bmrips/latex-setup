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

\usetheme[progressbar=frametitle,sectionpage=none]{moloch}

\setbeamertemplate{section in toc}[sections numbered]
\setbeamertemplate{page number in head/foot}[framenumber]

\LoadPackage{luacolor}
\definecolor{darkred}{rgb}{0.8,0,0}
\setbeamercolor{alerted text}{fg=darkred!80!gray}
