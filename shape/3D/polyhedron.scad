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
