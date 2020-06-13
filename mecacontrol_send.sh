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

declare -A KEYCODES

KEYCODES["channel+"]="46"
KEYCODES["channel-"]="47"
KEYCODES["volumeup"]="27"
KEYCODES["volumedown"]="28"
KEYCODES["button0"]="1"
KEYCODES["button1"]="2"
KEYCODES["button2"]="3"
KEYCODES["button3"]="4"
KEYCODES["button4"]="5"
KEYCODES["button5"]="6"
KEYCODES["button6"]="7"
KEYCODES["button7"]="8"
KEYCODES["button8"]="9"
KEYCODES["button9"]="10"
KEYCODES["ok"]="39"
KEYCODES["up"]="23"
KEYCODES["down"]="24"
KEYCODES["left"]="25"
KEYCODES["right"]="26"
KEYCODES["play"]="43"
KEYCODES["backward"]="41"
KEYCODES["forward"]="42"
KEYCODES["stop"]="44"
KEYCODES["back"]="33"
KEYCODES["exit"]="40"
KEYCODES["soundoff"]="35"
KEYCODES["text"]="36"
KEYCODES["epg"]="37"
KEYCODES["menu"]="38"
KEYCODES["blue"]="18"
KEYCODES["yellow"]="19"
KEYCODES["black"]="20"
KEYCODES["green"]="21"
KEYCODES["red"]="22"
KEYCODES["jumpstart"]="64"
KEYCODES["jumpend"]="65"
KEYCODES["record"]="45"
KEYCODES["pause"]="34"
KEYCODES["HDMI1"]="255 16"
KEYCODES["HDMI2"]="255 17"
KEYCODES["HDMI3"]="255 18"
KEYCODES["HDMI4"]="255 19"
KEYCODES["euro"]="255 20"
KEYCODES["av"]="255 21"
KEYCODES["audio"]="255 22"
KEYCODES["tv"]="255 0"
KEYCODES["poweroff"]="51"
KEYCODES["poweron"]="52"

TVNAME="${1:-Metz-TV}"
shift

declare -a PARAMS
for KEY in "${@}"; do
	if [ "${KEYCODES[${KEY}]}" != "" ]; then
		for K in $(echo "${KEYCODES[${KEY}]}"); do
			PARAMS+=("${K}")
		done
	else
		PARAMS+=("${KEY}")
	fi
done

CTRLURL="$("${SCRIPTDIR}/mecacontrol_find.sh" "${TVNAME}")"

if [ "${CTRLURL}" != "" ]; then
	"${SCRIPTDIR}/mecacontrol_key.py" "${CTRLURL}" "${PARAMS[@]}" || exit 1
else
	echo >&2 "Error: TV not found."
	exit 1
fi
