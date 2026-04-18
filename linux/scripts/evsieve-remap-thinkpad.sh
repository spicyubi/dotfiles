# !/bin/bash

# t480
runapp /usr/local/bin/evsieve \
--input /dev/input/event13 grab \
--input /dev/input/event3 grab \
--map yield key:capslock key:esc \
--map yield key:esc key:capslock \
--map btn:right key:leftmeta \
--map btn:left key:leftctrl \
--map btn:middle key:leftalt \
--output
