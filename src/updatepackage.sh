#!/bin/bash
DATE=$(date +%Y%m%d)
VERSION="25.${DATE}"
LASTVERSION=$(dpkg-parsechangelog --show-field Version)
rc=0
dpkg --compare-versions $VERSION gt $LASTVERSION && rc=1
if [ "$rc" = "0" ]; then
	SUBVERSION=${LASTVERSION##*.}
	if [ "$LASTVERSION" = "$VERSION" ]; then
		VERSION="${VERSION}.1"
	else
		VERSION="${VERSION}.$(( SUBVERSION + 1 ))"
	fi
fi
DEBFULLNAME="LliureX Team" DEBEMAIL="lliurex@gva.es" dch -v ${VERSION} --distribution noble "Mirror updated on ${DATE}"
