#!/bin/bash
#
# GPLv3 License
#
# Copyright (c) 2019-2022 Jean-Sebastien CONAN
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

# Builds a file path.
#
# @example
# buildpath "bar.scad" "foo/bar"                   # will build the path foo/bar/bar.scad
# buildpath "bar.scad" "foo/bar" "" "foo"          # will build the path foo/bar/foo-bar.scad
# buildpath "bar.scad" "foo/bar" "" "" "baz"       # will build the path foo/bar/bar-baz.scad
# buildpath "bar.scad" "foo/bar" "" "foo" "baz"    # will build the path foo/bar/foo-bar-baz.scad
# buildpath "bar.scad" "foo/bar" "stl"             # will build the path foo/bar/bar.stl
# buildpath "bar.scad" "foo/bar" "stl" "foo"       # will build the path foo/bar/foo-bar.stl
# buildpath "bar.scad" "foo/bar" "stl" "" "baz"    # will build the path foo/bar/bar-baz.stl
# buildpath "bar.scad" "foo/bar" "stl" "foo" "baz" # will build the path foo/bar/foo-bar-baz.stl
#
# @param filepath - The path to the original file.
# @param destpath - The path to the file.
# @param extension - A file extension to set to the file name.
# @param prefix - A prefix to add to the file name.
# @param suffix - A suffix to add to the file name.
buildpath() {
    local filepath="$1";
    local destpath="$2";
    local extension=$(prefixif "." "$3");
    local prefix=$(suffixif "$4" "-");
    local suffix=$(prefixif "-" "$5");
    local name=$(basename "${filepath%.*}")
    if [ "${extension}" == "" ]; then
        extension=$(prefixif "." "${filepath##*.}");
    fi
    echo "${destpath}/${prefix}${name}${suffix}${extension}"
}

# Makes sure a file exists. Otherwise creates a copy from the dist file.
#
# @example
# distfile "bar.scad"                   # copy bar-dist.scad to bar.scad if the file does not exist
# distfile "bar.scad" "foo.scaf"        # copy foo.scad to bar.scad if the file does not exist
#
# @param filepath - The path to the original file.
distfile() {
    local filepath="$1"
    local distpath="$2"
    if [ "${filepath}" == "" ]; then
        return
    fi

    if [ "${distpath}" == "" ]; then
        local extension=$(prefixif "." "${filepath##*.}")
        distpath="${filepath%.*}-dist${extension}"
    fi

    if [ ! -f "${filepath}" ] && [ -f "${distpath}" ]; then
        local filename=$(basename "${filepath}")
        local distname=$(basename "${distpath}")
        printmessage "The file ${C_SEL}${filename}${C_RST} does not exist. Creating a copy from ${C_SEL}${distname}${C_RST}."
        cp "${distpath}" "${filepath}"
    fi
}
