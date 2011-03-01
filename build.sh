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

# CTAN uploads generally don't have version numbers on them, and are flat:
rm -f ${CLASS}.zip
zip ${CLASS}.zip ${DISTFILES}
# But uploads anywhere else do, and are nested:
rm -rf ${CLASS}-${VERSION}
mkdir ${CLASS}-${VERSION}/
cp ${DISTFILES} ${CLASS}-${VERSION}/
zip -r ${CLASS}-${VERSION}.zip ${CLASS}-${VERSION}/
rm -rf ${CLASS}-${VERSION}
echo "Auto-detected version is: ${VERSION}"
