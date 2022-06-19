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
 * Test the operator: distributeMirror()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 17];
TESTBED_SHOW = true;

visualTestSuite(length=20, width=20, cols=3, margin=2, center=true) {
    /*  0 */ distributeMirror() { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }
    /*  1 */ distributeMirror(interval=1) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }
    /*  2 */ distributeMirror(interval=1, axis=yAxis3D()) { testElement("red"); testElement("green"); testElement("blue"); testElement("red"); testElement("green"); testElement("blue"); }

    /*  3 */ distributeMirror(intervalX=2) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }
    /*  4 */ distributeMirror(intervalY=2) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }
    /*  5 */ distributeMirror(intervalZ=2) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }

    /*  6 */ distributeMirror(interval=1, axisX=1) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }
    /*  7 */ distributeMirror(interval=1, axisY=1) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }
    /*  8 */ distributeMirror(interval=1, axisZ=1) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }

    /*  9 */ distributeMirror(center=true) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }
    /* 10 */ distributeMirror(interval=1, center=true) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }
    /* 11 */ distributeMirror(interval=1, center=true, axis=yAxis3D()) { testElement("red"); testElement("green"); testElement("blue"); testElement("red"); testElement("green"); testElement("blue"); }

    /* 12 */ distributeMirror(intervalX=2, center=true) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }
    /* 13 */ distributeMirror(intervalY=2, center=true) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }
    /* 14 */ distributeMirror(intervalZ=2, center=true) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }

    /* 15 */ distributeMirror(interval=1, axisX=1, center=true) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }
    /* 16 */ distributeMirror(interval=1, axisY=1, center=true) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }
    /* 17 */ distributeMirror(interval=1, axisZ=1, center=true) { testElement("red", 90); testElement("green", 90); testElement("blue", 90); testElement("red", 90); testElement("green", 90); testElement("blue", 90); }
}
