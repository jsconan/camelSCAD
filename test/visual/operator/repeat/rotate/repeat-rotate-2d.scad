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
 * Test the operator: repeatRotate2D()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 40];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=4, margin=2, center=true) {
    /*  0 */ repeatRotate2D() testElement();
    /*  1 */ repeatRotate2D(countX=3) testElement();
    /*  2 */ repeatRotate2D(countY=3) testElement();
    /*  3 */ repeatRotate2D(countX=3, countY=3) testElement();

    /*  4 */ repeatRotate2D(angleX=0) testElement();
    /*  5 */ repeatRotate2D(angleX=90) testElement();
    /*  6 */ repeatRotate2D(angleX=180) testElement();
    /*  7 */ repeatRotate2D(angleX=360) testElement();

    /*  8 */ repeatRotate2D(angleY=0) testElement();
    /*  9 */ repeatRotate2D(angleY=90) testElement();
    /* 10 */ repeatRotate2D(angleY=180) testElement();
    /* 11 */ repeatRotate2D(angleY=360) testElement();

    /* 12 */ repeatRotate2D(axisX=1) testElement();
    /* 13 */ repeatRotate2D(axisX=xAxis3D()) testElement();
    /* 14 */ repeatRotate2D(axisX=yAxis3D()) testElement();
    /* 15 */ repeatRotate2D(axisX=zAxis3D()) testElement();

    /* 16 */ repeatRotate2D(axisY=1) testElement();
    /* 17 */ repeatRotate2D(axisY=xAxis3D()) testElement();
    /* 18 */ repeatRotate2D(axisY=yAxis3D()) testElement();
    /* 19 */ repeatRotate2D(axisY=zAxis3D()) testElement();

    /* 20 */ repeatRotate2D(intervalX=2) testElement();
    /* 21 */ repeatRotate2D(intervalX=xAxis3D(2)) testElement();
    /* 22 */ repeatRotate2D(intervalX=yAxis3D(2)) testElement();
    /* 23 */ repeatRotate2D(intervalX=zAxis3D(2)) testElement();

    /* 24 */ repeatRotate2D(intervalY=2) testElement();
    /* 25 */ repeatRotate2D(intervalY=xAxis3D(2)) testElement();
    /* 26 */ repeatRotate2D(intervalY=yAxis3D(2)) testElement();
    /* 27 */ repeatRotate2D(intervalY=zAxis3D(2)) testElement();

    /* 28 */ repeatRotate2D(originX=2) testElement();
    /* 29 */ repeatRotate2D(originX=xAxis3D(2)) testElement();
    /* 30 */ repeatRotate2D(originX=yAxis3D(2)) testElement();
    /* 31 */ repeatRotate2D(originX=zAxis3D(2)) testElement();

    /* 32 */ repeatRotate2D(originY=2) testElement();
    /* 33 */ repeatRotate2D(originY=xAxis3D(2)) testElement();
    /* 34 */ repeatRotate2D(originY=yAxis3D(2)) testElement();
    /* 35 */ repeatRotate2D(originY=zAxis3D(2)) testElement();

    /* 36 */ repeatRotate2D(countX=3, angleX=90, axisX=xAxis3D(), intervalX=xAxis3D(2), originX=xAxis3D(2)) testElement();
    /* 37 */ repeatRotate2D(countY=3, angleY=90, axisY=yAxis3D(), intervalY=yAxis3D(2), originY=yAxis3D(2)) testElement();
    /* 38 */ repeatRotate2D(countX=3, countY=3, angleX=90, angleY=90, axisX=xAxis3D(), axisY=yAxis3D(), intervalX=xAxis3D(2), intervalY=yAxis3D(2)) testElement();
    /* 39 */ repeatRotate2D(countX=3, countY=3, angleX=90, angleY=90, axisX=xAxis3D(), axisY=yAxis3D(), originX=xAxis3D(2), originY=yAxis3D(2)) testElement();

    /* 40 */ repeatRotate2D(countX=3, countY=3, angleX=90, angleY=90, axisX=xAxis3D(), axisY=yAxis3D(), intervalX=xAxis3D(2), intervalY=yAxis3D(2), originX=xAxis3D(2), originY=yAxis3D(2)) testElement();
}
