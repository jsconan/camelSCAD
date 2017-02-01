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

use <../../full.scad>

/**
 * Part of the camelSCAD library.
 *
 * Unit test: Rendering mode.
 *
 * @package test/core/mode
 * @author jsconan
 */
module testCoreMode() {
    expectedModes = [
        ["dirty", 6, 2],
        ["dev", 1, 1.5],
        ["prod", .5, .5]
    ];
    testPackage("core/mode.scad", 3) {
        // test renderMode()
        testModule("renderMode()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(renderMode(), expectedModes[1], "Should return the default mode");
            }
            testUnit("modes", 3) {
                assertEqual(renderMode("dirty"), expectedModes[0], "Should return the dirty mode");
                assertEqual(renderMode("dev"), expectedModes[1], "Should return the development mode");
                assertEqual(renderMode("prod"), expectedModes[2], "Should return the production mode");
            }
        }
        // test facetAngle()
        testModule("facetAngle()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(facetAngle(), expectedModes[1][1], "Should return the minimum facet angle of the default mode");
            }
            testUnit("modes", 3) {
                assertEqual(facetAngle("dirty"), expectedModes[0][1], "Should return the minimum facet angle of the dirty mode");
                assertEqual(facetAngle("dev"), expectedModes[1][1], "Should return the minimum facet angle of the development mode");
                assertEqual(facetAngle("prod"), expectedModes[2][1], "Should return the minimum facet angle of the production mode");
            }
        }
        // test facetSize()
        testModule("facetSize()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(facetSize(), expectedModes[1][2], "Should return the minimum facet angle of the default mode");
            }
            testUnit("modes", 3) {
                assertEqual(facetSize("dirty"), expectedModes[0][2], "Should return the minimum facet angle of the dirty mode");
                assertEqual(facetSize("dev"), expectedModes[1][2], "Should return the minimum facet angle of the development mode");
                assertEqual(facetSize("prod"), expectedModes[2][2], "Should return the minimum facet angle of the production mode");
            }
        }
    }
}

testCoreMode();
