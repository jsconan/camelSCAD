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
 * 2D and 3D points handling.
 *
 * @package core/point
 * @author jsconan
 */

/**
 * Builds a 2D vector with the provided coordinates.
 *
 * @param Vector [v] - A vector to update.
 * @param Number [x] - The X-coordinate to apply.
 * @param Number [y] - The Y-coordinate to apply.
 * @param Number [r] - A radius, if the vector is intended to define a circle.
 * @param Number [d] - A diameter, if the vector is intended to define a circle.
 * @returns Vector
 */
function apply2D(v, x, y, r, d) =
    let(
        n = isNumber(v),
        x = uor(x, uor(d, r * 2)),
        y = uor(y, uor(d, r * 2))
    )
    [
        float(uor(x, n ? v : v[0])),
        float(uor(y, n ? v : v[1]))
    ]
;

/**
 * Builds a 3D vector with the provided coordinates.
 *
 * @param Vector [v] - A vector to update.
 * @param Number [x] - The X-coordinate to apply.
 * @param Number [y] - The Y-coordinate to apply.
 * @param Number [z] - The Z-coordinate to apply.
 * @param Number [r] - A radius, if the vector is intended to define a sphere.
 * @param Number [d] - A diameter, if the vector is intended to define a sphere.
 * @returns Vector
 */
function apply3D(v, x, y, z, r, d) =
    let(
        n = isNumber(v),
        x = uor(x, uor(d, r * 2)),
        y = uor(y, uor(d, r * 2)),
        z = uor(z, uor(d, r * 2))
    )
    [
        float(uor(x, n ? v : v[0])),
        float(uor(y, n ? v : v[1])),
        float(uor(z, n ? v : v[2]))
    ]
;

/**
 * Projects a 2D vector with the provided angle.
 *
 * @param Vector [v] - The vector to project.
 * @param Number a - The projection angle.
 * @param Number [x] - The X-coordinate, will overide the X in the vector.
 * @param Number [y] - The Y-coordinate, will overide the Y in the vector.
 * @returns Vector
 */
function project(v, a, x, y) =
    let(
        a = deg(a),
        v = apply2D(v, x, y)
    )
    [
        cos(a) * v[0],
        sin(a) * v[1]
    ]
;

/**
 * Computes the coordinates of a 2D point on a sinusoid wave.
 *
 * @param Number x - The X-coordinate of the point.
 * @param Number w - The length of the wave.
 * @param Number h - The amplitude of the sinusoid.
 * @param Number p - The phase of the sinusoid (the start angle).
 * @param Number o - The offset of the sinusoid.
 * @returns Vector
 */
function sinp(x, w, h, p, o) =
    let(
        x = float(x),
        w = divisor(w),
        h = divisor(h),
        p = float(p),
        o = float(o)
    )
    [
        x,
        h * sin(DEGREES * x / w + p) + o
    ]
;

/**
 * Computes the coordinates of a 2D point on a cosinusoid wave.
 *
 * @param Number y - The Y-coordinate of the point.
 * @param Number w - The length of the wave.
 * @param Number h - The amplitude of the cosinusoid.
 * @param Number p - The phase of the cosinusoid (the start angle).
 * @param Number o - The offset of the cosinusoid.
 * @returns Vector
 */
function cosp(y, w, h, p, o) =
    let(
        y = float(y),
        w = divisor(w),
        h = divisor(h),
        p = float(p),
        o = float(o)
    )
    [
        h * cos(DEGREES * y / w + p) + o,
        y
    ]
;

/**
 * Rotates a 2D vector.
 *
 * @param Vector v - The vector to rotate.
 * @param Number a - The rotate angle.
 * @returns Vector
 */
function rotate2D(v, a) =
    let(
        v = vector2D(v),
        a = deg(a)
    )
    !a ? v
   :[
        v[0] * cos(a) - v[1] * sin(a),
        v[1] * cos(a) + v[0] * sin(a)
    ]
;

/**
 * Rotates a 3D vector around the X axis.
 *
 * @param Vector v - The vector to rotate.
 * @param Number a - The rotate angle.
 * @returns Vector
 */
function rotate3DX(v, a) =
    let(
        v = vector3D(v),
        a = deg(a)
    )
    !a ? v
   :[
        v[0],
        v[1] * cos(a) - v[2] * sin(a),
        v[1] * sin(a) + v[2] * cos(a)
    ]
;

/**
 * Rotates a 3D vector around the Y axis.
 *
 * @param Vector v - The vector to rotate.
 * @param Number a - The rotate angle.
 * @returns Vector
 */
function rotate3DY(v, a) =
    let(
        v = vector3D(v),
        a = deg(a)
    )
    !a ? v
   :[
        v[2] * cos(a) - v[0] * sin(a),
        v[1],
        v[2] * sin(a) + v[0] * cos(a)
    ]
;

/**
 * Rotates a 3D vector around the Z axis.
 *
 * @param Vector v - The vector to rotate.
 * @param Number a - The rotate angle.
 * @returns Vector
 */
function rotate3DZ(v, a) =
    let(
        v = vector3D(v),
        a = deg(a)
    )
    !a ? v
   :[
        v[0] * cos(a) - v[1] * sin(a),
        v[0] * sin(a) + v[1] * cos(a),
        v[2]
    ]
;

/**
 * Computes a point at the middle.
 *
 * @param Vector a - The first point.
 * @param Vector b - The second point.
 * @returns Vector - The point at the middle.
 */
function middle(a, b) = (vector3D(a) + vector3D(b)) / 2;

/**
 * Moves a point in the wanted direction by a particular distance.
 *
 * @param Vector p - The point to move.
 * @param Vector v - The direction (will be normalized).
 * @param Number d - The distance to move.
 * @returns Vector
 */
function move(p, v, d) = vector3D(p) + normalize(v) * float(d);
