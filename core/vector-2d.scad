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
   :[ float(v.x), float(v.y) ]
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
   :[ divisor(v.x), divisor(v.y) ]
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
        float(uor(x, n ? v : v.x)),
        float(uor(y, n ? v : v.y))
    ]
;

/**
 * Produces a vector that only contains a value for the X-axis. Other components are zeroed.
 *
 * @param Number [x] - The value for the X-axis.
 * @returns Vector - Always returns a 2D vector that will only contain a value for the X-axis.
 */
function xAxis2D(x=1) = [numberOr(x, 1), 0];

/**
 * Produces a vector that only contains a value for the Y-axis. Other components are zeroed.
 *
 * @param Number [Y] - The value for the Y-axis.
 * @returns Vector - Always returns a 2D vector that will only contain a value for the Y-axis.
 */
function yAxis2D(y=1) = [0, numberOr(y, 1)];

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
        x = abs(float(uor(x, n ? v : v.x))),
        y = abs(float(uor(y, n ? v : v.y)))
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
    :[ float(v.y), -float(v.x) ]
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
    :[ float(v.y), float(v.x) ]
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
        n = i.x * j.y - i.y * j.x
    )
    n ? (
        let(
            k = -(a.x * j.y - c.x * j.y - j.x * a.y + j.x * c.y) / n
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
            a = getAngle(v.x, v.y) + asin(r / d)
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
        v = i.x == j.x,
        h = i.y == j.y
    )
    h && v ? (
        approx(pow(i.x - c.x, 2) + pow(i.y - c.y, 2), r * r) ? [i, j] : []
    )
   :v ? (
        let(
            a = abs(i.x - c.x)
        )
        a <= r ? (
            let(
                b = pythagoras(a, 0, r)
            )
            [
                [i.x, c.y - b],
                [i.x, c.y + b]
            ]
        )
       :[]

    )
   :h ? (
       let(
           a = abs(i.y - c.y)
       )
       a <= r ? (
           let(
               b = pythagoras(a, 0, r)
           )
           [
               [c.x - b, i.y],
               [c.x + b, i.y]
           ]
       )
      :[]
    )
   :(
        let(
            v = i - j,
            a = v.y / v.x,
            b = i.y - a * i.x,
            x = quadraticEquation(
                1 + a * a,
                2 * (-c.x + (b - c.y) * a),
                c.x * c.x + c.y * c.y + (c.y * -2 + b) * b - r * r
            )
        )
        x ? (
            [
                [x.x, a * x.x + b],
                [x.y, a * x.y + b]
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
        v = c1.x == c2.x,
        h = c1.y == c2.y
    )
    v && h ? []
   :v ? (
        let(
            a = c2.y - c1.y,
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
           a = c2.x - c1.x,
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
            x12 = c1.x * c1.x,
            y12 = c1.y * c1.y,
            r12 = r1 * r1,
            a = (c2.x * c2.x + c2.y * c2.y - x12 - y12 + r12 - r2 * r2) / (2 * (c2.y - c1.y)),
            b = (c2.x - c1.x) / (c2.y - c1.y),
            x = quadraticEquation(
                b * b + 1,
                (-c1.x + (c1.y - a) * b) * 2,
                (2 * -c1.y + a) * a + x12 + y12 - r12
            )
        )
        x ? (
            [
                [x.x, a - x.x * b],
                [x.y, a - x.y * b]
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
        w = getAngle(v.x, v.y)
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
    getAngle(v.x, v.y)
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
        angleA = getAngle(a.x, a.y),
        angleB = getAngle(b.x, b.y),
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
    is_undef(v) || is_undef(a) ? ORIGIN_2D
   :let(
       v = vector2D(v),
       a = float(a)
    )
    [
        v.x * cos(a) - v.y * sin(a),
        v.y * cos(a) + v.x * sin(a)
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
    is_undef(v) || is_undef(a) ? ORIGIN_2D
   :let(
        v = vector2D(v),
        a = vector2D(a),
        ax2 = a.x * a.x,
        ay2 = a.y * a.y,
        a2xy = 2 * a.x * a.y,
        a2 = divisor(ax2 + ay2)
    )
    [
        (ax2 * v.x - ay2 * v.x + a2xy * v.y) / a2,
        (ay2 * v.y - ax2 * v.y + a2xy * v.x) / a2
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
        r.x * cos(a),
        r.y * sin(a)
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
        float(p.x) * factor.x,
        float(p.y) * factor.y
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
        ax2 = a.x * a.x,
        ay2 = a.y * a.y,
        a2xy = 2 * a.x * a.y,
        a2 = divisor(ax2 + ay2)
    )
    [ for(p = points) let( v = vector2D(p) ) [
        (ax2 * v.x - ay2 * v.x + a2xy * v.y) / a2,
        (ay2 * v.y - ax2 * v.y + a2xy * v.x) / a2
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
        size.x / divisor(dim.x),
        size.y / divisor(dim.y)
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
    b.y - b.x
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
                        [ min(pt1.x, pt2.x, pt3.x, pt4.x),
                          min(pt1.y, pt2.y, pt3.y, pt4.y) ],
                        [ max(pt1.x, pt2.x, pt3.x, pt4.x),
                          max(pt1.y, pt2.y, pt3.y, pt4.y) ]
                    ]
                )
               :[
                    [ min(pt1.x, pt2.x, pt3.x),
                      min(pt1.y, pt2.y, pt3.y) ],
                    [ max(pt1.x, pt2.x, pt3.x),
                      max(pt1.y, pt2.y, pt3.y) ]
                ]
            )
           :[
                [ min(pt1.x, pt2.x),
                  min(pt1.y, pt2.y) ],
                [ max(pt1.x, pt2.x),
                  max(pt1.y, pt2.y) ]
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
        [ min(left[0].x, right[0].x),
          min(left[0].y, right[0].y) ],
        [ max(left[1].x, right[1].x),
          max(left[1].y, right[1].y) ]
    ]
;

/**
 * Generates a range to interpolate 2D coordinates given a step between 0 and 1, from a low and high coordinate.
 * Start and end thresholds allows to define at what position between 0 and 1 to begin and to stop the interpolation.
 *
 * @param Vector low - The bottom coordinates of the range to interpolate.
 * @param Vector high - The top coordinates of the range to interpolate.
 * @param Number [start] - The start threshold under what the low value will persist and above what it will be interpolated.
 * @param Number [end] - The end threshold above what the high value will persist and under what it will be interpolated.
 * @param Number [scale] - The percentage scale (default: 100).
 * @returns Vector
 */
function simpleInterpolationRange2D(low, high, start, end, scale) =
    let(
        low = vector2D(low),
        high = vector2D(high)
    )
    [
        simpleInterpolationRange(low=low.x, high=high.x, start=start, end=end, scale=scale),
        simpleInterpolationRange(low=low.y, high=high.y, start=start, end=end, scale=scale)
    ]
;

/**
 * Generates a range to interpolate 2D coordinates given a step between 0 and 1, from a list of coordinates.
 * Start and end thresholds allows to define at what position between 0 and 1 to begin and to stop the interpolation.
 * The index of each coordinate will be mapped to a position between the start and end positions.
 *
 * @param Vector values - The list of coordinates composing the range to interpolate.
 * @param Number [start] - The start threshold under what the first coordinate of the range will persist and above what it will be interpolated.
 * @param Number [end] - The end threshold above what the last coordinate of the range will persist and under what it will be interpolated.
 * @param Number [scale] - The percentage scale (default: 100).
 * @returns Vector
 */
function interpolationRange2D(values, start, end, scale) =
    let(
        values = array(values),
        count = len(values),
        start = abs(percentage(numberOr(start, 0), scale=scale)),
        end = abs(percentage(numberOr(end, 1), scale=scale)),
        first = min(start, end),
        last = max(start, end),
        step = (last - first) / divisor(count - 1),
        range = count ? [ for (i = [0 : count - 1]) [first + step * i, vector2D(values[i]) ] ]
                      : []
    )
    count ? [
                [ for (v = range) [v[0], v[1].x ] ],
                [ for (v = range) [v[0], v[1].y ] ]
            ]
          : range
;

/**
 * Interpolates 2D coordinates given a step between 0 and 1.
 *
 * @param Number step - A step between 0 and 1.
 * @param Vector low - The bottom coordinates of the range to interpolate.
 * @param Vector high - The top coordinates of the range to interpolate.
 * @param Number [start] - The start threshold under what the low coordinates will persist and above what they will be interpolated.
 * @param Number [end] - The end threshold above what the high coordinates will persist and under what they will be interpolated.
 * @param Number [scale] - The percentage scale (default: 100).
 * @param Vector [values] - A list of coordinates composing the range to interpolate.
 * @param Vector [range] - A pre-built interpolation range. If missing, it will be built from the parameters `low`, `high`, `start`, `end`, `scale`.
 * @returns Number
 */
function interpolateStep2D(step, low, high, start, end, scale, values, range) =
    let(
        range = is_list(range) ? range
               :is_list(values) ? interpolationRange2D(values=values, start=start, end=end, scale=scale)
               :simpleInterpolationRange2D(low=low, high=high, start=start, end=end, scale=scale)
    )
    [
        interpolateStep(step, range=range.x),
        interpolateStep(step, range=range.y)
    ]
;
