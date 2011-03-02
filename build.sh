#!/bin/sh

LATEX=pdflatex
CLASS=apa6e
# As per email from Robin Fairbairns on 2011-03-01, they don't want
# the .cls file (as a generated file) uploaded to the CTAN archive:
CTAN_DISTFILES="${CLASS}.dtx ${CLASS}.ins ${CLASS}.pdf README"
DISTFILES="${CTAN_DISTFILES} ${CLASS}.cls"

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
rm -f ${CLASS}-for-CTAN.zip
zip ${CLASS}-for-CTAN.zip ${CTAN_DISTFILES}
# But uploads anywhere else do, and are nested:
rm -rf ${CLASS}-${VERSION}
mkdir ${CLASS}-${VERSION}/
cp ${DISTFILES} ${CLASS}-${VERSION}/
zip -r ${CLASS}-${VERSION}.zip ${CLASS}-${VERSION}/
rm -rf ${CLASS}-${VERSION}
echo "Auto-detected version is: ${VERSION}"
