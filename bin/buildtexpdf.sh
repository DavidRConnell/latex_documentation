#!/bin/bash

source ~/.config/docsrc
[ -f ../docsrc ] && source ../docsrc

time latexmk -pv -xelatex -silent --interaction=nonstopmode $1
printtexerrors.sh $1

if $DOEXPORTPDF; then
	basepath=${$(dirname $1)//\./$PWD}
	tailfilepath=${basepath#*$DOCDIR}
	cp $1.pdf ${EXPORTDIR}${tailfilepath}.pdf
fi
