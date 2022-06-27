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
# Shared utils: Values related functions
#
# @example
# source "camelSCAD/scripts/utils.sh"
#
# @package scripts
# @author jsconan
#

# Prints the value if given or prints the default value.
#
# @example
# var=$(default "value" "default")  # will get "value"
# var=$(default "" "default")       # will get "default"
#
# @param value - The value to print if it is not empty.
# @param default - The default value that will be printed if the value is empty.
default() {
    if [ "$1" != "" ]; then
        echo "$1"
    else
        echo "$2"
    fi
}

# Prints prefix + suffix if the suffix is provided.
#
# @example
# var=$(prefixif "foo" "bar")   # will get "foobar"
# var=$(prefixif "foo" "")      # will get ""
# var=$(prefixif "" "bar")      # will get "bar"
#
# @param prefix - The prefix to print if the suffix is not empty.
# @param suffix - The suffix to print if it is not empty.
prefixif() {
    if [ "$2" != "" ]; then
        echo "$1$2"
    else
        echo ""
    fi
}

# Prints prefix + suffix if the prefix is provided.
#
# @example
# var=$(suffixif "foo" "bar")   # will get "foobar"
# var=$(suffixif "foo" "")      # will get "foo"
# var=$(suffixif "" "bar")      # will get ""
#
# @param prefix - The prefix to print if it is not empty.
# @param suffix - The suffix to print if the prefix is not empty.
suffixif() {
    if [ "$1" != "" ]; then
        echo "$1$2"
    else
        echo ""
    fi
}

# Prints a variable assignment if the value is provided
#
# @example
# var=$(varif "foo" "bar")   # will get "foo=bar"
# var=$(varif "foo" "bar" 1) # will get "foo=\"bar\""
# var=$(varif "foo" "")      # will get ""
# var=$(varif "foo" "" 1)    # will get ""
# var=$(varif "" "bar")      # will get ""
# var=$(varif "" "bar" 1)    # will get ""
#
# @param name - The name of the variable
# @param value - The value to assign
# @param string - Whether or not the value is a string
varif() {
    local name="$1"
    local value="$2"
    local string="$3"
    if [ "${name}" != "" ]; then
        if [ "${value}" != "" ] && [ "${string}" != "" ]; then
            value="\"${value}\""
        fi
        echo $(prefixif "${name}=" "${value}")
    else
        echo ""
    fi
}

# Prints a vector assignment if the values are provided
#
# @example
# var=$(vectorif "foo" 3 4 5)       # will get "foo=[3, 4, 5]"
# var=$(vectorif "foo" "" 4 5)      # will get "foo=[1, 4, 5]"
# var=$(vectorif "foo" "" "" 5)     # will get "foo=[1, 1, 5]"
# var=$(vectorif "foo" "" "" "")    # will get ""
# var=$(vectorif "foo")             # will get ""
# var=$(vectorif "" 1 2 3)          # will get ""
#
# @param name - The name of the variable
# @param ... - The values to assign
vectorif() {
    local name="$1"; shift
    local values=()
    local -i count=0
    for value in "$@"; do
        if [ "${value}" != "" ]; then
            count+=1
        else
            value=1
        fi
        values+=("${value}")
    done
    if [ ${count} -gt 0 ]; then
        echo "${name}=[$(joinby "," "${values[@]}")]"
    else
        echo ""
    fi
}

# Joins array elements by a glue string
#
# @example
# var=$(joinby "," "a" "b c" "d")           # will get "a,b c,d"
# var=$(joinby "/" "var" "local" "tmp")     # will get "var/local/tmp"
# FOO=("a" "b" "c")
# var=$(joinby "," "${FOO[@]}")             # will get "a,b,c"
#
# @param glue - A glue string to insert between each element.
# @param ... - List of elements.
joinby() {
    local d="$1"
    shift
    echo -n "$1"
    shift
    printf "%s" "${@/#/$d}"
}

# Prints the value to upper case.
#
# @example
# var=$(toupper "value")    # will get "VALUE"
# var=$(toupper "FooBar")   # will get "FOOBAR"
#
# @param ... - The values to print in upper case.
toupper() {
    echo "$*" | awk '{print toupper($0)}'
}

# Prints the value to lower case.
#
# @example
# var=$(tolower "VALUE")    # will get "value"
# var=$(tolower "FooBar")   # will get "foobar"
#
# @param ... - The values to print in lower case.
tolower() {
    echo "$*" | awk '{print tolower($0)}'
}
