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
 * Repeats the children modules `count` times with the provided `interval`.
 *
 * @param Number [count] - The number of times the children must be repeated.
 * @param Vector [interval] - The interval between each repeated children.
 * @param Boolean [center] - Whether or not center the repeated shapes.
 * @param Number [intervalX] - The X interval between each repeated children
 *                             (will overwrite the X coordinate in the `interval` vector).
 * @param Number [intervalY] - The Y interval between each repeated children
 *                             (will overwrite the Y coordinate in the `interval` vector).
 * @param Number [intervalZ] - The Z interval between each repeated children
 *                             (will overwrite the Z coordinate in the `interval` vector).
 */
module repeat(count    = 2,
              interval = [0, 0, 0],
              center   = false,
              intervalX, intervalY, intervalZ) {

    interval = apply3D(interval, intervalX, intervalY, intervalZ);
    offset = center ? -interval * (count - 1) / 2 : [0, 0, 0];

    for (i = [0 : count - 1]) {
        translate(offset + interval * i) {
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
 * @param Boolean [center] - Whether or not center the repeated shapes.
 */
module repeat2D(countX    = 2,
                countY    = 2,
                intervalX = [0, 0, 0],
                intervalY = [0, 0, 0],
                center    = false) {

    repeat(count=countY, interval=vector3D(intervalY), center=center) {
        repeat(count=countX, interval=vector3D(intervalX), center=center) {
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
 * @param Boolean [center] - Whether or not center the repeated shapes.
 */
module repeat3D(countX    = 2,
                countY    = 2,
                countZ    = 2,
                intervalX = [0, 0, 0],
                intervalY = [0, 0, 0],
                intervalZ = [0, 0, 0],
                center    = false) {

    repeat(count=countZ, interval=vector3D(intervalZ), center=center) {
        repeat(count=countY, interval=vector3D(intervalY), center=center) {
            repeat(count=countX, interval=vector3D(intervalX), center=center) {
                children();
            }
        }
    }
}

/**
 * Repeats horizontally a shape in two directions, the interval is set by the size of the shape.
 * @param Vector size - The size of the shape.
 * @param Vector [count] - The number of shapes on each axis.
 * @param Boolean [center] - Whether or not center the repeated shapes.
 */
module repeatShape2D(size, count = 1, center) {
    size = vector2D(size);
    count = vector2D(count);

    repeat2D(
        countX = count.x,
        countY = count.y,
        intervalX = [size.x, 0, 0],
        intervalY = [0, size.y, 0],
        center = center
    ) {
        children();
    }
}

/**
 * Repeats a shape in three directions, the interval is set by the size of the shape.
 * @param Vector size - The size of the shape.
 * @param Vector [count] - The number of shapes on each axis.
 * @param Boolean [center] - Whether or not center the repeated shapes.
 */
module repeatShape3D(size, count = 1, center) {
    size = vector3D(size);
    count = vector3D(count);

    repeat3D(
        countX = count.x,
        countY = count.y,
        countZ = count.z,
        intervalX = [size.x, 0, 0],
        intervalY = [0, size.y, 0],
        intervalZ = [0, 0, size.z],
        center = center
    ) {
        children();
    }
}

/**
 * Repeats the children modules on every position given in the `map`.
 *
 * @param Vector[] map - The list of position at which place the children.
 * @param Vector [offset] - An offset to add on each position.
 * @param Number [x] - The X-coordinate to apply on the offset.
 * @param Number [y] - The Y-coordinate to apply on the offset.
 * @param Number [z] - The Z-coordinate to apply on the offset.
 */
module repeatMap(map, offset, x, y, z) {
    offset = apply3D(offset, x, y, z);

    for (at = map) {
        translate(offset + vector3D(at)) {
            children();
        }
    }
}
