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

use <../../../full.scad>

/**
 * Part of the camelSCAD library.
 *
 * Unit tests: Ellipsoid shapes.
 *
 * @package test/shape/3D
 * @author jsconan
 */
module testShape3dEllipsoid() {
    testPackage("shape/3D/ellipsoid.scad", 1) {
        testModule("sizeEllipsoid", 3) {
            testUnit("no parameter", 1) {
                assertEqual(sizeEllipsoid(), [1, 1, 1], "Should always return a size even if not parameter has been provided");
            }
            testUnit("wrong types", 2) {
                assertEqual(sizeEllipsoid("12", "12", "12", "12", "12", "12"), [1, 1, 1], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeEllipsoid(true, true, true, true, true, true), [1, 1, 1], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("correct types", 26) {
                assertEqual(sizeEllipsoid(3), [3, 3, 3], "Should produce a radius vector from a single number radius");
                assertEqual(sizeEllipsoid(d=3), [1.5, 1.5, 1.5], "Should produce a radius vector from a single number diameter");

                assertEqual(sizeEllipsoid([3, 4, 5]), [3, 4, 5], "Should keep the provided radius vector");
                assertEqual(sizeEllipsoid(d=[3, 4, 5]), [1.5, 2, 2.5], "Should translate the provided diameter vector to a radius vector");

                assertEqual(sizeEllipsoid([3, 4, 5], rx=6), [6, 4, 5], "Should set the X radius with the provided radius in the provided radius vector");
                assertEqual(sizeEllipsoid([3, 4, 5], ry=6), [3, 6, 5], "Should set the Y radius with the provided radius in the provided radius vector");
                assertEqual(sizeEllipsoid([3, 4, 5], rz=6), [3, 4, 6], "Should set the Z radius with the provided radius in the provided radius vector");

                assertEqual(sizeEllipsoid([3, 4, 5], dx=2), [1, 4, 5], "Should replace the X radius with the provided diameter in the provided radius vector");
                assertEqual(sizeEllipsoid([3, 4, 5], dy=2), [3, 1, 5], "Should replace the Y radius with the provided diameter in the provided radius vector");
                assertEqual(sizeEllipsoid([3, 4, 5], dz=2), [3, 4, 1], "Should replace the Z radius with the provided diameter in the provided radius vector");

                assertEqual(sizeEllipsoid(d=[3, 4, 5], rx=5), [5, 2, 2.5], "Should set the X radius with the provided radius in the provided provided vector");
                assertEqual(sizeEllipsoid(d=[3, 4, 5], ry=5), [1.5, 5, 2.5], "Should set the Y radius with the provided radius in the provided provided vector");
                assertEqual(sizeEllipsoid(d=[3, 4, 5], rz=5), [1.5, 2, 5], "Should set the Z radius with the provided radius in the provided provided vector");

                assertEqual(sizeEllipsoid(d=[3, 4, 5], dx=2), [1, 2, 2.5], "Should replace the X radius with the provided diameter in the provided provided vector");
                assertEqual(sizeEllipsoid(d=[3, 4, 5], dy=2), [1.5, 1, 2.5], "Should replace the Y radius with the provided diameter in the provided provided vector");
                assertEqual(sizeEllipsoid(d=[3, 4, 5], dz=2), [1.5, 2, 1], "Should replace the Z radius with the provided diameter in the provided provided vector");

                assertEqual(sizeEllipsoid(rx=3), [3, 1, 1], "Should compose a radius vector from the provided X radius");
                assertEqual(sizeEllipsoid(ry=3), [1, 3, 1], "Should compose a radius vector from the provided Y radius");
                assertEqual(sizeEllipsoid(rz=3), [1, 1, 3], "Should compose a radius vector from the provided Z radius");
                assertEqual(sizeEllipsoid(rx=7, ry=3, rz=4), [7, 3, 4], "Should compose a radius vector from the provided X, Y and Z radius");

                assertEqual(sizeEllipsoid(dx=3), [1.5, 1, 1], "Should compose a radius vector from the provided X diameter");
                assertEqual(sizeEllipsoid(dy=3), [1, 1.5, 1], "Should compose a radius vector from the provided Y diameter");
                assertEqual(sizeEllipsoid(dz=3), [1, 1, 1.5], "Should compose a radius vector from the provided Z diameter");
                assertEqual(sizeEllipsoid(dx=7, dy=3, dz=4), [3.5, 1.5, 2], "Should compose a radius vector from the provided X, Y and Z diameter");

                assertEqual(sizeEllipsoid(rx=7, dy=3, dz=4), [7, 1.5, 2], "Should compose a radius vector from the provided X radius and the Y and Z diameters");
                assertEqual(sizeEllipsoid(dx=7, ry=3, rz=4), [3.5, 3, 4], "Should compose a radius vector from the provided X diameter and the Y and Z radius");
            }
        }
    }
}

testShape3dEllipsoid();
