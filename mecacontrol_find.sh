#!/bin/bash
BASEDIR="$(pwd)"
cd "$(dirname "${0}")" || exit 1
SCRIPTDIR="$(pwd)"
cd "${BASEDIR}" || exit 1

NAME="${1}"

"${SCRIPTDIR}/ssdpdiscovery.py" | grep -e "^LOCATION:" | cut -d ' ' -f 2 | grep -e ":49200/" | while read url; do
	"${SCRIPTDIR}/mecacontrol_upnp_get_url.py" "${url}" "${NAME}"
done
