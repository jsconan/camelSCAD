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
 * Ellipsoid shapes.
 *
 * @package shape/3D
 * @author jsconan
 */

/**
 * Computes the size of an ellipsoid.
 *
 * @param Number|Vector [r] - The radius or a vector that contains 3D radius.
 * @param Number|Vector [d] - The diameter or a vector that contains 3D diameters.
 * @param Number [rx] - The length radius.
 * @param Number [ry] - The width radius.
 * @param Number [rz] - The height radius.
 * @param Number [dx] - The length diameter.
 * @param Number [dy] - The width diameter.
 * @param Number [dz] - The height diameter.
 * @returns Vector - Returns a vector containing the 3D radius.
 */
function sizeEllipsoid(r, d, rx, ry, rz, dx, dy, dz) =
    let(
        r = apply3D(r, rx, ry, rz),
        d = apply3D(d, dx, dy, dz)
    )
    [
        // use divisor() to ensure the values will be forced to anything but 0
        divisor(d[0] && !rx ? d[0] / 2 : r[0]),
        divisor(d[1] && !ry ? d[1] / 2 : r[1]),
        divisor(d[2] && !rz ? d[2] / 2 : r[2])
    ]
;

/**
 * Creates a shaft (extruded ellipse) at the origin.
 *
 * @param Number|Vector [r] - The radius or a vector that contains length and width radius.
 * @param Number|Vector [d] - The diameter or a vector that contains length and width diameters.
 * @param Number [h] - The height of the shaft.
 * @param Number [rx] - The length radius.
 * @param Number [ry] - The width radius.
 * @param Number [dx] - The length of the shaft.
 * @param Number [dy] - The width of the shaft.
 * @param Boolean [center] - Whether or not center the shaft on the vertical axis.
 */
module shaft(r, h, d, rx, ry, dx, dy, center) {
    size = sizeEllipsoid(r=r, d=d, rx=rx, ry=ry, rz=h, dx=dx, dy=dy);
    linear_extrude(height=size[2], center=center, convexity=10) {
        ellipse(size);
    }
}

/**
 * Creates a wedge (extruded pie slice) at the origin.
 *
 * @param Number|Vector [r] - The radius or a vector that contains length and width radius.
 * @param Number|Vector [d] - The diameter or a vector that contains length and width diameters.
 * @param Number [h] - The height of the wedge.
 * @param Number [a] - The angle of the wedge
 * @param Number [a1] - The start angle of the wedge
 * @param Number [a2] - The end angle of the wedge
 * @param Number [rx] - The length radius.
 * @param Number [ry] - The width radius.
 * @param Number [dx] - The length of the wedge.
 * @param Number [dy] - The width of the wedge.
 * @param Boolean [center] - Whether or not center the wedge on the vertical axis.
 */
module wedge(r, h, a=90, d, a1, a2, rx, ry, dx, dy, center) {
    size = sizeEllipsoid(r=r, d=d, rx=rx, ry=ry, rz=h, dx=dx, dy=dy);
    linear_extrude(height=size[2], center=center, convexity=10) {
        pie(size, a=a, a1=a1, a2=a2);
    }
}

/**
 * Creates an ellipsoid at the origin.
 *
 * @param Number|Vector [r] - The radius or a vector that contains 3D radius.
 * @param Number|Vector [d] - The diameter or a vector that contains 3D diameters.
 * @param Number [rx] - The length radius.
 * @param Number [ry] - The width radius.
 * @param Number [rz] - The height radius.
 * @param Number [dx] - The length diameter.
 * @param Number [dy] - The width diameter.
 * @param Number [dz] - The height diameter.
 */
module ellipsoid(r, d, rx, ry, rz, dx, dy, dz) {
    size = sizeEllipsoid(r=r, d=d, rx=rx, ry=ry, rz=rz, dx=dx, dy=dy, dz=dz);
    r = max(size);
    scale(size / r) {
        sphere(r);
    }
}

/**
 * Creates a pipe at the origin.
 *
 * @param Number|Vector [r] - The radius of the pipe or a vector that contains horizontal and vertical radius.
 * @param Number|Vector [w] - The thickness of the pipe.
 * @param Number [h] - The height of the pipe.
 * @param Number|Vector [d] - The diameter of the pipe or a vector that contains horizontal and vertical diameters.
 * @param Number [rx] - The horizontal radius.
 * @param Number [ry] - The vertical radius.
 * @param Number [dx] - The horizontal diameter.
 * @param Number [dy] - The vertical diameter.
 * @param Number [wx] - The horizontal thickness of the pipe hole.
 * @param Number [wy] - The vertical thickness of the pipe hole.
 * @param Boolean [center] - Whether or not center the pipe on the vertical axis.
 */
module pipe(r, h, w=0.1, d, rx, ry, dx, dy, wx, wy, center) {
    size = sizeEllipsoid(r=r, d=d, rx=rx, ry=ry, rz=h, dx=dx, dy=dy);
    linear_extrude(height=size[2], center=center, convexity=10) {
        ring(r=size, w=w, wx=wx, wy=wy);
    }
}

/**
 * Creates a torus at the origin.
 * Note: the tore can be deformed if the ring is not perfectly circular.
 *
 * @param Number|Vector [r] - The radius of the torus ring or a vector that contains 3D radius.
 * @param Number|Vector [d] - The diameter of the torus ring or a vector that contains 3D diameters.
 * @param Number|Vector [w] - The radius of the torus pipe.
 * @param Number|Vector [W] - The diameter of the torus pipe.
 * @param Number [rx] - The length radius of the torus ring.
 * @param Number [ry] - The width radius of the torus ring.
 * @param Number [dx] - The length diameter of the torus ring.
 * @param Number [dy] - The width diameter of the torus ring.
 * @param Number [wx] - The length radius of the torus pipe.
 * @param Number [wy] - The width radius of the torus pipe.
 * @param Number [Wx] - The length diameter of the torus pipe.
 * @param Number [Wy] - The width diameter of the torus pipe.
 * @param Boolean [center] - Whether or not center the torus on the vertical axis.
 */
module torus(r, w=0.1, d, W, rx, ry, dx, dy, wx, wy, Wx, Wy, center) {
    sizeRing = sizeEllipse(r=r, d=d, rx=rx, ry=ry, dx=dx, dy=dy);
    sizePipe = sizeEllipse(r=w, d=W, rx=wx, ry=wy, dx=Wx, dy=Wy);

    translate([0, 0, center ? 0 : sizePipe[1]]) {
        resize(apply3D(vadd(sizeRing, sizePipe[0]), z=sizePipe[1]) * 2) {
            rotate_extrude(convexity=10) {
                translate([max(sizeRing) - sizePipe[0], 0, 0]) {
                    ellipse(sizePipe);
                }
            }
        }
    }
}
