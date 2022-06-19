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
 * Test the shape: roundedCornerWedge()
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
    visualTestSuite(length=20, width=20, cols=2, margin=2, center=true) {
        /*  0 */ testElement() roundedCornerWedge();
        /*  1 */ testElement() roundedCornerWedge(size=5);
        /*  2 */ testElement() roundedCornerWedge(size=5, h=2);

        /*  3 */ testElement() roundedCornerWedge(r=3);
        /*  4 */ testElement() roundedCornerWedge(d=3);
        /*  5 */ testElement() roundedCornerWedge(h=3);

        /*  6 */ testElement() roundedCornerWedge(size=5, h=2, p="ne");
        /*  7 */ testElement() roundedCornerWedge(size=5, h=2, p="nw");
        /*  8 */ testElement() roundedCornerWedge(size=5, h=2, p="se");
        /*  9 */ testElement() roundedCornerWedge(size=5, h=2, p="sw");

        /* 10 */ testElement() roundedCornerWedge(size=5, h=2, adjust=2);
        /* 11 */ testElement() roundedCornerWedge(r=3, adjust=2);

        /* 12 */ testElement() roundedCornerWedge(size=5, h=2, convex=true);
        /* 13 */ testElement() roundedCornerWedge(size=5, h=2, convex=true, adjust=2);

        /* 14 */ testElement() roundedCornerWedge(size=5, h=2, convex=true, p="ne");
        /* 15 */ testElement() roundedCornerWedge(size=5, h=2, convex=true, p="nw");
        /* 16 */ testElement() roundedCornerWedge(size=5, h=2, convex=true, p="se");
        /* 17 */ testElement() roundedCornerWedge(size=5, h=2, convex=true, p="sw");

    }
}
