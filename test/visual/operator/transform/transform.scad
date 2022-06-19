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
 * Test the operator: transform()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../full.scad>

ANGLE=45;
TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 15];
TESTBED_SHOW = true;

visualTestSuite(length=10, width=10, cols=3, margin=2, center=true) {
    /*  0 */ transform(scaleX=.5) testElement();
    /*  1 */ transform(scaleY=.5) testElement();
    /*  2 */ transform(scaleZ=.5) testElement();

    /*  3 */ transform(translateX=1) testElement();
    /*  4 */ transform(translateY=1) testElement();
    /*  5 */ transform(translateZ=1) testElement();

    /*  6 */ transform(scaleXY=.5) testElement();
    /*  7 */ transform(scaleXZ=.5) testElement();

    /*  8 */ transform(scaleYX=.5) testElement();
    /*  9 */ transform(scaleYZ=.5) testElement();

    /* 10 */ transform(scaleZX=.5) testElement();
    /* 11 */ transform(scaleZY=.5) testElement();

    /* 12 */ transform(translateX=1, translateY=2, translateZ=3) testElement();

    /* 13 */ transform(scaleX=cos(ANGLE), scaleY=cos(ANGLE), scaleXY=-sin(ANGLE), scaleYX=sin(ANGLE)) testElement();

    /* 14 */ transform(scaleX=cos(ANGLE), scaleY=cos(ANGLE), scaleXY=-sin(ANGLE), scaleYX=sin(ANGLE), translateX=1, translateY=2, translateZ=3) testElement();

    /* 15 */ transform() testElement();
}

