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
 * Operators that translate children modules with respect to particular rules.
 *
 * @package operator/translate
 * @author jsconan
 */

/**
 * Translates the children modules along the X axis.
 *
 * @param Number d - The distance to move.
 */
module translateX(d) {
    translate(xAxis3D(d)) {
        children();
    }
}

/**
 * Translates the children modules along the Y axis.
 *
 * @param Number d - The distance to move.
 */
module translateY(d) {
    translate(yAxis3D(d)) {
        children();
    }
}

/**
 * Translates the children modules along the Z axis.
 *
 * @param Number d - The distance to move.
 */
module translateZ(d) {
    translate(zAxis3D(d)) {
        children();
    }
}
