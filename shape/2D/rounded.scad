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
 * Computes the size of a 2D rounded shape.
 *
 * @param Number|Vector [r] - The radius of the rounded part or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter of the rounded part or a vector that contains horizontal and vertical diameters.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector - Returns the radius vector.
 */
function sizeRounded2D(r, d, rx, ry, dx, dy) =
    let(
        r = apply2D(r, rx, ry),
        d = apply2D(d, dx, dy)
    )
    [
        d[0] && !rx ? d[0] / 2 : r[0],
        d[1] && !ry ? d[1] / 2 : r[1]
    ]
;

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
        c = sizeRounded2D(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy),
        size = [
            divisor(s[0] ? s[0] : c[0] * 2),
            divisor(s[1] ? s[1] : c[1])
        ],
        horRadius = size[0] / 2,
        radius = [
            horRadius,
            min(size[1], or(c[1], horRadius))
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
        c = sizeRounded2D(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy),
        size = [
            divisor(s[0] ? s[0] : c[0] * 2),
            divisor(s[1] ? s[1] : c[1] * 2)
        ],
        horRadius = size[0] / 2,
        radius = [
            horRadius,
            min(size[1] / 2, or(c[1], horRadius))
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
        c = sizeRounded2D(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy),
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
 * Computes the size of a rounded corner. For now the function can only handle square corner.
 *
 * @param Number [size] - The size of the corner.
 * @param Number [r] - The radius of the round.
 * @param Number [d] - The diameter of the round.
 * @param String|Vector [p] - The position of the corner, as a cardinal point (default: "ne", aka North East).
 * @param Boolean [convex] - Whether makes a convex corner (default: false).
 * @returns Vector[] - Returns an array containing the vectors of size, radius and center, then the angles.
 */
function sizeRoundedCorner(size, r, d, p, convex) =
    let(
        r = d && !r ? float(d) / 2 : float(r),
        s = divisor(size ? size : r),
        p = let(p = cardinal(p)) [
            p[0] >= 0 ? 1 : -1,
            p[1] >= 0 ? 1 : -1
        ],
        R = max(s, r),
        S = (s == R),
        A = [0, s],
        B = [s, 0],
        C = S ? (convex ? [0, 0] : [ s, s ])
              : center2D(A, B, R, !convex),
        arcAngle = S ? RIGHT : angle2D(C - A, C - B),
        cornerAngle = absdeg(round(atan2(p[1], p[0]) - 45)),
        startAngle = absdeg(cornerAngle + (convex ? 0 : STRAIGHT) + (RIGHT - arcAngle) / 2)
    )
    [ vector2D(s), vector2D(R), rotp(C, cornerAngle), cornerAngle, startAngle, arcAngle ]
;

/**
 * Computes the points that draw the sketch of an arch shape.
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
        points = arc(r=radius, o=center, a=STRAIGHT)
    )
    center == [0, 0] ? points
   :complete(points, [radius[0], 0], -[radius[0], 0])
;

/**
 * Computes the points that draw the sketch of a stadium shape.
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
    center == [0, 0] ? arc(r=radius)
   :concat(arc(r=radius, o=center, a=STRAIGHT), arc(r=radius, o=-center, a=STRAIGHT, a1=STRAIGHT))
;

/**
 * Computes the points that draw the sketch of a rounded rectangle shape.
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
   :center == [0, 0] ? arc(r=radius)
   :concat(
       arc(r=radius, o=center, a1=0, a2=QUADRANT_1),
       arc(r=radius, o=[-center[0], center[1]], a1=QUADRANT_1, a2=QUADRANT_2),
       arc(r=radius, o=[-center[0], -center[1]], a1=QUADRANT_2, a2=QUADRANT_3),
       arc(r=radius, o=[center[0], -center[1]], a1=QUADRANT_3, a2=QUADRANT_4)
   )
;

/**
 * Computes the points that draw the sketch of a rounded corner shape.
 * For now the function can only handle square corner.
 *
 * @param Number [size] - The size of the corner.
 * @param Number [r] - The radius of the round.
 * @param Number [d] - The diameter of the round.
 * @param String|Vector [p] - The position of the corner, as a cardinal point (default: "ne", aka North East).
 * @param Boolean [convex] - Whether makes a convex corner (default: false).
 * @param Number [adjust] - An adjust value added to the size in order to fix wall alignment issue.
 * @returns Vector[]
 */
function drawRoundedCorner(size, r, d, p, convex, adjust) =
    let(
        specs = sizeRoundedCorner(size=size, r=r, d=d, p=p, convex=convex),
        size = specs[0],
        adjust = number(adjust),
        frame = adjust ? [
            rotp(convex ? [-adjust, size[1]] : [size[0], -adjust], specs[3]),
            rotp([-adjust, -adjust], specs[3]),
            rotp(convex ? [size[0], -adjust] : [-adjust, size[1]], specs[3])
        ]
       :[ [0, 0] ]
    )
    concat(
        frame,
        arc(r=specs[1], o=specs[2], a1=specs[4], a=specs[5])
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

/**
 * Creates a rounded corner shape at the origin.
 * For now the function can only handle square corner.
 *
 * @param Number [size] - The size of the corner.
 * @param Number [r] - The radius of the round.
 * @param Number [d] - The diameter of the round.
 * @param String|Vector [p] - The position of the corner, as a cardinal point (default: "ne", aka North East).
 * @param Boolean [convex] - Whether makes a convex corner (default: false).
 * @param Number [adjust] - An adjust value added to the size in order to fix wall alignment issue.
 */
module roundedCorner(size, r, d, p, convex, adjust) {
    polygon(
        points = drawRoundedCorner(size=size, r=r, d=d, p=p, convex=convex, adjust=adjust),
        convexity = 10
    );
}
