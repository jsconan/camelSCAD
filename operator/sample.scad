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
 * Takes a sample of the scene.
 *
 * @package operator
 * @author jsconan
 */

/**
 * Takes a sample of the scene and place it at the origin.
 * @param Number|Vector [size] - The size of sample.
 * @param Number|Vector [offset] - The position of the sample center. Will be the on the bottom face if center=false,
                                   and on the actual center if center=true.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [x] - The horizontal offset.
 * @param Number [y] - The depth offset.
 * @param Number [z] - The vertical offset.
 * @param Boolean [center] - Whether or not center the sample on the vertical axis.
 */
module sample(size, offset, l, w, h, x, y, z, center) {
    size = apply3D(size, l, w, h);
    offset = apply3D(offset, x, y, z);

    translate(-offset) {
        intersection() {
            translate(offset) {
                box(size, center=center);
            }
            children();
        }
    }
}
