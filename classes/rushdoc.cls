\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rushdoc}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage{paperformat}

\definecolor{rushgreen}{HTML}{1d6f42}
\definecolor{rushlightblue}{HTML}{436092}
\definecolor{tablegray}{gray}{0.8}

\setcolor{\titlecolor}{rushgreen}
\setcolor{\tablebgcolor}{tablegray}

\hypersetup{
	linkcolor=rushlightblue,
	urlcolor=rushlightblue,
	citecolor=rushlightblue
}

\setmainfont{Noto Serif}
\settitlefont{Noto Sans}
\pagenumbering{gobble}
