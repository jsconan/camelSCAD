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
# Shared utils: OpenSCAD related functions
#
# @example
# source "camelSCAD/scripts/utils.sh"
#
# @package scripts
# @author jsconan
#

# Defines the command for the OpenSCAD engine
export scadcmd="openscad"

# Defines the minimal required version for OpenSCAD
export scadver="2019.05"

# Defines the file extension for OpenSCAD files
export scadext="scad"

# Defines the file format for the rendering output
export scadout="stl"

# Defines the number of parallel processes spawned when rendering
export scadproc=4

# Prints the name of an OpenSCAD module (file name without the extension).
#
# @example
# var=$(scadmodulename "./bar.scad" "foobar")   # will get "bar"
# var=$(scadmodulename "foo/bar.scad" "foobar") # will get "bar"
# var=$(scadmodulename "foo/bar.txt" "")        # will get "bar.txt"
# var=$(scadmodulename "foo/bar" "")            # will get "bar"
# var=$(scadmodulename "" "foobar")             # will get "foobar"
#
# @param filepath - The path of the module.
# @param default - A default name to print of the path does not contain one.
scadmodulename() {
    if [ "$1" != "" ]; then
        echo $(basename "$1" ".${scadext}")
    else
        echo "$2"
    fi
}

# Prints the uri of an OpenSCAD module (file path without the extension).
#
# @example
# var=$(scadmoduleuri "./bar.scad" "foobar")   # will get "bar"
# var=$(scadmoduleuri "foo/bar.scad" "foobar") # will get "foo/bar"
# var=$(scadmoduleuri "foo/bar.txt" "")        # will get "foo/bar.txt"
# var=$(scadmoduleuri "foo/bar" "")            # will get "foo/bar"
# var=$(scadmoduleuri "" "foobar")             # will get "foobar"
#
# @param filepath - The path of the module.
# @param default - A default name to print of the path does not contain one.
scadmoduleuri() {
    if [ "$1" != "" ]; then
        local path=$(dirname "$1")
        local name=$(scadmodulename "$1" "$2")
        if [ "${path}" != "." ]; then
            echo "${path}/${name}"
        else
            echo "${name}"
        fi
    else
        echo "$2"
    fi
}

# Checks if OpenSCAD is installed.
# Exits with error code E_OPENSCAD if not installed.
#
# @example
# scadcheck         # will display "Detecting OpenSCAD",
#                   # then continue if OpenSCAD is found,
#                   # otherwise will fail with an error message
#
# scadcheck "foo"   # will display "Detecting OpenSCAD [from foo]",
#                   # then continue if OpenSCAD is found at the given path,
#                   # otherwise will fail with an error message
#
# @param [openscad] - The path to the OpenSCAD command (default "openscad").
scadcheck() {
    local info=
    if [ "$1" != "" ]; then
        scadcmd="$1"
        info=" [from ${C_SEL}${scadcmd}${C_RST}]"
    fi
    printmessage "Detecting ${C_SPE}OpenSCAD${C_RST}${info}..."
    local scad=$(${scadcmd} -v 2>&1)
    if [ "$?" != "0" ]; then
        printerror "It seems OpenSCAD has not been installed on your system.\nOr perhaps is it just not reachable...\nHave you placed it in your environment PATH variable?" ${E_OPENSCAD}
    else
        printmessage "${C_SPE}OpenSCAD${C_RST} has been detected."
    fi
    local version="${scad//[^0-9.]/}"
    if [[ "${version}" < "${scadver}" ]]; then
        printerror "The installed version of OpenSCAD does not meet the requirement.\n\tInstalled: ${version}\n\tRequired: ${scadver}" ${E_OPENSCAD}
    fi
}

# Calls OpenSCAD with the provided parameters.
#
#
# @example
# scadcall "foo.scad" "foo.stl"         # Calls OpenSCAD and renders foo.scad into foo.stl
#
# scadcall "foo.scad" "foo.stl" "bar=3" # Calls OpenSCAD and renders foo.scad into foo.stl,
#                                       # setting 3 into the variable bar
#
# @param sourcepath - The path of the SCAD file to load.
# @param outputpath - The path of the file that will contain the output.
# @param ... - A list of pre-defined variables.
scadcall() {
    local sourcepath="$1"; shift
    local outputpath="$1"; shift
    local params=()
    for var in "$@"; do
        if [ "${var}" != "" ]; then
            if [[ "${var}" == *=* ]]; then
                params+=("-D")
            fi
            params+=("${var}")
        fi
    done
    ${scadcmd} -o "${outputpath}" "${sourcepath}" "${params[@]}"
}

# Set the format of the ouput files.
#
#
# @example
# scadformat "stl"         # Set the output format to STL
#
# scadformat "3mf"         # Set the output format to 3MF
#
# @param format - The format of the output files.
scadformat() {
    if [ "$1" != "" ]; then
        export scadout=$(tolower $1)
    fi
    printmessage "${C_RST}Will render the files using ${C_SEL}$(toupper ${scadout})${C_RST} format"
}

# Set the number of parallel processes spawned when rendering.
#
#
# @example
# scadprocesses 4         # Will spawn 4 renderers at once
#
# scadprocesses 1         # Will spawn only 1 renderer at once
#
# @param number - The number of parallel processes.
scadprocesses() {
    if [ "$1" != "" ]; then
        export scadproc=$1
    fi
    printmessage "${C_RST}Will render the files spawning ${C_SEL}${scadproc}${C_RST} processes at a time"
}

# Renders a module.
#
# @example
# scadrender "bar.scad" "foo/bar"             # will render a STL file at foo/bar/bar.stl
# scadrender "bar.scad" "foo/bar" "foo"       # will render a STL file at foo/bar/foo-bar.stl
# scadrender "bar.scad" "foo/bar" "foo" "baz" # will render a STL file at foo/bar/foo-bar-baz.stl
#
# @param filepath - The path of the SCAD file to render.
# @param destpath - The path to the output file.
# @param prefix - A prefix to add to the output file.
# @param suffix - A suffix to add to the output file.
# @param ... - A list of pre-defined variables.
scadrender() {
    local filepath="$1"; shift
    local destpath="$1"; shift
    local prefix=$(suffixif "$1" "-"); shift
    local suffix=$(prefixif "-" "$1"); shift
    local filename=$(basename "${filepath}")
    local name=$(scadmodulename "${filepath}")
    local outputpath="${destpath}/${prefix}${name}${suffix}.${scadout}"
    printmessage "${C_RST}Rendering of ${C_SEL}${filename}${C_RST} to ${C_SEL}${outputpath}"
    scadcall "${filepath}" "${outputpath}" --render "renderMode=\"prod\"" "$@"
}

# Renders the files from a path. Several processes will be spawned at a time to parallelize the rendering and speeds it up.
# Exits with error code E_EMPTY if it is empty.
# Exits with error code E_CREATE if the output folder cannot be created.
#
# @example
# scadrenderall "bar" "foo/bar"              # will render STL files from bar/*.scad to foo/bar/*.stl
# scadrenderall "bar" "foo/bar" "foo"        # will render STL files from bar/*.scad to foo/bar/foo-*.stl
# scadrenderall "bar" "foo/bar" "foo" "baz"  # will render STL files from bar/*.scad to foo/bar/foo-*-baz.stl
#
# @param sourcepath - The path of the folder containing the SCAD files to render.
# @param destpath - The path to the output folder.
# @param prefix - A prefix to add to each output file.
# @param suffix - A suffix to add to the output file.
# @param ... - A list of pre-defined variables.
scadrenderall() {
    local sourcepath="$1"; shift
    local destpath="$1"; shift
    local prefix="$1"; shift
    local suffix="$1"; shift
    local mask="*.${scadext}"
    printmessage "Processing rendering from ${C_SEL}${sourcepath}${C_RST}..."
    foldermustcontain "${sourcepath}" "${mask}" "render"
    createpath "${destpath}" "output"
    local list=($(find "${sourcepath}" -maxdepth 1 -name "${mask}"))
    local i=0
    for filename in "${list[@]}"; do
        scadrender "${filename}" "${destpath}" "${prefix}" "${suffix}" "$@" &
        (( ++i%scadproc==0 )) && wait
    done
    wait
    printmessage "Done!"
}

# Renders the files from a path and its sub-folders.
# Several processes will be spawned at a time to parallelize the rendering and speeds it up.
# Exits with error code E_EMPTY if it is empty.
# Exits with error code E_CREATE if the output folder cannot be created.
#
# @example
# scadrenderallrecurse "bar" "foo/bar"              # will render STL files from bar/**/*.scad to foo/bar/**/*.stl
# scadrenderallrecurse "bar" "foo/bar" "foo"        # will render STL files from bar/**/*.scad to foo/bar/**/foo-*.stl
# scadrenderallrecurse "bar" "foo/bar" "foo" "baz"  # will render STL files from bar/**/*.scad to foo/bar/**/foo-*-baz.stl
#
# @param sourcepath - The path of the folder containing the SCAD files to render.
# @param destpath - The path to the output folder.
# @param prefix - A prefix to add to each output file.
# @param suffix - A suffix to add to the output file.
# @param ... - A list of pre-defined variables.
scadrenderallrecurse() {
    local src=$1; shift
    local dst=$1; shift
    local folders=($(recursepath "${src}" "*.${scadext}"))
    if [ "${folders}" == "" ]; then
        printerror "There is nothing to render at ${src}!" ${E_EMPTY}
    fi
    for folder in "${folders[@]}"; do
        scadrenderall "${src}${folder}" "${dst}${folder}" "$@"
    done
}

# Runs a unit tests suite.
# Exits with error code E_NOTFOUND if it does not exist.
# Exits with error code E_CREATE if the output folder cannot be created.
#
# @example
# scadunittest "" "foo" "bar" "suite"       # will run test from foo/suite.scad
#                                           # and put the result in bar/suite.csv
#
# scadunittest "bar" "foo" "bar" "suite"    # will run test from foo/bar.scad
#                                           # and put the result in bar/bar.csv
#
# @param suitename - The name of the test suite to run
# @param suitepath - The path to the folder that contain the test suites.
# @param outputpath - The path to the output folder.
# @param defaultsuite - The default test suite if none is provided.
scadunittest() {
    local suitename=$(scadmoduleuri "$1" $(default "$4" "suite"))
    local sourcepath="$2/${suitename}.${scadext}"
    local outputname="$3/${suitename//\//_}"
    local outputpath="${outputname}.csg"
    local logpath="${outputname}.log"
    local resultpath="${outputname}.csv"
    printmessage "Processing unit tests from ${C_SEL}${sourcepath}${C_RST}..."
    filemustexist "${sourcepath}" "test"
    createpath "$3" "output"
    scadcall "${sourcepath}" "${outputpath}" "CSV=true" >"${logpath}" 2>&1
    if [ "$?" != "0" ]; then
        printerror "$(<${logpath})" $?
    else
        sed -e 's/^ECHO: "\(.*\)"$/\1/g' "${logpath}" >"${resultpath}"
        awk -f "${libpath}/parse-test.awk" "${resultpath}"
        printmessage "Done!"
    fi
    rm "${outputpath}" "${logpath}" > /dev/null 2>&1
}
