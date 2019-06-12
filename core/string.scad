/**
 * @license
 * MIT License
 *
 * Copyright (c) 2017-2019 Jean-Sebastien CONAN
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

/**
 * Part of the camelSCAD library.
 *
 * Operations on strings.
 *
 * @package core/string
 * @author jsconan
 */

/**
 * Wraps a string with prefix and suffix. If no suffix is provided, it will be replaced by the prefix.
 * If the content is empty, no wrap will be done.
 *
 * @param String prefix
 * @param String content
 * @param String [suffix]
 * @returns String
 */
function wrap(prefix, content, suffix) =
    let(
        prefix = string(prefix),
        suffix = string(suffix)
    )
    content ? str(prefix, string(content), or(suffix, prefix))
            : ""
;

/**
 * Extracts a substring from a string.
 *
 * @param String s - The string from which extracts the substring.
 * @param Number [start] - The start index of the substring. If negative, will start from the end.
 * @param Number [length] - The length of the substring to extract.
 * @returns String
 */
function substr(s, start, length) =
    let(
        s = string(s),
        l = len(s),
        start = start < 0 ? max(0, start + l) : integer(start),
        end = min(start + numberOr(length, l), l) - 1
    )
    start <= end ? join([for (i = [start : end]) s[i] ]) : ""
;

/**
 * Gets the index of the first occurence of a substring.
 *
 * @param String s - The string in which searches the occurence.
 * @param String value - The substring to search.
 * @param Number offset - The position to start the search.
 * @returns Number
 */
function indexOf(s, value, offset) =
    let(
        offset = integer(offset),
        index = [ for (p = occurences(s, value)) if (p >= offset) p ]
    )
    len(index) ? index[0] : -1
;

/**
 * Gets the index of the last occurence of a substring.
 *
 * @param String s - The string in which searches the occurence.
 * @param String value - The substring to search.
 * @param Number offset - The position to start the search.
 * @returns Number
 */
function lastIndexOf(s, value, offset) =
    let(
        s = string(s),
        offset = numberOr(offset, len(s) - 1),
        index = [ for (p = occurences(s, value, true)) if (p <= offset) p ]
    )
    len(index) ? index[0] : -1
;

/**
 * Builds a string by joining each items of an array with the provided glue.
 *
 * @param Array terms - The array to join.
 * @param String glue - The glue that will link terms together.
 * @param Number offset - the start offset.
 * @returns String
 */
function join(terms, glue, offset=0) =
    let(
        glue = string(glue),
        terms = array(terms),
        count = len(terms),
        next = offset + 1
    )
    count > next ? str(terms[offset], glue, join(terms, glue, next))
   :count > offset ? terms[offset]
   :""
;

/**
 * Splits a string arround the provided separator.
 *
 * @param String s - The string to split.
 * @param String sep - The separator string.
 * @returns Array
 */
function split(s, sep,
               //internal
               positions, offset=0, i=0) =
    isUndef(positions) ?
        let(
            s = stringOr(s),
            sep = string(sep),
            positions = and(s, occurences(s, sep))
        )
        positions ? split(s, sep, positions) : isUndef(s) ? [] : [s]
    :
        let(
            count = len(positions),
            index = count && i < count ? [
                for (p = [i : count - 1])
                    if (positions[p] >= offset)
                        p
            ] : [],
            i = index[0],
            ok = i >= 0 && i < count,
            start = [substr(s, offset, ok ? positions[i] - offset : undef)]
        )
        ok ? concat(start, split(s, sep, positions, positions[i] + len(sep), i + 1))
        :start
;

/**
 * Replaces occurences in a string.
 *
 * @param String s - The string in which makes the replacements.
 * @param String from - The substring to replace.
 * @param String to - The replacement substring.
 * @returns String
 */
function replace(s, from, to,
                 //internal
                 positions, offset=0, i=0) =
    isUndef(positions) ?
        let(
            s = string(s),
            from = string(from),
            to = string(to),
            positions = occurences(s, from)
        )
        positions ? replace(s, from, to, positions) : s
    :
        let(
            count = len(positions),
            index = count && i < count ? [
                for (p = [i : count - 1])
                    if (positions[p] >= offset)
                        p
            ] : [],
            i = index[0],
            ok = i >= 0 && i < count,
            start = substr(s, offset, ok ? positions[i] - offset : undef)
        )
        ok ? str(start, to, replace(s, from, to, positions, positions[i] + len(from), i + 1))
        :start
;

/**
 * Lists the positions of each occurences of a substring.
 *
 * @param String s - The string in which searches the occurences.
 * @param String value - The substring to search.
 * @param Boolean reverse - Reverse the search order.
 * @returns String
 */
function occurences(s, value, reverse) =
    let(
        s = string(s),
        value = string(value),
        length = len(value),
        lastInString = len(s) - 1,
        lastInValue = length - 1,
        stringStart = reverse ? lastInString : 0,
        stringEnd = reverse ? 0 : lastInString,
        valueStart = reverse ? lastInValue : 0,
        valueEnd = reverse ? 0 : lastInValue,
        step = reverse ? -1 : 1,
        index = reverse ? lastInValue : 0,
        positions = lastInString < 0 || lastInValue < 0 ? [] : [
            for (i = [stringStart : step : stringEnd])
                if (s[i] == value[0]) [
                    for (j = [valueStart : step : valueEnd])
                        let( p = i + j )
                            if (p <= lastInString && s[p] == value[j])
                                p
                ]
        ]
    )
    [ for (p = positions) if (len(p) == length) p[index]]
;
