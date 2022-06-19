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
 * Test the shape: wedge()
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
        /*  0 */ testElement() wedge();
        /*  1 */ testElement() wedge(5);
        /*  2 */ testElement() wedge(5, 3);

        /*  3 */ testElement() wedge(r=5);
        /*  4 */ testElement() wedge(d=5);
        /*  5 */ testElement() wedge(h=5);

        /*  6 */ testElement() wedge(r=[5, 3]);
        /*  7 */ testElement() wedge(d=[5, 3]);
        /*  8 */ testElement() wedge(r=5, h=3, center=true);

        /*  9 */ testElement() wedge(rx=5);
        /* 10 */ testElement() wedge(ry=5);
        /* 11 */ testElement() wedge(rx=5, ry=3);

        /* 12 */ testElement() wedge(dx=5);
        /* 13 */ testElement() wedge(dy=5);
        /* 14 */ testElement() wedge(dx=5, dy=3);

        /* 15 */ testElement() wedge(r=5, h=3, a=30);
        /* 16 */ testElement() wedge(r=5, h=3, a1=30, a2=60);
        /* 17 */ testElement() wedge(r=5, h=3, a1=-20, a2=200);
    }
}
