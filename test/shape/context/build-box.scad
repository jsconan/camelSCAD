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
include <../../../core/constants.scad>

/**
 * Part of the camelSCAD library.
 *
 * Unit tests: Build box visualization.
 *
 * @package test/shape/context
 * @author jsconan
 */
module testShapeContextBuildBox() {
    testPackage("shape/context/build-box.scad", 1) {
        // test shape/context/build-box/sizeBuildPlate()
        testModule("sizeBuildPlate()", 2) {
            defaultSize = [DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE];
            defaultCell = [DEFAULT_BUILD_PLATE_CELL, DEFAULT_BUILD_PLATE_CELL];
            defaultCount = [floor(DEFAULT_BUILD_PLATE_SIZE / DEFAULT_BUILD_PLATE_CELL) + 1, floor(DEFAULT_BUILD_PLATE_SIZE / DEFAULT_BUILD_PLATE_CELL) + 1];
            defaultOffset = -[floor(DEFAULT_BUILD_PLATE_SIZE / DEFAULT_BUILD_PLATE_CELL) * DEFAULT_BUILD_PLATE_CELL, floor(DEFAULT_BUILD_PLATE_SIZE / DEFAULT_BUILD_PLATE_CELL) * DEFAULT_BUILD_PLATE_CELL] / 2;

            testUnit("default values", 3) {
                assertEqual(sizeBuildPlate(), [defaultSize, defaultCell, defaultCount, defaultOffset], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeBuildPlate("12", "12", "12", "12", "12", "12"), [[0, 0], [0, 0], [1, 1], [0, 0]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeBuildPlate(true, true, true, true, true, true), [[0, 0], [0, 0], [1, 1], [0, 0]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 15) {
                assertEqual(sizeBuildPlate(100), [[100, 100], defaultCell, [11, 11], [-50, -50]], "Should extend the size of the plate to a vector, and use the default cell size");
                assertEqual(sizeBuildPlate(100, 5), [[100, 100], [5, 5], [21, 21], [-50, -50]], "Should extend the size of the plate and the cell to vectors");

                assertEqual(sizeBuildPlate(100, l=200), [[200, 100], defaultCell, [21, 11], [-100, -50]], "Should extend the size of the plate to a vector, replace the length, and use the default cell size");
                assertEqual(sizeBuildPlate(100, w=200), [[100, 200], defaultCell, [11, 21], [-50, -100]], "Should extend the size of the plate to a vector, replace the width, and use the default cell size");

                assertEqual(sizeBuildPlate(100, 5, cl=10), [[100, 100], [10, 5], [11, 21], [-50, -50]], "Should extend the size of the plate and the cell to vectors, and replpace the cell length");
                assertEqual(sizeBuildPlate(100, 5, cw=10), [[100, 100], [5, 10], [21, 11], [-50, -50]], "Should extend the size of the plate and the cell to vectors, and replpace the cell width");

                assertEqual(sizeBuildPlate([200, 100]), [[200, 100], defaultCell, [21, 11], [-100, -50]], "Should use the size of the plate as a vector, and use the default cell size");
                assertEqual(sizeBuildPlate([200, 100], [20, 10]), [[200, 100], [20, 10], [11, 11], [-100, -50]], "Should use the size of the plate and the cell as vectors");

                assertEqual(sizeBuildPlate([200, 100], l=100), [[100, 100], defaultCell, [11, 11], [-50, -50]], "Should use the size of the plate as a vector, and use the default cell size, and replace the length");
                assertEqual(sizeBuildPlate([100, 200], w=100), [[100, 100], defaultCell, [11, 11], [-50, -50]], "Should use the size of the plate as a vector, and use the default cell size, and replace the width");

                assertEqual(sizeBuildPlate([200, 100], [20, 10], cl=10), [[200, 100], [10, 10], [21, 11], [-100, -50]], "Should use the size of the plate and the cell as vectors, and replade the cell length");
                assertEqual(sizeBuildPlate([200, 100], [10, 20], cw=10), [[200, 100], [10, 10], [21, 11], [-100, -50]], "Should use the size of the plate and the cell as vectors, and replade the cell width");

                assertEqual(sizeBuildPlate(l=200, w=100), [[200, 100], defaultCell, [21, 11], [-100, -50]], "Should accept the size as components, and use the default cell size");
                assertEqual(sizeBuildPlate(cl=20, cw=10), [defaultSize, [20, 10], [11, 21], [-100, -100]], "Should accept the cell as components, and use the default size");
                assertEqual(sizeBuildPlate(l=200, w=100, cl=20, cw=10), [[200, 100], [20, 10], [11, 11], [-100, -50]], "Should accept the size of the plate and the cell as components");
            }
        }
    }
}

testShapeContextBuildBox();
