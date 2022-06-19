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
 * Test the operator: repeatMirror3D()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 17];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=3, margin=2, center=true) {
    /*  0 */ repeatMirror3D() testElement(angle=90);
    /*  1 */ repeatMirror3D(countX=3, countY=3, countZ=3, intervalX=xAxis3D(2), intervalY=yAxis3D(2), intervalZ=zAxis3D(2), axisX=yAxis3D(), axisY=yAxis3D(), axisZ=zAxis3D()) testElement();
    /*  2 */ repeatMirror3D(countX=3, countY=3, countZ=3, intervalX=xAxis3D(2), intervalY=yAxis3D(2), intervalZ=zAxis3D(2), axisX=yAxis3D(), axisY=yAxis3D(), axisZ=zAxis3D(), center=true) testElement(center=true);

    /*  3 */ repeatMirror3D(countX=3) testElement(angle=90);
    /*  4 */ repeatMirror3D(countY=3) testElement(angle=90);
    /*  5 */ repeatMirror3D(countZ=3) testElement(angle=90);

    /*  6 */ repeatMirror3D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), intervalZ=zAxis3D(2)) testElement(angle=90);
    /*  7 */ repeatMirror3D(intervalX=yAxis3D(2), intervalY=zAxis3D(2), intervalZ=xAxis3D(2)) testElement(angle=90);
    /*  8 */ repeatMirror3D(intervalX=zAxis3D(2), intervalY=xAxis3D(2), intervalZ=yAxis3D(2)) testElement(angle=90);

    /*  9 */ repeatMirror3D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), intervalZ=zAxis3D(2), axisX=xAxis3D()) testElement(angle=90);
    /* 10 */ repeatMirror3D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), intervalZ=zAxis3D(2), axisX=yAxis3D()) testElement();
    /* 11 */ repeatMirror3D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), intervalZ=zAxis3D(2), axisX=zAxis3D()) testElement();

    /* 12 */ repeatMirror3D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), intervalZ=zAxis3D(2), axisY=xAxis3D()) testElement(angle=90);
    /* 13 */ repeatMirror3D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), intervalZ=zAxis3D(2), axisY=yAxis3D()) testElement();
    /* 14 */ repeatMirror3D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), intervalZ=zAxis3D(2), axisY=zAxis3D()) testElement();

    /* 15 */ repeatMirror3D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), intervalZ=zAxis3D(2), axisZ=xAxis3D()) testElement(angle=90);
    /* 16 */ repeatMirror3D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), intervalZ=zAxis3D(2), axisZ=yAxis3D()) testElement();
    /* 17 */ repeatMirror3D(intervalX=xAxis3D(2), intervalY=yAxis3D(2), intervalZ=zAxis3D(2), axisZ=zAxis3D()) testElement();
}
