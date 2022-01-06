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
    !r.x || !r.y || (!a1 && !a2) ? []
   :let(
        start = min(a1, a2),
        end = max(a1, a2),
        range = end - start,
        step = astep(max(r), absdeg(range)),
        inc = sign(a2 - a1) * step
    )
    complete(
        // intermediate points
        range <= step ? []
       :[ for (a = [a1 + inc : inc : a2]) arcp(r, a) + o ],
        // the start point
        arcp(r, a1) + o,
        // the final point
        arcp(r, a2) + o
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
 * @param Vector t - A translation offset.
 * @returns Vector[]
 */
function sinusoid(l, w, h, p, o, a, t) =
    let(
        a = deg(a),
        l = float(l),
        w = divisor(w),
        h = divisor(h),
        t = vector2D(t),
        s = sign(l),
        step = s * abs(l / (fragments(w) * l / w))
    )
    !l ? []
   :[
        for (x = [0 : step : l])
            let( p = sinp(x=x, w=w, h=h, p=p, o=o) )
            t + (a ? rotp(p, a) : p)
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
 * @param Vector t - A translation offset.
 * @returns Vector[]
 */
function cosinusoid(l, w, h, p, o, a, t) =
    let(
        a = deg(a),
        l = float(l),
        w = divisor(w),
        h = divisor(h),
        t = vector2D(t),
        s = sign(l),
        step = s * l / (fragments(w) * l / w)
    )
    !l ? []
   :[
        for (y = [0 : step : l])
            let( p = cosp(y=y, w=w, h=h, p=p, o=o) )
            t + (a ? rotp(p, a) : p)
    ]
;

/**
 * Computes a line from a path.
 *
 * A path is composed of commands, each one being a simple array starting by the
 * command name. Each command will produce points relative to the last command
 * or to the last existing point. When the line starts it will rely on the
 * existing points, if any. If no existing points is provided, the line will
 * start from the absolute origin ([0, 0]), unless the first command is a point.
 *
 * The following commands are recognized:
 * - P, Point: ["P", <x>, <y>] | ["P", <point>] - Adds a point at the given absolute coordinates.
 * - L, Line: ["L", <x>, <y>] | ["L", <point>] - Adds a line from the last point to the given relative coordinates.
 * - H, Horizontal line: ["H", <length>] - Adds an horizontal line from the last point with the given length. The sign of the length determines the direction.
 * - V, Vertical line: ["V", <length>] - Adds a vertical line from the last point with the given length. The sign of the length determines the direction.
 * - I, Intersection: ["I", <P1>, <P2>, <P3>] - Adds a line from the last point, that pass through P1 and intersects with the line defined by P2 and P3.
 * - T, Tangent: ["T", <x>, <y>, <radius>] | ["T", <point>, <radius>] - Adds a line from the last point, that ends at the tangent point with the defined circle. The sign of the radius determines the direction
 * - A, Angle: ["A", <angle>, <length>] - Adds a leaned line from the last point with the given angle and the given length. The sign of the length determines the direction.
 * - C, Circle: ["C", <radius>, <start angle>, <end angle>] - Adds a circle arc from the last point with the given radius and with the given angle.
 * - S, Sinusoid curve: ["S", <length>, <wave>, <height>, <phase>, <angle>] - Adds a sinusoid curve from the last point with the given parameters.
 * - B, Bezier curve: ["B", <P1>, <P2>, <P3>] - Adds a cubic bezier curve from the last point with the given control points (up to 3, the first beeing the last existing point).
 * - N, Nested: ["N", [<SubPath>]] - Nested path to execute.
 * - R, Repeat: ["R", <N>, [<SubPath>]] - Repeat N times the sub path.
 *
 * @param Array p - The path from which build the line
 * @param Vector[] points - The existing points to start the line from.
 * @param Number i - The start index in the path (default: 0)
 * @returns Vector[]
 */
function path(p, points, i) =
    let(
        p = array(p),
        i = integer(i),
        points = array(points),
        length = len(points),
        point = vector2D(points[length - 1]),
        cur = array(p[i]),
        cmd = cur[0],
        l = len(cur)
    )
    i >= len(p) ? points
   :let(
        values = (
            l <= 1 ? [point]
            :cmd == "P" || cmd == "p" ? [isVector(cur[1]) ? vector2D(cur[1]) : apply2D(x=cur[1], y=cur[2])]
            :cmd == "L" || cmd == "l" ? [point, point + (isVector(cur[1]) ? vector2D(cur[1]) : apply2D(x=cur[1], y=cur[2]))]
            :cmd == "H" || cmd == "h" ? [point, point + apply2D(x=cur[1])]
            :cmd == "V" || cmd == "v" ? [point, point + apply2D(y=cur[1])]
            :cmd == "I" || cmd == "i" ? [point, intersect2D(point, cur[1], cur[2], cur[3])]
            :cmd == "T" || cmd == "t" ? let(isv = isVector(cur[1])) [point, tangent2D(point, isv ? cur[1] : apply2D(x=cur[1], y=cur[2]), isv ? cur[2] : cur[3])]
            :cmd == "A" || cmd == "a" ? [point, point + arcPoint(a=cur[1], r=cur[2])]
            :cmd == "C" || cmd == "c" ? arc(r=cur[1], a1=cur[2], a2=cur[3], o=point + arcPoint(a=float(cur[2]) + STRAIGHT, r=cur[1]))
            :cmd == "S" || cmd == "s" ? sinusoid(l=cur[1], w=cur[2], h=cur[3], p=cur[4], a=cur[5], t=point)
            :cmd == "B" || cmd == "b" ? (
                l >= 4 ? concat([point], cubicBezierCurve(point, point + vector2D(cur[1]), point + vector2D(cur[2]), point + vector2D(cur[3])))
               :l == 3 ? concat([point], quadraticBezierCurve(point, point + vector2D(cur[1]), point + vector2D(cur[2])))
               :[point, point + vector2D(cur[1])]
            )
            :cmd == "N" || cmd == "n" ? path(p=cur[1], points=[point])
            :cmd == "R" || cmd == "r" ? path(p=times(cur[2], cur[1]), points=[point])
            :[]
        )
    )
    path(p=p, points=concat(values[0] == point ? slice(points, 0, -1) : points, values), i=i + 1)
;

/**
 * Computes the outline of a polygon. The outline can be at a particular distance.
 *
 * @param Vector[] points - The points defining the polygon to outline.
 * @param Number distance - The distance from the polygon for the outline.
 *                          A positive distance will place the outline outside,
 *                          while a negative distance will place it inside.
 * @returns Vector[]
 */
function outline(points, distance) =
    let(
        points = array(points),
        l = len(points),
        prev = l - 1,
        next = 1
    )
    l >= 3 ? [
        for (i = [0 : 1 : l - 1])
            vertexOutline2D(
                a=points[(i + prev) % l],
                v=points[i],
                b=points[(i + next) % l],
                distance=distance
            )
    ] : points
;

/**
 * Adds a value to each point of a line.
 *
 * @param Vector[] points - The points defining the line.
 * @param Number|Vector value - The value to add to the line.
 * @returns Vector[]
 */
function lineAdd(points, value) =
    let(
        points = array(points),
        l = max(
            len(arrayOr(value, [])),
            len(arrayOr(points[0], []))
        ),
        value = vector3D(value)
    )
    l > 2 ? [ for (p = points) vector3D(p) + value ]
          : [ for (p = points) vector2D(p) + value ]
;

/**
 * Builds a vector of faces to be used in a polyhedron. The function accepts the
 * number of points defining one main face of the polyhedron, then returns the
 * faces vector that contains the indices of each face enclosing the solid. This
 * only apply on simple polyhedron where two opposite faces share the same
 * number of points.
 *
 * @param Number length - The number of points for one main face of the polyhedron
 * @returns Vector[]
 */
function simplePolyhedronFaces(length) =
    let(
        length = integer(length)
    )
    length < 3 ? []
   :let(
       r1 = 0,
       r2 = length - 1,
       r3 = length,
       r4 = length * 2 - 1
   )
    concat([
        range(r1, r2),
        range(r4, r3)
    ], [
        for (i = [r1 : r2]) [
            r3 + i,
            r3 + (i + 1) % length,
            (r1 + i + 1) % length
        ]
    ], [
        for (i = [r1 : r2]) [
            r3 + i,
            (r1 + i + 1) % length,
            r1 + i
        ]
    ])
;

/**
 * Composes a list of points to be used in a simple polyhedron.
 *
 * @param Vector[] [bottom] - The list of points for the bottom face.
 * @param Vector[] [top] - The list of points for the top face.
 * @param Vector[] [points] - The list of points for a main face.
 * @param Vector [distance] - The distance between two main faces.
 * @param Number [x] - The distance between two main faces on the X-axis.
 * @param Number [y] - The distance between two main faces on the Y-axis.
 * @param Number [z] - The distance between two main faces on the Z-axis.
 * @returns Vector[]
 */
function simplePolyhedronPoints(bottom, top, points, distance, x, y, z) =
    let(
       distance = apply3D(v=distance, x=x, y=y, z=z)
    )
    top && bottom ? concat(
        [ for (p = bottom) vector3D(p) ],
        [ for (p = top) vector3D(p) + distance ]
    )
   :let(
       points = [ for (p = (points ? points : (top ? top : bottom))) vector3D(p) ]
   )
   concat(
       points,
       [ for (p = points) p + distance ]
   )
;
