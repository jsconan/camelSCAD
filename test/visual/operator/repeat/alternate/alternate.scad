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
 * Test the operator: repeatAlternate()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 14];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=3, margin=2, center=true) {
    /*  0 */ repeatAlternate() testElement();
    /*  1 */ repeatAlternate(renderEven=false) testElement();
    /*  2 */ repeatAlternate(renderEven=true) testElement();

    /*  3 */ repeatAlternate(count=4) testElement();
    /*  4 */ repeatAlternate(interval=1) testElement();
    /*  5 */ repeatAlternate(count=4, interval=1, renderEven=true) testElement();

    /*  6 */ repeatAlternate(count=4, interval=[1, 2, 3]) testElement();
    /*  7 */ repeatAlternate(count=4, interval=[1, 2, 3], renderEven=true) testElement();
    /*  8 */ repeatAlternate(count=4, interval=1, renderEven=true, center=true) testElement(center=true);

    /*  9 */ repeatAlternate(count=4, intervalX=1) testElement();
    /* 10 */ repeatAlternate(count=4, intervalY=1) testElement();
    /* 11 */ repeatAlternate(count=4, intervalZ=1) testElement();

    /* 12 */ repeatAlternate(count=4, intervalX=1, renderEven=true) testElement();
    /* 13 */ repeatAlternate(count=4, intervalY=1, renderEven=true) testElement();
    /* 14 */ repeatAlternate(count=4, intervalZ=1, renderEven=true) testElement();
}
