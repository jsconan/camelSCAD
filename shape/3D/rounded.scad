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
 * @package shape/3D
 * @author jsconan
 */

/**
 * Computes the size of a 3D rounded shape.
 *
 * @param Number|Vector [r] - The radius of the rounded part or a vector that contains radius for each dimensions.
 * @param Number|Vector [d] - The diameter of the rounded part or a vector that contains diameters for each dimensions.
 * @param Number [rx] - The length radius.
 * @param Number [ry] - The width radius.
 * @param Number [rz] - The height radius.
 * @param Number [dx] - The length diameter.
 * @param Number [dy] - The width diameter.
 * @param Number [dz] - The height diameter.
 * @returns Vector - Returns the radius vector.
 */
function sizeRounded3D(r, d, rx, ry, rz, dx, dy, dz) =
    let(
        r = apply3D(r, rx, ry, rz),
        d = apply3D(d, dx, dy, dz)
    )
    [
        d.x && !rx ? d.x / 2 : r.x,
        d.y && !ry ? d.y / 2 : r.y,
        d.z && !rz ? d.z / 2 : r.z
    ]
;

/**
 * Computes the size of an arch box.
 *
 * @param Number|Vector [size] - The size of the arch.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[] - Returns an array containing the size vector and the radius vector.
 */
function sizeArchBox(size, r, d, l, w, h, rx, ry, dx, dy) =
    let(
        s = apply3D(size, l, w, h),
        c = sizeRounded2D(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy),
        size = [
            divisor(s.x ? s.x : c.x * 2),
            divisor(s.y ? s.y : c.y),
            divisor(s.z)
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
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[] - Returns an array containing the size vector and the radius vector.
 */
function sizeSlot(size, r, d, l, w, h, rx, ry, dx, dy) =
    let(
        s = apply3D(size, l, w, h),
        c = sizeRounded2D(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy),
        size = [
            divisor(s.x ? s.x : c.x * 2),
            divisor(s.y ? s.y : c.y * 2),
            divisor(s.z)
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
 * Computes the size of a cushion shape.
 *
 * @param Number|Vector [size] - The size of the rounded rectangle.
 * @param Number|Vector [r] - The radius of the corners or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter of the corners  or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius of the corners.
 * @param Number [ry] - The vertical radius of the corners.
 * @param Number [dx] - The horizontal diameter of the corners.
 * @param Number [dy] - The vertical diameter of the corners.
 * @returns Vector[] - Returns an array containing the size vector and the radius vector.
 */
function sizeCushion(size, r, d, l, w, h, rx, ry, dx, dy) =
    let(
        s = apply3D(size, l, w, h),
        c = sizeRounded2D(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy),
        size = [
            divisor(s.x ? s.x : c.x * 2),
            divisor(s.y ? s.y : c.y * 2),
            divisor(s.z)
        ],
        radius = [
            min(size.x / 2, c.x),
            min(size.y / 2, c.y)
        ]
    )
    [ size, radius.x && radius.y ? radius : [0, 0] ]
;

/**
 * Computes the size of a bullet shape.
 *
 * @param Number|Vector [size] - The size of the bullet.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[] - Returns an array containing the size vector and the radius vector.
 */
function sizeBullet(size, r, d, l, w, h, rx, ry, dx, dy) =
    let(
        s = apply3D(size, l, w, h),
        c = sizeRounded2D(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy),
        size = [
            divisor(s.x ? s.x : c.x * 2),
            divisor(s.y ? s.y : c.x * 2),
            divisor(s.z ? s.z : c.y)
        ],
        horRadius = max(size.x, size.y) / 2,
        radius = [
            horRadius,
            min(size.z, or(c.y, horRadius))
        ]
    )
    [ size, radius ]
;

/**
 * Computes the size of a pill shape.
 *
 * @param Number|Vector [size] - The size of the pill.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[] - Returns an array containing the size vector and the radius vector.
 */
function sizePill(size, r, d, l, w, h, rx, ry, dx, dy) =
    let(
        s = apply3D(size, l, w, h),
        c = sizeRounded2D(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy),
        size = [
            divisor(s.x ? s.x : c.x * 2),
            divisor(s.y ? s.y : c.x * 2),
            divisor(s.z ? s.z : c.y * 2)
        ],
        horRadius = max(size.x, size.y) / 2,
        radius = [
            horRadius,
            min(size.z / 2, or(c.y, horRadius))
        ]
    )
    [ size, radius ]
;

/**
 * Computes the size of a peg shape.
 *
 * @param Number|Vector [size] - The size of the peg.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[] - Returns an array containing the size vector and the radius vector.
 */
function sizePeg(size, r, d, l, w, h, rx, ry, dx, dy) =
    let(
        s = apply3D(size, l, w, h),
        c = sizeRounded2D(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy),
        size = [
            divisor(s.x ? s.x : c.x * 2),
            divisor(s.y ? s.y : c.x * 2),
            divisor(s.z ? s.z : c.y * 2)
        ],
        radius = [
            min(max(size.x, size.y) / 2, c.x),
            min(size.z / 2, c.y)
        ]
    )
    [ size, radius.x && radius.y ? radius : [0, 0] ]
;

/**
 * Computes the size of a plate shape.
 *
 * @param Number|Vector [size] - The size of the plate.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[] - Returns an array containing the size vector and the radius vector.
 */
function sizePlate(size, r, d, l, w, h, rx, ry, dx, dy) =
    let(
        s = apply3D(size, l, w, h),
        c = sizeRounded2D(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy),
        size = [
            divisor(s.x ? s.x : c.x * 2),
            divisor(s.y ? s.y : c.x * 2),
            divisor(s.z ? s.z : c.y * 2)
        ],
        verRadius = size.z / 2,
        radius = [
            min(max(size.x, size.y) / 2, or(c.x, verRadius)),
            verRadius
        ]
    )
    [ size, radius ]
;

/**
 * Computes the points that draw the sketch of a bullet shape.
 *
 * @param Number|Vector [size] - The size of the bullet.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[]
 */
function drawBullet(size, r, d, l, w, h, rx, ry, dx, dy) =
    let(
        specs = sizeBullet(size=size, r=r, d=d, l=l, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy),
        size = specs[0],
        radius = specs[1],
        center = [
            0, size.z - radius.y
        ],
        points = arc(r=radius, o=center, a=RIGHT)
    )
    complete(points, [radius.x, 0], [0, 0])
;

/**
 * Computes the points that draw the sketch of a pill shape.
 *
 * @param Number|Vector [size] - The size of the pill.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[]
 */
function drawPill(size, r, d, l, w, h, rx, ry, dx, dy) =
    let(
        specs = sizePill(size=size, r=r, d=d, l=l, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy),
        size = specs[0],
        radius = specs[1],
        center = [
            0, size.z / 2 - radius.y
        ]
    )
    center == [0, 0] ? arc(r=radius, a1=-RIGHT, a2=RIGHT)
   :concat(
        arc(r=radius, o=-center, a=RIGHT, a1=-RIGHT),
        arc(r=radius, o=center, a=RIGHT)
    )
;

/**
 * Computes the points that draw the sketch of a peg shape.
 *
 * @param Number|Vector [size] - The size of the peg.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[]
 */
function drawPeg(size, r, d, l, w, h, rx, ry, dx, dy) =
    let(
        specs = sizePeg(size=size, r=r, d=d, l=l, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy),
        size = specs[0],
        radius = specs[1],
        right = max(size.x, size.y) / 2,
        top = size.z / 2,
        center = [
            right - radius.x,
            top - radius.y
        ]
    )
    radius == [0, 0] ? [ [right, top], [0, top], [0, -top], [right, -top] ]
   :center == [0, 0] ? arc(r=radius, a1=-RIGHT, a2=RIGHT)
   :complete(
        concat(
            arc(r=radius, o=[center.x, -center.y], a1=QUADRANT_3, a2=QUADRANT_4),
            arc(r=radius, o=center, a1=0, a2=QUADRANT_1)
        ),
        [0, -top],
        [0, top]
    )
;

/**
 * Computes the points that draw the sketch of a plate shape.
 *
 * @param Number|Vector [size] - The size of the plate.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[]
 */
function drawPlate(size, r, d, l, w, h, rx, ry, dx, dy) =
    let(
        specs = sizePlate(size=size, r=r, d=d, l=l, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy),
        size = specs[0],
        radius = specs[1],
        center = [
            max(size.x, size.y) / 2 - radius.x, 0
        ],
        points = arc(r=radius, o=center, a1=-RIGHT, a2=RIGHT)
    )
    center == [0, 0] ? points
   :complete(points, -[0, radius.y], [0, radius.y])
;

/**
 * Creates an arch box at the origin.
 *
 * @param Number|Vector [size] - The size of the arch.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @param Boolean [center] - Whether or not center the box on the vertical axis.
 */
module archBox(size, r, d, l, w, h, rx, ry, dx, dy, center) {
    size = sizeArchBox(size=size, r=r, d=d, l=l, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy);
    linear_extrude(height=size[0].z, center=center, convexity=10) {
        arch(size[0], size[1]);
    }
}

/**
 * Creates a slot shape at the origin.
 *
 * @param Number|Vector [size] - The size of the stadium.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @param Boolean [center] - Whether or not center the box on the vertical axis.
 */
module slot(size, r, d, l, w, h, rx, ry, dx, dy, center) {
    size = sizeSlot(size=size, r=r, d=d, l=l, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy);
    linear_extrude(height=size[0].z, center=center, convexity=10) {
        stadium(size[0], size[1]);
    }
}

/**
 * Creates a cushion shape at the origin.
 *
 * @param Number|Vector [size] - The size of the rounded rectangle.
 * @param Number|Vector [r] - The radius of the corners or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter of the corners  or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius of the corners.
 * @param Number [ry] - The vertical radius of the corners.
 * @param Number [dx] - The horizontal diameter of the corners.
 * @param Number [dy] - The vertical diameter of the corners.
 * @param Boolean [center] - Whether or not center the box on the vertical axis.
 */
module cushion(size, r, d, l, w, h, rx, ry, dx, dy, center) {
    size = sizeCushion(size=size, r=r, d=d, l=l, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy);
    linear_extrude(height=size[0].z, center=center, convexity=10) {
        roundedRectangle(size[0], size[1]);
    }
}

/**
 * Creates a bullet shape at the origin.
 *
 * @param Number|Vector [size] - The size of the bullet.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 */
module bullet(size, r, d, l, w, h, rx, ry, dx, dy) {
    specs = sizeBullet(size=size, r=r, d=d, l=l, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy);
    resize(specs[0]) {
        rotate_extrude(convexity=10) {
            polygon(
                points=drawBullet(size=specs[0], r=specs[1]),
                convexity=10
            );
        }
    }
}

/**
 * Creates a pill shape at the origin.
 *
 * @param Number|Vector [size] - The size of the pill.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 */
module pill(size, r, d, l, w, h, rx, ry, dx, dy) {
    specs = sizePill(size=size, r=r, d=d, l=l, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy);
    resize(specs[0]) {
        rotate_extrude(convexity=10) {
            polygon(
                points=drawPill(size=specs[0], r=specs[1]),
                convexity=10
            );
        }
    }
}

/**
 * Creates a peg shape at the origin.
 *
 * @param Number|Vector [size] - The size of the peg.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 */
module peg(size, r, d, l, w, h, rx, ry, dx, dy) {
    specs = sizePeg(size=size, r=r, d=d, l=l, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy);
    resize(specs[0]) {
        rotate_extrude(convexity=10) {
            polygon(
                points=drawPeg(size=specs[0], r=specs[1]),
                convexity=10
            );
        }
    }
}

/**
 * Creates a plate shape at the origin.
 *
 * @param Number|Vector [size] - The size of the plate.
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 */
module plate(size, r, d, l, w, h, rx, ry, dx, dy) {
    specs = sizePlate(size=size, r=r, d=d, l=l, w=w, h=h, rx=rx, ry=ry, dx=dx, dy=dy);
    resize(specs[0]) {
        rotate_extrude(convexity=10) {
            polygon(
                points=drawPlate(size=specs[0], r=specs[1]),
                convexity=10
            );
        }
    }
}

/**
 * Creates a rounded corner wedge at the origin.
 * For now the function can only handle square corner.
 *
 * @param Number [size] - The size of the corner.
 * @param Number [r] - The radius of the round.
 * @param Number [h] - The height of the solid.
 * @param Number [d] - The diameter of the round.
 * @param String|Vector [p] - The position of the corner, as a cardinal point (default: "ne", aka North East).
 * @param Boolean [convex] - Whether makes a convex corner (default: false).
 * @param Number [adjust] - An adjust value added to the size in order to fix wall alignment issue.
 * @param Boolean [center] - Whether or not center the solid on the vertical axis.
 */
module roundedCornerWedge(size, r, h, d, p, convex, adjust, center) {
    linear_extrude(height=divisor(h), center=center, convexity=10) {
        roundedCorner(size=size, r=r, d=d, p=p, convex=convex, adjust=adjust);
    }
}

/**
 * Draws a link.
 * @param Vector|Number neck - The size of the link neck.
 * @param Vector|Number bulk - The size of the link bulb.
 * @param Number Height - The thickness of the link.
 * @param Number [w] - The width of the neck.
 * @param Number [h] - The height of the neck.
 * @param Number [rx] - The horizontal radius of the bulb.
 * @param Number [ry] - The vertical radius of the bulb.
 * @param Number [dx] - The horizontal diameter of the bulb.
 * @param Number [dy] - The vertical diameter of the bulb.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 * @param Boolean [center] - Whether or not center the solid on the vertical axis.
 */
module link(neck, bulb, height, w, h, rx, ry, dx, dy, distance = 0, center=false) {
    linear_extrude(height=divisor(height), center=center, convexity=10) {
        linkProfile(
            neck = neck,
            bulb = bulb,
            w = w,
            h = h,
            rx = rx,
            ry = ry,
            dx = dx,
            dy = dy,
            distance = distance
        );
    }
}
