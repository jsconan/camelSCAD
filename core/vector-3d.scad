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
 * 3D vectors handling.
 *
 * @package core/vector
 * @author jsconan
 */

/**
 * Ensures the value is a 3D vector. Incomplete vectors will be completed with 0,
 * while too big vectors will be truncated. If a single number is provided instead
 * of a vector, a vector filled with the provided number will be returned.
 * Other values will be replaced by 0.
 *
 * @param Vector|Number v - The value that should be a vector.
 * @returns Vector - Always returns a 3D vector.
 */
function vector3D(value) =
    is_num(value) ? [ value, value, value ]
   :[ float(value.x), float(value.y), float(value.z) ]
;

/**
 * Ensures the value is a 3D vector and does not contain 0. Incomplete vectors will
 * be completed with 1, while too big vectors will be truncated. If a single number
 * is provided instead of a vector, a vector filled with the provided number will
 * be returned. Other values will be replaced by 1.
 *
 * @param Vector|Number value - The value that should be a vector.
 * @returns Vector - Always returns a 3D vector that will not contain 0.
 */
function divisor3D(value) =
    is_num(value) ? let( value = divisor(value) ) [ value, value, value ]
   :[ divisor(value.x), divisor(value.y), divisor(value.z) ]
;

/**
 * Builds a 3D vector from the provided coordinates. Incomplete vectors will be
 * completed with 0, while too big vectors will be truncated. If a single number
 * is provided instead of a vector, a vector filled with the provided number will
 * be returned. Other values will be replaced by 0.
 *
 * @param Vector [v] - A vector to update.
 * @param Number [x] - The X-coordinate to apply.
 * @param Number [y] - The Y-coordinate to apply.
 * @param Number [z] - The Z-coordinate to apply.
 * @param Number [r] - A radius, if the vector is intended to define a circle.
 * @param Number [d] - A diameter, if the vector is intended to define a circle.
 * @returns Vector - Always returns a 3D vector.
 */
function apply3D(v, x, y, z, r, d) =
    let(
        n = is_num(v),
        d = uor(d, r ? r * 2 : r),
        x = uor(x, d),
        y = uor(y, d),
        z = uor(z, d)
    )
    [
        float(uor(x, n ? v : v.x)),
        float(uor(y, n ? v : v.y)),
        float(uor(z, n ? v : v.z))
    ]
;

/**
 * Produces a vector that only contains a value for the X-axis. Other components are zeroed.
 *
 * @param Number [x] - The value for the X-axis.
 * @returns Vector - Always returns a 3D vector that will only contain a value for the X-axis.
 */
function xAxis3D(x=1) = [numberOr(x, 1), 0, 0];

/**
 * Produces a vector that only contains a value for the Y-axis. Other components are zeroed.
 *
 * @param Number [Y] - The value for the Y-axis.
 * @returns Vector - Always returns a 3D vector that will only contain a value for the Y-axis.
 */
function yAxis3D(y=1) = [0, numberOr(y, 1), 0];

/**
 * Produces a vector that only contains a value for the Z-axis. Other components are zeroed.
 *
 * @param Number [Z] - The value for the Z-axis.
 * @returns Vector - Always returns a 3D vector that will only contain a value for the Z-axis.
 */
function zAxis3D(z=1) = [0, 0, numberOr(z, 1)];

/**
 * Normalizes a vector as `norm(v) = 1`.
 * Ensures the value is a 3D vector. Incomplete vectors will be completed with 0,
 * while too big vectors will be truncated. If a single number is provided instead
 * of a vector, a vector filled with the provided number will be returned.
 * Other values will be replaced by 0.
 *
 * @param Vector v - The vector to normalize.
 * @returns Vector - Always returns a 3D vector.
 */
function unit3D(v) =
    let( v = vector3D(v) )
    v / divisor(norm(v))
;

/**
 * Computes a point at the middle.
 *
 * @param Vector a - The first point.
 * @param Vector b - The second point.
 * @returns Vector - The point at the middle.
 */
function middle3D(a, b) = (vector3D(a) + vector3D(b)) / 2;

/**
 * Moves a point in the wanted direction by a particular distance.
 *
 * @param Vector p - The point to move.
 * @param Vector v - The direction (will be normalized).
 * @param Number d - The distance to move.
 * @returns Vector
 */
function move3D(p, v, d) = vector3D(p) + unit3D(v) * float(d);

/**
 * Computes the point at the wanted distance from the origin on the defined line.
 * The line is defined by two points: the origin and another arbitrary point.
 *
 * @param Vector a - The origin of the line.
 * @param Vector b - The second point on the line.
 * @param Number d - The distance from the origin where to find the wanted point.
 * @returns Vector
 */
function extend3D(a, b, d) =
    let(
        a = vector3D(a),
        b = vector3D(b),
        d = float(d)
    )
    a + unit3D(b - a) * d
;

/**
 * Computes the angle between two 3D vectors.
 *
 * @param Vector [a] - The first vector
 * @param Vector [b] - The second vector
 * @returns Number
 */
function angle3D(a, b) =
    let(
        a = vector3D(a),
        b = vector3D(b)
    )
    vangle(a, b)
;

/**
 * Computes the vertex angle given three 3D point.
 *
 * @param Vector [a] - The first point
 * @param Vector [b] - The second point
 * @param Vector [v] - The vertex point
 * @returns Number
 */
function vertexAngle3D(a, b, v) =
    let(
        v = vector3D(v),
        a = vector3D(a) - v,
        b = vector3D(b) - v
    )
    vangle(a, b)
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
        v.x,
        v.y * cos(a) - v.z * sin(a),
        v.y * sin(a) + v.z * cos(a)
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
        v.z * cos(a) - v.x * sin(a),
        v.y,
        v.z * sin(a) + v.x * cos(a)
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
        v.x * cos(a) - v.y * sin(a),
        v.x * sin(a) + v.y * cos(a),
        v.z
    ]
;

/**
 * Computes the scale factor needed to resize a list of 3D points to fit in the requested size.
 *
 * @param Vector[] points - The points to scale.
 * @param Vector|Number size - The size in which the points should fit.
 *                             Can be a number or a vector that contains dimensions.
 * @returns Vector
 */
function scaleFactor3D(points, size) =
    !size ? divisor3D()
   :let(
        size = divisor3D(size),
        dim = dimensions3D(points)
    )
    [
        size.x / divisor(dim.x),
        size.y / divisor(dim.y),
        size.z / divisor(dim.z)
    ]
;

/**
 * Computes the dimensions of the space occupied by a list of 3D points.
 *
 * @param Vector[] points - The points to dimension.
 * @returns Vector
 */
function dimensions3D(points) =
    let(
        b = boundaries3D(points)
    )
    b.y - b.x
;

/**
 * Computes the boundaries of the space occupied by a list of 3D points.
 *
 * @param Vector[] points - The points from which get the boundaries.
 * @returns Vector[]
 */
function boundaries3D(v,
                    // internal
                    p, l) =
    let(
        p = float(p),
        l = numberOr(l, len(arrayOr(v, [])))
    )
    l <= 4 ? (
        let(
            pt1 = vector3D(v[p])
        )
        l > 1 ? (
            let(
                pt2 = vector3D(v[p + 1])
            )
            l > 2 ? (
                let(
                    pt3 = vector3D(v[p + 2])
                )
                l > 3 ? (
                    let(
                        pt4 = vector3D(v[p + 3])
                    )
                    [
                        [ min(pt1.x, pt2.x, pt3.x, pt4.x),
                          min(pt1.y, pt2.y, pt3.y, pt4.y),
                          min(pt1.z, pt2.z, pt3.z, pt4.z) ],
                        [ max(pt1.x, pt2.x, pt3.x, pt4.x),
                          max(pt1.y, pt2.y, pt3.y, pt4.y),
                          max(pt1.z, pt2.z, pt3.z, pt4.z) ]
                    ]
                )
               :[
                    [ min(pt1.x, pt2.x, pt3.x),
                      min(pt1.y, pt2.y, pt3.y),
                      min(pt1.z, pt2.z, pt3.z) ],
                    [ max(pt1.x, pt2.x, pt3.x),
                      max(pt1.y, pt2.y, pt3.y),
                      max(pt1.z, pt2.z, pt3.z) ]
                ]
            )
           :[
                [ min(pt1.x, pt2.x),
                  min(pt1.y, pt2.y),
                  min(pt1.z, pt2.z) ],
                [ max(pt1.x, pt2.x),
                  max(pt1.y, pt2.y),
                  max(pt1.z, pt2.z) ]
            ]
        )
       :[pt1, pt1]
    )
   :let(
        half = floor(l / 2),
        left = boundaries3D(v, p, half),
        right = boundaries3D(v, p + half, l - half)
    )
    [
        [ min(left[0].x, right[0].x),
          min(left[0].y, right[0].y),
          min(left[0].z, right[0].z) ],
        [ max(left[1].x, right[1].x),
          max(left[1].y, right[1].y),
          max(left[1].z, right[1].z) ]
    ]
;

/**
 * Interpolates 3D coordinates given a step between 0 and 1.
 *
 * @param Number step - A step between 0 and 1.
 * @param Vector low - The bottom coordinates of the range to interpolate.
 * @param Vector high - The top coordinates of the range to interpolate.
 * @param Number [start] - The start threshold under what the low coordinates will persist and above what they will be interpolated.
 * @param Number [end] - The end threshold above what the high coordinates will persist and under what they will be interpolated.
 * @param Number [scale] - The percentage scale (default: 100).
 * @param Vector [range] - A pre-built interpolation range. If missing, it will be built from the parameters `low`, `high`, `start`, `end`, `scale`.
 * @returns Number
 */
function interpolateStep3D(step, low, high, start, end, scale, range) =
    let(
        low = vector3D(low),
        high = vector3D(high)
    )
    [
        interpolateStep(step=step, low=low.x, high=high.x, start=start, end=end, scale=scale, range=is_list(range) ? range.x : undef),
        interpolateStep(step=step, low=low.y, high=high.y, start=start, end=end, scale=scale, range=is_list(range) ? range.y : undef),
        interpolateStep(step=step, low=low.z, high=high.z, start=start, end=end, scale=scale, range=is_list(range) ? range.z : undef)
    ]
;
