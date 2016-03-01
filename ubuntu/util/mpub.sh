#!/bin/bash

#: Sets permissions of items in the Public folder to a+rx
#: 
#: Tested on Ubuntu Server 15.10.  
#: Author: Fastily

printf "Setting contents of Public folder to all read all exec\n"
chmod -R a+rx ~/Public/*

printf "Done!\n"
