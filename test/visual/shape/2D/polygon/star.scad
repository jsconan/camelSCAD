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
 * Test the shape: star()
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
        /*  0 */ testElement() star();
        /*  1 */ testElement() star(5);
        /*  2 */ testElement() star(5, 3);

        /*  3 */ testElement() star(5, l=3);
        /*  4 */ testElement() star(5, w=3);
        /*  5 */ testElement() star(5, l=3, w=3);

        /*  6 */ testElement() star(5, cl=2);
        /*  7 */ testElement() star(5, cw=2);
        /*  8 */ testElement() star(5, cl=2, cw=2);

        /*  9 */ testElement() star([5, 3]);
        /* 10 */ testElement() star([5, 3], [1, 2]);
        /* 11 */ testElement() star([5, 3], [1, 2], 5);

        /* 12 */ testElement() star(size=5, core=2, edges=3);
        /* 13 */ testElement() star(size=5, core=2, edges=4);
        /* 14 */ testElement() star(size=5, core=2, edges=5);

        /* 15 */ testElement() star(size=5, core=2, edges=6);
        /* 16 */ testElement() star(size=5, core=2, edges=7);
        /* 17 */ testElement() star(size=5, core=2, edges=8);
    }
}
