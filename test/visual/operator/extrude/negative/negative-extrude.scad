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
 * Test the operator: negativeExtrude()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 14];
TESTBED_SHOW = true;

visualTestSuite(length=10, width=10, cols=3, margin=2, center=true) {
    /*  0 */ testElement() negativeExtrude() square(1);
    /*  1 */ testElement() negativeExtrude(height=2) square(1);
    /*  2 */ testElement() negativeExtrude(height=-2) square(1);

    /*  3 */ testElement() negativeExtrude(center=true) square(1);
    /*  4 */ testElement() negativeExtrude(height=2, center=true) square(1);
    /*  5 */ testElement() negativeExtrude(height=-2, center=true) square(1);

    /*  6 */ testElement() negativeExtrude(twist=45) square(1, center=true);
    /*  7 */ testElement() negativeExtrude(height=2, twist=45) square(1, center=true);
    /*  8 */ testElement() negativeExtrude(height=-2, twist=45) square(1, center=true);

    /*  9 */ testElement() negativeExtrude(twist=45, slices=10) square(1, center=true);
    /* 10 */ testElement() negativeExtrude(height=2, twist=45, slices=10) square(1, center=true);
    /* 11 */ testElement() negativeExtrude(height=-2, twist=45, slices=10) square(1, center=true);

    /* 12 */ testElement() negativeExtrude(scale=2) square(1, center=true);
    /* 13 */ testElement() negativeExtrude(height=2, scale=2) square(1, center=true);
    /* 14 */ testElement() negativeExtrude(height=-2, scale=2) square(1, center=true);
}
