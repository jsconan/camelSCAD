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
 * Operators that extrude children modules with respect to particular rules.
 *
 * @package operator/extrude
 * @author jsconan
 */

/**
 * Extrudes linearly the children modules, and applies a wall adjustment to ensure
 * the final object will not produce artifacts after a `difference()` operation.
 *
 * @param Number [height] - The height of the extrusion. If the value is negative,
 *                          the extrusion will be made top to bottom (below the origin).
 * @param Number|String [direction] - Tells on what sides adjust the height to make sure
 *                                    the difference won't produce dummy walls.
 * @param Boolean [center] - Whether or not center the extrusion on the vertical axis.
 * @param Number [convexity] - If the extrusion fails for a non-trivial 2D shape,
 *                             try setting the convexity parameter.
 * @param Number [twist] - The number of degrees of through which the shape is extruded.
 * @param Number [slices] - Defines the number of intermediate points along the Z axis
 *                          of the extrusion.
 * @param Number|Vector [scale] - Scales the 2D shape by this value over the height of
 *                                the extrusion.
 */
module negativeExtrude(height, direction, center, convexity, twist, slices, scale) {
    center = boolean(center);
    convexity = numberOr(convexity, 10);
    height = align(value=height, direction=direction, center=center);

    translateZ(height[1]) {
        linear_extrude(height=height[0], center=center, convexity=convexity, twist=twist, slices=slices, scale=scale) {
            children();
        }
    }
}
