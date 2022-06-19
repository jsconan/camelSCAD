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
 * Test the shape: hexagonBox()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

RENDER_MODE = "prod";
TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 11];
TESTBED_SHOW = true;

applyMode(RENDER_MODE) {
    visualTestSuite(length=20, width=20, cols=3, margin=2, center=true) {
        /*  0 */ testElement() hexagonBox();
        /*  1 */ testElement() hexagonBox(5);
        /*  2 */ testElement() hexagonBox([3, 5]);

        /*  3 */ testElement() hexagonBox(5, pointy=false);
        /*  4 */ testElement() hexagonBox(5, pointy=true);
        /*  5 */ testElement() hexagonBox(5, adjust=1);

        /*  6 */ testElement() hexagonBox(5, l=3, w=3);
        /*  7 */ testElement() hexagonBox(l=3, w=3, s=5);
        /*  8 */ testElement() hexagonBox(s=3);

        /*  9 */ testElement() hexagonBox(s=3, h=3, center=true);
        /* 10 */ testElement() hexagonBox(3, center=true);
        /* 11 */ testElement() hexagonBox(3, h=6, center=true);
    }
}
