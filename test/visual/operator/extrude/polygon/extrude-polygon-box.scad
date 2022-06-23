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
 * Test the operator: extrudePolygonBox()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 17];
TESTBED_SHOW = true;

visualTestSuite(length=10, width=10, cols=3, margin=2, center=true) {
    /*  0 */ testElement() extrudePolygonBox();
    /*  1 */ testElement() extrudePolygonBox([[0,0], [1,0], [1,1], [0,1]]);
    /*  2 */ testElement() extrudePolygonBox([[0,0], [1,0], [1,1], [0,1]], 2);

    /*  3 */ testElement() extrudePolygonBox(points=[[0,0], [1,0], [1,1], [0,1]], wall=.5, ground=.1, center=true);
    /*  4 */ testElement() extrudePolygonBox(points=[[0,0], [1,0], [1,1], [0,1]], wall=.5, ground=.1, height=2, center=true);
    /*  5 */ testElement() extrudePolygonBox(points=[[0,0], [1,0], [1,1], [0,1]], wall=.5, ground=.1, height=-2, center=true);

    /*  6 */ testElement() extrudePolygonBox(points=[[-1,-1], [1,-1], [1,1], [-1,1]], wall=.5, ground=.1, twist=45);
    /*  7 */ testElement() extrudePolygonBox(points=[[-1,-1], [1,-1], [1,1], [-1,1]], wall=.5, ground=.1, height=2, twist=45);
    /*  8 */ testElement() extrudePolygonBox(points=[[-1,-1], [1,-1], [1,1], [-1,1]], wall=.5, ground=.1, height=-2, twist=45);

    /*  9 */ testElement() extrudePolygonBox(points=[[-1,-1], [1,-1], [1,1], [-1,1]], wall=.5, ground=.1, twist=45, slices=10);
    /* 10 */ testElement() extrudePolygonBox(points=[[-1,-1], [1,-1], [1,1], [-1,1]], wall=.5, ground=.1, height=2, twist=45, slices=10);
    /* 11 */ testElement() extrudePolygonBox(points=[[-1,-1], [1,-1], [1,1], [-1,1]], wall=.5, ground=.1, height=-2, twist=45, slices=10);

    /* 12 */ testElement() extrudePolygonBox(points=[[-1,-1], [1,-1], [1,1], [-1,1]], wall=.5, ground=.1, scale=2);
    /* 13 */ testElement() extrudePolygonBox(points=[[-1,-1], [1,-1], [1,1], [-1,1]], wall=.5, ground=.1, height=2, scale=2);
    /* 14 */ testElement() extrudePolygonBox(points=[[-1,-1], [1,-1], [1,1], [-1,1]], wall=.5, ground=.1, height=-2, scale=2);

    /* 15 */ testElement() extrudePolygonBox(points=[[0,0], [1,0], [1,1], [0,1]], height=1, wall=.5, ground=.1, distance=.5);
    /* 16 */ testElement() extrudePolygonBox(points=[[0,0], [1,0], [1,1], [0,1]], height=1, wall=.5, ground=.1, distance=-.5);
}
