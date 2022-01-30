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
 * Operators that repeat children modules with respect to particular rules.
 *
 * @package operator/repeat
 * @author jsconan
 */

/**
 * Repeats the children modules `count` times with the provided `interval`
 * and mirror them around the plan described by the vector `axis`.
 *
 * @param Number [count] - The number of times the children must be repeated.
 * @param Vector [interval] - The interval between each repeated children.
 * @param Vector [axis] - The normal vector of the mirroring plan around which mirror the children.
 * @param Boolean [center] - Whether or not center the repeated shapes.
 * @param Number [intervalX] - The X interval between each repeated children
 *                             (will overwrite the X coordinate in the `interval` vector).
 * @param Number [intervalY] - The Y interval between each repeated children
 *                             (will overwrite the Y coordinate in the `interval` vector).
 * @param Number [intervalZ] - The Z interval between each repeated children
 *                             (will overwrite the Z coordinate in the `interval` vector).
 * @param Number [axisX] - The X-coordinate of the normal vector of the mirroring plan around which mirror the children
 *                         (will overwrite the X coordinate in the `axis` vector).
 * @param Number [axisY] - The Y-coordinate of the normal vector of the mirroring plan around which mirror the children
 *                         (will overwrite the Y coordinate in the `axis` vector).
 * @param Number [axisZ] - The Z-coordinate of the normal vector of the mirroring plan around which mirror the children
 *                         (will overwrite the Z coordinate in the `axis` vector).
 */
module repeatMirror(count    = 2,
                    interval = 0,
                    axis     = xAxis3D(),
                    center   = false,
                    intervalX, intervalY, intervalZ,
                    axisX, axisY, axisZ) {

    interval = apply3D(interval, intervalX, intervalY, intervalZ);
    axis = apply3D(axis, axisX, axisY, axisZ);
    offset = center ? -interval * (count - 1) / 2 : ORIGIN_3D;

    for (i = [0 : count - 1]) {
        translate(offset + interval * i) {
            if (i % 2) {
                mirror(axis) {
                    children();
                }
            } else {
                children();
            }
        }
    }
}

/**
* Repeats the children modules `count` times in two directions with the provided `interval`
* and mirror them around the plan described by the vector `axis`.
 *
 * @param Number [countX] - The number of times the children must be repeated along the X axis.
 * @param Number [countY] - The number of times the children must be repeated along the Y axis.
 * @param Vector [axisX] - The rotation axis around which rotate the children along the X axis.
 * @param Vector [axisY] - The rotation axis around which rotate the children along the Y axis.
 * @param Vector [intervalX] - The interval between each repeated children along the X axis.
 * @param Vector [intervalY] - The interval between each repeated children along the Y axis.
 * @param Boolean [center] - Whether or not center the repeated shapes.
 */
module repeatMirror2D(countX    = 2,
                      countY    = 2,
                      axisX     = xAxis3D(),
                      axisY     = yAxis3D(),
                      intervalX = 0,
                      intervalY = 0,
                      center    = false) {

    repeatMirror(count=countY, interval=vector3D(intervalY), axis=vector3D(axisY), center=center) {
        repeatMirror(count=countX, interval=vector3D(intervalX), axis=vector3D(axisX), center=center) {
            children();
        }
    }
}

/**
* Repeats the children modules `count` times in three directions with the provided `interval`
* and mirror them around the plan described by the vector `axis`.
 *
 * @param Number [countX] - The number of times the children must be repeated along the X axis.
 * @param Number [countY] - The number of times the children must be repeated along the Y axis.
 * @param Number [countZ] - The number of times the children must be repeated along the Z axis.
 * @param Vector [axisX] - The rotation axis around which rotate the children along the X axis.
 * @param Vector [axisY] - The rotation axis around which rotate the children along the Y axis.
 * @param Vector [axisZ] - The rotation axis around which rotate the children along the Z axis.
 * @param Vector [intervalX] - The interval between each repeated children along the X axis.
 * @param Vector [intervalY] - The interval between each repeated children along the Y axis.
 * @param Vector [intervalZ] - The interval between each repeated children along the Z axis.
 * @param Boolean [center] - Whether or not center the repeated shapes.
 */
module repeatMirror3D(countX    = 2,
                      countY    = 2,
                      countZ    = 2,
                      axisX     = xAxis3D(),
                      axisY     = yAxis3D(),
                      axisZ     = zAxis3D(),
                      intervalX = 0,
                      intervalY = 0,
                      intervalZ = 0,
                      center    = false) {

    repeatMirror(count=countZ, interval=vector3D(intervalZ), axis=vector3D(axisZ), center=center) {
        repeatMirror(count=countY, interval=vector3D(intervalY), axis=vector3D(axisY), center=center) {
            repeatMirror(count=countX, interval=vector3D(intervalX), axis=vector3D(axisX), center=center) {
                children();
            }
        }
    }
}
