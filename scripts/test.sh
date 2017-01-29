#!/bin/bash
#
# MIT License
#
# Copyright (c) 2017 Jean-Sebastien CONAN
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
# @package util/test
# @author jsconan
#

name=test/suite

scriptPath=$(dirname $0)
project=${scriptPath}/..
finename=${project}/${name}
src=${finename}.scad
dst=${finename}.csg
output=${finename}.log
result=${finename}.csv

echo -e "\033[0m"

echo "Checking directories..."
if [ ! -f "${src}" ]; then
    echo -e "\033[31m"
    echo "There is nothing to test!"
    echo "Are you at the root of the project?"
    echo -e "\033[0m"
    exit 1
fi

echo "Detecting OpenSCAD..."
openscad -v >/dev/null 2>&1
if [ "$?" != "0" ]; then
    echo -e "\033[31m"
    echo "It seems that OpenSCAD has not been installed on your system."
    echo "Or perhaps is it just not reachable..."
    echo "Have you placed it in your environment PATH variable?"
    echo -e "\033[0m"
    exit 3
fi

echo "OpenSCAD has been detected. Processing the files..."
openscad -o "${dst}" "${src}" -D CSV=true >"${output}" 2>&1

if [ "$?" != "0" ]; then
    echo -e "\033[31m"
    cat "${output}"
else
    cat "${output}" | sed -e 's/^ECHO: "\(.*\)"$/\1/g' >"${result}"
    awk -f "${scriptPath}/parse-test.awk" "${result}"
fi

rm "${dst}" "${output}" > /dev/null 2>&1

echo -e "\033[0m"
echo "Done!"
