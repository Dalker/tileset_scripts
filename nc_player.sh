#!/usr/bin/env sh
#
# this is an example of use of the namecopy bash script
#
./namecopy.sh player_frames/frame_ 0 6 player/idle_front_ -r
./namecopy.sh player_frames/frame_ 6 6 player/idle_side_  -r
./namecopy.sh player_frames/frame_ 12 6 player/idle_back_  -r
./namecopy.sh player_frames/frame_ 18 6 player/walk_front_  -r
./namecopy.sh player_frames/frame_ 24 6 player/walk_side_  -r
./namecopy.sh player_frames/frame_ 30 6 player/walk_back_  -r
./namecopy.sh player_frames/frame_ 36 4 player/attack_front_  -r
./namecopy.sh player_frames/frame_ 42 4 player/attack_side_  -r
./namecopy.sh player_frames/frame_ 48 4 player/attack_back_  -r
./namecopy.sh player_frames/frame_ 54 3 player/death_  -r
