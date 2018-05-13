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
 * Maths and arithmetic operations.
 *
 * @package core/maths
 * @author jsconan
 */

/**
 * Ensures an angle is defined within degree range (-360..360).
 *
 * @param Number a - The angle.
 * @returns Number
 */
function deg(a) =
    let(
        a = float(a),
        angle = a % DEGREES
    )
    !angle && abs(a) >= DEGREES ? sign(a) * DEGREES
                                : angle
;

/**
 * Ensures an angle is defined within an absolute degree range (0..360).
 *
 * @param Number a - The angle.
 * @returns Number
 */
function absdeg(a) =
    let( angle = deg(a) )
    angle < 0 ? deg(angle + DEGREES)
              : angle
;

/**
 * Ensures an angle is defined within an absolute straight angle range (0..180).
 *
 * @param Number a - The angle.
 * @returns Number
 */
function straight(a) =
    let( a = absdeg(a) )
    a > STRAIGHT ? DEGREES - a
                 : a
;

/**
 * Computes the number of fragments needed to draw a circle with the provided radius.
 *
 * @param Number [r] - The radius of the circle.
 * @param Number [d] - The diameter of the circle.
 * @returns Number
 */
function fragments(r, d) =
    let( d = or(float(d), float(r) * 2) )
    d < MIN_SIZE * 2 ? 3
   :$fn ? max(3, $fn)
   :max(5, ceil(min(DEGREES / max($fa, MIN_ANGLE), d * PI / max($fs, MIN_ANGLE))))
;

/**
 * Computes the step angle needed to draw a circle with the provided radius.
 *
 * @param Number [r] - The radius of the circle.
 * @param Number [a] - An optional angle to cover, default to 360.
 * @param Number [d] - The diameter of the circle.
 * @returns Number
 */
function astep(r, a=DEGREES, d) = min(DEGREES / fragments(r=r, d=d), float(a));

/**
 * Computes a length based on the Pythagore's theorem.
 *
 * @param Number a - The A side of the rectangle (0 or undef to compute this value).
 * @param Number b - The B side of the rectangle (0 or undef to compute this value).
 * @param Number c - The hypotenuse of the rectangle (0 or undef to compute this value).
 * @returns Number
 */
function pythagore(a, b, c) =
    sqrt(c ? pow(float(c), 2) - pow(a ? float(a) : float(b), 2)
           : pow(float(a), 2) + pow(float(b), 2))
;

/**
 * Computes the apothem of a regular N-sides polygon.
 * An apothem is a line from the center of a regular polygon at right angles
 * to any of its sides.
 * The apothem can be computed either from the radius of the inscribed circle
 * or from the length of one side. Only one of these values is required, if
 * both are provided, the radius is predominant.
 *
 * @param Number n - The number of sides (min 3).
 * @param Number [r] - The radius of the inscribed circle.
 * @param Number [a] - The length of a side.
 * @returns Number
 */
function apothem(n, r, a) =
    let (
        n = max(float(n), 3)
    )
    r ? float(r) * cos(PI / n)
      : float(a) / 2 * tan(PI / n)
;

/**
 * Computes the factorial of N.
 *
 * @param Number n
 * @returns Number
 */
function factorial(n) =
    let( n = float(n) )
    n > 0 ? factorial(n - 1) * n : 1
;

/**
 * Forces a value to be within the provided domain.
 *
 * @param Number value - The value to limit.
 * @param Number low - The lowest value of the domain.
 * @param Number high - The highest value of the domain.
 * @returns Number
 */
function limit(value, low, high) =
    let(
        value = float(value),
        low = float(low),
        high = float(high)
    )
    min(max(min(low, high), value), max(low, high))
;

/**
 * Rounds a value with the requested precision.
 *
 * @param Number value - The value to round.
 * @param Number precision - The number of decimal digits.
 * @returns Number
 */
function fixed(value, precision) =
    let(
        precision = pow(10, float(precision))
    )
    round(float(value) * precision) / precision
;

/**
 * Rounds a value by the provided unit.
 *
 * @param Number value - The value to round.
 * @param Number unit - The value to round.
 * @returns Number
 */
function roundBy(value, unit) =
    let(
        unit = divisor(unit)
    )
    round(float(value) / unit) * unit
;

/**
 * Rounds a value by the provided unit to the lowest.
 *
 * @param Number value - The value to round.
 * @param Number unit - The value to round.
 * @returns Number
 */
function floorBy(value, unit) =
    let(
        unit = divisor(unit)
    )
    floor(float(value) / unit) * unit
;

/**
 * Rounds a value by the provided unit to the highest.
 *
 * @param Number value - The value to round.
 * @param Number unit - The value to round.
 * @returns Number
 */
function ceilBy(value, unit) =
    let(
        unit = divisor(unit)
    )
    ceil(float(value) / unit) * unit
;

/**
 * Counts the number of decimals in the fractional part of the number.
 *
 * @param Number value - The value to analyse.
 * @returns Number
 */
function decimals(value) =
    let(
        value = abs(float(value))
    )
    isZero(value) ? 0
   :let(
        value = value - floor(value)
    )
    isZero(value) ? 0 : min(1 + decimals(value * 10), MAX_DECIMALS)
;
