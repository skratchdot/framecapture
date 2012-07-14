#!/bin/bash
#
#     Name: framecapture.sh
#  Version: 1.0
# Released: 2012-07-14
#     Info: https://github.com/skratchdot/framecapture/

# Set some defaults
usage="Usage: $(basename $0 .sh) [-h|--help] [-mattecolor <color>] [-frame <geometry>] <filename>"
filename=""
mattecolor="blue"
frame="6x6+2+2"

# We require screencapture to work properly
hash screencapture 2>/dev/null || {
	echo >&2 "\"framecapture\" requires \"screencapture\" but it's not installed.  Aborting."
	exit 1
}

# We require convert to work properly
hash convert 2>/dev/null || {
	echo >&2 "\"framecapture\" requires \"convert\" but it's not installed. \"convert\" will be installed when installing ImageMagick.  Aborting."
	exit 1
}

# Parse command line options
while [ "$1" != "" ]; do
	case $1 in
		-mattecolor )		shift
							mattecolor=$1
							;;
		-frame )			shift
							frame=$1
							;;
		-h | --help )		echo "$usage"
							exit 0
							;;
		* )					filename=$1
							shift
							;;
	esac
	shift
done

## Must pass in a final argument that is a file
[[ -n "$filename" ]] || {
	echo "$usage"
	exit 2
}

# Execute our commands
screencapture -is "$filename"
convert "$filename" -mattecolor "$mattecolor" -frame "$frame" "$filename"
exit 0