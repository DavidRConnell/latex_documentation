#!/bin/bash
# First arg should be where files are located
# Second arg where files should be linked

for f in $PWD/$1/*; do
	ln -s $f $2/
done
