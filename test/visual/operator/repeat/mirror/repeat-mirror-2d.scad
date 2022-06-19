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
 * Test the operator: repeatMirror2D()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 16];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=3, margin=2, center=true) {
    /*  0 */ repeatMirror2D() testElement(angle=90);
    /*  1 */ repeatMirror2D(countX=3) testElement(angle=90);
    /*  2 */ repeatMirror2D(countY=3) testElement(angle=90);

    /*  3 */ repeatMirror2D(intervalX=xAxis3D(2), intervalY=yAxis3D(2)) testElement(angle=90);
    /*  4 */ repeatMirror2D(intervalX=yAxis3D(2), intervalY=xAxis3D(2)) testElement(angle=90);
    /*  5 */ repeatMirror2D(intervalX=zAxis3D(2), intervalY=yAxis3D(2)) testElement(angle=90);

    /*  6 */ repeatMirror2D(intervalX=xAxis3D(2), intervalY=zAxis3D(2)) testElement(angle=90);
    /*  7 */ repeatMirror2D(intervalX=yAxis3D(2), intervalY=zAxis3D(2)) testElement(angle=90);
    /*  8 */ repeatMirror2D(intervalX=zAxis3D(2), intervalY=yAxis3D(2)) testElement(angle=90);

    /*  9 */ repeatMirror2D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), axisX=xAxis3D()) testElement(angle=90);
    /* 10 */ repeatMirror2D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), axisX=yAxis3D()) testElement();
    /* 11 */ repeatMirror2D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), axisX=zAxis3D()) testElement();

    /* 12 */ repeatMirror2D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), axisY=xAxis3D()) testElement(angle=90);
    /* 13 */ repeatMirror2D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), axisY=yAxis3D()) testElement();
    /* 14 */ repeatMirror2D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), axisY=zAxis3D()) testElement();

    /* 15 */ repeatMirror2D(countX=3, countY=3, intervalX=xAxis3D(2), intervalY=yAxis3D(2), axisX=yAxis3D(), axisY=yAxis3D(1)) testElement();
    /* 16 */ repeatMirror2D(countX=3, countY=3, intervalX=xAxis3D(2), intervalY=yAxis3D(2), axisX=yAxis3D(), axisY=yAxis3D(1), center=true) testElement(center=true);
}
