#!/bin/bash
# First arg should be location of links
# Second arg should be location of original files

for f in $PWD/$2/*; do
	l=$1/${f#*$2/}
	if [[ $(readlink $l) == $f ]]; then
		rm $l
	fi
done
