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
 * Rounded shapes.
 *
 * @package shape/2D
 * @author jsconan
 */

/**
 * Computes the size of an arch shape.
 *
 * @param Number|Vector [size] - The size of the arch.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[] - Returns an array containing the size vector and the radius vector.
 */
function sizeArch(size, r, d, w, h, rx, ry, dx, dy) =
    let(
        s = apply2D(size, w, h),
        r = apply2D(r, rx, ry),
        d = apply2D(d, dx, dy),
        c = [
            d[0] && !rx ? d[0] / 2 : r[0],
            d[1] && !ry ? d[1] / 2 : r[1]
        ],
        size = [
            divisor(s[0] ? s[0] : c[0] * 2),
            divisor(s[1] ? s[1] : c[1])
        ],
        radius = [
            size[0] / 2,
            c[1] ? min(size[1], c[1]) : size[1]
        ]
    )
    [ size, radius ]
;

/**
 * Computes the size of a stadium shape.
 *
 * @param Number|Vector [size] - The size of the stadium.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[] - Returns an array containing the size vector and the radius vector.
 */
function sizeStadium(size, r, d, w, h, rx, ry, dx, dy) =
    let(
        s = apply2D(size, w, h),
        r = apply2D(r, rx, ry),
        d = apply2D(d, dx, dy),
        c = [
            d[0] && !rx ? d[0] / 2 : r[0],
            d[1] && !ry ? d[1] / 2 : r[1]
        ],
        size = [
            divisor(s[0] ? s[0] : c[0] * 2),
            divisor(s[1] ? s[1] : c[1] * 2)
        ],
        radius = [
            size[0] / 2,
            c[1] ? min(size[1] / 2, c[1]) : size[1] / 2
        ]
    )
    [ size, radius ]
;

/**
 * Computes the size of a rounded rectangle.
 *
 * @param Number|Vector [size] - The size of the rounded rectangle.
 * @param Number|Vector [r] - The radius of the corners or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter of the corners  or a vector that contains horizontal and vertical diameters.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius of the corners.
 * @param Number [ry] - The vertical radius of the corners.
 * @param Number [dx] - The horizontal diameter of the corners.
 * @param Number [dy] - The vertical diameter of the corners.
 * @returns Vector[] - Returns an array containing the size vector and the radius vector.
 */
function sizeRoundedRectangle(size, r, d, w, h, rx, ry, dx, dy) =
    let(
        s = apply2D(size, w, h),
        r = apply2D(r, rx, ry),
        d = apply2D(d, dx, dy),
        c = [
            d[0] && !rx ? d[0] / 2 : r[0],
            d[1] && !ry ? d[1] / 2 : r[1]
        ],
        size = [
            divisor(s[0] ? s[0] : c[0] * 2),
            divisor(s[1] ? s[1] : c[1] * 2)
        ],
        radius = [
            min(size[0] / 2, c[0]),
            min(size[1] / 2, c[1])
        ]
    )
    [ size, radius[0] && radius[1] ? radius : [0, 0] ]
;

/**
 * Computes the points that draw an arch shape.
 *
 * @param Number|Vector [size] - The size of the arch.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[]
 */
function drawArch(size, r, d, w, h, rx, ry, dx, dy) =
    let(
        specs = sizeArch(size=size, r=r, d=d, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy),
        size = specs[0],
        radius = specs[1],
        center = [
            0, size[1] - radius[1]
        ],
        points = arc(v=radius, o=center, a=180)
    )
    center == [0, 0] ? points
   :complete(points, [radius[0], 0], -[radius[0], 0])
;

/**
 * Computes the points that draw a stadium shape.
 *
 * @param Number|Vector [size] - The size of the stadium.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[]
 */
function drawStadium(size, r, d, w, h, rx, ry, dx, dy) =
    let(
        specs = sizeStadium(size=size, r=r, d=d, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy),
        size = specs[0],
        radius = specs[1],
        center = [
            0, size[1] / 2 - radius[1]
        ]
    )
    center == [0, 0] ? arc(v=radius)
   :concat(arc(v=radius, o=center, a=180), arc(v=radius, o=-center, a=-180))
;

/**
 * Computes the points that draw a rounded rectangle shape.
 *
 * @param Number|Vector [size] - The size of the rounded rectangle.
 * @param Number|Vector [r] - The radius of the corners or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter of the corners  or a vector that contains horizontal and vertical diameters.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius of the corners.
 * @param Number [ry] - The vertical radius of the corners.
 * @param Number [dx] - The horizontal diameter of the corners.
 * @param Number [dy] - The vertical diameter of the corners.
 * @returns Vector[]
 */
function drawRoundedRectangle(size, r, d, w, h, rx, ry, dx, dy) =
    let(
        specs = sizeRoundedRectangle(size=size, r=r, d=d, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy),
        size = specs[0],
        radius = specs[1],
        right = size[0] / 2,
        top = size[1] / 2,
        center = [
            right - radius[0],
            top - radius[1]
        ]
    )
    radius == [0, 0] ? [ [right, top], [-right, top], [-right, -top], [right, -top] ]
   :center == [0, 0] ? arc(v=radius)
   :concat(
       arc(v=radius, o=center, a1=0, a2=90),
       arc(v=radius, o=[-center[0], center[1]], a1=90, a2=180),
       arc(v=radius, o=[-center[0], -center[1]], a1=180, a2=270),
       arc(v=radius, o=[center[0], -center[1]], a1=270, a2=360)
   )
;

/**
 * Creates an arch shape at the origin.
 *
 * @param Number|Vector [size] - The size of the arch.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 */
module arch(size, r, d, w, h, rx, ry, dx, dy) {
    polygon(
        points = drawArch(size=size, r=r, d=d, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy),
        convexity = 10
    );
}

/**
 * Creates a stadium shape at the origin.
 *
 * @param Number|Vector [size] - The size of the stadium.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 */
module stadium(size, r, d, w, h, rx, ry, dx, dy) {
    polygon(
        points = drawStadium(size=size, r=r, d=d, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy),
        convexity = 10
    );
}

/**
 * Creates a rounded rectangle shape at the origin.
 *
 * @param Number|Vector [size] - The size of the rounded rectangle.
 * @param Number|Vector [r] - The radius of the corners or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter of the corners  or a vector that contains horizontal and vertical diameters.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius of the corners.
 * @param Number [ry] - The vertical radius of the corners.
 * @param Number [dx] - The horizontal diameter of the corners.
 * @param Number [dy] - The vertical diameter of the corners.
 */
module roundedRectangle(size, r, d, w, h, rx, ry, dx, dy) {
    polygon(
        points = drawRoundedRectangle(size=size, r=r, d=d, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy),
        convexity = 10
    );
}
