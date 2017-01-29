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
 * Operators that apply on children modules with respect to particular rules.
 *
 * @package operator
 * @author jsconan
 */

/**
 * Applies a transformation on the children modules.
 *
 * @param Number [scaleX] - The scale factor on the X axis.
 * @param Number [scaleY] - The scale factor on the Y axis.
 * @param Number [scaleZ] - The scale factor on the Z axis.
 * @param Number [translateX] - The translation on X axis.
 * @param Number [translateY] - The translation on Y axis.
 * @param Number [translateZ] - The translation on Z axis.
 * @param Number [scaleXY] - The scale factor on the X axis sheared along Y.
 * @param Number [scaleXZ] - The scale factor on the X axis sheared along Z.
 * @param Number [scaleYX] - The scale factor on the Y axis sheared along X.
 * @param Number [scaleYZ] - The scale factor on the Y axis sheared along Z.
 * @param Number [scaleZX] - The scale factor on the Z axis sheared along X.
 * @param Number [scaleZY] - The scale factor on the Z axis sheared along Y.
 */
module transform(scaleX=1, scaleY=1, scaleZ=1,
                 translateX=0, translateY=0, translateZ=0,
                 scaleXY=0, scaleXZ=0,
                 scaleYX=0, scaleYZ=0,
                 scaleZX=0, scaleZY=0) {
    m = [
        [scaleX, scaleXY, scaleXZ, translateX],
        [scaleYX, scaleY, scaleYZ, translateY],
        [scaleZX, scaleZY, scaleZ, translateZ]
    ];

    multmatrix(m) {
        children();
    }
}
