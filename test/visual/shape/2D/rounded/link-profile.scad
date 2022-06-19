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
 * Test the shape: linkProfile()
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
        /*  0 */ testElement() linkProfile();
        /*  1 */ testElement() linkProfile(3);
        /*  2 */ testElement() linkProfile(3, 2);

        /*  3 */ testElement() linkProfile(neck=[2, 3]);
        /*  4 */ testElement() linkProfile(neck=[2, 3], bulb=[3, 2]);
        /*  5 */ testElement() linkProfile(neck=2, bulb=3);

        /*  6 */ testElement() linkProfile(neck=2, bulb=2, w=3);
        /*  7 */ testElement() linkProfile(neck=2, bulb=2, h=3);
        /*  8 */ testElement() linkProfile(neck=2, bulb=2, w=3, h=3);

        /*  9 */ testElement() linkProfile(neck=2, bulb=2, rx=3);
        /* 10 */ testElement() linkProfile(neck=2, bulb=2, ry=3);
        /* 11 */ testElement() linkProfile(neck=2, bulb=2, rx=3, ry=3);

        /* 12 */ testElement() linkProfile(neck=2, bulb=2, dx=3);
        /* 13 */ testElement() linkProfile(neck=2, bulb=2, dy=3);
        /* 14 */ testElement() linkProfile(neck=2, bulb=2, dx=3, dy=3);

        /* 15 */ testElement() linkProfile(neck=3, bulb=3, distance=1);
        /* 16 */ testElement() linkProfile(neck=3, bulb=3, distance=-1);
    }
}
