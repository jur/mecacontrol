#!/bin/bash
BASEDIR="$(pwd)"
cd "$(dirname "${0}")" || exit 1
SCRIPTDIR="$(pwd)"
cd "${BASEDIR}" || exit 1

# Send command to Metz TV
#
# Parameters: [TV Name] [Key Code] [Device Code]
#
# See mecacontrol_key.py for key and device codes.

TVNAME="${1:-Metz-TV}"
shift
CTRLURL="$("${SCRIPTDIR}/mecacontrol_find.sh" "${TVNAME}")"

if [ "${CTRLURL}" != "" ]; then
	"${SCRIPTDIR}/mecacontrol_key.py" "${CTRLURL}" "${@}" || exit 1
else
	echo >&2 "Error: TV not found."
	exit 1
fi
