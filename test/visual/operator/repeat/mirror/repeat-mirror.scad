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
 * Test the operator: repeatMirror()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 17];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=3, margin=2, center=true) {
    /*  0 */ repeatMirror() testElement(angle=90);
    /*  1 */ repeatMirror(count=3) testElement(angle=90);
    /*  2 */ repeatMirror(interval=2) testElement(angle=90);

    /*  3 */ repeatMirror(count=3, interval=xAxis3D(2)) testElement(angle=90);
    /*  4 */ repeatMirror(count=3, interval=yAxis3D(2)) testElement();
    /*  5 */ repeatMirror(count=3, interval=zAxis3D(2)) testElement();

    /*  6 */ repeatMirror(count=3, interval=2, axis=xAxis3D()) testElement(angle=90);
    /*  7 */ repeatMirror(count=3, interval=2, axis=yAxis3D()) testElement();
    /*  8 */ repeatMirror(count=3, interval=2, axis=zAxis3D()) testElement();

    /*  9 */ repeatMirror(count=3, interval=2, axis=xAxis3D(), center=true) testElement(angle=90, center=true);
    /* 10 */ repeatMirror(count=3, interval=2, axis=yAxis3D(), center=true) testElement(center=true);
    /* 11 */ repeatMirror(count=3, interval=2, axis=zAxis3D(), center=true) testElement(center=true);

    /* 12 */ repeatMirror(count=3, intervalX=2) testElement(angle=90);
    /* 13 */ repeatMirror(count=3, intervalY=2) testElement(angle=90);
    /* 14 */ repeatMirror(count=3, intervalZ=2) testElement(angle=90);

    /* 15 */ repeatMirror(count=3, interval=1, axisX=1) testElement(angle=90);
    /* 16 */ repeatMirror(count=3, interval=1, axisY=1) testElement();
    /* 17 */ repeatMirror(count=3, interval=1, axisZ=1) testElement();
}
