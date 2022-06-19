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
 * Test the operator: operation()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../full.scad>

TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 3];
TESTBED_SHOW = true;

module element1() { cylinder(h=1, r=1, center=true); }
module element2() { cube([1, 1, 2], center=true); }

visualTestSuite(length=10, width=10, cols=2, margin=2, center=true) {
    /*  0 */ testElement() operation() { element1(); element2(); }
    /*  1 */ testElement() operation(-1) { element1(); element2(); }
    /*  2 */ testElement() operation(0) { element1(); element2(); }
    /*  3 */ testElement() operation(1) { element1(); element2(); }
}
