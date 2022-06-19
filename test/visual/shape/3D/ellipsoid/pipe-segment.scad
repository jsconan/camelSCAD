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
 * Test the shape: pipeSegment()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

RENDER_MODE = "prod";
TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 23];
TESTBED_SHOW = true;

applyMode(RENDER_MODE) {
    visualTestSuite(length=20, width=20, cols=3, margin=2, center=true) {
        /*  0 */ testElement() pipeSegment();
        /*  1 */ testElement() pipeSegment(5);
        /*  2 */ testElement() pipeSegment(5, 3);

        /*  3 */ testElement() pipeSegment(r=5, w=1);
        /*  4 */ testElement() pipeSegment(d=5, w=1);
        /*  5 */ testElement() pipeSegment(h=5, w=1);

        /*  6 */ testElement() pipeSegment(w=.5);
        /*  7 */ testElement() pipeSegment(w=[.5, .3]);
        /*  8 */ testElement() pipeSegment(r=[5, 3], h=3, w=1, center=true);

        /*  9 */ testElement() pipeSegment(wx=.5);
        /* 10 */ testElement() pipeSegment(wy=.5);
        /* 11 */ testElement() pipeSegment(wx=.5, wy=.3);

        /* 12 */ testElement() pipeSegment(r=[5, 3], w=[.5, .3]);
        /* 13 */ testElement() pipeSegment(d=[5, 3], w=[.5, .3]);
        /* 14 */ testElement() pipeSegment(d=[5, 3], h=3, w=[.5, .3]);

        /* 15 */ testElement() pipeSegment(rx=5, w=1);
        /* 16 */ testElement() pipeSegment(ry=5, w=1);
        /* 17 */ testElement() pipeSegment(rx=5, ry=3, w=1);

        /* 18 */ testElement() pipeSegment(dx=5, w=1);
        /* 19 */ testElement() pipeSegment(dy=5, w=1);
        /* 20 */ testElement() pipeSegment(dx=5, dy=3, w=1);

        /* 21 */ testElement() pipeSegment(r=5, h=3, w=1, a=30);
        /* 22 */ testElement() pipeSegment(r=5, h=3, w=1, a1=30, a2=60);
        /* 23 */ testElement() pipeSegment(r=5, h=3, w=1, a1=-20, a2=200);
    }
}
