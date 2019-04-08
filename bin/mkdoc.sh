#!/bin/sh

source ./docsrc

mkdir $1
mkdir $1/sections

sed "s/\_/\\\_/g" > $1/$1.tex << _EOF_
\documentclass{article}

\usepackage{documentation}

\setmainfont[Ligatures=TeX]{$MAINFONT}
\setsansfont[Ligatures=TeX]{$MAINFONT}

\title{$2}
\author{$AUTHOR \\\\ email:
	\href{mailto:$EMAIL}{$EMAIL}}

\begin{document}
	\pagenumbering{gobble}
	\maketitle

\end{document}
_EOF_
