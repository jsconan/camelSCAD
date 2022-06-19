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
 * Test the operator: distributeRotate()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 17];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=3, margin=2, center=true) {
    /*  0 */ distributeRotate() { testElement("red"); testElement("green"); testElement("blue"); }
    /*  1 */ distributeRotate(angle=STRAIGHT) { testElement("red"); testElement("green"); testElement("blue"); }
    /*  2 */ distributeRotate(angle=RIGHT) { testElement("red"); testElement("green"); testElement("blue"); }

    /*  3 */ distributeRotate(axis=xAxis3D()) { testElement("red"); testElement("green"); testElement("blue"); }
    /*  4 */ distributeRotate(axis=yAxis3D()) { testElement("red"); testElement("green"); testElement("blue"); }
    /*  5 */ distributeRotate(axis=zAxis3D()) { testElement("red"); testElement("green"); testElement("blue"); }

    /*  6 */ distributeRotate(interval=1) { testElement("red"); testElement("green"); testElement("blue"); }
    /*  7 */ distributeRotate(interval=1, center=true) { testElement("red", center=true); testElement("green", center=true); testElement("blue", center=true); }
    /*  8 */ distributeRotate(origin=1) { testElement("red"); testElement("green"); testElement("blue"); }

    /*  9 */ distributeRotate(intervalX=1) { testElement("red"); testElement("green"); testElement("blue"); }
    /* 10 */ distributeRotate(intervalY=1) { testElement("red"); testElement("green"); testElement("blue"); }
    /* 11 */ distributeRotate(intervalZ=1) { testElement("red"); testElement("green"); testElement("blue"); }

    /* 12 */ distributeRotate(axisX=1) { testElement("red"); testElement("green"); testElement("blue"); }
    /* 13 */ distributeRotate(axisY=1) { testElement("red"); testElement("green"); testElement("blue"); }
    /* 14 */ distributeRotate(axisZ=1) { testElement("red"); testElement("green"); testElement("blue"); }

    /* 15 */ distributeRotate(originX=1) { testElement("red"); testElement("green"); testElement("blue"); }
    /* 16 */ distributeRotate(originY=1) { testElement("red"); testElement("green"); testElement("blue"); }
    /* 17 */ distributeRotate(originZ=1) { testElement("red"); testElement("green"); testElement("blue"); }
}
