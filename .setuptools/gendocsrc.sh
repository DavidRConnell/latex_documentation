#!/bin/bash

[ -d ~/.config ] || mkdir -p ~/.config/latexdocs
[ -f ~/.config/latexdocs/docsrc ] && exit 0

cat > ~/.config/docsrc <<- _EOF_
	# Document variables.
	AUTHOR=
	EMAIL=
	DOCTYPE=

	MAINFONT=
	TITLEFONT=

	NUMBERPAGES=false
	USETWOCOLUMN=false
	ADDABSTRACT=false

	# Saving and path variables.
	DOEXPORTPDF=false
	DOCPATH=
	EXPORTPATH=
	_EOF_
