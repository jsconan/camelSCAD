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
 * and rotate them by a fraction of the `angle`.
 *
 * @param Number [angle] - The angle interval in which rotate the elements.
 * @param Vector [axis] - The rotation axis around which rotate the elements.
 * @param Vector [interval] - The interval between each elements.
 * @param Vector [origin] - The rotate origin.
 * @param Number [intervalX] - The X interval between each repeated children
 *                             (will overwrite the X coordinate in the `interval` vector).
 * @param Number [intervalY] - The Y interval between each repeated children
 *                             (will overwrite the Y coordinate in the `interval` vector).
 * @param Number [intervalZ] - The Z interval between each repeated children
 *                             (will overwrite the Z coordinate in the `interval` vector).
 * @param Number [axisX] - The X axis factor (will overwrite the X coordinate in the `axis` vector).
 * @param Number [axisY] - The Y axis factor (will overwrite the Y coordinate in the `axis` vector).
 * @param Number [axisZ] - The Z axis factor (will overwrite the Z coordinate in the `axis` vector).
 * @param Number [originX] - The X origin (will overwrite the X coordinate in the `origin` vector).
 * @param Number [originY] - The Y origin (will overwrite the Y coordinate in the `origin` vector).
 * @param Number [originZ] - The Z origin (will overwrite the Z coordinate in the `origin` vector).
 */
module distributeRotate(angle    = 360,
                        axis     = [0, 0, 1],
                        interval = [0, 0, 0],
                        origin   = [0, 0, 0],
                        intervalX, intervalY, intervalZ,
                        axisX, axisY, axisZ,
                        originX, originY, originZ) {

    interval = apply3D(interval, intervalX, intervalY, intervalZ);
    origin = apply3D(origin, originX, originY, originZ);
    angle = deg(angle);
    partAngle = angle / (angle % 360 ? $children - 1 : $children);
    axis = apply3D(axis, axisX, axisY, axisZ) * partAngle;

    for (i = [0 : $children - 1]) {
        translate(interval * i) {
            rotateOrigin(a=axis * i, o=origin) {
                children(i);
            }
        }
    }
}
