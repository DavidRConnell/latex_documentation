#!/bin/bash

source .setuptools/linklocations

[ -d $TEXDIR ] || mkdir -p $TEXDIR

ln -s $PWD/packages/* $TEXDIR
ln -s $PWD/bin/* $BINDIR

.setuptools/gendocsrc.sh
