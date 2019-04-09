#!/bin/bash

function help {
	cat <<- _EOF_
		See README for usage.
		_EOF_
}

if [ $# != 1 ]; then
	help
	exit 1
fi

for f in $PWD/python/*; do
	ln -s $f $1/${f#*packages/}
done
