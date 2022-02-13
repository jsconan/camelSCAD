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
 * Computes the angle of a point on a circle.
 *
 * @param Number [x] - The X coordinate of the point.
 * @param Number [y] - The Y coordinate of the point.
 * @returns Number
 */
function getAngle(x, y) =
    let(
        x = float(x),
        y = float(y),
        a = x || y ? atan2(y, x)
                   : 0
    )
    a >= 0 ? a
           : a + DEGREES
;

/**
 * Gets the length of an arc given the radius and the angle.
 *
 * @param Number angle - The angle of the arc.
 * @param Number [radius] - The radius of the circle.
 * @param Number [diameter] - The diameter of the circle.
 * @returns Number
 */
function getArcLength(angle, radius, diameter) =
    let(
        diameter = numberOr(diameter, float(radius) * 2),
        angle = float(angle)
    )
    PI * diameter * angle / DEGREES
;

/**
 * Gets the angle of an arc given the radius and the length.
 *
 * @param Number length - The length of the arc.
 * @param Number [radius] - The radius of the circle.
 * @param Number [diameter] - The diameter of the circle.
 * @returns Number
 */
function getArcAngle(length, radius, diameter) =
    let(
        diameter = numberOr(diameter, float(radius) * 2),
        length = float(length)
    )
    !diameter ? 0
   :(length * DEGREES) / (PI * diameter)
;

/**
 * Gets the length of a chord given the radius and the angle.
 *
 * @param Number angle - The angle of the chord.
 * @param Number [radius] - The radius of the circle.
 * @param Number [diameter] - The diameter of the circle.
 * @returns Number
 */
function getChordLength(angle, radius, diameter) =
    let(
        diameter = numberOr(diameter, float(radius) * 2),
        angle = float(angle)
    )
    diameter * sin(angle / 2)
;

/**
 * Gets the height of a chord given the radius and the angle.
 *
 * @param Number angle - The angle of the chord.
 * @param Number [radius] - The radius of the circle.
 * @param Number [diameter] - The diameter of the circle
 * @returns Number
 */
function getChordHeight(angle, radius, diameter) =
    let(
        radius = numberOr(radius, float(diameter) / 2),
        angle = float(angle)
    )
    radius - (radius * cos(angle / 2))
;

/**
 * Gets the distance to a chord given the radius and the angle.
 *
 * @param Number angle - The angle of the chord.
 * @param Number [radius] - The radius of the circle.
 * @param Number [diameter] - The diameter of the circle.
 * @returns Number
 */
function getChordDistance(angle, radius, diameter) =
    let(
        radius = numberOr(radius, float(diameter) / 2),
        angle = float(angle)
    )
    radius * cos(angle / 2)
;

/**
 * Gets the angle of a chord given the radius and the length.
 *
 * @param Number length - The length of the chord.
 * @param Number [radius] - The radius of the circle.
 * @param Number [diameter] - The diameter of the circle.
 * @returns Number
 */
function getChordAngle(length, radius, diameter) =
    let(
        diameter = numberOr(diameter, float(radius) * 2),
        length = float(length)
    )
    !length ? 0
   :asin(length / diameter) * 2
;

/**
 * Gets the angle value at a particular index in a regular polygon.
 *
 * @param Number index - The index of the angle.
 * @param Number [count] - The number of sides in the polygon.
 * @returns Number - The angle for the provided index.
 */
function getPolygonAngle(index, count = 4) =
    let(
        count = divisor(count),
        index = (float(index) + count) % count
    )
    DEGREES / count * index
;

/**
 * Computes a length based on the Pythagoras's theorem.
 *
 * @param Number a - The A side of the rectangle (0 or undef to compute this value).
 * @param Number b - The B side of the rectangle (0 or undef to compute this value).
 * @param Number c - The hypotenuse of the rectangle (0 or undef to compute this value).
 * @returns Number
 */
function pythagoras(a, b, c) =
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
 * @param Number [l] - The length of a side of the polygon.
 * @returns Number
 */
function apothem(n, r, l) =
    let (
        n = max(float(n), 3)
    )
    r ? float(r) * cos(STRAIGHT / n)
      : float(l) / (2 * tan(STRAIGHT / n))
;

/**
 * Computes the radius of a circle circumscribing a regular N-sides polygon.
 * The circumradius can be computed either from the apothem or the side of the
 * circumscribed polygon. Only one of these values is required, if both are
 * provided, the apothem is predominant.
 *
 * @param Number n - The number of sides (min 3).
 * @param Number [a] - The apothem of the regular polygon.
 * @param Number [l] - The length of a side of the polygon.
 * @returns Number
 */
function circumradius(n, a, l) =
    let (
        n = max(float(n), 3),
        a = a ? float(a) : float(l) / (2 * tan(STRAIGHT / n))
    )
    a / cos(STRAIGHT / n)
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
 * Tells whether a value is even or not.
 *
 * @param Number n
 * @returns Boolean
 */
function even(n) = float(n) % 2 == 0;

/**
 * Tells whether a value is odd or not.
 *
 * @param Number n
 * @returns Boolean
 */
function odd(n) = float(n) % 2 != 0;

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

/**
 * Resolves a quadratic equation: `ax^2+bx+c=0`.
 * Returns the result as a vector of two values:
 * - the first value is for the result of (-b - sqrt(delta)) / (2 * a)
 * - the second value is for the result of (-b + sqrt(delta)) / (2 * a)
 * If the equation cannot be resolved, returns an empty vector.
 *
 * @param Number a - The A term of the equation.
 * @param Number b - The B term of the equation.
 * @param Number c - The C term of the equation.
 * @returns Vector[]
 */
function quadraticEquation(a, b, c) =
    let(
        a = float(a) * 2,
        b = float(b),
        c = float(c),
        d = sqrt(b * b - 2 * a * c)
    )
    a && d >= 0 ? [
        (-b - d) / a,
        (-b + d) / a
    ]
   :[]
;

/**
 * Extract the X-coordinate from a linear position.
 *
 * @param Number i - The linear position.
 * @param Number count - The maximal value for the linear position.
 * @returns Number
 */
function iToX(i, count) = float(i) % divisor(count);

/**
 * Extract the X-coordinate from a linear position.
 *
 * @param Number i - The linear position.
 * @param Number count - The maximal value for the linear position.
 * @returns Number
 */
function iToY(i, count) = floor(float(i) / divisor(count));

/**
 * Gets a percentage ratio as a number between 0 and 1.
 *
 * @param Number v - The percentage value. It can be either a number between 1 and `domain` (default: 100), or a value between 0 and 1.
 * @param Number [domain] - The percentage domain applied to compute the percentage ratio (default: 100).
 * @returns Number
 */
function percentage(v, domain) =
    let(
        v = float(v),
        domain = float(domain)
    )
    v < -1 || v > 1 ? v / (domain ? domain : 100)
                    : v
;

/**
 * Generates a range to interpolate a value given a step between 0 and 1, from a low and high value.
 * Start and end thresholds allows to define at what position between 0 and 1 to begin and to stop the interpolation.
 *
 * @param Number low - The bottom value of the range to interpolate.
 * @param Number high - The top value of the range to interpolate.
 * @param Number [start] - The start threshold under what the low value will persist and above what it will be interpolated.
 * @param Number [end] - The end threshold above what the high value will persist and under what it will be interpolated.
 * @param Number [domain] - The percentage domain applied to compute the percentage ratio for the thresholds (default: 100).
 * @returns Vector
 */
function simpleInterpolationRange(low, high, start, end, domain) =
    let(
        low = float(low),
        high = float(high),
        start = abs(percentage(numberOr(start, 0), domain=domain)),
        end = abs(percentage(numberOr(end, 1), domain=domain)),
        first = min(start, end),
        last = max(start, end)
    )
    [
        [first, low],
        [last, high]
    ]
;

/**
 * Generates a range to interpolate a value given a step between 0 and 1, from a list of values.
 * Start and end thresholds allows to define at what position between 0 and 1 to begin and to stop the interpolation.
 * The index of each value will be mapped to a position between the start and end positions.
 *
 * @param Vector values - The list of values composing the range to interpolate.
 * @param Number [start] - The start threshold under what the first value of the range will persist and above what it will be interpolated.
 * @param Number [end] - The end threshold above what the last value of the range will persist and under what it will be interpolated.
 * @param Number [domain] - The percentage domain applied to compute the percentage ratio for the thresholds (default: 100).
 * @returns Vector
 */
function interpolationRange(values, start, end, domain) =
    let(
        values = array(values),
        count = len(values),
        start = abs(percentage(numberOr(start, 0), domain=domain)),
        end = abs(percentage(numberOr(end, 1), domain=domain)),
        first = min(start, end),
        last = max(start, end),
        step = (last - first) / divisor(count - 1)
    )
    count ? [ for (i = [0 : count - 1]) [first + step * i, float(values[i]) ] ]
          : []
;

/**
 * Interpolates a value given a step between 0 and 1.
 *
 * @param Number step - A step between 0 and 1.
 * @param Number [low] - The bottom value of the range to interpolate.
 * @param Number [high] - The top value of the range to interpolate.
 * @param Number [start] - The start threshold under what the low value will persist and above what it will be interpolated.
 * @param Number [end] - The end threshold above what the high value will persist and under what it will be interpolated.
 * @param Number [domain] - The percentage domain applied to compute the percentage ratio for the thresholds (default: 100).
 * @param Vector [values] - A list of values composing the range to interpolate.
 * @param Vector [range] - A pre-built interpolation range. If missing, it will be built from the parameters `low`, `high`, `start`, `end`, `domain`.
 * @returns Number
 */
function interpolateStep(step, low, high, start, end, domain, values, range) =
    lookup(
        float(step),
        is_list(range) ? range
       :is_list(values) ? interpolationRange(values=values, start=start, end=end, domain=domain)
       :simpleInterpolationRange(low=low, high=high, start=start, end=end, domain=domain)
    )
;

/**
 * Computes the threshold for a particular interpolation step considering the expected number of steps,
 * and with respect to start and end thresholds.
 * @param Number step - The current step.
 * @param Number steps - The total number of expected steps.
 * @param Number [start] - The start threshold under what the low value will persist and above what it will be interpolated.
 * @param Number [end] - The end threshold above what the high value will persist and under what it will be interpolated.
 * @param Number [domain] - The percentage domain applied to compute the percentage ratio for the thresholds (default: 100).
 * @returns Number
 */
function interpolationThreshold(step, steps, start, end, domain) =
    let(
        step = float(step),
        steps = divisor(steps),
        start = abs(percentage(numberOr(start, 0), domain=domain)),
        end = abs(percentage(numberOr(end, 1), domain=domain)),
        range = max(start, end) - min(start, end)
    )
    start + step * range / steps
;
