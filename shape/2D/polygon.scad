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
 * Polygon shapes.
 *
 * @package shape/2D
 * @author jsconan
 */

/**
 * Computes the size of a rectangle shape.
 *
 * @param Number|Vector [size] - The size of the rectangle.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @returns Vector - Returns the size vector.
 */
function sizeRectangle(size, l, w) =
    let(
        size = apply2D(size, l, w)
    )
    [
        divisor(size[0]),
        divisor(size[1])
    ]
;

/**
 * Computes the size of a trapezium shape.
 *
 * @param Number|Vector [size] - The size of the trapezium.
 * @param Number [a] - The length of the bottom base.
 * @param Number [b] - The length of the top base.
 * @param Number [w] - The width between bases.
 * @returns Vector - Returns the size vector, as [a, b, w].
 */
function sizeTrapezium(size, a, b, w) =
    let(
        size = apply3D(size, a, b, w)
    )
    [
        divisor(size[0]),
        divisor(size[1]),
        divisor(size[2])
    ]
;

/**
 * Computes the size of a regular polygon.
 *
 * @param Number|Vector [size] - The size of the polygon.
 * @param Number [n] - The number of facets (min. 3).
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [s] - The length of a side.
 * @returns Vector - Returns the size vector, as [l, w, n].
 */
function sizeRegularPolygon(size, n, l, w, s) =
    let(
        n = max(3, float(n)),
        size = (s && !size && !l && !w) ? vector2D(2 * divisor(s) / (2 * sin(180 / n)))
                                        : apply2D(size, l, w)
    )
    [
        divisor(size[0]),
        divisor(size[1]),
        n
    ]
;

/**
 * Computes the size of a star shape.
 *
 * @param Number|Vector [size] - The outer size of the star.
 * @param Number|Vector [core] - The size of the core.
 * @param Number [edges] - The number of star edges (min. 3).
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [cl] - The core length.
 * @param Number [cw] - The core width.
 * @returns Vector[] - Returns two vectors containing the outer and core size of the star
 */
function sizeStar(size, core, edges, l, w, cl, cw) =
    let(
        edges = max(3, float(edges)),
        size = divisor2D(apply2D(size, l, w)),
        core = apply2D(core, cl, cw)
    )
    [
        size,
        core == [0, 0] ? size * or(1 - 3 / edges, 0.2) : core,
        edges
    ]
;

/**
 * Computes the points that draw a rectangle shape.
 *
 * @param Number|Vector [size] - The size of the rectangle.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @returns Vector[]
 */
function drawRectangle(size, l, w) =
    let(
        size = sizeRectangle(size=size, l=l, w=w),
        half = size / 2
    )
    [
        [ half[0],  half[1]],
        [-half[0],  half[1]],
        [-half[0], -half[1]],
        [ half[0], -half[1]]
    ]
;

/**
 * Computes the points that draw a trapezium shape.
 *
 * @param Number|Vector [size] - The size of the trapezium.
 * @param Number [a] - The length of the bottom base.
 * @param Number [b] - The length of the top base.
 * @param Number [w] - The width between bases.
 * @returns Vector[w]
 */
function drawTrapezium(size, a, b, w) =
    let(
        size = sizeTrapezium(size=size, a=a, b=b, w=w),
        half = size / 2
    )
    [
        [ half[1],  half[2]],
        [-half[1],  half[2]],
        [-half[0], -half[2]],
        [ half[0], -half[2]]
    ]
;

/**
 * Computes the points that draw a regular polygon.
 *
 * @param Number|Vector [size] - The size of the polygon.
 * @param Number [n] - The number of facets (min. 3).
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [s] - The length of a side.
 * @returns Vector[]
 */
function drawRegularPolygon(size, n, l, w, s) =
    let(
        size = sizeRegularPolygon(size=size, n=n, l=l, w=w, s=s),
        n = size[2],
        step = DEGREES / n,
        radius = size / 2
    )
    [
        for(i = [0 : n - 1])
            arcp(radius, i * step + 90)
    ]
;

/**
 * Computes the points that draw an hexagon.
 *
 * @param Number|Vector [size] - The size of the hexagon.
 * @param Number [adjust] - An adjust length added on the horizontal side
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [s] - The length of a side.
 * @returns Vector[]
 */
function drawHexagon(size, adjust, l, w, s) =
    let(
        n = 6,
        size = sizeRegularPolygon(size=size, n=n, l=l, w=w, s=s),
        step = DEGREES / n,
        o = [float(adjust) / 2, 0],
        radius = size / 2
    )
    [
        arcp(radius, 0) + o,
        arcp(radius, 60) + o,
        arcp(radius, 120) - o,
        arcp(radius, 180) - o,
        arcp(radius, 240) - o,
        arcp(radius, 300) + o
    ]
;

/**
 * Computes the points that draw a star shape.
 *
 * @param Number|Vector [size] - The outer size of the star.
 * @param Number|Vector [core] - The size of the core.
 * @param Number [edges] - The number of star edges (min. 3).
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [cl] - The core length.
 * @param Number [cw] - The core width.
 * @returns Vector[]
 */
function drawStar(size, core, edges, l, w, cl, cw) =
    let(
        size = sizeStar(size=size, core=core, edges=edges, l=l, w=w, cl=cl, cw=cw),
        edges = size[2],
        inner = size[1],
        outer = size[0],
        angle = DEGREES / edges,
        step = angle / 2
    )
    [
        for (i = [0 : 2 * edges - 1])
            let(
                e = floor(i / 2),
                m = i % 2,
                a = angle * e + (m ? step : 0) + 90
            )
            [
                cos(a) * (m ? inner[0] : outer[0]),
                sin(a) * (m ? inner[1] : outer[1])
            ]
    ]
;

/**
 * Creates a rectangle at the origin.
 *
 * @param Number|Vector [size] - The size of the rectangle.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 */
module rectangle(size, l, w) {
    polygon(
        points = drawRectangle(size=size, l=l, w=w),
        convexity = 10
    );
}

/**
 * Creates a trapezium at the origin.
 *
 * @param Number|Vector [size] - The size of the trapezium.
 * @param Number [a] - The length of the bottom base.
 * @param Number [b] - The length of the top base.
 * @param Number [w] - The width between bases.
 */
module trapezium(size, a, b, w) {
    polygon(
        points = drawTrapezium(size=size, a=a, b=b, w=w),
        convexity = 10
    );
}

/**
 * Creates a regular polygon at the origin.
 *
 * @param Number|Vector [size] - The size of the polygon.
 * @param Number [n] - The number of facets (min. 3).
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [s] - The length of a side.
 */
module regularPolygon(size, n, l, w, s) {
    polygon(
        points = drawRegularPolygon(size=size, n=n, l=l, w=w, s=s),
        convexity = 10
    );
}

/**
 * Creates an hexagon at the origin.
 *
 * @param Number|Vector [size] - The size of the hexagon.
 * @param Number [adjust] - An adjust length added on the horizontal side
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [s] - The length of a side.
 */
module hexagon(size, adjust, l, w, s) {
    polygon(
        points = drawHexagon(size=size, adjust=adjust, l=l, w=w, s=s),
        convexity = 10
    );
}

/**
 * Creates a star at the origin.
 *
 * @param Number|Vector [size] - The outer size of the star.
 * @param Number|Vector [core] - The size of the core.
 * @param Number [edges] - The number of star edges (min. 3).
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [cl] - The core length.
 * @param Number [cw] - The core width.
 */
module star(size, core, edges, l, w, cl, cw) {
    polygon(
        points = drawStar(size=size, core=core, edges=edges, l=l, w=w, cl=cl, cw=cw),
        convexity = 10
    );
}
