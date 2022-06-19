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
 * Test the shape: ellipsoid()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

RENDER_MODE = "prod";
TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 13];
TESTBED_SHOW = true;

applyMode(RENDER_MODE) {
    visualTestSuite(length=20, width=20, cols=2, margin=2, center=true) {
        /*  0 */ testElement() ellipsoid();
        /*  1 */ testElement() ellipsoid(5);

        /*  2 */ testElement() ellipsoid(r=5);
        /*  3 */ testElement() ellipsoid(d=5);

        /*  4 */ testElement() ellipsoid(r=[5, 3, 2]);
        /*  5 */ testElement() ellipsoid(d=[5, 3, 2]);

        /*  6 */ testElement() ellipsoid(rx=5);
        /*  7 */ testElement() ellipsoid(dx=5);

        /*  8 */ testElement() ellipsoid(ry=5);
        /*  9 */ testElement() ellipsoid(dy=5);

        /* 10 */ testElement() ellipsoid(rz=5);
        /* 11 */ testElement() ellipsoid(dz=5);

        /* 12 */ testElement() ellipsoid(rx=5, ry=3, rz=2);
        /* 13 */ testElement() ellipsoid(dx=5, dy=3, dz=2);
    }
}
