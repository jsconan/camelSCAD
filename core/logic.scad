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
 * Comparisons and boolean operations.
 *
 * @package core/logic
 * @author jsconan
 */

/**
 * Returns the first value if it is equivalent to true, otherwise returns the second value.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @returns *
 */
function or(a, b) = a ? a : b;

/**
 * Returns the second value if the first value is equivalent to true.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @returns *
 */
function and(a, b) = a ? b : a;

/**
 * Returns the first value if it is defined, otherwise returns the second value.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @returns *
 */
function uor(a, b) = isUndef(a) ? b : a;

/**
 * Returns the second value if the first value is defined.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @returns *
 */
function uand(a, b) = isUndef(a) ? a : b;

/**
 * Gets the first value if it is a number, otherwise gets the second value whatever it is.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @return Number|*
 */
function numberOr(a, b) = isNumber(a) ? a : b;

/**
 * Gets the first value if it is an integer, otherwise gets the second value whatever it is.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @return Number|*
 */
function integerOr(a, b) = isInteger(a) ? a : b;

/**
 * Gets the first value if it is a boolean, otherwise gets the second value whatever it is.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @return Boolean|*
 */
function booleanOr(a, b) = isBoolean(a) ? a : b;

/**
 * Gets the first value if it is a string, otherwise gets the second value whatever it is.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @return String|*
 */
function stringOr(a, b) = isString(a) ? a : b;

/**
 * Gets the first value if it is an array, otherwise gets the second value whatever it is.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @return Array|*
 */
function arrayOr(a, b) = isArray(a) ? a : b;

/**
 * Gets the first value if it is a vector, otherwise gets the second value whatever it is.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @return Vector|*
 */
function vectorOr(a, b) = isVector(a) ? a : b;

/**
 * Gets the first value if it is a 2D vector, otherwise gets the second value whatever it is.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @return Vector|*
 */
function vector2DOr(a, b) = isVector2D(a) ? a : b;

/**
 * Gets the first value if it is a 3D vector, otherwise gets the second value whatever it is.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @return Vector|*
 */
function vector3DOr(a, b) = isVector3D(a) ? a : b;

/**
 * Checks if all elements of an array are equivalent to true.
 *
 * @param Array a - The array to check.
 * @returns Boolean
 */
function allTrue(a) =
    let( l = len(a) )
    l && !isString(a) ? len([ for (i = a) if (i) i ]) == l
                      : !!a
;

/**
 * Checks if all elements of an array are falsy.
 *
 * @param Array a - The array to check.
 * @returns Boolean
 */
function allFalse(a) =
    let( l = len(a) )
    l && !isString(a) ? len([ for (i = a) if (!i) i ]) == l
                      : !a
;

/**
 * Checks if all elements of an array are equal.
 *
 * @param Array a - The array to check
 * @returns Boolean
 */
function allSame(a) =
    let( l = len(a) )
    l > 1 && !isString(a) ? !len([ for (i = [1 : l - 1]) if (a[i - 1] != a[i]) i ])
                          : true
;

/**
 * Checks if a value is comprised within the given range, inclusive.
 *
 * @param Number value - The value to check.
 * @param Number low - The lowest value of the range.
 * @param Number high - The highest value of the range.
 * @returns Boolean
 */
function between(value, low, high) =
    let(
        value = float(value),
        low = float(low),
        high = float(high)
    )
    (value >= min(low, high) && value <= max(low, high))
;

/**
 * Checks if an array contains a particular value.
 *
 * @param Array a - The array to check.
 * @param * value - The value to search for.
 * @returns Boolean
 */
function contains(a, value) = len([ for (i = a) if (i == value) i ]) > 0;
