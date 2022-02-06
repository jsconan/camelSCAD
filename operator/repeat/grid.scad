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
 * Repeats the children module `count` times and place each copy on a grid with the provided `interval`, up to `line` elements per lines.
 *
 * @param Number [count] - The number of times the children must be repeated.
 * @param Vector [intervalX] - The interval between each columns.
 * @param Vector [intervalY] - The interval between each lines.
 * @param Number [line] - The max number of elements per lines.
 * @param Boolean [center] - Whether or not center the repeated shapes.
 */
module repeatGrid(count     = 2,
                  intervalX = xAxis3D(),
                  intervalY = yAxis3D(),
                  line      = 2,
                  center    = false) {

    intervalX = vector3D(intervalX);
    intervalY = vector3D(intervalY);
    count = max(floor(abs(float(count))), 1);
    line = max(floor(abs(float(line))), 1);
    offsetX = center ? -intervalX * ((count > line ? line : count) - 1) / 2 : ORIGIN_3D;
    offsetY = center ? -intervalY * (iToY(count, line) - (iToX(count, line) ? 0 : 1)) / 2 : ORIGIN_3D;

    for (i = [0 : count - 1]) {
        translate(offsetX + intervalX * iToX(i, line) + offsetY + intervalY * iToY(i, line)) {
            children();
        }
    }
}
