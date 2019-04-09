#!/bin/bash

source .setuptools/linklocations

.setuptools/rmlinksin.sh $TEXDIR ./packages
.setuptools/rmlinksin.sh $BINDIR ./bin
