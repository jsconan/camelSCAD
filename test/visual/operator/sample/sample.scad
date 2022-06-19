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
 * Test the operator: sample()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 17];
TESTBED_SHOW = true;

visualTestSuite(length=10, width=10, cols=3, margin=2, center=true) {
    /*  0 */ testElement() sample() testElement();
    /*  1 */ testElement() sample(size=.5) testElement();
    /*  2 */ testElement() sample(size=.5, offset=.5) testElement();

    /*  3 */ testElement() sample(size=[1, 1, .2]) testElement();
    /*  4 */ testElement() sample(size=[1, .2, 1]) testElement();
    /*  5 */ testElement() sample(size=[.2, 1, 1]) testElement();

    /*  6 */ testElement() sample(size=[1, 1, .2], offset=[0, 0, .6]) testElement();
    /*  7 */ testElement() sample(size=[1, .2, 1], offset=[0, .6, 0]) testElement();
    /*  8 */ testElement() sample(size=[.2, 1, 1], offset=[.6, 0, 0]) testElement();

    /*  9 */ testElement() sample(size=1, l=.2) testElement();
    /* 10 */ testElement() sample(size=1, w=.2) testElement();
    /* 11 */ testElement() sample(size=1, h=.2) testElement();

    /* 12 */ testElement() sample(size=1, l=.2, x=.6) testElement();
    /* 13 */ testElement() sample(size=1, w=.2, y=.6) testElement();
    /* 14 */ testElement() sample(size=1, h=.2, z=.6) testElement();

    /* 15 */ testElement() sample(size=[1, 1, .2], offset=[0, 0, .6], center=true) testElement(center=true);
    /* 16 */ testElement() sample(size=[1, .2, 1], offset=[0, .6, 0], center=true) testElement(center=true);
    /* 17 */ testElement() sample(size=[.2, 1, 1], offset=[.6, 0, 0], center=true) testElement(center=true);
}
