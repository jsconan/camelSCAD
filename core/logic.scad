/**
 * @license
 * MIT License
 *
 * Copyright (c) 2017-2022 Jean-Sebastien CONAN
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
 * Returns `true` when the paramaters do not have the same boolean meaning, otherwise return `false`.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @returns *
 */
function xor(a, b) = (!a && b) || (a && !b);

/**
 * Returns the first value if it is defined, otherwise returns the second value.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @returns *
 */
function uor(a, b) = is_undef(a) ? b : a;

/**
 * Returns the second value if the first value is defined.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @returns *
 */
function uand(a, b) = is_undef(a) ? a : b;

/**
 * Gets the first value if it is a number, otherwise gets the second value whatever it is.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @return Number|*
 */
function numberOr(a, b) = is_num(a) ? a : b;

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
function booleanOr(a, b) = is_bool(a) ? a : b;

/**
 * Gets the first value if it is a string, otherwise gets the second value whatever it is.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @return String|*
 */
function stringOr(a, b) = is_string(a) ? a : b;

/**
 * Gets the first value if it is an array, otherwise gets the second value whatever it is.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @return Array|*
 */
function arrayOr(a, b) = is_list(a) ? a : b;

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
    let(
        a = array(a),
        l = len(a)
    )
    l ? len([ for (i = a) if (i) i ]) == l
      : false
;

/**
 * Checks if all elements of an array are falsy.
 *
 * @param Array a - The array to check.
 * @returns Boolean
 */
function allFalse(a) =
    let(
        a = array(a),
        l = len(a)
    )
    l ? len([ for (i = a) if (!i) i ]) == l
      : true
;

/**
 * Checks if all elements of an array are equal.
 *
 * @param Array a - The array to check
 * @returns Boolean
 */
function allSame(a) =
    let(
        a = array(a),
        l = len(a)
    )
    l > 1 ? !len([ for (i = [1 : l - 1]) if (a[i - 1] != a[i]) i ])
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
function contains(a, value) =
    let(
        a = array(a)
    )
    len([ for (i = a) if (i == value) i ]) > 0
;

/**
 * Checks if the provided values are approximately equal. Number will be rounded with the wanted decimal precision.
 * Strings and booleans will be strictly compared. Arrays and vectors will be recursively compared.
 *
 * @param * a - The first value.
 * @param * b - The second value.
 * @param Number [precision] - The wanted decimal precision (default: 5).
 * @returns Boolean
 */
function approx(a, b, precision=5,
                // internal
                p, l) =
    is_list(a) ? (
       !is_list(b) ? false
       :(
            let(
                la = len(a),
                lb = len(b)
            )
            la != lb ? false
           :!l && (!la || concat(a) != a) ? a == b
           :let(
                p = float(p),
                l = numberOr(l, la)
            )
            l <= 4 ? (
                let(
                    r1 = approx(a[p], b[p], precision)
                )
                r1 && l > 1 ? (
                    let(
                        r2 = approx(a[p + 1], b[p + 1], precision)
                    )
                    r2 && l > 2 ? (
                        let(
                            r3 = approx(a[p + 2], b[p + 2], precision)
                        )
                        r3 && l > 3 ? approx(a[p + 3], b[p + 3], precision)
                       :r3
                    )
                   :r2
                )
               :r1
            )
           :let(
                half = floor(l / 2)
            )
            approx(a, b, precision, p, half) && approx(a, b, precision, p + half, l - half)
        )
    )
   :is_num(a) ? (
        !is_num(b) ? false
       :(
            let(
                sa = sign(a),
                sb = sign(b)
            )
            sa != sb ? false
           :sa == 0 ? a == b
           :let(
                precision = pow(10, float(precision)),
                a = round(a * precision) / precision,
                b = round(b * precision) / precision
            )
            a == b
        )
    )
   :a == b
;
