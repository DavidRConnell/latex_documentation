#!/bin/sh

source ./docsrc

time latexmk -pv -xelatex -silent --interaction=nonstopmode $1
./printtexerrors.sh $1

if [ $EXTERNALSAVE ]; then
	basepath=${$(dirname $1)//\./$PWD}
	tailfilepath=${basepath#*docs}
	cp $1.pdf ${EXTERNALLOC}${tailfilepath}.pdf
done
