#!/usr/bin/bash
#
# separate_frames bash script
#
# Author: Daniel Kessler (a.k.a. Dalker)
# Start Date: 2023.03.29
# License: GPLv2
#
# Goal: separate frames from a png sprite tileset into individual files
#
# Motivation: This little script was developped in response to a remark on one of
#    QuillRaven's YouTube videos about programming a game with Kotlin using libGDX
#  -> see https://www.youtube.com/watch?v=y8Wlv_CizOY
#!/usr/bin/bash
set -o errexit; set -o nounset

ME=$( basename "$0" .sh )
HELP() {
    echo "$ME: get fixed size icons from image file and save them"
    echo "Usage: $ME [-r] srcfile dimension dstbase"
    echo "ARGUMENTS:"
    echo "     srcfile: source image file"
    echo "   dimension: mxn size of icons to extract"
    echo "     dstbase: base name for destination files"
    echo "OPTION:"
    echo "    -r: do it for real (otherwise, echo expected action)"
    echo "EXAMPLE:"
    echo "   $ME player.png 48x48 player/frame_"
    exit
}

CHECK_EXISTS() {
    if [ ! -e "$1" ]; then
       echo "$1 does not exist -- stoping"
       exit
    fi
}

ARGS=()
REAL=false
while [ $# -gt 0 ]; do
    if [ "${1:0:1}" != "-" ]; then # no dash
        ARGS+=("$1")
    elif [ "$1" = "-r" ]; then
        REAL=true
    else
        HELP
    fi
    shift
done

if [ ${#ARGS[@]} -ne 3 ]; then
   HELP
fi

SRCFILE=${ARGS[0]}
DIMENSION=${ARGS[1]}
DSTBASE=${ARGS[2]}

CHECK_EXISTS "$SRCFILE"
CHECK_EXISTS "$(dirname ${DSTBASE})/"
if [ $REAL = true ]; then
    magick convert "$SRCFILE" -crop "$DIMENSION" "$DSTBASE"%02d.png
else
    echo "would do:"
    echo "> magick convert $SRCFILE -crop $DIMENSION ${DSTBASE}%02d.png"
    echo "add -r to make it real"
fi
