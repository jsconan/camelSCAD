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
    isNumber(value) ? [ value, value, value ]
   :[ float(value[0]), float(value[1]), float(value[2]) ]
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
    isNumber(value) ? let( value = divisor(value) ) [ value, value, value ]
   :[ divisor(value[0]), divisor(value[1]), divisor(value[2]) ]
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
        n = isNumber(v),
        d = uor(d, r ? r * 2 : r),
        x = uor(x, d),
        y = uor(y, d),
        z = uor(z, d)
    )
    [
        float(uor(x, n ? v : v[0])),
        float(uor(y, n ? v : v[1])),
        float(uor(z, n ? v : v[2]))
    ]
;

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
        size[0] / divisor(dim[0]),
        size[1] / divisor(dim[1]),
        size[2] / divisor(dim[2])
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
    b[1] - b[0]
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
                        [ min(pt1[0], pt2[0], pt3[0], pt4[0]),
                          min(pt1[1], pt2[1], pt3[1], pt4[1]),
                          min(pt1[2], pt2[2], pt3[2], pt4[2]) ],
                        [ max(pt1[0], pt2[0], pt3[0], pt4[0]),
                          max(pt1[1], pt2[1], pt3[1], pt4[1]),
                          max(pt1[2], pt2[2], pt3[2], pt4[2]) ]
                    ]
                )
               :[
                    [ min(pt1[0], pt2[0], pt3[0]),
                      min(pt1[1], pt2[1], pt3[1]),
                      min(pt1[2], pt2[2], pt3[2]) ],
                    [ max(pt1[0], pt2[0], pt3[0]),
                      max(pt1[1], pt2[1], pt3[1]),
                      max(pt1[2], pt2[2], pt3[2]) ]
                ]
            )
           :[
                [ min(pt1[0], pt2[0]),
                  min(pt1[1], pt2[1]),
                  min(pt1[2], pt2[2]) ],
                [ max(pt1[0], pt2[0]),
                  max(pt1[1], pt2[1]),
                  max(pt1[2], pt2[2]) ]
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
        [ min(left[0][0], right[0][0]),
          min(left[0][1], right[0][1]),
          min(left[0][2], right[0][2]) ],
        [ max(left[1][0], right[1][0]),
          max(left[1][1], right[1][1]),
          max(left[1][2], right[1][2]) ]
    ]
;
