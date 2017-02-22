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
 * Lines handling.
 *
 * @package core/line
 * @author jsconan
 */

/**
 * Computes the coordinates of a 2D arc by rotating a vector along the provided angle.
 *
 * @param Number|Vector r - The number or the vector that defines the radius of the arc (can be ellipse).
 * @param Number [a] - The angle to cover.
 * @param Vector [o] - The coordinates of the center of the arc.
 * @param Number [a1] - The start angle of the arc.
 * @param Number [a2] - The end angle of the arc.
 * @returns Vector[]
 */
function arc(r, a=DEGREES, o, a1, a2) =
    let(
        r = vector2D(r),
        o = vector2D(o),
        a1 = deg(a1),
        a2 = a2 != undef ? deg(a2) : a1 + deg(a)
    )
    !r[0] || !r[1] || (!a1 && !a2) ? []
   :let(
        start = min(a1, a2),
        end = max(a1, a2),
        step = astep(max(r), absdeg(end - start))
    )
    complete(
        // intermediate points
        end - start <= step ? []
       :[ for (a = [start + step : step : end]) arcp(r, a) + o ],
        // the start point
        arcp(r, start) + o,
        // the final point
        arcp(r, end) + o
    )
;

/**
 * Computes a sinusoid wave.
 * Without angle, the line will be horizontal.
 *
 * @param Number l - The length of the curve.
 * @param Number w - The wave length.
 * @param Number h - The amplitude of the sinusoid.
 * @param Number p - The phase of the sinusoid (the start angle).
 * @param Number o - The offset of the sinusoid.
 * @param Number a - A rotation angle.
 * @returns Vector
 */
function sinusoid(l, w, h, p, o, a) =
    let(
        a = deg(a),
        l = float(l),
        step = l / fragments(l)
    )
    [
        for (x = [0 : step : l])
            let( p = sinp(x=x, w=w, h=h, p=p, o=o) )
            a ? rotp(p, a) : p
    ]
;

/**
 * Computes a cosinusoid wave.
 * Without angle, the line will be vertical.
 *
 * @param Number l - The length of the curve.
 * @param Number w - The wave length.
 * @param Number h - The amplitude of the cosinusoid.
 * @param Number p - The phase of the cosinusoid (the start angle).
 * @param Number o - The offset of the cosinusoid.
 * @param Number a - A rotation angle.
 * @returns Vector
 */
function cosinusoid(l, w, h, p, o, a) =
    let(
        a = deg(a),
        l = float(l),
        step = l / fragments(l)
    )
    [
        for (y = [0 : step : l])
            let( p = cosp(y=y, w=w, h=h, p=p, o=o) )
            a ? rotp(p, a) : p
    ]
;
