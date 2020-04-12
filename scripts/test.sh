#!/bin/bash
#
# MIT License
#
# Copyright (c) 2017-2019 Jean-Sebastien CONAN
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
# Parses and displays the results of the unit tests.
#
# @package scripts
# @author jsconan
#

# script config
scriptpath=$(dirname $0)
project=$(pwd)
srcpath=${project}
dstpath=${project}
input="test"
output="output"
suite=
defaultsuite="suite"
cleanUp=

source "${scriptpath}/utils.sh"

# load parameters
while (( "$#" )); do
    case $1 in
        "-i"|"--input")
            input=$2
            shift
        ;;
        "-o"|"--output")
            output=$2
            shift
        ;;
        "-d"|"--defaut")
            defaultsuite=$2
            shift
        ;;
        "-c"|"--clean")
            cleanUp=1
        ;;
        "-h"|"--help")
            echo -e "${C_INF}Runs a tests suite for OpenSCAD files${C_RST}"
            echo -e "  ${C_INF}Usage:${C_RST}"
            echo -e "${C_CTX}\t$0 [command] [-h|--help] [-o|--option value] \"test suite\"${C_RST}"
            echo
            echo -e "${C_MSG}  -h,  --help         ${C_RST}Show this help"
            echo -e "${C_MSG}  -i   --input        ${C_RST}Set the folder that contains the input files (default: ./${input})"
            echo -e "${C_MSG}  -o   --output       ${C_RST}Set the folder that contains the output files (default: ./${output})"
            echo -e "${C_MSG}  -d   --default      ${C_RST}Set the default test suite (default: ${defaultsuite})"
            echo -e "${C_MSG}  -c   --clean        ${C_RST}Clean up the output folder before running the tests suite"
            echo
            exit 0
        ;;
        *)
            ls ${srcpath}/$1 >/dev/null 2>&1
            if [ "$?" == "0" ]; then
                suite=$1
            else
                printerror "Unknown parameter ${1}"
            fi
        ;;
    esac
    shift
done

# set the paths
if [ "${input}" != "" ]; then
    srcpath=${project}/${input}
fi
if [ "${output}" != "" ]; then
    dstpath=${project}/${output}
fi

# check the paths
if [ ! -d "${srcpath}" ]; then
    printerror "The input path ${srcpath} does not exist!"
fi
if [ ! -d "${dstpath}" ]; then
    printmessage ${C_ERR}"Warning! The output path ${dstpath} does not exist!"
fi

# check OpenSCAD
scadcheck

# clean up the output
if [ "${cleanUp}" != "" ]; then
    printmessage "${C_CTX}Cleaning up the output folder"
    rm -rf "${dstpath}"
fi

# run the tests
printmessage "${C_MSG}Running the test suite $(default "${suite}" "${defaultsuite}")"
scadunittest "${suite}" "${srcpath}" "${dstpath}" "${defaultsuite}"
