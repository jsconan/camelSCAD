#!/bin/bash
#
# GPLv3 License
#
# Copyright (c) 2019 Jean-Sebastien CONAN
#
# This file is part of jsconan/things.
#
# jsconan/things is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# jsconan/things is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with jsconan/things. If not, see <http://www.gnu.org/licenses/>.
#

#
# Part of the camelSCAD library.
#
# Shared utils: Display and messages related functions
#
# @example
# source "camelSCAD/scripts/utils.sh"
#
# @package scripts
# @author jsconan
#

# List of color codes
export C_ERR="\033[31m"
export C_SEL="\033[32m"
export C_SPE="\033[33m"
export C_CTX="\033[36m"
export C_RST="\033[0m"
export C_MSG="\033[1m"
export C_INF="\033[32m"

# List of error codes
export E_ERROR=-1      # Generic error
export E_OPENSCAD=1    # OpenSCAD not installed
export E_NOTFOUND=2    # Path does not exist or is not reachable
export E_CREATE=3      # Cannot create the folder
export E_EMPTY=4       # Empty folder

# Prints a colored message.
#
# @example
# colorize "Hello World!"           # display the text using the default color
# colorize "Hello World!" SPE       # display the text using the C_SPE color
# colorize "Hello World!" $C_CTX    # display the text using the code from $C_CTX
# colorize "Hello World!" "\033[1m" # display the text using a specific code
#
# @param message - The message to print.
# @param [color] - The color to apply, could be a constant like ERR or
#                  any valid ANSI code like \033[??m] (default C_INF).
colorize() {
    local message="$1"
    local color=${C_INF}
    if [ "$2" != "" ]; then
        color=C_$2
        if [ "${!color}" != "" ]; then
            color=${!color}
        else
            color=$2
        fi
    fi
    echo -e "${color}${message}${C_RST}"
}

# Prints a message, ensuring the color context is cleaned before and after.
#
# @example
# printmessage "Hello World!"           # simple message display
# printmessage "Hello ${C_SEL}World!"   # message with color
#
# @param message - The message to print.
printmessage() {
    echo -e "${C_RST}$1${C_RST}"
}

# Prints an error message and exits with the provided code.
#
# @example
# printerror "Something went wrong!"            # error message with default code (-1)
# printerror "Something went wrong!" E_EMPTY    # error message with specific code
#
# @param message - The message to print.
# @param [error] - The error code to exit with (default E_ERROR).
printerror() {
    local message="$1"
    local error=$2
    if [ "${error}" == "" ]; then
        error=${E_ERROR}
    fi
    echo
    colorize "${message}" ${C_ERR}
    echo
    exit ${error}
}
