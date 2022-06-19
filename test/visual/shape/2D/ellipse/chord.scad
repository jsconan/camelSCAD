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
 * Test the shape: chord()
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
        /*  0 */ testElement() chord();
        /*  1 */ testElement() chord(5);

        /*  2 */ testElement() chord(r=5);
        /*  3 */ testElement() chord(d=5);

        /*  4 */ testElement() chord(r=[5, 3]);
        /*  5 */ testElement() chord(d=[5, 3]);

        /*  6 */ testElement() chord(rx=5);
        /*  7 */ testElement() chord(ry=5);

        /*  8 */ testElement() chord(dx=5);
        /*  9 */ testElement() chord(dy=5);

        /* 10 */ testElement() chord(rx=5, ry=3);
        /* 11 */ testElement() chord(dx=5, dy=3);

        /* 12 */ testElement() chord(r=5, a=30);
        /* 13 */ testElement() chord(r=5, a1=30, a2=60);

        /* 14 */ testElement() chord(rx=5, ry=3, a=30);
        /* 15 */ testElement() chord(rx=5, ry=3, a1=30, a2=60);
    }
}
