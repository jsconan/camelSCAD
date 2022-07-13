#!/bin/bash
#
# MIT License
#
# Copyright (c) 2019-2022 Jean-Sebastien CONAN
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

#
# Part of the camelSCAD library.
#
# Shared utils: Slic3r related functions
#
# @example
# source "camelSCAD/scripts/utils.sh"
#
# @package scripts
# @author jsconan
#

# Defines the command for the Slic3r software
export slic3rcmd="slic3r"

# Defines the displayed name for the Slic3r software
export slic3rname="Slic3r"

# Defines the minimal required version for Slic3r
export slic3rver="1.3"

# Defines the config path
export slic3rconfigpath=

# Defines the number of parallel processes spawned when slicing
export slic3rproc=4

# Defines the file extension for model files
export slic3rext="stl"

# Use another slicer instead of Slic3r
#
# @example
# slic3ruse PrusaSlicer 2.0     # will use "PrusaSlicer" instead of "Slic3r"
#                               # the minimal version is set to 2.0
#
# slic3ruse PrusaSlicer 2.0 PE  # will use "PrusaSlicer" instead of "Slic3r"
#                               # the minimal version is set to "2.0"
#                               # the displayed name will be "PE"
#
# @param [command] - The command for the slicer to use
# @param [version] - The minimal version expected
# @param [name] - The displayed name
slic3ruse() {
    local command=$1
    local version=$2
    local name=$3
    if [ "${command}" != "" ]; then
        export slic3rcmd="${command}"
    fi
    if [ "${version}" != "" ]; then
        export slic3rver="${version}"
    fi
    if [ "${name}" != "" ]; then
        export slic3rname="${name}"
    else
        export slic3rname="${slic3rcmd}"
    fi
    printmessage "${C_RST}Will use ${C_SPE}${slic3rname}${C_RST}, minimal version ${C_SPE}${version}${C_RST}"
}

# Use PrusaSlicer instead of Slic3r
#
# @example
# useprusaslicer     # will use PrusaSlicer instead of Slic3r
#
# useprusaslicer 2.0 # will use PrusaSlicer instead of Slic3r
#                    # the minimal version is set to 2.0
#
# @param [version] - The minimal version expected
useprusaslicer() {
    slic3ruse "PrusaSlicer" "2.1"
}

# Gets the version of the installed Slic3r.
# Exits with error code E_SLIC3R if not installed.
#
# @example
# slic3rversion     # will display "xxx.xx.xx",
#
# slic3rversion "foo" # will display "xxxx.xx", or return E_SLIC3R if not installed
#
# @param [slic3r] - The path to the Slic3r command (default "slic3r").
slic3rversion() {
    local version
    local cmd="${slic3rcmd}"
    if [ "$1" != "" ]; then
        cmd="$1"
    fi
    version="$(${cmd} --help | egrep -o '[0-9].[0-9]' | head -1 2>&1)"
    if [ "$?" != "0" ]; then
        return ${E_SLIC3R}
    fi
    echo "${version}"
}

# Checks if Slic3r is installed.
# Exits with error code E_SLIC3R if not installed.
#
# @example
# slic3rcheck       # will display "Detecting Slic3r",
#                   # then continue if Slic3r is found,
#                   # otherwise will fail with an error message
#
# slic3rcheck "foo" # will display "Detecting Slic3r [from foo]",
#                   # then continue if Slic3r is found at the given path,
#                   # otherwise will fail with an error message
#
# @param [slic3r] - The path to the Slic3r command (default "slic3r").
slic3rcheck() {
    local info
    if [ "$1" != "" ]; then
        slic3rcmd="$1"
        info=" [from ${C_SEL}${slic3rcmd}${C_RST}]"
    fi
    printmessage "Detecting ${C_SPE}${slic3rname}${C_RST}${info}..."
    local slic3rpath=$(which ${slic3rcmd} 2>&1)
    if [ "${slic3rpath}" == "" ]; then
        printerror "It seems ${slic3rname} has not been installed on your system.\nOr perhaps is it just not reachable...\nHave you placed it in your environment PATH variable?" ${E_SLIC3R}
    else
        printmessage "${C_SPE}${slic3rname}${C_RST} has been detected."
    fi
    local version="$(slic3rversion)"
    if [[ "${version}" < "${slic3rver}" ]]; then
        printerror "The installed version of ${slic3rname} does not meet the requirement.\n\tInstalled: ${version}\n\tRequired: ${slic3rver}" ${E_SLIC3R}
    fi
}

# Set the format of the model files.
#
#
# @example
# slic3rformat "stl"         # Set the model format to STL
#
# slic3rformat "3mf"         # Set the model format to 3MF
#
# @param format - The format of the model files.
slic3rformat() {
    if [ "$1" != "" ]; then
        export slic3rext=$(tolower $1)
    fi
    printmessage "${C_RST}Will slice the models corresponding to the ${C_SEL}$(toupper ${slic3rext})${C_RST} format"
}

# Set the path the config file.
#
#
# @example
# slic3rconfig "my_config.ini"         # Will use the config from the file my_config.ini
#
# @param config - The path to the file containing the config.
slic3rconfig() {
    if [ "$1" != "" ]; then
        export slic3rconfigpath=$1
    fi
    if [ "${slic3rconfigpath}" != "" ]; then
        printmessage "${C_RST}Will slice the models using the config from ${C_SEL}${slic3rconfigpath}${C_RST}"
        if [ ! -f "${configpath}" ]; then
            printmessage "${C_WRN}Warning! The config for Slic3r does not exist!"
        fi
    else
        printmessage "${C_RST}No config file provided, will slice the models using the default config."
    fi
}

# Set the number of parallel processes spawned when slicing.
#
#
# @example
# slic3rprocesses 4         # Will spawn 4 slicers at once
#
# slic3rprocesses 1         # Will spawn only 1 slicer at once
#
# @param number - The number of parallel processes.
slic3rprocesses() {
    if [ "$1" != "" ]; then
        export slic3rproc=$1
    fi
    printmessage "${C_RST}Will slice the models spawning ${C_SEL}${slic3rproc}${C_RST} processes at a time"
}

# Calls Slic3r with the provided parameters.
#
#
# @example
# slic3rcall "foo.slic3r" "foo.stl"         # Calls Slic3r and slices foo.stl into foo.gcode
#
# slic3rcall "foo.slic3r" "foo.stl" "bar=3" # Calls Slic3r and slices foo.stl into foo.gcode,
#                                           # adding the parameter bar
#
# @param sourcepath - The path of the SCAD file to load.
# @param outputpath - The path of the file that will contain the output.
# @param ... - A list of pre-defined variables.
slic3rcall() {
    local sourcepath="$1"; shift
    local outputpath="$1"; shift
    local params=()
    if [ "${slic3rconfigpath}" != "" ]; then
        params+=("--load")
        params+=("${slic3rconfigpath}")
    fi
    for var in "$@"; do
        if [ "${var}" != "" ]; then
            params+=("${var}")
        fi
    done
    ${slic3rcmd} -g "${sourcepath}" --output "${outputpath}" "${params[@]}"
}

# Slices a model.
#
# @example
# slic3rslice "bar.stl" "foo/bar"
#
# @param filepath - The path of the file to slice.
# @param destpath - The path to the output file.
# @param ... - A list of additional parameters.
slic3rslice() {
    local filepath="$1"; shift
    local outputpath="$1"; shift
    local filename=$(basename "${filepath}")
    printmessage "${C_RST}Slicing of ${C_SEL}${filename}${C_RST} to ${C_SEL}${outputpath}"
    slic3rcall "${filepath}" "${outputpath}" "$@"
}

# Slices the models from a path. Several processes will be spawned at a time to parallelize the slicing and speeds it up.
# Exits with error code E_EMPTY if it is empty.
# Exits with error code E_CREATE if the output folder cannot be created.
#
# @example
# slic3rsliceall "bar" "foo/bar"
#
# @param sourcepath - The path of the folder containing the models to slice.
# @param destpath - The path to the output folder.
# @param ... - A list of additional parameters.
slic3rsliceall() {
    local sourcepath="$1"; shift
    local destpath="$1"; shift
    local mask="*.${slic3rext}"
    printmessage "Processing slicing from ${C_SEL}${sourcepath}${C_RST}..."
    foldermustcontain "${sourcepath}" "${mask}" "slice"
    createpath "${destpath}" "output"
    local list=($(find "${sourcepath}" -maxdepth 1 -name "${mask}"))
    local i=0
    for filename in "${list[@]}"; do
        slic3rslice "${filename}" "${destpath}" "$@" &
        (( ++i%slic3rproc==0 )) && wait
    done
    wait
    printmessage "Done!"
}

# Slices the models from a path and its sub-folders.
# Several processes will be spawned at a time to parallelize the slicing and speeds it up.
# Exits with error code E_EMPTY if it is empty.
# Exits with error code E_CREATE if the output folder cannot be created.
#
# @example
# slic3rsliceall "bar" "foo/bar"
#
# @param sourcepath - The path of the folder containing the models to slice.
# @param destpath - The path to the output folder.
# @param ... - A list of additional parameters.
slic3rsliceallrecurse() {
    local src=$1; shift
    local dst=$1; shift
    local mask="*.${slic3rext}"
    local files=($(find "${src}" -maxdepth 1 -name "${mask}"))
    local folders=($(recursepath "${src}" "${mask}"))
    if [ ${#files[@]} -eq 0 ] && [ ${#folders[@]} -eq 0 ]; then
        printerror "There is nothing to slice at ${src}!" ${E_EMPTY}
    fi
    if [ ${#files[@]} -gt 0 ]; then
        slic3rsliceall "${src}" "${dst}" "$@"
    fi
    for folder in "${folders[@]}"; do
        slic3rsliceall "${src}${folder}" "${dst}${folder}" "$@"
    done
}
