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
 * Operators that repeat children modules with respect to particular rules.
 *
 * @package operator/repeat
 * @author jsconan
 */

/**
 * Repeats and rotates the children modules `count` times with the provided `interval`.
 *
 * @param Number [count] - The number of times the children must be repeated.
 * @param Number [angle] - The angle interval in which rotate the children.
 * @param Vector [axis] - The rotation axis around which rotate the children.
 * @param Vector [interval] - The interval between each repeated children.
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
module repeatRotate(count    = 2,
                    angle    = 360,
                    axis     = [0, 0, 1],
                    interval = [0, 0, 0],
                    origin   = [0, 0, 0],
                    intervalX, intervalY, intervalZ,
                    axisX, axisY, axisZ,
                    originX, originY, originZ) {

    interval = apply3D(interval, intervalX, intervalY, intervalZ);
    origin = apply3D(origin, originX, originY, originZ);
    angle = deg(angle);
    partAngle = angle / (angle % 360 ? count - 1 : count);
    axis = apply3D(axis, axisX, axisY, axisZ) * partAngle;

    for (i = [0 : count - 1]) {
        translate(interval * i) {
            rotateOrigin(a=axis * i, o=origin) {
                children();
            }
        }
    }
}

/**
 * Repeats and rotates the children modules in two directions `count` times with the provided `interval`.
 *
 * @param Number [countX] - The number of times the children must be repeated along the X axis.
 * @param Number [countY] - The number of times the children must be repeated along the Y axis.
 * @param Number [angleX] - The angle interval in which rotate the children along the X axis.
 * @param Number [angleY] - The angle interval in which rotate the children along the Y axis.
 * @param Vector [axisX] - The rotation axis around which rotate the children along the X axis.
 * @param Vector [axisY] - The rotation axis around which rotate the children along the Y axis.
 * @param Vector [intervalX] - The interval between each repeated children along the X axis.
 * @param Vector [intervalY] - The interval between each repeated children along the Y axis.
 * @param Vector [originX] - The rotate origin along the X axis.
 * @param Vector [originY] - The rotate origin along the Y axis.
 */
module repeatRotate2D(countX    = 2,
                      countY    = 2,
                      angleX    = 360,
                      angleY    = 360,
                      axisX     = [0, 0, 1],
                      axisY     = [0, 1, 0],
                      intervalX = [0, 0, 0],
                      intervalY = [0, 0, 0],
                      originX   = [0, 0, 0],
                      originY   = [0, 0, 0]) {

    repeatRotate(count=countY, interval=vector3D(intervalY), angle=angleY, axis=vector3D(axisY), origin=originY) {
        repeatRotate(count=countX, interval=vector3D(intervalX), angle=angleX, axis=vector3D(axisX), origin=originX) {
            children();
        }
    }
}

/**
 * Repeats and rotates the children modules in three directions `count` times with the provided `interval`.
 *
 * @param Number [countX] - The number of times the children must be repeated along the X axis.
 * @param Number [countY] - The number of times the children must be repeated along the Y axis.
 * @param Number [countZ] - The number of times the children must be repeated along the Z axis.
 * @param Number [angleX] - The angle interval in which rotate the children along the X axis.
 * @param Number [angleY] - The angle interval in which rotate the children along the Y axis.
 * @param Number [angleZ] - The angle interval in which rotate the children along the Z axis.
 * @param Vector [axisX] - The rotation axis around which rotate the children along the X axis.
 * @param Vector [axisY] - The rotation axis around which rotate the children along the Y axis.
 * @param Vector [axisZ] - The rotation axis around which rotate the children along the Z axis.
 * @param Vector [intervalX] - The interval between each repeated children along the X axis.
 * @param Vector [intervalY] - The interval between each repeated children along the Y axis.
 * @param Vector [intervalZ] - The interval between each repeated children along the Z axis.
 * @param Vector [originX] - The rotate origin along the X axis.
 * @param Vector [originY] - The rotate origin along the Y axis.
 * @param Vector [originZ] - The rotate origin along the Z axis.
 */
module repeatRotate3D(countX    = 2,
                      countY    = 2,
                      countZ    = 2,
                      angleX    = 360,
                      angleY    = 360,
                      angleZ    = 360,
                      axisX     = [0, 0, 1],
                      axisY     = [0, 1, 0],
                      axisZ     = [1, 0, 0],
                      intervalX = [0, 0, 0],
                      intervalY = [0, 0, 0],
                      intervalZ = [0, 0, 0],
                      originX   = [0, 0, 0],
                      originY   = [0, 0, 0],
                      originZ   = [0, 0, 0]) {

    repeatRotate(count=countZ, interval=vector3D(intervalZ), angle=angleZ, axis=vector3D(axisZ), origin=originZ) {
        repeatRotate(count=countY, interval=vector3D(intervalY), angle=angleY, axis=vector3D(axisY), origin=originY) {
            repeatRotate(count=countX, interval=vector3D(intervalX), angle=angleX, axis=vector3D(axisX), origin=originX) {
                children();
            }
        }
    }
}
