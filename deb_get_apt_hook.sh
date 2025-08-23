#!/usr/bin/env bash


## Author: Tommy Miland (@tmiland) - Copyright (c) 2025


######################################################################
####                    Deb Get Apt Hook.sh                       ####
####            Hook deb-get into apt to get deb-get              ####
####                updates when running apt get                  ####
####                   Maintained by @tmiland                     ####
######################################################################

VERSION='1.0.0'

#------------------------------------------------------------------------------#
#
# MIT License
#
# Copyright (c) 2025 Tommy Miland
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#------------------------------------------------------------------------------#
# ANSI Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
RESET='\033[0m'    # Reset color

# Print an error message and exit (Red)
error() {
  printf "${RED}ERROR: %s${RESET}\n" "$*" >&2
  exit 1
}

# Print a log message (Green)
ok() {
  printf "${GREEN}%s${RESET}\n" "$*"
}

warn() {
  printf "${YELLOW}%s${RESET}\n" "$*"
}

# https://gist.github.com/imthenachoman/f722f6d08dfb404fed2a3b2d83263118
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=770938
# this script is an enhancement of https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=770938
# we need to work up the process tree to find the apt command that triggered the call to this script
# get the initial PID
PID=$$
# find the apt command by working up the process tree
# loop until
# - PID is empty
# - PID is 1
# - or PID command is apt
while [[ -n "$PID" && "$PID" != "1" && "$(ps -ho comm "${PID}")" != "apt" ]] ; do
  # the current PID is not the apt command so go up one by getting the parent PID of hte current PID
  PID=$(ps -ho ppid "$PID" | xargs)
done
# assuming we found the apt command, get the full args
if [[ "$(ps -ho comm "${PID}")" = "apt" ]] ; then
  LAST_CMD="$(ps -ho args "${PID}")"
fi

# echo "Last command is $LAST_CMD"
tmp=/tmp/deb-get_update

if [[ -n "$LAST_CMD" ]]
then
  if [[ "$LAST_CMD" == "apt update" ]]
  then
    if [ $(command -v 'deb-get') ]
    then
      ok "Running deb-get update via deb-get-apt-hook..."
      DISABLE_APT=y \
        deb-get update | tee $tmp || error "Unable to run deb-get update..."
      if grep "has an update pending" $tmp
      then
        read -rp "      do you want to upgrade deb-get packages? [y/n] " q
        if [ "$q" == "y" ]; then
          DISABLE_APT=y \
            deb-get upgrade || error "Unable to run deb-get upgrade..."
        fi
      fi
      ok "Done."
      rm $tmp
    fi
  fi
fi

exit 0