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
 * Test the operator: repeatRotate()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 34];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=7, margin=2, center=true) {
    /*  0 */ repeatRotate() testElement();
    /*  1 */ repeatRotate(count=1) testElement();
    /*  2 */ repeatRotate(count=3) testElement();
    /*  3 */ repeatRotate(count=3, angle=0) testElement();
    /*  4 */ repeatRotate(count=3, angle=RIGHT) testElement();
    /*  5 */ repeatRotate(count=3, angle=STRAIGHT) testElement();
    /*  6 */ repeatRotate(count=3, angle=DEGREES) testElement();

    /*  7 */ repeatRotate(count=3, axis=1) testElement();
    /*  8 */ repeatRotate(count=3, axis=xAxis3D()) testElement();
    /*  9 */ repeatRotate(count=3, axis=yAxis3D()) testElement();
    /* 10 */ repeatRotate(count=3, axis=zAxis3D()) testElement();
    /* 11 */ repeatRotate(count=3, axisX=1) testElement();
    /* 12 */ repeatRotate(count=3, axisY=1) testElement();
    /* 13 */ repeatRotate(count=3, axisZ=1) testElement();

    /* 14 */ repeatRotate(count=3, interval=3) testElement();
    /* 15 */ repeatRotate(count=3, interval=xAxis3D(3)) testElement();
    /* 16 */ repeatRotate(count=3, interval=yAxis3D(3)) testElement();
    /* 17 */ repeatRotate(count=3, interval=zAxis3D(3)) testElement();
    /* 18 */ repeatRotate(count=3, interval=xAxis3D(1), center=true) testElement(center=true);
    /* 19 */ repeatRotate(count=3, interval=yAxis3D(1), center=true) testElement(center=true);
    /* 20 */ repeatRotate(count=3, interval=zAxis3D(1), center=true) testElement(center=true);

    /* 21 */ repeatRotate(count=3, interval=3) testElement();
    /* 22 */ repeatRotate(count=3, intervalX=3) testElement();
    /* 23 */ repeatRotate(count=3, intervalY=3) testElement();
    /* 24 */ repeatRotate(count=3, intervalZ=3) testElement();
    /* 25 */ repeatRotate(count=3, intervalX=1, center=true) testElement(center=true);
    /* 26 */ repeatRotate(count=3, intervalY=1, center=true) testElement(center=true);
    /* 27 */ repeatRotate(count=3, intervalZ=1, center=true) testElement(center=true);

    /* 28 */ repeatRotate(count=3, origin=3) testElement();
    /* 29 */ repeatRotate(count=3, origin=xAxis3D(3)) testElement();
    /* 30 */ repeatRotate(count=3, origin=yAxis3D(3)) testElement();
    /* 31 */ repeatRotate(count=3, origin=zAxis3D(3)) testElement();
    /* 32 */ repeatRotate(count=3, originX=3) testElement();
    /* 33 */ repeatRotate(count=3, originY=3) testElement();
    /* 34 */ repeatRotate(count=3, originZ=3) testElement();
}
