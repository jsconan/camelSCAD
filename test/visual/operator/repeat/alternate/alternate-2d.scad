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
 * Test the operator: repeatAlternate2D()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 23];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=3, margin=2, center=true) {
    /*  0 */ repeatAlternate2D() testElement();
    /*  1 */ repeatAlternate2D(countX=4) testElement();
    /*  2 */ repeatAlternate2D(countY=4) testElement();

    /*  3 */ repeatAlternate2D(intervalX=1) testElement();
    /*  4 */ repeatAlternate2D(intervalY=1) testElement();
    /*  5 */ repeatAlternate2D(intervalX=1, intervalY=1) testElement();

    /*  6 */ repeatAlternate2D(intervalX=[1, 0, 0]) testElement();
    /*  7 */ repeatAlternate2D(intervalY=[0, 1, 0]) testElement();
    /*  8 */ repeatAlternate2D(intervalX=[1, 0, 0], intervalY=[0, 1, 0]) testElement();

    /*  9 */ repeatAlternate2D(countX=3, countY=4, intervalX=[1, 0, 0], intervalY=[0, 1, 0]) testElement();
    /* 10 */ repeatAlternate2D(countX=4, countY=3, intervalX=[1, 0, 0], intervalY=[0, 1, 0]) testElement();
    /* 11 */ repeatAlternate2D(countX=3, countY=4, intervalX=[1, 0, 0], intervalY=[0, 1, 0], center=true) testElement(center=true);

    /* 12 */ repeatAlternate2D(renderEven=true) testElement();
    /* 13 */ repeatAlternate2D(countX=4, renderEven=true) testElement();
    /* 14 */ repeatAlternate2D(countY=4, renderEven=true) testElement();

    /* 15 */ repeatAlternate2D(intervalX=1, renderEven=true) testElement();
    /* 16 */ repeatAlternate2D(intervalY=1, renderEven=true) testElement();
    /* 17 */ repeatAlternate2D(intervalX=1, intervalY=2, renderEven=true) testElement();

    /* 18 */ repeatAlternate2D(intervalX=[1, 0, 0], renderEven=true) testElement();
    /* 19 */ repeatAlternate2D(intervalY=[0, 1, 0], renderEven=true) testElement();
    /* 20 */ repeatAlternate2D(intervalX=[1, 0, 0], intervalY=[0, 1, 0], renderEven=true) testElement();

    /* 21 */ repeatAlternate2D(countX=3, countY=4, intervalX=[1, 0, 0], intervalY=[0, 1, 0], renderEven=true) testElement();
    /* 22 */ repeatAlternate2D(countX=4, countY=3, intervalX=[1, 0, 0], intervalY=[0, 1, 0], renderEven=true) testElement();
    /* 23 */ repeatAlternate2D(countX=3, countY=4, intervalX=[1, 0, 0], intervalY=[0, 1, 0], renderEven=true, center=true) testElement(center=true);
}
