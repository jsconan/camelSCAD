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
 * 2D vectors handling.
 *
 * @package core/vector
 * @author jsconan
 */

/**
 * Ensures the value is a 2D vector. Incomplete vectors will be completed with 0,
 * while too big vectors will be truncated. If a single number is provided instead
 * of a vector, a vector filled with the provided number will be returned.
 * Other values will be replaced by 0.
 *
 * @param Vector|Number v - The value that should be a vector.
 * @returns Vector - Always returns a 2D vector.
 */
function vector2D(v) =
    isNumber(v) ? [ v, v ]
   :[ float(v[0]), float(v[1]) ]
;

/**
 * Ensures the value is a 2D vector and does not contain 0. Incomplete vectors will
 * be completed with 1, while too big vectors will be truncated. If a single number
 * is provided instead of a vector, a vector filled with the provided number will
 * be returned. Other values will be replaced by 1.
 *
 * @param Vector|Number value - The value that should be a vector.
 * @returns Vector - Always returns a 2D vector that will not contain 0.
 */
function divisor2D(v) =
    isNumber(v) ? let( v = divisor(v) ) [ v, v ]
   :[ divisor(v[0]), divisor(v[1]) ]
;

/**
 * Builds a 2D vector from the provided coordinates. Incomplete vectors will be
 * completed with 0, while too big vectors will be truncated. If a single number
 * is provided instead of a vector, a vector filled with the provided number will
 * be returned. Other values will be replaced by 0.
 *
 * @param Vector [v] - A vector to update.
 * @param Number [x] - The X-coordinate to apply.
 * @param Number [y] - The Y-coordinate to apply.
 * @param Number [r] - A radius, if the vector is intended to define a circle.
 * @param Number [d] - A diameter, if the vector is intended to define a circle.
 * @returns Vector - Always returns a 2D vector.
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
 * Gets the length of a 2D vector.
 * Ensures the value is a 2D vector. Incomplete vectors will be completed with 0,
 * while too big vectors will be truncated. If a single number is provided instead
 * of a vector, a vector filled with the provided number will be returned.
 * Other values will be replaced by 0.
 *
 * @param Vector v - The vector from which gets the length.
 * @returns Number
 */
function norm2D(v) =
    let( v = vector2D(v) )
    sqrt(v[0] * v[0] + v[1] * v[1])
;

/**
 * Normalizes a vector as `norm(v) = 1`.
 * Ensures the value is a 2D vector. Incomplete vectors will be completed with 0,
 * while too big vectors will be truncated. If a single number is provided instead
 * of a vector, a vector filled with the provided number will be returned.
 * Other values will be replaced by 0.
 *
 * @param Vector v - The vector to normalize.
 * @returns Vector - Always returns a 2D vector.
 */
function unit2D(v) =
    let( v = vector2D(v) )
    v / divisor(sqrt(v[0] * v[0] + v[1] * v[1]))
;

/**
 * Gets an orthogonal vector of the given vector.
 * Ensures the value is a 2D vector. Incomplete vectors will be completed with 0,
 * while too big vectors will be truncated. If a single number is provided instead
 * of a vector, a vector filled with the provided number will be returned.
 * Other values will be replaced by 0.
 *
 * @param Vector v - The vector from which get an orthogonal vector.
 * @returns Vector - Always returns a 2D vector.
 */
function normal(v) =
    isNumber(v) ? [ v, -v ]
    :[ float(v[1]), -float(v[0]) ]
;

/**
 * Flips the coordinates of a 2D vector.
 * Ensures the value is a 2D vector. Incomplete vectors will be completed with 0,
 * while too big vectors will be truncated. If a single number is provided instead
 * of a vector, a vector filled with the provided number will be returned.
 * Other values will be replaced by 0.
 *
 * @param Vector v - The vector to flip.
 * @returns Vector - Always returns a 2D vector.
 */
function flip(v) =
    isNumber(v) ? [ v, v ]
    :[ float(v[1]), float(v[0]) ]
;

/**
 * Computes a point at the middle.
 *
 * @param Vector a - The first point.
 * @param Vector b - The second point.
 * @returns Vector - The point at the middle.
 */
function middle2D(a, b) = (vector2D(a) + vector2D(b)) / 2;

/**
 * Moves a point in the wanted direction by a particular distance.
 *
 * @param Vector p - The point to move.
 * @param Vector v - The direction (will be normalized).
 * @param Number d - The distance to move.
 * @returns Vector
 */
function move2D(p, v, d) = vector2D(p) + unit2D(v) * float(d);

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
function rotp(v, a) = [
    v[0] * cos(a) - v[1] * sin(a),
    v[1] * cos(a) + v[0] * sin(a)
];

/**
 * Mirrors a 2D vector around a particular axis.
 *
 * @param Vector v - The vector to rotate.
 * @param Number a - The mirror axis.
 * @returns Vector
 */
function mirp(v, a) =
    let(
        ua = unit2D(a),
        uv = unit2D(v),
        cost = uv * ua,
        sint = uv[0] * ua[1] - uv[1] * ua[0],
        cos2t = cost * cost - sint * sint,
        sin2t = 2 * sint * cost
    )
    [
        cos2t * v[0] - sin2t * v[1],
        sin2t * v[0] + cos2t * v[1],
    ]
;

/**
 * Computes the coordinates of a point on an ellipse given an angle and a radius vector.
 *
 * @param Vector [r] - The radius of the ellipse.
 * @param Number [a] - The radius angle.
 * @returns Vector
 */
function arcp(r, a) = [
    r[0] * cos(a),
    r[1] * sin(a)
];

/**
 * Computes the coordinates of a point on a circle given an angle and a radius.
 *
 * @param Number|Vector [r] - The radius of the circle. Can be a vector to compute an ellipse point.
 * @param Number [a] - The radius angle.
 * @param Number [x] - The X-coordinate, will overide the X in the radius vector.
 * @param Number [y] - The Y-coordinate, will overide the Y in the radius vector.
 * @returns Vector
 */
function arcPoint(r, a, x, y) = arcp(apply2D(r, x, y), deg(a));

/**
 * Rotates a list of 2D points.
 *
 * @param Vector[] points - The points to rotate.
 * @param Number a - The rotate angle.
 * @returns Vector[]
 */
function rotate2D(points, a) =
    !len(points) ? []
   :let(
        a = deg(a)
    )
    [ for(p = points) rotp(vector2D(p), a) ]
;

/**
 * Scales a list of 2D points.
 *
 * @param Vector[] points - The points to scale.
 * @param Vector|Number factor - A scale factor. Can be a number or a vector that contains scale factors for each axis.
 * @returns Vector[]
 */
function scale2D(points, factor) =
    !len(points) ? []
   :let(
        factor = divisor2D(factor)
    )
    [ for (p = points) [
        float(p[0]) * factor[0],
        float(p[1]) * factor[1]
    ] ]
;

/**
 * Resizes a list of 2D points to fit in the requested size.
 *
 * @param Vector[] points - The points to scale.
 * @param Vector|Number size - The size in which the points should fit.
 *                             Can be a number or a vector that contains dimensions.
 * @returns Vector[]
 */
function resize2D(points, size) = scale2D(points, scaleFactor2D(points, size));

/**
 * Mirrors a list of 2D points around the provided axis.
 *
 * @param Vector[] points - The points to mirror.
 * @param Vector axis - The mirror axis.
 * @returns Vector[]
 */
function mirror2D(points, axis) =
    !len(points) ? []
   :let(
        axis = undef == axis ? [0, 1] : vector2D(axis)
    )
    [ for(p = points) mirp(vector2D(p), axis) ]
;

/**
 * Computes the scale factor needed to resize a list of 2D points to fit in the requested size.
 *
 * @param Vector[] points - The points to scale.
 * @param Vector|Number size - The size in which the points should fit.
 *                             Can be a number or a vector that contains dimensions.
 * @returns Vector
 */
function scaleFactor2D(points, size) =
    !size ? divisor2D()
   :let(
        size = divisor2D(size),
        dim = dimensions2D(points)
    )
    [
        size[0] / divisor(dim[0]),
        size[1] / divisor(dim[1])
    ]
;

/**
 * Computes the dimensions of the space occupied by a list of 2D points.
 *
 * @param Vector[] points - The points to dimension.
 * @returns Vector
 */
function dimensions2D(points) =
    let(
        b = boundaries2D(points)
    )
    b[1] - b[0]
;

/**
 * Computes the boundaries of the space occupied by a list of 2D points.
 *
 * @param Vector[] points - The points from which get the boundaries.
 * @returns Vector[]
 */
function boundaries2D(points,
                      // internal
                      p, l) =
    let(
        p = float(p),
        l = numberOr(l, float(len(points)))
    )
    l <= 4 ? (
        let(
            pt1 = vector2D(points[p])
        )
        l > 1 ? (
            let(
                pt2 = vector2D(points[p + 1])
            )
            l > 2 ? (
                let(
                    pt3 = vector2D(points[p + 2])
                )
                l > 3 ? (
                    let(
                        pt4 = vector2D(points[p + 3])
                    )
                    [
                        [ min(pt1[0], pt2[0], pt3[0], pt4[0]),
                          min(pt1[1], pt2[1], pt3[1], pt4[1]) ],
                        [ max(pt1[0], pt2[0], pt3[0], pt4[0]),
                          max(pt1[1], pt2[1], pt3[1], pt4[1]) ]
                    ]
                )
               :[
                    [ min(pt1[0], pt2[0], pt3[0]),
                      min(pt1[1], pt2[1], pt3[1]) ],
                    [ max(pt1[0], pt2[0], pt3[0]),
                      max(pt1[1], pt2[1], pt3[1]) ]
                ]
            )
           :[
                [ min(pt1[0], pt2[0]),
                  min(pt1[1], pt2[1]) ],
                [ max(pt1[0], pt2[0]),
                  max(pt1[1], pt2[1]) ]
            ]
        )
       :[pt1, pt1]
    )
   :let(
        half = floor(l / 2),
        left = boundaries2D(points, p, half),
        right = boundaries2D(points, p + half, l - half)
    )
    [
        [ min(left[0][0], right[0][0]),
          min(left[0][1], right[0][1]) ],
        [ max(left[1][0], right[1][0]),
          max(left[1][1], right[1][1]) ]
    ]
;
