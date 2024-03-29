/**
 * @license
 * MIT License
 *
 * Copyright (c) 2022 Jean-Sebastien CONAN
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
 * Repeats the children modules `count` times with the provided `interval`,
 * only rendering the odd or even positions. This means that the children
 * will be rendered less than `count` times as half of the positions will
 * be left empty.
 *
 * @param Number [count] - The number of times the children must be repeated.
 * @param Vector [interval] - The interval between each repeated children.
 * @param Boolean [renderEven] - Only render on even positions.
 * @param Boolean [center] - Whether or not center the repeated shapes.
 * @param Number [intervalX] - The X interval between each repeated children
 *                             (will overwrite the X coordinate in the `interval` vector).
 * @param Number [intervalY] - The Y interval between each repeated children
 *                             (will overwrite the Y coordinate in the `interval` vector).
 * @param Number [intervalZ] - The Z interval between each repeated children
 *                             (will overwrite the Z coordinate in the `interval` vector).
 */
module repeatAlternate(count      = 2,
                       interval   = 0,
                       renderEven = false,
                       center     = false,
                       intervalX, intervalY, intervalZ) {

    renderEven = boolean(renderEven);
    interval = apply3D(interval, intervalX, intervalY, intervalZ);
    offset = center ? -interval * (count - 1) / 2 : ORIGIN_3D;

    for (i = [0 : count - 1]) {
        if (renderEven == even(i)) {
            translate(offset + interval * i) {
                children();
            }
        }
    }
}

/**
 * Repeats the children modules in two directions `count` times with the provided `interval`,
 * only rendering the odd or even positions. This means that the children
 * will be rendered less than `count` times as half of the positions will
 * be left empty.
 *
 * @param Number [countX] - The number of times the children must be repeated along the X axis.
 * @param Number [countY] - The number of times the children must be repeated along the Y axis.
 * @param Vector [intervalX] - The interval between each repeated children along the X axis.
 * @param Vector [intervalY] - The interval between each repeated children along the Y axis.
 * @param Boolean [renderEven] - Only render on even positions.
 * @param Boolean [center] - Whether or not center the repeated shapes.
 */
module repeatAlternate2D(countX     = 2,
                         countY     = 2,
                         intervalX  = 0,
                         intervalY  = 0,
                         renderEven = false,
                         center     = false) {

    renderEven = boolean(renderEven);
    intervalX = vector3D(intervalX);
    intervalY = vector3D(intervalY);
    offsetX = center ? -intervalX * (countX - 1) / 2 : ORIGIN_3D;
    offsetY = center ? -intervalY * (countY - 1) / 2 : ORIGIN_3D;
    offset = offsetX + offsetY;

    for (y = [0 : countY - 1] ) {
        for (x = [0 : countX - 1] ) {
            alignedXY = even(x) == even(y);
            if (renderEven == alignedXY) {
                translate(offset + intervalX * x + intervalY * y) {
                    children();
                }
            }
        }
    }
}

/**
 * Repeats the children modules in three directions `count` times with the provided `interval`,
 * only rendering the odd or even positions. This means that the children
 * will be rendered less than `count` times as half of the positions will
 * be left empty.
 *
 * @param Number [countX] - The number of times the children must be repeated along the X axis.
 * @param Number [countY] - The number of times the children must be repeated along the Y axis.
 * @param Number [countZ] - The number of times the children must be repeated along the Z axis.
 * @param Vector [intervalX] - The interval between each repeated children along the X axis.
 * @param Vector [intervalY] - The interval between each repeated children along the Y axis.
 * @param Vector [intervalZ] - The interval between each repeated children along the Z axis.
 * @param Boolean [renderEven] - Only render on even positions.
 * @param Boolean [center] - Whether or not center the repeated shapes.
 */
module repeatAlternate3D(countX     = 2,
                         countY     = 2,
                         countZ     = 2,
                         intervalX  = 0,
                         intervalY  = 0,
                         intervalZ  = 0,
                         renderEven = false,
                         center     = false) {

    renderEven = boolean(renderEven);
    intervalX = vector3D(intervalX);
    intervalY = vector3D(intervalY);
    intervalZ = vector3D(intervalZ);
    offsetX = center ? -intervalX * (countX - 1) / 2 : ORIGIN_3D;
    offsetY = center ? -intervalY * (countY - 1) / 2 : ORIGIN_3D;
    offsetZ = center ? -intervalZ * (countZ - 1) / 2 : ORIGIN_3D;
    offset = offsetX + offsetY + offsetZ;

    for (z = [0 : countZ - 1] ) {
        for (y = [0 : countY - 1] ) {
            for (x = [0 : countX - 1] ) {
                alignedXY = even(x) == even(y);
                evenZ = even(z);
                if ((renderEven == alignedXY && evenZ) || (renderEven != alignedXY && !evenZ)) {
                    translate(offset + intervalX * x + intervalY * y + intervalZ * z) {
                        children();
                    }
                }
            }
        }
    }
}
