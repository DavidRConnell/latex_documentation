#!/bin/bash

[ -d ~/.config ] || mkdir ~/.config
[ -f ~/.config/docsrc ] && exit 0

cat > ~/.config/docsrc <<- _EOF_
	AUTHOR=
	EMAIL=
	DOCTYPE=

	MAINFONT=
	TITLEFONT=

	NUMBERPAGES=false
	USETWOCOLUMN=false
	ADDABSTRACT=false

	DOEXPORTPDF=false
	DOCDIR=
	EXPORTDIR=
	_EOF_
