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
 * Test the shape: regularCross()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

RENDER_MODE = "prod";
TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 17];
TESTBED_SHOW = true;

applyMode(RENDER_MODE) {
    visualTestSuite(length=20, width=20, cols=3, margin=2, center=true) {
        /*  0 */ testElement() regularCross();
        /*  1 */ testElement() regularCross(5);
        /*  2 */ testElement() regularCross(5, 3);

        /*  3 */ testElement() regularCross(5, l=3);
        /*  4 */ testElement() regularCross(5, w=3);
        /*  5 */ testElement() regularCross(5, l=3, w=3);

        /*  6 */ testElement() regularCross(5, cl=2);
        /*  7 */ testElement() regularCross(5, cw=2);
        /*  8 */ testElement() regularCross(5, cl=2, cw=2);

        /*  9 */ testElement() regularCross([5, 3]);
        /* 10 */ testElement() regularCross([5, 3], [1, 2]);
        /* 11 */ testElement() regularCross([5, 3], [1, 2], 5);

        /* 12 */ testElement() regularCross(size=5, core=2, l=3);
        /* 13 */ testElement() regularCross(size=5, core=2, w=3);
        /* 14 */ testElement() regularCross(size=5, core=2, l=3, w=3);

        /* 15 */ testElement() regularCross(size=5, core=2, cl=1);
        /* 16 */ testElement() regularCross(size=5, core=2, cw=1);
        /* 17 */ testElement() regularCross(size=5, core=2, cl=1, cw=1);
    }
}
