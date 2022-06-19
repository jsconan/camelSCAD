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
 * Test the shape: ring()
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
    visualTestSuite(length=20, width=20, cols=4, margin=2, center=true) {
        /*  0 */ testElement() ring();
        /*  1 */ testElement() ring(5);

        /*  2 */ testElement() ring(w=.5);
        /*  3 */ testElement() ring(wx=.5);
        /*  4 */ testElement() ring(wy=.5);
        /*  5 */ testElement() ring(w=[.5, .3]);

        /*  6 */ testElement() ring(r=5, w=1);
        /*  7 */ testElement() ring(d=5, w=1);

        /*  8 */ testElement() ring(r=[5, 3], w=1);
        /*  9 */ testElement() ring(d=[5, 3], w=1);

        /* 10 */ testElement() ring(rx=5, w=1);
        /* 11 */ testElement() ring(ry=5, w=1);

        /* 12 */ testElement() ring(dx=5, w=1);
        /* 13 */ testElement() ring(dy=5, w=1);

        /* 14 */ testElement() ring(rx=5, ry=3, w=1);
        /* 15 */ testElement() ring(dx=5, dy=3, w=1);
    }
}
