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
 * Distributes the children modules with the provided `interval`,
 * and mirror them around the plan described by the vector `axis`.
 *
 * @param Vector [interval] - The interval between each elements.
 * @param Vector [axis] - The normal vector of the mirroring plan around which mirror the elements.
 * @param Number [intervalX] - The X interval between each repeated children
 *                             (will overwrite the X coordinate in the `interval` vector).
 * @param Number [intervalY] - The Y interval between each repeated children
 *                             (will overwrite the Y coordinate in the `interval` vector).
 * @param Number [intervalZ] - The Z interval between each repeated children
 *                             (will overwrite the Z coordinate in the `interval` vector).
 * @param Number [axisX] - The X-coordinate of the normal vector of the mirroring plan around which mirror the elements
 *                         (will overwrite the X coordinate in the `axis` vector).
 * @param Number [axisY] - The Y-coordinate of the normal vector of the mirroring plan around which mirror the elements
 *                         (will overwrite the Y coordinate in the `axis` vector).
 * @param Number [axisZ] - The Z-coordinate of the normal vector of the mirroring plan around which mirror the elements
 *                         (will overwrite the Z coordinate in the `axis` vector).
 */
module distributeMirror(interval = [0, 0, 0],
                        axis     = [1, 0, 0],
                        intervalX, intervalY, intervalZ,
                        axisX, axisY, axisZ) {

    interval = apply3D(interval, intervalX, intervalY, intervalZ);
    axis = apply3D(axis, axisX, axisY, axisZ);

    for (i = [0 : $children - 1]) {
        translate(interval * i) {
            if (i % 2) {
                mirror(axis) {
                    children(i);
                }
            } else {
                children(i);
            }
        }
    }
}
