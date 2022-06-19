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
 * Test the shape: meshBox()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

RENDER_MODE = "prod";
TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 20];
TESTBED_SHOW = true;

applyMode(RENDER_MODE) {
    visualTestSuite(length=20, width=20, cols=3, margin=2, center=true) {
        /*  0 */ testElement() meshBox();
        /*  1 */ testElement() meshBox(5);
        /*  2 */ testElement() meshBox([5, 3, 2], center=true);

        /*  3 */ testElement() meshBox(size=10, count=5);
        /*  4 */ testElement() meshBox(size=10, count=5, gap=1);
        /*  5 */ testElement() meshBox(size=10, count=5, gap=1, pointy=true);

        /*  6 */ testElement() meshBox(size=[10, 8], count=[5, 3], gap=[1, 2]);
        /*  7 */ testElement() meshBox(size=[10, 8], count=[5, 3], gap=[1, 2], linear=true);
        /*  8 */ testElement() meshBox(size=[10, 8], count=[5, 3], gap=1, linear=true);

        /*  9 */ testElement() meshBox(size=10, count=5, gap=1, linear=true);
        /* 10 */ testElement() meshBox(size=10, count=5, gap=1, linear=true, pointy=true);
        /* 11 */ testElement() meshBox(size=10, count=5, gap=1, linear=true, even=true);

        /* 12 */ testElement() meshBox(size=10, count=5, gap=1, l=5);
        /* 13 */ testElement() meshBox(size=10, count=5, gap=1, w=5);
        /* 14 */ testElement() meshBox(size=10, count=5, gap=1, l=5, w=5, h=2, center=true);

        /* 15 */ testElement() meshBox(size=10, count=5, gap=1, cx=5);
        /* 16 */ testElement() meshBox(size=10, count=5, gap=1, cy=5);
        /* 17 */ testElement() meshBox(size=10, count=5, gap=1, cx=5, cy=5, h=2, center=true);

        /* 18 */ testElement() meshBox(size=10, count=5, gap=1, gx=.5);
        /* 19 */ testElement() meshBox(size=10, count=5, gap=1, gy=.5);
        /* 20 */ testElement() meshBox(size=10, count=5, gap=1, gx=.5, gy=.5, h=2, center=true);
    }
}
