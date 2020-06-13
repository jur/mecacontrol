#!/bin/bash
BASEDIR="$(pwd)"
cd "$(dirname "${0}")" || exit 1
SCRIPTDIR="$(pwd)"
cd "${BASEDIR}" || exit 1

"${SCRIPTDIR}/ssdpdiscovery.py" | grep -e "^LOCATION:" | cut -d ' ' -f 2 | grep -e ":49200/"
