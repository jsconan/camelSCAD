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
 * Unit tests: Miscellaneous utils.
 *
 * @package test/core/util
 * @author jsconan
 */
module testCoreUtil() {
    testPackage("core/util.scad", 4) {
        // test core/util/position()
        testModule("position()", 5) {
            testUnit("no parameter", 1) {
                assertEqual(position(), 0, "Should return a position value that tells there is nothing");
            }
            testUnit("wrong type", 4) {
                assertEqual(position(""), 0, "An empty string is not a position value, but should be converted to false, should return 0");
                assertEqual(position("ne"), -1, "A string is not a position value, but should be converted to true, should return -1");
                assertEqual(position([]), 0, "An empty vector is not a position value, but should be converted to false, should return 0");
                assertEqual(position([1]), -1, "A vector is not a position value, but should be converted to true, should return -1");
            }
            testUnit("boolean", 4) {
                assertEqual(position(true, false), -1, "If there is something before, should return -1");
                assertEqual(position(false, false), 0, "If there is nothing around, should return 0");
                assertEqual(position(false, true), 1, "If there is something after, should return 1");
                assertEqual(position(true, true), 2, "If there is something before and after, should return 2");
            }
            testUnit("number", 4) {
                assertEqual(position(1, 0), -1, "If there is something before, should return -1");
                assertEqual(position(0, 0), 0, "If there is nothing around, should return 0");
                assertEqual(position(0, 1), 1, "If there is something after, should return 1");
                assertEqual(position(1, 1), 2, "If there is something before and after, should return 2");
            }
            testUnit("default", 4) {
                assertEqual(position(before=1), -1, "If there is something before, should return -1");
                assertEqual(position(), 0, "If there is nothing around, should return 0");
                assertEqual(position(after=1), 1, "If there is something after, should return 1");
                assertEqual(position(before=1, after=1), 2, "If there is something before and after, should return 2");
            }
        }
        // test core/util/before()
        testModule("before()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(before(), false, "Should tell there is nothing");
            }
            testUnit("wrong type", 5) {
                assertEqual(before(""), false, "An empty string is not a position value, should return false");
                assertEqual(before("1"), false, "A string is not a position value, should return false");
                assertEqual(before([]), false, "An empty vector is not a position value, should return false");
                assertEqual(before([1]), false, "A vector is not a position value, should return false");
                assertEqual(before(true), false, "A boolean is not a position value, should return false");
            }
            testUnit("number", 6) {
                assertEqual(before(-5), true, "If the position value is below -1, should return true");
                assertEqual(before(-1), true, "If the position value is -1, should return true");
                assertEqual(before(0), false, "If the position value is 0, should return false");
                assertEqual(before(1), false, "If the position value is 1, should return false");
                assertEqual(before(2), true, "If the position value is 2, should return true");
                assertEqual(before(10), true, "If the position value is above 2, should return true");
            }
        }
        // test core/util/after()
        testModule("after()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(after(), false, "Should tell there is nothing");
            }
            testUnit("wrong type", 5) {
                assertEqual(after(""), false, "An empty string is not a position value, should return false");
                assertEqual(after("1"), false, "A string is not a position value, should return false");
                assertEqual(after([]), false, "An empty vector is not a position value, should return false");
                assertEqual(after([1]), false, "A vector is not a position value, should return false");
                assertEqual(after(true), false, "A boolean is not a position value, should return false");
            }
            testUnit("number", 6) {
                assertEqual(after(-5), false, "If the position value is below -1, should return false");
                assertEqual(after(-1), false, "If the position value is -1, should return false");
                assertEqual(after(0), false, "If the position value is 0, should return false");
                assertEqual(after(1), true, "If the position value is 1, should return true");
                assertEqual(after(2), true, "If the position value is 2, should return true");
                assertEqual(after(10), true, "If the position value is above 2, should return true");
            }
        }
        // test core/util/cardinal()
        testModule("cardinal()", 5) {
            testUnit("no parameter", 1) {
                assertEqual(cardinal(), [0, 0], "Should return an empty descriptor");
            }
            testUnit("number", 6) {
                assertEqual(cardinal(-5), [-1, -1], "If a single number is provided, it should be interpreted as a position for X and Y. If the number is below 0, the function should return [-1, -1]");
                assertEqual(cardinal(-1), [-1, -1], "If a single number is provided, it should be interpreted as a position for X and Y. If the number is -1, the function should return [-1, -1]");
                assertEqual(cardinal(0), [0, 0], "If a single number is provided, it should be interpreted as a position for X and Y. If the number is 0, the function should return [0, 0]");
                assertEqual(cardinal(1), [1, 1], "If a single number is provided, it should be interpreted as a position for X and Y. If the number is 1, the function should return [1, 1]");
                assertEqual(cardinal(2), [2, 2], "If a single number is provided, it should be interpreted as a position for X and Y. If the number is 2, the function should return [2, 2]");
                assertEqual(cardinal(10), [2, 2], "If a single number is provided, it should be interpreted as a position for X and Y. If the number is above 2, the function should return [2, 2]");
            }
            testUnit("vector", 6) {
                assertEqual(cardinal([-5, -3]), [-1, -1], "A vector that contains values below 0 should be converted to [-1, -1]");
                assertEqual(cardinal([-1, -1]), [-1, -1], "A vector that contains [-1, -1] should be kept intact");
                assertEqual(cardinal([0, 0]), [0, 0], "A vector that contains [0, 0] should be kept intact");
                assertEqual(cardinal([1, 1]), [1, 1], "A vector that contains [1, 1] should be kept intact");
                assertEqual(cardinal([2, 2]), [2, 2], "A vector that contains [2, 2] should be kept intact");
                assertEqual(cardinal([10, 15]), [2, 2], "A vector that contains values above 2 should be converted to [2, 2]");
            }
            testUnit("string", 22) {
                assertEqual(cardinal(""), [0, 0], "If a an empty string is provided, the function should return [0, 0]");

                assertEqual(cardinal("w"), [-1, 0], "If a the West (w) side has been declared, the function should return [-1, 0]");
                assertEqual(cardinal("W"), [-1, 0], "If a the West (W) side has been declared, the function should return [-1, 0]");
                assertEqual(cardinal("e"), [1, 0], "If a the East (e) side has been declared, the function should return [1, 0]");
                assertEqual(cardinal("E"), [1, 0], "If a the East (E) side has been declared, the function should return [1, 0]");
                assertEqual(cardinal("we"), [2, 0], "If both East (e) and West (w) sides have been declared, the function should return [2, 0]");
                assertEqual(cardinal("WE"), [2, 0], "If both East (e) and West (W) sides have been declared, the function should return [2, 0]");

                assertEqual(cardinal("s"), [0, -1], "If a the South (s) side has been declared, the function should return [0, -1]");
                assertEqual(cardinal("S"), [0, -1], "If a the South (S) side has been declared, the function should return [0, -1]");
                assertEqual(cardinal("n"), [0, 1], "If a the North (n) side has been declared, the function should return [0, 1]");
                assertEqual(cardinal("N"), [0, 1], "If a the North (N) side has been declared, the function should return [0, 1]");
                assertEqual(cardinal("sn"), [0, 2], "If both South (s) and North (n) sides have been declared, the function should return [0, 2]");
                assertEqual(cardinal("SN"), [0, 2], "If both South (S) and North (N) sides have been declared, the function should return [0, 2]");

                assertEqual(cardinal("ws"), [-1, -1], "If a the West and South sides have been declared, the function should return [-1, -1]");
                assertEqual(cardinal("wn"), [-1, 1], "If a the West and North sides have been declared, the function should return [-1, 1]");
                assertEqual(cardinal("es"), [1, -1], "If a the East and South sides have been declared, the function should return [1, -1]");
                assertEqual(cardinal("en"), [1, 1], "If a the East and North sides have been declared, the function should return [1, 1]");

                assertEqual(cardinal("esn"), [1, 2], "If a the East, South and North sides have been declared, the function should return [1, 2]");
                assertEqual(cardinal("wsn"), [-1, 2], "If a the West, South and North sides have been declared, the function should return [-1, 2]");
                assertEqual(cardinal("ews"), [2, -1], "If a the East, West and South sides have been declared, the function should return [2, -1]");
                assertEqual(cardinal("ewn"), [2, 1], "If a the East, West and North sides have been declared, the function should return [2, 1]");

                assertEqual(cardinal("ewsn"), [2, 2], "If a the East, West, South and North sides have been declared, the function should return [2, 2]");
            }
            testUnit("wrong type", 4) {
                assertEqual(cardinal(true), [0, 0], "A boolean should produce [0, 0]");
                assertEqual(cardinal("1"), [0, 0], "String containing numbers should produce [0, 0]");
                assertEqual(cardinal(["1", "2", "3"]), [0, 0], "An array of strings containing numbers should produce [0, 0]");
                assertEqual(cardinal(["n", "e"]), [1, 1], "An array of strings could produce positions");
            }
        }
    }
}

testCoreUtil();
