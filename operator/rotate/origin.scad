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
 * Operators that rotate children modules with respect to particular rules.
 *
 * @package operator/rotate
 * @author jsconan
 */

/**
 * Rotates the children modules from the provided origin.
 *
 * @param Vector|Number [a] - The rotate angle to apply.
 * @param Vector [v] - The rotate axis.
 * @param Vector [o] - The rotate origin.
 */
module rotateOrigin(a, v, o) {
    o = vector3D(o);
    translate(o) {
        rotate(a=a, v=v) {
            translate(-o) {
                children();
            }
        }
    }
}

/**
 * Rotates the children modules around the X axis from the provided origin.
 *
 * @param Number a - The rotate angle to apply.
 * @param Vector [o] - The rotate origin.
 */
module rotateOriginX(a, o) {
    o = vector3D(o);
    translate(o) {
        rotate([a, 0, 0]) {
            translate(-o) {
                children();
            }
        }
    }
}

/**
 * Rotates the children modules around the Y axis from the provided origin.
 *
 * @param Number a - The rotate angle to apply.
 * @param Vector [o] - The rotate origin.
 */
module rotateOriginY(a, o) {
    o = vector3D(o);
    translate(o) {
        rotate([0, a, 0]) {
            translate(-o) {
                children();
            }
        }
    }
}

/**
 * Rotates the children modules around the Z axis from the provided origin.
 *
 * @param Number a - The rotate angle to apply.
 * @param Vector [o] - The rotate origin.
 */
module rotateOriginZ(a, o) {
    o = vector3D(o);
    translate(o) {
        rotate([0, 0, a]) {
            translate(-o) {
                children();
            }
        }
    }
}
