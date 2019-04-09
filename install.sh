#!/bin/bash

source .setuptools/linklocations
[ -d $TEXLOC/tex/latex ] || mkdir -p $TEXLOC/tex/latex

.setuptools/lncontents.sh packages $TEXDIR
.setuptools/lncontents.sh bin $BINDIR
.setuptools/gendocsrc.sh
