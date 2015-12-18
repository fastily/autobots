#!/bin/bash

#: Sets mouse tracking to a sane level for wireless keyboard-mouse combos.  
#: Apply when you cannot edit mouse tracking in settings.
#: 
#: Tested on Ubuntu Server 15.10.  
#: Author: Fastily


printf "Old Mouse Settings are:\n"
xset q  | grep acceleration

printf "Setting mouse tracking 1.2 accl and 0 threshold\n"
xset mouse 1 0

printf "New Mouse settings are:\n"
xset q  | grep acceleration

printf "Done!\n"