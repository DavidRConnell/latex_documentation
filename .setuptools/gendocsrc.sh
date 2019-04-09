#!/bin/bash

[ -d ~/.config ] || mkdir ~/.config

cat > ~/.config/docsrc <<- _EOF_
	AUTHOR=
	EMAIL=
	DOCTYPE=

	MAINFONT=
	TITLEFONT=

	DOEXPORTPDF=false
	DOCDIR=
	EXPORTDIR=
	_EOF_
