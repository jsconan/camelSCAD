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
 * Test the shape: roundedCorner()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

RENDER_MODE = "prod";
TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 15];
TESTBED_SHOW = true;

applyMode(RENDER_MODE) {
    visualTestSuite(length=20, width=20, cols=2, margin=2, center=true) {
        /*  0 */ testElement() roundedCorner();
        /*  1 */ testElement() roundedCorner(size=5);

        /*  2 */ testElement() roundedCorner(r=3);
        /*  3 */ testElement() roundedCorner(d=3);

        /*  4 */ testElement() roundedCorner(size=5, p="ne");
        /*  5 */ testElement() roundedCorner(size=5, p="nw");
        /*  6 */ testElement() roundedCorner(size=5, p="se");
        /*  7 */ testElement() roundedCorner(size=5, p="sw");

        /*  8 */ testElement() roundedCorner(size=5, adjust=2);
        /*  9 */ testElement() roundedCorner(r=3, adjust=2);

        /*  9 */ testElement() roundedCorner(size=5, convex=true);
        /* 11 */ testElement() roundedCorner(size=5, convex=true, adjust=2);

        /* 12 */ testElement() roundedCorner(size=5, convex=true, p="ne");
        /* 13 */ testElement() roundedCorner(size=5, convex=true, p="nw");
        /* 14 */ testElement() roundedCorner(size=5, convex=true, p="se");
        /* 15 */ testElement() roundedCorner(size=5, convex=true, p="sw");

    }
}
