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
 * Operators that distribute children modules with respect to particular rules.
 *
 * @package operator/distribute
 * @author jsconan
 */

/**
 * Distributes the children modules on a grid with the provided `interval`, up to `line` elements per lines.
 *
 * @param Vector [intervalX] - The interval between each columns.
 * @param Vector [intervalY] - The interval between each lines.
 * @param Number [line] - The max number of elements per lines.
 */
module distributeGrid(intervalX = [1, 0, 0],
                      intervalY = [0, 1, 0],
                      line      = 2) {

    intervalX = vector3D(intervalX);
    intervalY = vector3D(intervalY);
    line = max(floor(abs(float(line))), 1);

    for (i = [0 : $children - 1]) {
        translate(intervalX * (i % line) + intervalY * floor(i / line)) {
            children(i);
        }
    }
}
