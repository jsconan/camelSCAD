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
 * Test the operator: repeatGrid()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 11];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=3, margin=2, center=true) {
    /*  0 */ repeatGrid() testElement();
    /*  1 */ repeatGrid(count=1) testElement();
    /*  2 */ repeatGrid(count=3) testElement();

    /*  3 */ repeatGrid(count=3, intervalX=xAxis3D(2), intervalY=yAxis3D(2)) testElement();
    /*  4 */ repeatGrid(count=3, intervalX=xAxis3D(2), intervalY=yAxis3D(2), line=1) testElement();
    /*  5 */ repeatGrid(count=3, intervalX=xAxis3D(2), intervalY=yAxis3D(2), line=3) testElement();

    /*  6 */ repeatGrid(count=3, intervalX=xAxis3D(2), intervalY=yAxis3D(2), center=true) testElement(center=true);
    /*  7 */ repeatGrid(count=3, intervalX=xAxis3D(2), intervalY=yAxis3D(2), line=1, center=true) testElement(center=true);
    /*  8 */ repeatGrid(count=3, intervalX=xAxis3D(2), intervalY=yAxis3D(2), line=3, center=true) testElement(center=true);

    /*  9 */ repeatGrid(count=3, intervalX=xAxis3D(2), intervalY=zAxis3D(2)) testElement();
    /* 10 */ repeatGrid(count=3, intervalX=xAxis3D(2), intervalY=zAxis3D(2), line=1) testElement();
    /* 11 */ repeatGrid(count=3, intervalX=xAxis3D(2), intervalY=zAxis3D(2), line=3) testElement();
}
