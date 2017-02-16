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
 * Ellipse shapes.
 *
 * @package shape/2D
 * @author jsconan
 */

/**
 * Computes the size of an ellipse.
 *
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector - Returns a vector containing the horizontal and vertical radius.
 */
function sizeEllipse(r, d, rx, ry, dx, dy) =
    let(
        r = apply2D(r, rx, ry),
        d = apply2D(d, dx, dy)
    )
    [
        // use divisor() to ensure the values will be forced to anything but 0
        divisor(d[0] && !rx ? d[0] / 2 : r[0]),
        divisor(d[1] && !ry ? d[1] / 2 : r[1])
    ]
;

/**
 * Computes the size of a ring.
 *
 * @param Number|Vector [r] - The radius of the ring or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [w] - The thickness of the ring.
 * @param Number|Vector [d] - The diameter of the ring or a vector that contains horizontal and vertical diameters.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @param Number [wx] - The horizontal thickness of the ring hole.
 * @param Number [wy] - The vertical thickness of the ring hole.
 * @returns Vector[] - Returns two vectors containing the horizontal and vertical radius of the outer and the inner circles.
 */
function sizeRing(r, w, d, rx, ry, dx, dy, wx, wy) =
    let(
        out = sizeEllipse(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy),
        w = apply2D(w, wx, wy),
        in = [
            max(min(out[0], out[0] - w[0]), 0),
            max(min(out[1], out[1] - w[1]), 0)
        ]
    )
    [ out, in ]
;

/**
 * Computes the points that draw the sketch of an ellipse.
 *
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[]
 */
function drawEllipse(r, d, rx, ry, dx, dy) =
    arc(
        r=sizeEllipse(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy),
        a=360
    )
;

/**
 * Computes the points that draw the sketch of a pie slice.
 *
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [a] - The angle of the pie
 * @param Number [a1] - The start angle of the pie
 * @param Number [a2] - The end angle of the pie
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @returns Vector[]
 */
function drawPie(r, a=90, d, a1, a2, rx, ry, dx, dy) =
    let (
        a1 = deg(a1),
        a2 = a2 != undef ? deg(a2) : a1 + deg(a),
        angle = absdeg(a2 - a1),
        points = arc(r=sizeEllipse(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy), a1=a1, a2=a2)
    )
    // add the origin to the list of points, unless it is a complete circle
    !angle || angle == 360 ? points : complete(points, [0, 0])
;

/**
 * Creates an ellipse at the origin.
 *
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 */
module ellipse(r, d, rx, ry, dx, dy) {
    polygon(
        points = drawEllipse(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy),
        convexity = 10
    );
}

/**
 * Creates a pie slice at the origin.
 *
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [a] - The angle of the pie
 * @param Number [a1] - The start angle of the pie
 * @param Number [a2] - The end angle of the pie
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 */
module pie(r, a=90, d, a1, a2, rx, ry, dx, dy) {
    polygon(
        points = drawPie(r=r, a=a, d=d, a1=a1, a2=a2, rx=rx, ry=ry, dx=dx, dy=dy),
        convexity = 10
    );
}

/**
 * Creates a chord at the origin.
 *
 * @param Number|Vector [r] - The radius or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [d] - The diameter or a vector that contains horizontal and vertical diameters.
 * @param Number [a] - The angle of the chord
 * @param Number [a1] - The start angle of the chord
 * @param Number [a2] - The end angle of the chord
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 */
module chord(r, a=90, d, a1, a2, rx, ry, dx, dy) {
    polygon(
        points = arc(v=sizeEllipse(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy), a=a, a1=a1, a2=a2),
        convexity = 10
    );
}

/**
 * Creates a ring at the origin.
 *
 * @param Number|Vector [r] - The radius of the ring or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [w] - The thickness of the ring.
 * @param Number|Vector [d] - The diameter of the ring or a vector that contains horizontal and vertical diameters.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @param Number [wx] - The horizontal thickness of the ring hole.
 * @param Number [wy] - The vertical thickness of the ring hole.
 * @returns Vector[] - Returns two vectors containing the horizontal and vertical radius of the outer and the inner circles.
 */
module ring(r, w, d, rx, ry, dx, dy, wx, wy) {
    size = sizeRing(r=r, w=w, d=d, rx=rx, ry=ry, dx=dx, dy=dy, wx=wx, wy=wy);
    difference() {
        ellipse(r=size[0]);
        ellipse(r=size[1]);
    }
}
