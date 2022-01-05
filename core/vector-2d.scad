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
    is_num(v) ? [ v, v ]
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
    is_num(v) ? let( v = divisor(v) ) [ v, v ]
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
        n = is_num(v),
        d = uor(d, r ? r * 2 : r),
        x = uor(x, d),
        y = uor(y, d)
    )
    [
        float(uor(x, n ? v : v[0])),
        float(uor(y, n ? v : v[1]))
    ]
;

/**
 * Gets a point on a particular quadrant.
 * @param Vector v - The original point
 * @param Number i - The index of the quadrant (from 0 to 3)
 * @param Number [x] - The X-coordinate to apply.
 * @param Number [y] - The Y-coordinate to apply.
 * @returns Vector - Always returns a 2D vector that gives the point on the
 *                   requested quadrant.
 */
function quadrant(v, i, x, y) =
    let(
        n = is_num(v),
        i = integer(i) % 4,
        x = abs(float(uor(x, n ? v : v[0]))),
        y = abs(float(uor(y, n ? v : v[1])))
    )
    i == 1 ? [-x,  y]
   :i == 2 ? [-x, -y]
   :i == 3 ? [ x, -y]
           : [ x,  y]
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
function norm2D(v) = norm(vector2D(v));

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
    v / divisor(norm(v))
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
    is_num(v) ? [ v, -v ]
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
    is_num(v) ? [ v, v ]
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
 * Computes the point at the wanted distance from the origin on the defined line.
 * The line is defined by two points: the origin and another arbitrary point.
 *
 * @param Vector a - The origin of the line.
 * @param Vector b - The second point on the line.
 * @param Number d - The distance from the origin where to find the wanted point.
 * @returns Vector
 */
function extend2D(a, b, d) =
    let(
        a = vector2D(a),
        b = vector2D(b),
        d = float(d)
    )
    a + unit2D(b - a) * d
;

/**
 * Computes the center of a cicle that pass through two points.
 *
 * @param Number a - The first point.
 * @param Number b - The second point.
 * @param Number r - The radius of the circle. It must be larger than, or equal, the distance between the two points.
 * @param Boolean [negative] - Select whether the center should be in the positive (`false`, default) or the negative (`true`) side.
 * @returns Number
 */
function center2D(a, b, r, negative) =
    let(
        a = vector2D(a),
        b = vector2D(b),
        ab = negative ? a - b : b - a
    )
    move2D(
        middle2D(a, b),
        normal(ab),
        pythagoras(0, norm(ab) / 2, float(r))
    )
;

/**
 * Computes a parallel line. The source line is defined by two points.
 * The parallel line will be defined by two other points translated by
 * the provided distance.
 *
 * @param Vector a - The first point on the line.
 * @param Vector b - The second point on the line.
 * @param Number d - The distance to the parallel line. The sign determines the direction
 * @returns Vector[]
 */
function parallel2D(a, b, d) =
    let(
        a = vector2D(a),
        b = vector2D(b),
        v = normal(unit2D(b - a)),
        d = float(d)
    )
    [
        a + v * d,
        b + v * d
    ]
;

/**
 * Computes the point at the intersection of two lines.
 * Each line is defined by two points.
 * If the lines cannot intersect (i.e. are parallel), returns the first point.
 *
 * @param Vector a - The first point on the first line.
 * @param Vector b - The second point on the first line.
 * @param Vector c - The first point on the second line.
 * @param Vector d - The second point on the second line.
 * @returns Vector
 */
function intersect2D(a, b, c, d) =
    let(
        a = vector2D(a),
        b = vector2D(b),
        c = vector2D(c),
        d = vector2D(d),
        i = b - a,
        j = d - c,
        n = i[0] * j[1] - i[1] * j[0]
    )
    n ? (
        let(
            k = -(a[0] * j[1] - c[0] * j[1] - j[0] * a[1] + j[0] * c[1]) / n
        )
        a + k * i
    )
   :a
;

/**
 * Computes the point at the intersection of a circle and a tangent line.
 * The center is defined by a center and a radius.
 * The line is defined by a point.
 *
 * @param Vector p - A point on the line that should be tangent to the circle
 * @param Vector c - The center of the circle.
 * @param Number r - The radius of the circle
 * @returns Vector
 */
function tangent2D(p, c, r) =
    let(
        p = vector2D(p),
        c = vector2D(c),
        r = float(r),
        v = c - p,
        d = norm2D(v)
    )
    d > r ? (
        let(
            t = pythagoras(0, r, d),
            a = getAngle(v[0], v[1]) + asin(r / d)
        )
        p + arcPoint(t, a)
    )
   :p
;

/**
 * Computes the points at the intersection of a circle and a line.
 * The circle is defined by a center and a radius.
 * The line is defined by two points.
 * If the function cannot compute the intersection, returns an empty vector.
 *
 * @param Vector i - The first point on the line
 * @param Vector j - The second point on the line
 * @param Vector c - The center of the circle.
 * @param Number r - The radius of the circle
 * @returns Vector[]
 */
function circleLineIntersect2D(i, j, c, r) =
    let(
        i = vector2D(i),
        j = vector2D(j),
        c = vector2D(c),
        r = abs(float(r)),
        v = i[0] == j[0],
        h = i[1] == j[1]
    )
    h && v ? (
        approx(pow(i[0] - c[0], 2) + pow(i[1] - c[1], 2), r * r) ? [i, j] : []
    )
   :v ? (
        let(
            a = abs(i[0] - c[0])
        )
        a <= r ? (
            let(
                b = pythagoras(a, 0, r)
            )
            [
                [i[0], c[1] - b],
                [i[0], c[1] + b]
            ]
        )
       :[]

    )
   :h ? (
       let(
           a = abs(i[1] - c[1])
       )
       a <= r ? (
           let(
               b = pythagoras(a, 0, r)
           )
           [
               [c[0] - b, i[1]],
               [c[0] + b, i[1]]
           ]
       )
      :[]
    )
   :(
        let(
            v = i - j,
            a = v[1] / v[0],
            b = i[1] - a * i[0],
            x = quadraticEquation(
                1 + a * a,
                2 * (-c[0] + (b - c[1]) * a),
                c[0] * c[0] + c[1] * c[1] + (c[1] * -2 + b) * b - r * r
            )
        )
        x ? (
            [
                [x[0], a * x[0] + b],
                [x[1], a * x[1] + b]
            ]
        )
       :[]
    )
;

/**
 * Computes the points at the intersection of two circles.
 * Each circle is defined by a center and a radius.
 * If the function cannot compute the intersection, returns an empty vector.
 *
 * @param Vector c1 - The center of the first circle.
 * @param Number r1 - The radius of the first circle
 * @param Vector c2 - The center of the second circle.
 * @param Number r2 - The radius of the second circle
 * @returns Vector[]
 */
function circleIntersect2D(c1, r1, c2, r2) =
    let(
        c1 = vector2D(c1),
        c2 = vector2D(c2),
        r1 = abs(float(r1)),
        r2 = abs(float(r2)),
        v = c1[0] == c2[0],
        h = c1[1] == c2[1]
    )
    v && h ? []
   :v ? (
        let(
            a = c2[1] - c1[1],
            l = abs(a),
            d = r1 + r2
        )
        l > d ? []
       :l == d ? (
            let(
                p = c1 + [0, sign(a) * r1]
            )
            [ p, p ]
        )
       :(
            let(
                y = (r2 * r2 - a * a - r1 * r1) / (-2 * a),
                x = sqrt(r2 * r2 - (a - y) * (a - y))
            )
            [ c1 + [x, -y], c1 + [x, y] ]
        )
    )
   :h ? (
       let(
           a = c2[0] - c1[0],
           l = abs(a),
           d = r1 + r2
       )
       l > d ? []
      :l == d ? (
           let(
               p = c1 + [sign(a) * r1, 0]
           )
           [ p, p ]
       )
      :(
           let(
               x = (r2 * r2 - a * a - r1 * r1) / (-2 * a),
               y = sqrt(r2 * r2 - (a - x) * (a - x))
           )
           [ c1 + [-x, y], c1 + [x, y] ]
       )
   )
  :(
        let(
            x12 = c1[0] * c1[0],
            y12 = c1[1] * c1[1],
            r12 = r1 * r1,
            a = (c2[0] * c2[0] + c2[1] * c2[1] - x12 - y12 + r12 - r2 * r2) / (2 * (c2[1] - c1[1])),
            b = (c2[0] - c1[0]) / (c2[1] - c1[1]),
            x = quadraticEquation(
                b * b + 1,
                (-c1[0] + (c1[1] - a) * b) * 2,
                (2 * -c1[1] + a) * a + x12 + y12 - r12
            )
        )
        x ? (
            [
                [x[0], a - x[0] * b],
                [x[1], a - x[1] * b]
            ]
        )
       :[]
   )
;

/**
 * Computes the third edge of an isosceles triangle.
 * The edges that have the same angle must be provided.
 * The height or the angle must be provided.
 * If both are provided, the height overrides the angle.
 *
 * @param Vector a - The first edge
 * @param Vector b - The second edge
 * @param Number [h] - The height of the triangle
 * @param Number [angle] - The angle of the triangle
 * @returns Vector
 */
function isosceles2D(a, b, h, angle) =
    let(
        a = vector2D(a),
        b = vector2D(b),
        v = b - a,
        d = norm2D(v) / 2,
        w = getAngle(v[0], v[1])
    )
    h != undef ? (
        let(
            h = float(h),
            r = pythagoras(h, d),
            angle = getAngle(d, h)
        )
        a + arcPoint(r, w + angle)
    )
   :(
       let(
           angle = straight(angle)
       )
       angle < RIGHT ? (
           let(
               r = d / cos(angle)
           )
           a + arcPoint(r, w + angle)
       )
      :a
   )
;

/**
 * Computes the angle of a line defined by two points.
 *
 * @param Vector [a] - The first point on the line
 * @param Vector [b] - The second point on the line
 * @returns Number
 */
function protractor(a, b) =
    let(
        v = vector2D(b) - vector2D(a)
    )
    getAngle(v[0], v[1])
;

/**
 * Computes the angle between two 2D vectors.
 *
 * @param Vector [a] - The first vector
 * @param Vector [b] - The second vector
 * @returns Number
 */
function angle2D(a, b) =
    let(
        a = vector2D(a),
        b = vector2D(b)
    )
    vangle(a, b)
;

/**
 * Computes the vertex angle given three 2D points.
 *
 * @param Vector [a] - The first point
 * @param Vector [b] - The second point
 * @param Vector [v] - The vertex point
 * @returns Number
 */
function vertexAngle2D(a, b, v) =
    let(
        v = vector2D(v),
        a = vector2D(a) - v,
        b = vector2D(b) - v
    )
    vangle(a, b)
;

/**
 * Computes the outline of a vertex at the given distance from the edges.
 * The vertex is defined by three points.
 * The distance from the edges is placed on a normal vector from each edge,
 * and the outline point should be at the intersect of those vectors
 *
 * @param Vector [a] - The first point
 * @param Vector [b] - The second point
 * @param Vector [v] - The vertex point
 * @param Number [distance] - The distance from the edges,
 *                            on a perpendicular line from each edge
 * @returns Vector
 */
function vertexOutline2D(a, b, v, distance) =
    let(
        v = vector2D(v),
        a = vector2D(a) - v,
        b = vector2D(b) - v,
        angleA = getAngle(a[0], a[1]),
        angleB = getAngle(b[0], b[1]),
        angle = (angleB - angleA) / 2,
        length = float(distance) / divisor(abs(sin(angle)))
    )
    v + arcp([length, length], angle < 0 ? angleB - angle + STRAIGHT : angleA + angle)
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
function rotp(v, a) =
    is_undef(v) || is_undef(a) ? [0, 0]
   :let( 
       v = vector2D(v),
       a = float(a)
    )
    [
        v[0] * cos(a) - v[1] * sin(a),
        v[1] * cos(a) + v[0] * sin(a)
    ]
;

/**
 * Mirrors a 2D vector around a particular axis.
 *
 * @param Vector v - The vector to rotate.
 * @param Number a - The mirror axis.
 * @returns Vector
 */
function mirp(v, a) =
    is_undef(v) || is_undef(a) ? [0, 0]
   :let(
        v = vector2D(v),
        a = vector2D(a),
        ax2 = a[0] * a[0],
        ay2 = a[1] * a[1],
        a2xy = 2 * a[0] * a[1],
        a2 = divisor(ax2 + ay2)
    )
    [
        (ax2 * v[0] - ay2 * v[0] + a2xy * v[1]) / a2,
        (ay2 * v[1] - ax2 * v[1] + a2xy * v[0]) / a2
    ]
;

/**
 * Computes the coordinates of a point on an ellipse given an angle and a radius vector.
 *
 * @param Vector [r] - The radius of the ellipse.
 * @param Number [a] - The radius angle.
 * @returns Vector
 */
function arcp(r, a) =
    let(
        r = vector2D(r),
        a = float(a)
    )
    [
        r[0] * cos(a),
        r[1] * sin(a)
    ]
;

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
    !is_list(points) || !len(points) ? []
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
    !is_list(points) || !len(points) ? []
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
    !is_list(points) || !len(points) ? []
   :let(
        a = undef == axis ? [0, 1] : vector2D(axis),
        ax2 = a[0] * a[0],
        ay2 = a[1] * a[1],
        a2xy = 2 * a[0] * a[1],
        a2 = divisor(ax2 + ay2)
    )
    [ for(p = points) let( v = vector2D(p) ) [
        (ax2 * v[0] - ay2 * v[0] + a2xy * v[1]) / a2,
        (ay2 * v[1] - ax2 * v[1] + a2xy * v[0]) / a2
    ] ]
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
        l = numberOr(l, len(arrayOr(points, [])))
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
