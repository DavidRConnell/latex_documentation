#!/bin/bash

source ~/.config/docsrc
[ -f $PWD/docsrc ] && source $PWD/docsrc

time latexmk -pv -xelatex -silent --interaction=nonstopmode $1
printtexerrors.sh $1

if $SAVEEXTERNALLY; then
	basepath=${$(dirname $1)//\./$PWD}
	tailfilepath=${basepath#*docs}
	cp $1.pdf ${EXTERNALLOC}${tailfilepath}.pdf
fi
