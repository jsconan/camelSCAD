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
 * Operations on vectors.
 *
 * @package core/vector
 * @author jsconan
 */

/**
 * Adds a value on each elements of a vector.
 *
 * @param Vector v - The vector to add.
 * @param Number value - The value to add.
 * @returns Vector
 */
function vadd(v, value) =
    len(v) ?
    let( value = float(value) )
    [ for (i = v) float(i) + value ]
   :[]
;

/**
 * Subtracts a value from each elements of a vector.
 *
 * @param Vector v - The vector to subtract.
 * @param Number value - The value to subtract.
 * @returns Vector
 */
function vsub(v, value) =
    len(v) ?
    let( value = float(value) )
    [ for (i = v) float(i) - value ]
   :[]
;

/**
 * Multiplies two vectors, elements by elements.
 *
 * @param Vector a - The first vector to multiply.
 * @param Vector b - The second vector to multiply.
 * @returns Vector
 */
function vmul(a, b) =
    let(
        lenA = len(a),
        lenB = len(b)
    )
    lenA && lenB ? [
        for (i = [0 : max(lenA, lenB) - 1])
            float(a[i]) * float(b[i])
    ]
   :[]
;

/**
 * Divides two vectors, elements by elements.
 *
 * @param Vector a - The vector to divide.
 * @param Vector b - The vector that will divide.
 * @returns Vector
 */
function vdiv(a, b) =
    let(
        lenA = len(a),
        lenB = len(b)
    )
    lenA && lenB ? [
        for (i = [0 : max(lenA, lenB) - 1])
            float(a[i]) / divisor(b[i])
    ]
   :[]
;

/**
 * Compares each elements of a vector with a value and keep the smallest.
 *
 * @param Vector v - The vector to check.
 * @param Number value - The minimum value.
 * @returns Vector
 */
function vmin(v, value) =
    len(v) ? let( value = float(value) )
    [ for (i = v) min(float(i), value) ]
   :[]
;

/**
 * Compares each elements of a vector with a value and keep the biggest.
 *
 * @param Vector v - The vector to check.
 * @param Number value - The maximum value.
 * @returns Vector
 */
function vmax(v, value) =
    len(v) ? let( value = float(value) )
    [ for (i = v) max(float(i), value) ]
   :[]
;

/**
 * Computes the power of each vector elements.
 *
 * @param Vector v - The vector to power.
 * @param Number [power] - The power value.
 * @returns Vector
 */
function vpow(v, power=2) =
    len(v) ? let( power = float(power) )
    [ for (i = v) pow(float(i), power) ]
   :[]
;

/**
 * Computes the absolute value of each vector elements.
 *
 * @param Vector v - The vector to absolute.
 * @returns Vector
 */
function vabs(v) =
    len(v) ? [ for (i = v) abs(float(i)) ]
           : []
;

/**
 * Computes the sign of each vector elements.
 *
 * @param Vector v - The vector to sign.
 * @returns Vector
 */
function vsign(v) =
    len(v) ? [ for (i = v) float(sign(i)) ]
           : []
;

/**
 * Computes the sum of all elements from a vector.
 *
 * @param Vector v - The vector to sum.
 * @returns Number
 */
function vsum(v,
               // internal
               p, l) =
    let(
        p = float(p),
        l = numberOr(l, float(len(v)))
    )
    l <= 4 ? (
        l <= 1 ? float(v[p])
       :float(v[p]) + float(v[p + 1]) + (
            l > 2 ? float(v[p + 2]) + (
                l > 3 ? float(v[p + 3]) : 0
            ) : 0
        )
    )
   :let(
        half = floor(l / 2)
    )
    vsum(v, p, half) + vsum(v, p + half, l - half)
;

/**
 * Computes the average of all elements in a vector.
 *
 * @param Vector v - The vector to average.
 * @returns Number
 */
function vaverage(v) =
    let( count = len(v) )
    count ? vsum(v) / count
          : 0
;

/**
 * Computes the factorial of N and put the result of each iterations in a vector.
 *
 * @param Number n
 * @returns Vector
 */
function vfactorial(n,
                    // internal
                    i=0, fact=1) =
    let(
        isnum = isNumber(n),
        n = isnum ? n : 0,
        fact = fact * or(i, 1)
    )
    !isnum || i > n ? [] : concat([fact], vfactorial(n, i + 1, fact))
;

/**
 * Converts each vector elements in positive or negative factors.
 * Strictly positive values will be replaced by 1, while other values will be replaced by -1.
 *
 * @param Vector v - The vector to convert.
 * @returns Vector
 */
function vfactor(v) =
    !isArray(v) ? (v ? 1 : -1)
   :len(v) == 0 ? v
   :[ for (b = v) b ? 1 : -1 ]
;

/**
 * Converts each elements of an array into boolean values.
 *
 * @param Array - The array to convert.
 * @param Boolean bool - Whether or not use true boolean values instead of O and 1.
 * @returns Array
 */
function vboolean(a, bool) =
    let(
        t = bool ? true : 1,
        f = bool ? false : 0
    )
    !isArray(a) ? (a ? t : f)
    :len(a) == 0 ? a
    :[ for (b = a) b ? t : f ]
;
