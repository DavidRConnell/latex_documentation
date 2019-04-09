#!/bin/bash

[ -d ~/.config ] || mkdir ~/.config

cat > ~/.config/docsrc <<- _EOF_
	AUTHOR=
	EMAIL=
	DOCTYPE=

	MAINFONT=
	TITLEFONT=

	DOEXPORTPDF=false
	EXPORTLOC=
	_EOF_
