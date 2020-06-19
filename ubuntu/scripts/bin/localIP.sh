#!/bin/bash

#: Grab this computer's local ip address and print to std out
#:
#: Author: Fastily

ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'