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
 * Polyhedron shapes.
 *
 * @package shape/3D
 * @author jsconan
 */

/**
 * Computes the size of a box.
 *
 * @param Number|Vector [size] - The size of the box.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @returns Vector - Returns the size vector.
 */
function sizeBox(size, l, w, h) =
    let(
        size = apply3D(size, l, w, h)
    )
    [
        divisor(size[0]),
        divisor(size[1]),
        divisor(size[2])
    ]
;

/**
 * Computes the size of a trapezium shape.
 *
 * @param Number|Vector [size] - The size of the trapezium.
 * @param Number [a] - The length of the bottom base.
 * @param Number [b] - The length of the top base.
 * @param Number [w] - The width between bases.
 * @param Number [h] - The height of the box.
 * @returns Vector - Returns the size vector, as [a, b, w, h].
 */
function sizeTrapeziumBox(size, a, b, w, h) =
    let(
        h = uor(h, isNumber(size) ? size : size[3]),
        size = apply3D(size, a, b, w)
    )
    [
        divisor(size[0]),
        divisor(size[1]),
        divisor(size[2]),
        divisor(h)
    ]
;

/**
 * Computes the size of a regular polygon.
 *
 * @param Number|Vector [size] - The size of the polygon.
 * @param Number [n] - The number of facets (min. 3).
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The height of the box.
 * @param Number [s] - The length of a side.
 * @returns Vector - Returns the size vector, as [l, w, h, n].
 */
function sizeRegularPolygonBox(size, n, l, w, h, s) =
    let(
        n = max(3, float(n)),
        size = (s && !size && !l && !w) ? vector3D(2 * divisor(s) / (2 * sin(STRAIGHT / n)))
                                        : apply3D(size, l, w, h)
    )
    [
        divisor(size[0]),
        divisor(size[1]),
        divisor(size[2]),
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
 * @param Number [h] - The height of the box.
 * @param Number [cl] - The core length.
 * @param Number [cw] - The core width.
 * @returns Vector[] - Returns two vectors containing the outer and core size of the star
 */
function sizeStarBox(size, core, edges, l, w, h, cl, cw) =
    let(
        edges = max(3, float(edges)),
        size = divisor3D(apply3D(size, l, w, h)),
        core = apply2D(core, cl, cw)
    )
    [
        size,
        core == [0, 0] ? vector2D(size) * or(1 - 3 / edges, 0.2) : core,
        edges
    ]
;

/**
 * Creates a box at the origin.
 *
 * @param Number|Vector [size] - The size of the box.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Boolean [center] - Whether or not center the box on the vertical axis.
 */
module box(size, l, w, h, center) {
    size = sizeBox(size=size, l=l, w=w, h=h);
    linear_extrude(height=size[2], center=center, convexity=10) {
        rectangle(size);
    }
}

/**
 * Creates a trapezium box at the origin.
 *
 * @param Number|Vector [size] - The size of the trapezium.
 * @param Number [a] - The length of the bottom base.
 * @param Number [b] - The length of the top base.
 * @param Number [w] - The width between bases.
 * @param Number [h] - The height of the box.
 * @param Boolean [center] - Whether or not center the box on the vertical axis.
 */
module trapeziumBox(size, a, b, w, h, center) {
    size = sizeTrapeziumBox(size=size, a=a, b=b, w=w, h=h);
    linear_extrude(height=size[3], center=center, convexity=10) {
        trapezium(size);
    }
}

/**
 * Creates a regular polygon at the origin.
 *
 * @param Number|Vector [size] - The size of the polygon.
 * @param Number [n] - The number of facets (min. 3).
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [s] - The length of a side.
 * @param Boolean [center] - Whether or not center the box on the vertical axis.
 */
module regularPolygonBox(size, n, l, w, h, s, center) {
    size = sizeRegularPolygonBox(size=size, n=n, l=l, w=w, h=h, s=s);
    linear_extrude(height=size[2], center=center, convexity=10) {
        regularPolygon(size, size[3]);
    }
}

/**
 * Creates an hexagon at the origin.
 *
 * @param Number|Vector [size] - The size of the hexagon.
 * @param Boolean [pointy] - Tells if the hexagon must be pointy topped (default: false, Flat topped).
 * @param Number [adjust] - An adjust length added on the horizontal side.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [s] - The length of a side.
 * @param Boolean [center] - Whether or not center the box on the vertical axis.
 */
module hexagonBox(size, pointy, adjust, l, w, h, s, center) {
    size = sizeRegularPolygonBox(size=size, n=6, l=l, w=w, h=h, s=s);
    linear_extrude(height=size[2], center=center, convexity=10) {
        hexagon(size=size, pointy=pointy, adjust=adjust);
    }
}

/**
 * Creates a star at the origin.
 *
 * @param Number|Vector [size] - The outer size of the star.
 * @param Number|Vector [core] - The size of the core.
 * @param Number [edges] - The number of star edges (min. 3).
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width
 * @param Number [h] - The overall height..
 * @param Number [cl] - The core length.
 * @param Number [cw] - The core width.
 * @param Boolean [center] - Whether or not center the box on the vertical axis.
 */
module starBox(size, core, edges, l, w, h, cl, cw, center) {
    size = sizeStarBox(size=size, core=core, edges=edges, l=l, w=w, h=h, cl=cl, cw=cw);
    linear_extrude(height=size[0][2], center=center, convexity=10) {
        star(size[0], size[1], size[2]);
    }
}

/**
 * Creates a mesh with honeycomb cells using a hex grid pattern.
 *
 * @param Number|Vector [size] - The outer size of the mesh.
 * @param Number|Vector [count] - The number of cells on each lines and each columns.
 * @param Number|Vector [gap] - The space between two cells.
 * @param Boolean [pointy] - Tells if the hexagons in the mesh are pointy topped (default: false, Flat topped).
 * @param Boolean [linear] - Tells if the hex grid is linear instead of radial (default: false).
 * @param Boolean [even] - Tells if the first hexagons of a the linear grid should be below the line (default: false).
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [cx] - The number of cells per lines.
 * @param Number [cy] - The number of cells per columns.
 * @param Number [gx] - The space between two cells on each lines.
 * @param Number [gy] - The space between two cells on each columns.
 * @param Boolean [center] - Whether or not center the box on the vertical axis.
 */
module meshBox(size, count, gap, pointy, linear, even, l, w, h, cx, cy, gx, gy, center) {
    size = apply3D(size, l, w, h);
    linear_extrude(height=size[2], center=center, convexity=10) {
        mesh(size=size, count=count, gap=gap, pointy=pointy, linear=linear, even=even, cx=cx, cy=cy, gx=gx, gy=gy);
    }
}
