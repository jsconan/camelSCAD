/**
 * @license
 * MIT License
 *
 * Copyright (c) 2017 Jean-Sebastien CONAN
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
 * Operations on lists.
 *
 * @package core/list
 * @author jsconan
 */

/**
 * Fills an array with a value upon the requested length.
 *
 * @param * value - The value to fill with. Can be of any type.
 * @param Number length - The length of the array to fill.
 * @returns Array
 */
function fill(value, length) =
    let( length = float(length) )
    length > 0 ? [ for (i = [0 : length - 1]) value ]
               : []
;

/**
 * Fills an array with a range of values.
 *
 * @param Number start - The start of the range, or the length of the range
 * @param Number [end] - The end of the range.
 * @param Number [step] - The range increment.
 * @returns Array
 */
function range(start, end, step) =
    let(
        s = float(start),
        simple = s && isUndef(end),
        start = simple ? 0 : s,
        end = simple ? s : float(end),
        step = or(number(step), start > end ? -1 : 1)
    )
    start || end ? [ for (i = [start : step : end]) i ]
                 : []
;

/**
 * Returns a list range with the ideal step to cover this range by the required count.
 *
 * @param Number start - The start of the range.
 * @param Number count - The number of steps to cover the range.
 * @param Number end - The end of the range.
 * @returns Number
 */
function steps(start, count, end) =
    let(
        start = float(start),
        end = float(end),
        step = (end - start) / divisor(float(count) - 1)
    )
    [ start : step : end ]
;

/**
 * Reverses an array.
 *
 * @param Array collection - The array to reverse.
 * @returns Array
 */
function reverse(collection) =
    let( collection = arrayOr(collection, []) )
    [ for (i = [len(collection) - 1 : -1 : 0]) collection[i] ]
;

/**
 * Flattens a multi level array to a less deep array.
 *
 * @param Array collection - The array to flatten.
 * @returns Array
 */
function flatten(collection) = [ for (a = arrayOr(collection, [])) for (b = a) b ];

/**
 * Finds the index of a key in a collection.
 *
 * @param Array collection - The collection in which search.
 * @param * key - The key to search in the collection.
 * @returns Number - The position of the key in the collection, or -1 if not found.
 */
function find(collection, key) = numberOr(search([key], collection)[0], -1);

/**
 * Fetches a record from a collection with respect to the provided key.
 *
 * @param Array collection - The collection in which search.
 * @param * key - The key for which fetch the record.
 * @returns * - The record that relates to the key, or undef if not found.
 */
function fetch(collection, key) = collection[find(collection, key)];

/**
 * Checks if an element exists in an array.
 *
 * @param Array collection - The collection from which search the element.
 * @param * elem - The element to search.
 * @returns Boolean
 */
function inArray(collection, elem) = find(collection, elem) > -1;

/**
 * Completes a list with start and end elements, at the condition there are not aleady present.
 *
 * @param Array collection - The list  to complete.
 * @param * start - The start element to add.
 * @param * end - The end element to add.
 * @returns Array
 */
function complete(collection, start, end) =
    let(
        collection = arrayOr(collection, []),
        first = start && start != collection[0] && start != collection[len(collection) - 1] ? concat([start], collection) : collection,
        second = end && end != first[0] && end != first[len(first) - 1] ? concat(first, [end]) : first
    )
    second
;

/**
 * Gets an array slice.
 *
 * @param Array collection - The collection to slice.
 * @param Number [start] - The start index of the slice. If negative, will start from the end.
 * @param Number [end] - The end index of the slice, exclusive.
 * @returns Array
 */
function slice(collection, start, end) =
    let(
        collection = arrayOr(collection, []),
        length = len(collection),
        start = start < 0 ? max(0, length + start) : integer(start),
        end = (end < 0 ? max(start, length + end) : numberOr(end, length)) - 1
    )
    length && start <= end ? [ for (i = [start : end]) if (i < length) collection[i] ]
                           : []
;

/**
 * Changes the contents of an array by removing existing elements and/or adding new elements.
 *
 * @param Array collection - The collection to slice.
 * @param Number [start] - The index at which to start changing the array. If negative, will start from the end.
 * @param Number [remove] - The number of elements to remove.
 * @param Array [elems] - The elements to add to the array, beginning at the start index.
 * @returns Array
 */
function splice(collection, start, remove, elems) =
    let(
        collection = arrayOr(collection, []),
        elems = arrayOr(elems, []),
        length = len(collection),
        start = min(start < 0 ? max(0, length + start) : integer(start), length),
        next = start + numberOr(remove, length - start),
        last = length - 1
    )
    length || len(elems)
   ?concat(
       length && start > 0 ? [ for (i = [0 : start - 1]) collection[i] ] : [],
       elems,
       length && next <= last ? [ for (i = [next : last]) collection[i] ] : []
    )
   :[]
;

/**
 * Gets the N first elements of an array.
 *
 * @param Array collection - The collection from which get the elements.
 * @param Number [count] - The number of elements to get.
 * @returns Array|*
 */
function first(collection, count) =
    let( count = numberOr(count, 1) )
    count > 1 ? slice(collection, 0, count)
          : arrayOr(collection, [])[0]
;

/**
 * Gets the N last elements of an array.
 *
 * @param Array collection - The collection from which get the elements.
 * @param Number [count] - The number of elements to get.
 * @returns *
 */
function last(collection, count) =
    let( count = numberOr(count, 1) )
    count > 1 ? slice(collection, -count)
          : arrayOr(collection, [])[len(collection) - 1]
;

/**
 * Removes the last element of an array.
 *
 * @param Array collection - The collection from which removes the element.
 * @returns Array
 */
function pop(collection) = slice(collection, end=-1);

/**
 * Removes the first element of an array.
 *
 * @param Array collection - The collection from which removes the element.
 * @returns Array
 */
function shift(collection) = slice(collection, 1);

/**
 * Adds an element at the end of an array.
 *
 * @param Array collection - The collection to which add the element.
 * @param * elem - The element to add.
 * @returns Array
 */
function push(collection, elem) = concat(arrayOr(collection, []), [elem]);

/**
 * Adds an element at the beginning of an array.
 *
 * @param Array collection - The collection to which add the element.
 * @param * elem - The element to add.
 * @returns Array
 */
function unshift(collection, elem) = concat([elem], arrayOr(collection, []));

/**
 * Picks elements in an array to build another array.
 *
 * @param Array collection - The collection in which pick the elements.
 * @param Array what - The indexes of the elements to pick.
 * @returns Array
 */
function pick(collection, what) =
    let(
        collection = arrayOr(collection, []),
        length = len(collection),
        what = arrayOr(what, [])
    )
    [ for (i = what) if (i < length) collection[i] ]
;

/**
 * Sorts an array.
 *
 * @param Array collection - The collection to sort.
 * @returns Array
 */
function sort(collection,
              // internal
              nocheck=false) =
    let( length = len(collection) )
    !length || !nocheck && isString(collection) ? []            // not array or empty
   :let( middle = collection[floor(length / 2)] )
    concat(
        sort([ for (i = collection) if (i < middle) i ], true), // lesser
        [ for (i = collection) if (i == middle) i ],            // equal
        sort([ for (i = collection) if (i > middle) i ], true)  // greater
    )
;
