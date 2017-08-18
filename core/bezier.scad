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
        tm1 = 1 - float(t),
        tm12 = tm1 * tm1,
        t2 = t * t
    )
    [
        float(p0[0]) * tm12 + float(p1[0]) * 2 * t * tm1 + float(p2[0]) * t2,
        float(p0[1]) * tm12 + float(p1[1]) * 2 * t * tm1 + float(p2[1]) * t2
    ]
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
        tm1 = 1 - float(t),
        tm12 = tm1 * tm1,
        tm13 = tm12 * tm1,
        t2 = t * t,
        t3 = t2 * t
    )
    [
        float(p0[0]) * tm13 + float(p1[0]) * 3 * t * tm12 + float(p2[0]) * 3 * t2 * tm1 + float(p3[0]) * t3,
        float(p0[1]) * tm13 + float(p1[1]) * 3 * t * tm12 + float(p2[1]) * 3 * t2 * tm1 + float(p3[1]) * t3
    ]
;
