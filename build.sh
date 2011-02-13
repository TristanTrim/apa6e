#!/bin/sh

LATEX=pdflatex
CLASS=apa6e
DISTFILES="${CLASS}.dtx ${CLASS}.ins ${CLASS}.pdf ${CLASS}.cls README"

VERSION=$(grep '^ *\[..../../..' ${CLASS}.dtx | python -c 'import sys; print sys.stdin.read().split()[1]')

# Docs
$LATEX ${CLASS}.dtx
makeindex -s gind.ist -o ${CLASS}.ind ${CLASS}.idx
makeindex -s gglo.ist -o ${CLASS}.gls ${CLASS}.glo
$LATEX ${CLASS}.dtx
# The .cls file
rm -f ${CLASS}.cls
$LATEX ${CLASS}.ins

# CTAN uploads generally don't have version numbers on them:
rm -f ${CLASS}.zip
zip ${CLASS}.zip ${DISTFILES}
# But uploads anywhere else do:
zip ${CLASS}-${VERSION}.zip ${DISTFILES}
echo "Auto-detected version is: ${VERSION}"
