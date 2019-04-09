#!/bin/bash

TEXLOC=$(kpsewhich -expand-var '$TEXMFHOME') || false
BINLOC=~/bin

function missinglatex {
	cat <<- _EOF_
		Package requires LaTeX to be installed
		_EOF_

	exit 1
}

[ -d $TEXLOC ] || missinglatex
[ -d $TEXLOC/tex/latex ] || mkdir -p $TEXLOC/tex/latex
[ -d $BINLOC ] || mkdir ~/bin


for f in $PWD/packages/*; do
	ln -s $f $TEXLOC/tex/latex/${f#*packages/}
done

for f in $PWD/bin/*; do
	ln -s $f $BINLOC/${f#*bin/}
done

./.setuptools/gendocsrc.sh
