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
# Shared utils: Files related functions
#
# @example
# source "camelSCAD/scripts/utils.sh"
#
# @package scripts
# @author jsconan
#

# Checks if a file exists.
# Exits with error code E_NOTFOUND if it does not exist.
#
# @example
# filemustexist "foo/bar"           # will continue if the file exists,
#                                   # otherwise will fail with message:
#                                   # "There is nothing at foo/bar"
#
# filemustexist "foo/bar" "show"    # will continue if the file exists,
#                                   # otherwise will fail with message:
#                                   # "There is nothing to show"
#
# @param path - The path of the file that must exist.
# @param verb - A verb to insert in the printed message.
filemustexist() {
    if [ ! -f "$1" ]; then
        local verb=$(prefixif "to " "$2")
        local info=$(default "${verb}" "at $1")
        printerror "There is nothing ${info}!" ${E_NOTFOUND}
    fi
}

# Checks if a folder contains files.
# Exits with error code E_EMPTY if it is empty.
#
# @example
# foldermustcontain "foo/bar"           # will continue if the contains files,
#                                       # otherwise will fail with message:
#                                       # "There is nothing at foo/bar"
#
# foldermustcontain "foo/bar" "" "show" # will continue if the contains files,
#                                       # otherwise will fail with message:
#                                       # "There is nothing to show"
#
# foldermustcontain "foo/bar" "*.txt"   # will continue if the contains .txt files,
#                                       # otherwise will fail with message:
#                                       # "There is nothing at foo/bar"
#
# @param path - The path of the folder that must contain files.
# @param mask - The file mask that match the files to find.
# @param verb - A verb to insert in the printed message.
foldermustcontain() {
    local mask=$(default "$2" "*")
    local list=($(find "$1" -maxdepth 1 -name "${mask}"))
    if [ ${#list[@]} -eq 0 ]; then
        local verb=$(prefixif "to " "$3")
        local info=$(default "${verb}" "at $1")
        printerror "There is nothing ${info}!" ${E_EMPTY}
    fi
}

# Creates a folder if needed.
# Exits with error code E_CREATE if cannot create.
#
# @example
# createpath "foo/bar"          # will display "Checking folder foo/bar...",
#                               # then continue if the folder already exists,
#                               # otherwise will display "Create folder foo/bar"
#                               # and then will create the folder
#
# createpath "foo/bar" "output" # will display "Checking folder output...",
#                               # then continue if the folder already exists,
#                               # otherwise will display "Create folder output"
#                               # and then will create the folder
#
# @param path - The path of the folder to create.
# @param label - The name to insert in the printed message.
createpath() {
    local path="$1"
    local label=$(default "$2" "$1")
    printmessage "Checking folder ${C_SEL}${label}${C_RST}..."
    if [ ! -d "${path}" ]; then
        printmessage "Create folder ${C_SEL}${label}"
        mkdir -p "${path}" >/dev/null
        if [ ! -d "${path}" ]; then
            printerror "Cannot create the folder!" ${E_CREATE}
        fi
    fi
}

# Recursively list all folders from a path, matching a files pattern.
#
# @param sourcepath - The input path in which recursively search the files pattern.
# @param pattern - The files pattern each folder much contain.
recursepath() {
    local input=$1; shift
    local pattern=$1; shift
    local folders=($(find ${input} -type d -print 2>/dev/null))
    for folderpath in "${folders[@]}"; do
        folder=$(echo ${folderpath#${input}})
        local files=($(find ${folderpath}/${pattern} -maxdepth 1 -type f -print 2>/dev/null))
        if [ "${files}" != "" ]; then
            echo "${folder}"
        fi
    done
}
