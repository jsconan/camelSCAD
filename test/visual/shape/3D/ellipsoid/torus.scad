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
 * Test the shape: torus()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

RENDER_MODE = "prod";
TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 26];
TESTBED_SHOW = true;

applyMode(RENDER_MODE) {
    visualTestSuite(length=20, width=20, cols=3, margin=2, center=true) {
        /*  0 */ testElement() torus();
        /*  1 */ testElement() torus(5);
        /*  2 */ testElement() torus(5, 1);

        /*  3 */ testElement() torus(r=5);
        /*  4 */ testElement() torus(d=5);
        /*  5 */ testElement() torus(w=.5);

        /*  7 */ testElement() torus(W=1);
        /*  6 */ testElement() torus(w=[.5, .3]);
        /*  8 */ testElement() torus(W=[1, .5]);

        /*  9 */ testElement() torus(r=[5, 3], w=1, center=true);
        /* 10 */ testElement() torus(d=[5, 3], W=1, center=true);
        /* 11 */ testElement() torus(d=[5, 3], W=1);

        /* 12 */ testElement() torus(wx=.5);
        /* 13 */ testElement() torus(wy=.5);
        /* 14 */ testElement() torus(wx=.5, wy=.3);

        /* 15 */ testElement() torus(Wx=.5);
        /* 16 */ testElement() torus(Wy=.5);
        /* 17 */ testElement() torus(Wx=.5, Wy=.3);

        /* 18 */ testElement() torus(r=[5, 3], w=[.5, .3]);
        /* 19 */ testElement() torus(d=[5, 3], W=[.5, .3]);

        /* 21 */ testElement() torus(rx=5, w=1);
        /* 22 */ testElement() torus(ry=5, w=1);
        /* 23 */ testElement() torus(rx=5, ry=3, w=1);

        /* 24 */ testElement() torus(dx=5, W=1);
        /* 25 */ testElement() torus(dy=5, W=1);
        /* 26 */ testElement() torus(dx=5, dy=3, W=1);
    }
}
