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
 * Test the operator: repeatRotate3D()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 55];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=4, margin=2, center=true) {
    /*  0 */ repeatRotate3D() testElement();
    /*  1 */ repeatRotate3D(countX=3) testElement();
    /*  2 */ repeatRotate3D(countY=3) testElement();
    /*  3 */ repeatRotate3D(countZ=3) testElement();

    /*  4 */ repeatRotate3D(angleX=0) testElement();
    /*  5 */ repeatRotate3D(angleX=90) testElement();
    /*  6 */ repeatRotate3D(angleX=180) testElement();
    /*  7 */ repeatRotate3D(angleX=360) testElement();

    /*  8 */ repeatRotate3D(angleY=0) testElement();
    /*  9 */ repeatRotate3D(angleY=90) testElement();
    /* 10 */ repeatRotate3D(angleY=180) testElement();
    /* 11 */ repeatRotate3D(angleY=360) testElement();

    /* 12 */ repeatRotate3D(angleZ=0) testElement();
    /* 13 */ repeatRotate3D(angleZ=90) testElement();
    /* 14 */ repeatRotate3D(angleZ=180) testElement();
    /* 15 */ repeatRotate3D(angleZ=360) testElement();

    /* 16 */ repeatRotate3D(axisX=1) testElement();
    /* 17 */ repeatRotate3D(axisX=xAxis3D()) testElement();
    /* 18 */ repeatRotate3D(axisX=yAxis3D()) testElement();
    /* 19 */ repeatRotate3D(axisX=zAxis3D()) testElement();

    /* 20 */ repeatRotate3D(axisY=1) testElement();
    /* 21 */ repeatRotate3D(axisY=xAxis3D()) testElement();
    /* 22 */ repeatRotate3D(axisY=yAxis3D()) testElement();
    /* 23 */ repeatRotate3D(axisY=zAxis3D()) testElement();

    /* 24 */ repeatRotate3D(axisZ=1) testElement();
    /* 25 */ repeatRotate3D(axisZ=xAxis3D()) testElement();
    /* 26 */ repeatRotate3D(axisZ=yAxis3D()) testElement();
    /* 27 */ repeatRotate3D(axisZ=zAxis3D()) testElement();

    /* 28 */ repeatRotate3D(intervalX=2) testElement();
    /* 29 */ repeatRotate3D(intervalX=xAxis3D(2)) testElement();
    /* 30 */ repeatRotate3D(intervalX=yAxis3D(2)) testElement();
    /* 31 */ repeatRotate3D(intervalX=zAxis3D(2)) testElement();

    /* 32 */ repeatRotate3D(intervalY=2) testElement();
    /* 33 */ repeatRotate3D(intervalY=xAxis3D(2)) testElement();
    /* 34 */ repeatRotate3D(intervalY=yAxis3D(2)) testElement();
    /* 35 */ repeatRotate3D(intervalY=zAxis3D(2)) testElement();

    /* 36 */ repeatRotate3D(intervalZ=2) testElement();
    /* 37 */ repeatRotate3D(intervalZ=xAxis3D(2)) testElement();
    /* 38 */ repeatRotate3D(intervalZ=yAxis3D(2)) testElement();
    /* 39 */ repeatRotate3D(intervalZ=zAxis3D(2)) testElement();

    /* 40 */ repeatRotate3D(originX=2) testElement();
    /* 41 */ repeatRotate3D(originX=xAxis3D(2)) testElement();
    /* 42 */ repeatRotate3D(originX=yAxis3D(2)) testElement();
    /* 43 */ repeatRotate3D(originX=zAxis3D(2)) testElement();

    /* 44 */ repeatRotate3D(originY=2) testElement();
    /* 45 */ repeatRotate3D(originY=xAxis3D(2)) testElement();
    /* 46 */ repeatRotate3D(originY=yAxis3D(2)) testElement();
    /* 47 */ repeatRotate3D(originY=zAxis3D(2)) testElement();

    /* 48 */ repeatRotate3D(originZ=2) testElement();
    /* 49 */ repeatRotate3D(originZ=xAxis3D(2)) testElement();
    /* 50 */ repeatRotate3D(originZ=yAxis3D(2)) testElement();
    /* 51 */ repeatRotate3D(originZ=zAxis3D(2)) testElement();

    /* 52 */ repeatRotate3D(countX=3, angleX=90, axisX=xAxis3D(), intervalX=xAxis3D(2), originX=xAxis3D(2)) testElement();
    /* 53 */ repeatRotate3D(countY=3, angleY=90, axisY=yAxis3D(), intervalY=yAxis3D(2), originY=yAxis3D(2)) testElement();
    /* 54 */ repeatRotate3D(countZ=3, angleZ=90, axisZ=yAxis3D(), intervalZ=yAxis3D(2), originZ=yAxis3D(2)) testElement();
    /* 55 */ repeatRotate3D(countX=3, countY=3, countZ=3, angleX=90, angleY=90, angleZ=90, axisX=xAxis3D(), axisY=yAxis3D(), axisZ=zAxis3D(), intervalX=xAxis3D(2), intervalY=yAxis3D(2), intervalZ=zAxis3D(2), originX=xAxis3D(2), originY=yAxis3D(2), originZ=zAxis3D(2)) testElement();
}
