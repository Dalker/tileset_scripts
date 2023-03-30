#!/usr/bin/bash
#
# namecopy bash script
#
# Author: Daniel Kessler (a.k.a. Dalker)
# Start Date: 2023.03.29
# License: GPLv2
#
# Goal: copy some .png files named as basename_xx.png, where xx are numbers 00, 01, ...
#   to a new base name and numbering such as newbase/name_y.png, ...
#   NB: source assumed to use two digits for numbering, destination uses only one
#
# Motivation: This little script was developped in response to a remark on one of
#    QuillRaven's YouTube videos about programming a game with Kotlin using libGDX
#  -> see https://www.youtube.com/watch?v=y8Wlv_CizOY
set -o errexit; set -o nounset

ME=$( basename "$0" .sh )
HELP() {
    echo "$ME: batch copy files ending with ##.png"
    echo "Usage: $ME [-r] srcbase n_init_frame n_frames dstbase"
    echo "ARGUMENTS:"
    echo "       srcbase: base name for source files"
    echo "    init_frame: number of first frame to take"
    echo "      n_frames: number of frames to take"
    echo "       dstbase: base name for destination files"
    echo "OPTION:"
    echo "    -r: do it for real (otherwise, list expected actions)"
    echo "EXAMPLE:"
    echo "   $ME player_frames/frame_ 18 6 player/walk_front_"
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
        echo "unknown argument: $1"
        HELP
    fi
    shift
done

if [ ${#ARGS[@]} -ne 4 ]; then
    echo "$ME needs exactly 4 arbuments"
    HELP
fi

SRCBASE=${ARGS[0]}
INIT_FRAME=${ARGS[1]}
N_FRAMES=${ARGS[2]}
DSTBASE=${ARGS[3]}

n=0
if [ $REAL = false ]; then
    echo "would do:"
fi
while [ "$n" -lt "$N_FRAMES" ]
do
    frame_num=$((INIT_FRAME + n))
    xx_fnum=$(printf "%02d" "$frame_num")
    source="${SRCBASE}${xx_fnum}.png"
    dest="${DSTBASE}${n}.png"
    CHECK_EXISTS "$source"
    if [ $REAL = true ]; then
        cp -i "$source" "$dest"
    else
        echo "> cp -i $source $dest"
    fi
    n=$((n + 1))
done
if [ $REAL = false ]; then
    echo "add -r to make it real"
fi
