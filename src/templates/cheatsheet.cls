\RequirePackage{bmrips/prelude}

\LoadClassWithOptions{scrarticle}

\LoadPackage{
    bmrips/font,
    bmrips/language,
    bmrips/hyperlinks,
    bmrips/miscellaneous,
    bmrips/textflow
}

\LoadPackage[
    top    = 6mm,
    bottom = 6mm,
    left   = 6mm,
    right  = 6mm,
    landscape
]{geometry}

\pagestyle{empty}

\setlength{\parindent}{0pt}

% Section use less space.
\renewcommand*{\section}{\@startsection%
    {section}% name
    {1}% level
    {0mm}% indent
    {-1.75ex plus -0.5ex minus -0.2ex}% beforeskip
    {1.15ex plus 0.2ex}% afterskip
    {\usekomafont{disposition}\usekomafont{section}\large}% style
}

% Mini-sections instead of subsections.
\renewcommand*{\subsection}{\minisec}

% Less space around display math.  Since the default `\normalsize` at the begin of the document
% resets these skips, they also have to be the set at the begin of the document.
\AtBeginDocument{
    \setlength{\abovedisplayskip}{4pt plus 1pt minus 1pt}
    \setlength{\belowdisplayskip}{4pt plus 1pt minus 1pt}
    \setlength{\abovedisplayshortskip}{0pt plus 1pt minus 1pt}
    \setlength{\belowdisplayshortskip}{0pt plus 1pt minus 1pt}
}

% No vertical space and less indent in lists.
\setlist{
    nosep,
    leftmargin = 1.2em
}

% Split the document into five columns
\LoadPackage{multicol}
\AtBeginDocument{
    \begin{multicols*}{5}
}
\AtEndDocument{
    \vfill
    \end{multicols*}
}
