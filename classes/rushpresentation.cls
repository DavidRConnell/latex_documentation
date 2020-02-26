\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rushpresentation}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass{beamer}
\usetheme{Madrid}

\RequirePackage{presentation}
\usefonttheme{serif}
\setmainfont{Noto Serif}
\settitlefont{Noto Sans}

\definecolor{rushgreen}{HTML}{1d6f42}
\definecolor{rushlightblue}{HTML}{436092}
\definecolor{tablegray}{gray}{0.8}
\definecolor{accentblue}{HTML}{436092}
\definecolor{accentred}{HTML}{9d4329}

\setcolor{\titlecolor}{rushgreen}
\setcolor{\tablebgcolor}{tablegray}

\setbeamercolor{palette primary}{bg=rushgreen,fg=white}
\setbeamercolor{palette secondary}{bg=rushgreen,fg=white}
\setbeamercolor{palette tertiary}{bg=rushgreen,fg=white}
\setbeamercolor{palette quaternary}{bg=rushgreen,fg=white}
\setbeamercolor{structure}{fg=rushgreen}
\setbeamercolor{section in toc}{fg=rushgreen}
\setbeamercolor{subsection in head/foot}{bg=rushlightblue,fg=white}

\hypersetup{
	linkcolor=white,
	urlcolor=rushlightblue,
	citecolor=rushlightblue
}

\setbeamertemplate{frametitle}{%
  \textbf{\titlefont\color{\titlecolor}\small\insertframetitle}\\
  {\color{black}\footnotesize\insertframesubtitle}
}
\setbeamertemplate{enumerate items}[default]
\setbeamertemplate{itemize items}[square]

