\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rushpresentation}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{beamer}
\usetheme{Madrid}

\RequirePackage{presentation}

\definecolor{rushgreen}{HTML}{1d6f42}
\definecolor{rushlightblue}{HTML}{436092}
\definecolor{tablegray}{gray}{0.8}

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
	linkcolor=rushlightblue,
	urlcolor=rushlightblue,
	citecolor=rushlightblue
}

\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{frametitle}{\color{\titlecolor}\textbf{\small\insertframetitle}}
