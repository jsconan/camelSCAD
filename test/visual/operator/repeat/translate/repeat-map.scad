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
 * Entry point for visual testing.
 *
 * Test the operator: repeatMap()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 7];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=4, margin=2, center=true) {
    /*  0 */ repeatMap() testElement();
    /*  1 */ repeatMap(map=[0, 2, 4]) testElement();
    /*  2 */ repeatMap(map=[0, 2, 4], offset=1) testElement();
    /*  3 */ repeatMap(map=[[0, 0, 0], [2, 0, 0], [0, 2, 0]], offset=1) testElement();

    /*  4 */ repeatMap(map=[[0, 0, 0], [2, 0, 0], [0, 2, 0]], offset=[0, 0, 1]) testElement();
    /*  5 */ repeatMap(map=[[0, 0, 0], [2, 0, 0], [0, 2, 0]], x=1) testElement();
    /*  6 */ repeatMap(map=[[0, 0, 0], [2, 0, 0], [0, 2, 0]], y=1) testElement();
    /*  7 */ repeatMap(map=[[0, 0, 0], [2, 0, 0], [0, 2, 0]], z=1) testElement();
}
