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
 * Test the operator: repeat3D()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 13];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=4, margin=2, center=true) {
    /*  0 */ repeat3D() testElement();
    /*  1 */ repeat3D(countX=3) testElement();
    /*  2 */ repeat3D(countY=3) testElement();
    /*  3 */ repeat3D(countZ=3) testElement();

    /*  4 */ repeat3D(intervalX=2) testElement();
    /*  5 */ repeat3D(intervalY=2) testElement();
    /*  6 */ repeat3D(intervalZ=2) testElement();
    /*  7 */ repeat3D(intervalX=2, intervalY=2, intervalZ=2) testElement();

    /*  8 */ repeat3D(intervalX=[2, 0, 0]) testElement();
    /*  9 */ repeat3D(intervalY=[0, 2, 0]) testElement();
    /* 10 */ repeat3D(intervalZ=[0, 0, 2]) testElement();
    /* 11 */ repeat3D(intervalX=[2, 0, 0], intervalY=[0, 2, 0], intervalZ=[0, 0, 2]) testElement();

    /* 12 */ repeat3D(countX=4, countY=3, countZ=2, intervalX=[2, 0, 0], intervalY=[0, 2, 0], intervalZ=[0, 0, 2]) testElement();
    /* 13 */ repeat3D(countX=4, countY=3, countZ=2, intervalX=[2, 0, 0], intervalY=[0, 2, 0], intervalZ=[0, 0, 2], center=true) testElement(center=true);
}
