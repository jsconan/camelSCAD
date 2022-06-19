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
 * Test the shape: regularPolygonBox()
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
        /*  0 */ testElement() regularPolygonBox();
        /*  1 */ testElement() regularPolygonBox(5);
        /*  2 */ testElement() regularPolygonBox(5, 5);

        /*  3 */ testElement() regularPolygonBox(n=6, l=2);
        /*  4 */ testElement() regularPolygonBox(n=6, w=2);
        /*  5 */ testElement() regularPolygonBox(n=6, s=2);

        /*  6 */ testElement() regularPolygonBox(n=6, s=2, h=3, center=true);
        /*  7 */ testElement() regularPolygonBox(size=5, n=6, h=3, center=true);
        /*  8 */ testElement() regularPolygonBox(n=6, l=5, w=4, h=3, center=true);

        /*  9 */ testElement() regularPolygonBox([3, 5], 5);
        /* 10 */ testElement() regularPolygonBox([5, 3], 5);
        /* 11 */ testElement() regularPolygonBox([5, 5], 5);

        /* 12 */ testElement() regularPolygonBox(n=6, l=3, w=3);
        /* 13 */ testElement() regularPolygonBox(n=6, l=3, w=3, s=3);
        /* 14 */ testElement() regularPolygonBox(5, n=6, s=1);

        /* 15 */ testElement() regularPolygonBox(5, n=3);
        /* 16 */ testElement() regularPolygonBox(5, n=4);
        /* 17 */ testElement() regularPolygonBox(5, n=5);

        /* 18 */ testElement() regularPolygonBox(5, n=6);
        /* 19 */ testElement() regularPolygonBox(5, n=7);
        /* 20 */ testElement() regularPolygonBox(5, n=8);
    }
}
