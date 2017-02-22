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
 * Repeats the children modules `count` times with the provided `interval`.
 *
 * @param Number [count] - The number of times the children must be repeated.
 * @param Vector [interval] - The interval between each repeated children.
 * @param Number [x] - The X interval between each repeated children
 *                     (will overwrite the X coordinate in the `interval` vector).
 * @param Number [y] - The Y interval between each repeated children
 *                     (will overwrite the Y coordinate in the `interval` vector).
 * @param Number [z] - The Z interval between each repeated children
 *                     (will overwrite the Z coordinate in the `interval` vector).
 */
module repeat(count    = 2,
              interval = [0, 0, 0],
              x, y, z) {

    interval = apply3D(interval, x, y, z);

    for (i = [0 : count - 1]) {
        translate(interval * i) {
            children();
        }
    }
}

/**
 * Repeats the children modules in two directions `count` times with the provided `interval`.
 *
 * @param Number [countX] - The number of times the children must be repeated along the X axis.
 * @param Number [countY] - The number of times the children must be repeated along the Y axis.
 * @param Vector [intervalX] - The interval between each repeated children along the X axis.
 * @param Vector [intervalY] - The interval between each repeated children along the Y axis.
 */
module repeat2D(countX    = 2,
                countY    = 2,
                intervalX = [0, 0, 0],
                intervalY = [0, 0, 0]) {

    repeat(count=countY, interval=vector3D(intervalY)) {
        repeat(count=countX, interval=vector3D(intervalX)) {
            children();
        }
    }
}

/**
 * Repeats the children modules in three directions `count` times with the provided `interval`.
 *
 * @param Number [countX] - The number of times the children must be repeated along the X axis.
 * @param Number [countY] - The number of times the children must be repeated along the Y axis.
 * @param Number [countZ] - The number of times the children must be repeated along the Z axis.
 * @param Vector [intervalX] - The interval between each repeated children along the X axis.
 * @param Vector [intervalY] - The interval between each repeated children along the Y axis.
 * @param Vector [intervalZ] - The interval between each repeated children along the Z axis.
 */
module repeat3D(countX    = 2,
                countY    = 2,
                countZ    = 2,
                intervalX = [0, 0, 0],
                intervalY = [0, 0, 0],
                intervalZ = [0, 0, 0]) {

    repeat(count=countZ, interval=vector3D(intervalZ)) {
        repeat(count=countY, interval=vector3D(intervalY)) {
            repeat(count=countX, interval=vector3D(intervalX)) {
                children();
            }
        }
    }
}
