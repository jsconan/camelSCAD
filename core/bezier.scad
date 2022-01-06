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
 * Bezier and other parametric curves.
 *
 * @package core/bezier
 * @author jsconan
 */

/**
 * Computes the coordinates of a point along a quadratic bezier curve.
 *
 * @param Number t - The parametric value, which may vary from 0 to 1.
 * @param Vector p0 - The coordinates of the 1st control point.
 * @param Vector p1 - The coordinates of the 2nd control point.
 * @param Vector p2 - The coordinates of the 3rd control point.
 * @returns Vector - Returns the coordinates of the point.
 */
function quadraticBezierPoint(t, p0, p1, p2) =
    let(
        t = float(t),
        tm1 = 1 - t,
        tm12 = tm1 * tm1,
        t2 = t * t
    )
    vector2D(p0) * tm12 + vector2D(p1) * 2 * t * tm1 + vector2D(p2) * t2
;

/**
 * Computes the coordinates of a point along a cubic bezier curve.
 *
 * @param Number t - The parametric value, which may vary from 0 to 1.
 * @param Vector p0 - The coordinates of the 1st control point.
 * @param Vector p1 - The coordinates of the 2nd control point.
 * @param Vector p2 - The coordinates of the 3rd control point.
 * @param Vector p3 - The coordinates of the 4th control point.
 * @returns Vector - Returns the coordinates of the point.
 */
function cubicBezierPoint(t, p0, p1, p2, p3) =
    let(
        t = float(t),
        tm1 = 1 - t,
        tm12 = tm1 * tm1,
        tm13 = tm12 * tm1,
        t2 = t * t,
        t3 = t2 * t
    )
    vector2D(p0) * tm13 + vector2D(p1) * 3 * t * tm12 + vector2D(p2) * 3 * t2 * tm1 + vector2D(p3) * t3
;

/**
 * Computes the coordinates of a quadratic bezier curve.
 *
 * @param Vector p0 - The coordinates of the 1st control point.
 * @param Vector p1 - The coordinates of the 2nd control point.
 * @param Vector p2 - The coordinates of the 3rd control point.
 * @returns Vector[] - Returns the coordinates of each points in the curve.
 */
function quadraticBezierCurve(p0, p1, p2, recurse) =
    is_undef(recurse)
   ?let(
        p0 = vector2D(p0),
        p1 = vector2D(p1),
        p2 = vector2D(p2)
    )
    complete(
        quadraticBezierCurve(p0, p1, p2, 0),
        p0,
        p2
    )
   :recurse > MAX_RECURSE ? []
   :let(
        p01 = (p0 + p1) / 2,
        p12 = (p1 + p2) / 2,
        p012 = (p01 + p12) / 2,
        finish = !recurse ? false
       :let(
            d12 = p1 - p2,
            d0 = p2 - p0,
            d1 = abs(d12.x * d0.y - d12.y * d0.x),
            tolerance = $fs * $fa * BEZIER_TOLERANCE
        )
        d1 > EPSILON ? d1 < tolerance
                     : let(d = p012 - (p0 + p2) / 2) d.x + d.y <= tolerance
    )
    finish ? [p012] : concat(
        quadraticBezierCurve(p0, p01, p012, recurse + 1),
        quadraticBezierCurve(p012, p12, p2, recurse + 1)
    )
;

/**
 * Computes the coordinates of a cubic bezier curve.
 *
 * @param Vector p0 - The coordinates of the 1st control point.
 * @param Vector p1 - The coordinates of the 2nd control point.
 * @param Vector p2 - The coordinates of the 3rd control point.
 * @param Vector p3 - The coordinates of the 4th control point.
 * @returns Vector[] - Returns the coordinates of each points in the curve.
 */
function cubicBezierCurve(p0, p1, p2, p3, recurse) =
    is_undef(recurse)
   ?let(
        p0 = vector2D(p0),
        p1 = vector2D(p1),
        p2 = vector2D(p2),
        p3 = vector2D(p3)
    )
    complete(
        cubicBezierCurve(p0, p1, p2, p3, 0),
        p0,
        p3
    )
   :recurse > MAX_RECURSE ? []
   :let(
        p01 = (p0 + p1) / 2,
        p12 = (p1 + p2) / 2,
        p23 = (p2 + p3) / 2,
        p012 = (p01 + p12) / 2,
        p123 = (p12 + p23) / 2,
        p0123 = (p012 + p123) / 2,
        finish = !recurse ? false
       :let(
            d13 = p1 - p3,
            d23 = p2 - p3,
            d0 = p3 - p0,
            d1 = abs(d13.x * d0.y - d13.y * d0.x),
            d2 = abs(d23.x * d0.y - d23.y * d0.x),
            tolerance = $fs * $fa * BEZIER_TOLERANCE
        )
        d1 > EPSILON && d2 > EPSILON ? d1 + d2 < tolerance
       :d1 > EPSILON ? d1 < tolerance
       :d2 > EPSILON ? d2 < tolerance
       :let(d = p0123 - (p0 + p3) / 2) d.x + d.y <= tolerance
    )
    finish ? [p0123] : concat(
        cubicBezierCurve(p0, p01, p012, p0123, recurse + 1),
        cubicBezierCurve(p0123, p123, p23, p3, recurse + 1)
    )
;
