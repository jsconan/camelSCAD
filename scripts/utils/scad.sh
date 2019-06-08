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
export scadver="2015.03"

# Defines the file extension for OpenSCAD files
export scadext=".scad"

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
        echo $(basename "$1" "${scadext}")
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
            params+=("-D")
            params+=("${var}")
        fi
    done
    ${scadcmd} --render -o "${outputpath}" "${sourcepath}" "${params[@]}"
}

# Renders a module.
#
# @example
# scadtostl "bar.scad" "foo/bar"       # will render a STL file at foo/bar/bar.stl
# scadtostl "bar.scad" "foo/bar" "foo" # will render a STL file at foo/bar/foo-bar.stl
#
# @param filepath - The path of the SCAD file to render.
# @param destpath - The path to the output file.
# @param prefix - A prefix to add to the output file.
# @param ... - A list of pre-defined variables.
scadtostl() {
    local filepath="$1"; shift
    local destpath="$1"; shift
    local prefix=$(suffixif "$1" "-"); shift
    local filename=$(basename "${filepath}")
    local name=$(scadmodulename "${filepath}")
    local outputpath="${destpath}/${prefix}${name}.stl"
    printmessage "${C_RST}Rendering of ${C_SEL}${filename}${C_RST} to ${C_SEL}${outputpath}"
    scadcall "${filepath}" "${outputpath}" "renderMode=\"prod\"" "$@"
}

# Renders the files from a path.
# Exits with error code E_EMPTY if it is empty.
# Exits with error code E_CREATE if the output folder cannot be created.
#
# @example
# scadtostlall "bar" "foo/bar"         # will render STL files at foo/bar/*.stl
# scadtostlall "bar" "foo/bar" "foo"   # will render STL files at foo/bar/foo-*.stl
#
# @param sourcepath - The path of the folder containing the SCAD files to render.
# @param destpath - The path to the output folder.
# @param prefix - A prefix to add to each output file.
# @param ... - A list of pre-defined variables.
scadtostlall() {
    local sourcepath="$1"; shift
    local destpath="$1"; shift
    local prefix="$1"; shift
    local mask="*${scadext}"
    printmessage "Processing rendering from ${C_SEL}${sourcepath}${C_RST}..."
    foldermustcontain "${sourcepath}" "${mask}" "render"
    createpath "${destpath}" "output"
    local list=($(find "${sourcepath}" -maxdepth 1 -name "${mask}"))
    for filename in "${list[@]}"; do
        scadtostl "${filename}" "${destpath}" "${prefix}" "$@"
    done
    printmessage "Done!"
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
    local sourcepath="$2/${suitename}${scadext}"
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
