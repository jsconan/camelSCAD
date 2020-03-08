/**
 * @license
 * MIT License
 *
 * Copyright (c) 2017-2020 Jean-Sebastien CONAN
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
 * Unit test: Version.
 *
 * @package test/core/version
 * @author jsconan
 */
module testCoreVersion() {
    validateRequirements();
    testPackage("core/version.scad", 2) {
        // test checkOpenSCAD()
        testModule("checkOpenSCAD()", 1) {
            testUnit("must satisfy", 1) {
                assertEqual(checkOpenSCAD(), true, "The installed version of OpenSCAD must be up to date enough");
            }
        }
        // test camelSCAD()
        testModule("camelSCAD()", 2) {
            testUnit("as vector", 1) {
                assertEqual(camelSCAD(), [0, 11, 0], "The current version of the library is 0.11.0");
            }
            testUnit("as string", 1) {
                assertEqual(camelSCAD(true), "0.11.0", "The current version of the library is 0.11.0");
            }
        }
    }
}

testCoreVersion();
