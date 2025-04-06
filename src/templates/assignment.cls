\RequirePackage{bmrips/prelude}

\LoadClassWithOptions[
    footsepline,
    headsepline,
    headlines = 3
]{scrarticle}
\LoadPackage{
    bmrips/font,
    bmrips/language,
    bmrips/textflow,
    bmrips/hyperlinks,
    bmrips/miscellaneous,
    bmrips/math
}

% Head holds university, course, author and title, page number as foot
\LoadPackage[
    footsepline,
    headsepline
]{scrlayer-scrpage}
\LoadPackage{lastpage}
\addtokomafont{pagehead}{\normalshape}
\addtokomafont{pagefoot}{\normalshape}
\cfoot{\IfLanguageName{german}
    {Seite:~\thepage~von~\pageref{LastPage}} % German
    {Page:~\thepage~of~\pageref{LastPage}}}  % English

\def\@university{~}
\def\@course{~}
\newcommand*{\university}[1]{
    \def\@university{#1}
}
\newcommand*{\course}[1]{
    \def\@course{#1}
}

\ihead{\@university\\\@course}
\chead{\large\textbf{\@title}}
\ohead{\@author}
