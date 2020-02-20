#!/bin/bash
#
# GPLv3 License
#
# Copyright (c) 2019-2020 Jean-Sebastien CONAN
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
# var=$(varif "foo" "")      # will get ""
# var=$(varif "" "bar")      # will get ""
#
# @param name - The name of the variable
# @param value - The value to assign
varif() {
    if [ "$1" != "" ]; then
        echo $(prefixif "$1=" "$2")
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
