#!/bin/bash

source ~/.config/docsrc
[ -f $PWD/docsrc ] && source $PWD/docsrc

projname="$1"
shift
title="$@"

mkdir $projname
mkdir $projname/sections

sed "s/\_/\\\_/g" > $projname/$projname.tex << _EOF_
\documentclass{article}

\usepackage{documentation}

\setmainfont{$MAINFONT}
\settitlefont{$TITLEFONT}

\title{$title}
\author{$AUTHOR \\\\ email:
	\href{mailto:$EMAIL}{$EMAIL}}

\begin{document}
	\pagenumbering{gobble}
	\maketitle

\end{document}
_EOF_
