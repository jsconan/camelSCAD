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
 * Test the operator: repeatAlternate3D()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 31];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=4, margin=2, center=true) {
    /*  0 */ repeatAlternate3D() testElement();
    /*  1 */ repeatAlternate3D(countX=4) testElement();
    /*  2 */ repeatAlternate3D(countY=4) testElement();
    /*  3 */ repeatAlternate3D(countZ=4) testElement();

    /*  4 */ repeatAlternate3D(intervalX=1) testElement();
    /*  5 */ repeatAlternate3D(intervalY=1) testElement();
    /*  6 */ repeatAlternate3D(intervalZ=1) testElement();
    /*  7 */ repeatAlternate3D(intervalX=1, intervalY=1, intervalZ=1) testElement();

    /*  8 */ repeatAlternate3D(intervalX=[1, 0, 0]) testElement();
    /*  9 */ repeatAlternate3D(intervalY=[0, 1, 0]) testElement();
    /* 10 */ repeatAlternate3D(intervalZ=[0, 0, 1]) testElement();
    /* 11 */ repeatAlternate3D(intervalX=[1, 0, 0], intervalY=[0, 1, 0], intervalZ=[0, 0, 1]) testElement();

    /* 12 */ repeatAlternate3D(countX=3, countY=4, countZ=5, intervalX=[1, 0, 0], intervalY=[0, 1, 0], intervalZ=[0, 0, 1]) testElement();
    /* 13 */ repeatAlternate3D(countX=5, countY=4, countZ=3, intervalX=[1, 0, 0], intervalY=[0, 1, 0], intervalZ=[0, 0, 1]) testElement();
    /* 14 */ repeatAlternate3D(countX=4, countY=5, countZ=3, intervalX=[1, 0, 0], intervalY=[0, 1, 0], intervalZ=[0, 0, 1]) testElement();
    /* 15 */ repeatAlternate3D(countX=3, countY=4, countZ=5, intervalX=[1, 0, 0], intervalY=[0, 1, 0], intervalZ=[0, 0, 1], center=true) testElement(center=true);

    /* 16 */ repeatAlternate3D(renderEven=true) testElement();
    /* 17 */ repeatAlternate3D(countX=4, renderEven=true) testElement();
    /* 18 */ repeatAlternate3D(countY=4, renderEven=true) testElement();
    /* 19 */ repeatAlternate3D(countZ=4, renderEven=true) testElement();

    /* 20 */ repeatAlternate3D(intervalX=1, renderEven=true) testElement();
    /* 21 */ repeatAlternate3D(intervalY=1, renderEven=true) testElement();
    /* 22 */ repeatAlternate3D(intervalZ=1, renderEven=true) testElement();
    /* 23 */ repeatAlternate3D(intervalX=1, intervalY=1, intervalZ=1, renderEven=true) testElement();

    /* 24 */ repeatAlternate3D(intervalX=[1, 0, 0], renderEven=true) testElement();
    /* 25 */ repeatAlternate3D(intervalY=[0, 1, 0], renderEven=true) testElement();
    /* 26 */ repeatAlternate3D(intervalZ=[0, 0, 1], renderEven=true) testElement();
    /* 27 */ repeatAlternate3D(intervalX=[1, 0, 0], intervalY=[0, 1, 0], intervalZ=[0, 0, 1], renderEven=true) testElement();

    /* 28 */ repeatAlternate3D(countX=3, countY=4, countZ=5, intervalX=[1, 0, 0], intervalY=[0, 1, 0], intervalZ=[0, 0, 1], renderEven=true) testElement();
    /* 29 */ repeatAlternate3D(countX=5, countY=4, countZ=3, intervalX=[1, 0, 0], intervalY=[0, 1, 0], intervalZ=[0, 0, 1], renderEven=true) testElement();
    /* 20 */ repeatAlternate3D(countX=4, countY=5, countZ=3, intervalX=[1, 0, 0], intervalY=[0, 1, 0], intervalZ=[0, 0, 1], renderEven=true) testElement();
    /* 31 */ repeatAlternate3D(countX=3, countY=4, countZ=5, intervalX=[1, 0, 0], intervalY=[0, 1, 0], intervalZ=[0, 0, 1], renderEven=true, center=true) testElement(center=true);
}
