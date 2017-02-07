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
 * coarchs of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * coarchs or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

use <../../../full.scad>

/**
 * Part of the camelSCAD library.
 *
 * Unit tests: Polyhedron shapes.
 *
 * @package test/shape/3D
 * @author jsconan
 */
module testShape3dPolyhedron() {
    testPackage("shape/3D/polyhedron.scad", 1) {
        // test shape/3D/polyhedron/sizeBox()
        testModule("sizeBox()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeBox(), [1, 1, 1], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeBox("12", "12", "12"), [1, 1, 1], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeBox(true, true, true), [1, 1, 1], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 8) {
                assertEqual(sizeBox(3), [3, 3, 3], "Should produce a size vector from a single number size");
                assertEqual(sizeBox([3]), [3, 1, 1], "Should complete incomplete size vector");
                assertEqual(sizeBox([3, 2]), [3, 2, 1], "Should complete incomplete size vector");
                assertEqual(sizeBox([3, 4, 5]), [3, 4, 5], "Should keep the provided size vector");
                assertEqual(sizeBox([3, 4, 5, 6]), [3, 4, 5], "Should truncate too big size vector");
                assertEqual(sizeBox([3, 4, 2], l=5), [5, 4, 2], "Should set the length with the provided length in the provided size vector");
                assertEqual(sizeBox([3, 4, 2], w=5), [3, 5, 2], "Should set the width with the provided width in the provided size vector");
                assertEqual(sizeBox([3, 4, 2], h=5), [3, 4, 5], "Should set the height with the provided width in the provided size vector");
            }
        }
    }
}

testShape3dPolyhedron();
