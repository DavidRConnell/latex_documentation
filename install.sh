#!/bin/bash

source .setuptools/linklocations
[ -d $TEXLOC/tex/latex ] || mkdir -p $TEXLOC/tex/latex

ln -s $PWD/packages/* $TEXDIR
ln -s $PWD/bin/* $BINDIR

.setuptools/gendocsrc.sh
