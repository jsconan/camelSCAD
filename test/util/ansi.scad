/**
 * @license
 * MIT License
 *
 * Copyright (c) 2017 Jean-Sebastien CONAN
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

use <../../full.scad>

/**
 * Part of the camelSCAD library.
 *
 * Unit tests: Strings manipulations for ANSI terminal.
 *
 * @package test/util/ansi
 * @author jsconan
 */
module testUtilAnsi() {
    testPackage("util/ansi.scad", 6) {
        // test util/ansi/ansiCode()
        testModule("ansiCode()", 3) {
            testUnit("no parameters", 1) {
                assertEqual(ansiCode(), str(chr(27), "[0m"), "Should produce a `all attributes off` code");
            }
            testUnit("number or string", 2) {
                assertEqual(ansiCode(30), str(chr(27), "[30m"), "Should produce the expected code");
                assertEqual(ansiCode("40"), str(chr(27), "[40m"), "Should produce the expected code");
            }
            testUnit("array", 2) {
                assertEqual(ansiCode([1, 30]), str(chr(27), "[1;30m"), "Should produce the expected code");
                assertEqual(ansiCode([0, "40"]), str(chr(27), "[0;40m"), "Should produce the expected code");
            }
        }
        // test util/ansi/ansiCodeOff()
        testModule("ansiCodeOff()", 1) {
            testUnit("no parameters", 1) {
                assertEqual(ansiCodeOff(), str(chr(27), "[0m"), "Should produce a `all attributes off` code");
            }
        }
        // test util/ansi/ansiBackgroundColor()
        testModule("ansiBackgroundColor()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(ansiBackgroundColor(), 40, "Should produce the default background color code");
            }
            testUnit("number", 3) {
                assertEqual(ansiBackgroundColor(2), 42, "Should produce the expected background color code");
                assertEqual(ansiBackgroundColor(-4), 44, "Should fix the value and produce a valid background color code");
                assertEqual(ansiBackgroundColor(10), 42, "Should fix the value and produce a valid background color code");
            }
            testUnit("not a number", 3) {
                assertEqual(ansiBackgroundColor(true), 40, "Should produce the default background color code");
                assertEqual(ansiBackgroundColor("2"), 40, "Should produce the default background color code");
                assertEqual(ansiBackgroundColor([3]), 40, "Should produce the default background color code");
            }
        }
        // test util/ansi/ansiForegroundColor()
        testModule("ansiForegroundColor()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(ansiForegroundColor(), 30, "Should produce the default foreground color code");
            }
            testUnit("number", 3) {
                assertEqual(ansiForegroundColor(2), 32, "Should produce the expected foreground color code");
                assertEqual(ansiForegroundColor(-4), 34, "Should fix the value and produce a valid foreground color code");
                assertEqual(ansiForegroundColor(10), 32, "Should fix the value and produce a valid foreground color code");
            }
            testUnit("not a number", 3) {
                assertEqual(ansiForegroundColor(true), 30, "Should produce the default foreground color code");
                assertEqual(ansiForegroundColor("2"), 30, "Should produce the default foreground color code");
                assertEqual(ansiForegroundColor([3]), 30, "Should produce the default foreground color code");
            }
        }
        // test util/ansi/ansiBackground()
        testModule("ansiBackground()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(ansiBackground(), str(chr(27), "[", 40, "m"), "Should produce the default background color code");
            }
            testUnit("number", 3) {
                assertEqual(ansiBackground(2), str(chr(27), "[", 42, "m"), "Should produce the expected background color code");
                assertEqual(ansiBackground(-4), str(chr(27), "[", 44, "m"), "Should fix the value and produce a valid background color code");
                assertEqual(ansiBackground(10), str(chr(27), "[", 42, "m"), "Should fix the value and produce a valid background color code");
            }
            testUnit("not a number", 3) {
                assertEqual(ansiBackground(true), str(chr(27), "[", 40, "m"), "Should produce the default background color code");
                assertEqual(ansiBackground("2"), str(chr(27), "[", 40, "m"), "Should produce the default background color code");
                assertEqual(ansiBackground([3]), str(chr(27), "[", 40, "m"), "Should produce the default background color code");
            }
        }
        // test util/ansi/ansiForeground()
        testModule("ansiForeground()", 5) {
            testUnit("no parameter", 1) {
                assertEqual(ansiForeground(), str(chr(27), "[0;", 30, "m"), "Should produce the default background color code");
            }
            testUnit("number", 3) {
                assertEqual(ansiForeground(2), str(chr(27), "[0;", 32, "m"), "Should produce the expected background color code");
                assertEqual(ansiForeground(-4), str(chr(27), "[0;", 34, "m"), "Should fix the value and produce a valid background color code");
                assertEqual(ansiForeground(10), str(chr(27), "[0;", 32, "m"), "Should fix the value and produce a valid background color code");
            }
            testUnit("not a number", 3) {
                assertEqual(ansiForeground(true), str(chr(27), "[0;", 30, "m"), "Should produce the default background color code");
                assertEqual(ansiForeground("2"), str(chr(27), "[0;", 30, "m"), "Should produce the default background color code");
                assertEqual(ansiForeground([3]), str(chr(27), "[0;", 30, "m"), "Should produce the default background color code");
            }
            testUnit("number, bright", 3) {
                assertEqual(ansiForeground(2, true), str(chr(27), "[1;", 32, "m"), "Should produce the expected background color code");
                assertEqual(ansiForeground(-4, true), str(chr(27), "[1;", 34, "m"), "Should fix the value and produce a valid background color code");
                assertEqual(ansiForeground(10, true), str(chr(27), "[1;", 32, "m"), "Should fix the value and produce a valid background color code");
            }
            testUnit("not a number, bright", 3) {
                assertEqual(ansiForeground(true, "1"), str(chr(27), "[1;", 30, "m"), "Should produce the default background color code");
                assertEqual(ansiForeground("2", 1), str(chr(27), "[1;", 30, "m"), "Should produce the default background color code");
                assertEqual(ansiForeground([3], [0]), str(chr(27), "[1;", 30, "m"), "Should produce the default background color code");
            }
        }
    }
}

testUtilAnsi();
