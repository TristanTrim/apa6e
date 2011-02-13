#!/bin/sh

LATEX=pdflatex
CLASS=apa6e

# Docs
$LATEX ${CLASS}.dtx
makeindex -s gind.ist -o ${CLASS}.ind ${CLASS}.idx
makeindex -s gglo.ist -o ${CLASS}.gls ${CLASS}.glo
$LATEX ${CLASS}.dtx
# The .cls file
rm -f ${CLASS}.cls
$LATEX ${CLASS}.ins
