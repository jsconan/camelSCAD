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
        d.x && !rx ? d.x / 2 : r.x,
        d.y && !ry ? d.y / 2 : r.y
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
            divisor(s.x ? s.x : c.x * 2),
            divisor(s.y ? s.y : c.y)
        ],
        horRadius = size.x / 2,
        radius = [
            horRadius,
            min(size.y, or(c.y, horRadius))
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
            divisor(s.x ? s.x : c.x * 2),
            divisor(s.y ? s.y : c.y * 2)
        ],
        horRadius = size.x / 2,
        radius = [
            horRadius,
            min(size.y / 2, or(c.y, horRadius))
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
            divisor(s.x ? s.x : c.x * 2),
            divisor(s.y ? s.y : c.y * 2)
        ],
        radius = [
            min(size.x / 2, c.x),
            min(size.y / 2, c.y)
        ]
    )
    [ size, radius.x && radius.y ? radius : [0, 0] ]
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
            p.x >= 0 ? 1 : -1,
            p.y >= 0 ? 1 : -1
        ],
        R = max(s, r),
        S = (s == R),
        A = [0, s],
        B = [s, 0],
        C = S ? (convex ? [0, 0] : [ s, s ])
              : center2D(A, B, R, !convex),
        arcAngle = S ? RIGHT : angle2D(C - A, C - B),
        cornerAngle = absdeg(round(atan2(p.y, p.x) - 45)),
        startAngle = absdeg(cornerAngle + (convex ? 0 : STRAIGHT) + (RIGHT - arcAngle) / 2)
    )
    [ vector2D(s), vector2D(R), rotp(C, cornerAngle), cornerAngle, startAngle, arcAngle ]
;

/**
 * Computes the size of a link.
 *
 * @param Vector|Number neck - The size of the link neck.
 * @param Vector|Number bulk - The size of the link bulb.
 * @param Number [w] - The width of the neck.
 * @param Number [h] - The height of the neck.
 * @param Number [rx] - The horizontal radius of the bulb.
 * @param Number [ry] - The vertical radius of the bulb.
 * @param Number [dx] - The horizontal diameter of the bulb.
 * @param Number [dy] - The vertical diameter of the bulb.
 * @returns Vector[] - Returns an array containing the size of the nect and the radius of the bulb.
 */
function sizeLinkProfile(neck, bulb, w, h, rx, ry, dx, dy) =
    let(
        neck = apply2D(uor(neck, bulb), w, h),
        bulb = sizeRounded2D(d=uor(bulb, neck), rx=rx, ry=ry, dx=dx, dy=dy)
    )
    [ divisor2D(neck), divisor2D(bulb) ]
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
            0, size.y - radius.y
        ],
        points = arc(r=radius, o=center, a=STRAIGHT)
    )
    center == [0, 0] ? points
   :complete(points, [radius.x, 0], -[radius.x, 0])
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
            0, size.y / 2 - radius.y
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
        right = size.x / 2,
        top = size.y / 2,
        center = [
            right - radius.x,
            top - radius.y
        ]
    )
    radius == [0, 0] ? [ [right, top], [-right, top], [-right, -top], [right, -top] ]
   :center == [0, 0] ? arc(r=radius)
   :concat(
       arc(r=radius, o=center, a1=0, a2=QUADRANT_1),
       arc(r=radius, o=[-center.x, center.y], a1=QUADRANT_1, a2=QUADRANT_2),
       arc(r=radius, o=[-center.x, -center.y], a1=QUADRANT_2, a2=QUADRANT_3),
       arc(r=radius, o=[center.x, -center.y], a1=QUADRANT_3, a2=QUADRANT_4)
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
            rotp(convex ? [-adjust, size.y] : [size.x, -adjust], specs[3]),
            rotp([-adjust, -adjust], specs[3]),
            rotp(convex ? [size.x, -adjust] : [-adjust, size.y], specs[3])
        ]
       :[ [0, 0] ]
    )
    concat(
        frame,
        arc(r=specs[1], o=specs[2], a1=specs[4], a=specs[5])
    )
;

/**
 * Draws the profile of a link.
 * @param Vector|Number neck - The size of the link neck.
 * @param Vector|Number bulk - The size of the link bulb.
 * @param Number [w] - The width of the neck.
 * @param Number [h] - The height of the neck.
 * @param Number [rx] - The horizontal radius of the bulb.
 * @param Number [ry] - The vertical radius of the bulb.
 * @param Number [dx] - The horizontal diameter of the bulb.
 * @param Number [dy] - The vertical diameter of the bulb.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
function drawLinkProfile(neck, bulb, w, h, rx, ry, dx, dy, distance = 0) =
    let(
        size = sizeLinkProfile(neck=neck, bulb=bulb, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy),
        neck = size[0],
        bulb = size[1],
        startX = ALIGN,
        startY = neck.y / 2
    )
    outline(
        points = path([
            ["P", startX, startY],
            ["H", -neck.x - startX],
            ["C", bulb, 0, 180],
            ["V", -neck.y],
            ["C", bulb, 180, 360],
            ["H", neck.x + startX],
        ]),
        distance = distance
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

/**
 * Draws the profile of a link.
 * @param Vector|Number neck - The size of the link neck.
 * @param Vector|Number bulk - The size of the link bulb.
 * @param Number [w] - The width of the neck.
 * @param Number [h] - The height of the neck.
 * @param Number [rx] - The horizontal radius of the bulb.
 * @param Number [ry] - The vertical radius of the bulb.
 * @param Number [dx] - The horizontal diameter of the bulb.
 * @param Number [dy] - The vertical diameter of the bulb.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module linkProfile(neck, bulb, w, h, rx, ry, dx, dy, distance = 0) {
    polygon(
        points = drawLinkProfile(
            neck = neck,
            bulb = bulb,
            w = w,
            h = h,
            rx = rx,
            ry = ry,
            dx = dx,
            dy = dy,
            distance = distance
        ),
        convexity = 10
    );
}
