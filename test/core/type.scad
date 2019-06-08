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
include <../../core/constants.scad>

/**
 * Part of the camelSCAD library.
 *
 * Unit tests: Type detection and type casting.
 *
 * @package test/core/type
 * @author jsconan
 */
module testCoreType() {
    testPackage("core/type.scad", 21) {
        // test core/type/isUndef()
        testModule("isUndef()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(isUndef(), true, "No parameter, not defined");
            }
            testUnit("parameter", 7) {
                assertEqual(isUndef(undef), true, "Undef is not defined");
                assertEqual(isUndef(false), false, "A boolean is defined");
                assertEqual(isUndef(0), false, "A number is defined");
                assertEqual(isUndef(""), false, "An empty string is defined");
                assertEqual(isUndef("abc"), false, "A string is defined");
                assertEqual(isUndef([]), false, "An empty array is defined");
                assertEqual(isUndef([0]), false, "A vector is defined");
            }
        }
        // test core/type/isNAN()
        testModule("isNAN()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(isNAN(), false, "No parameter, not NAN");
            }
            testUnit("parameter", 8) {
                assertEqual(isNAN(undef), false, "Undef is not NAN");
                assertEqual(isNAN(false), false, "A boolean is not NAN");
                assertEqual(isNAN(0), false, "A number is not NAN");
                assertEqual(isNAN(""), false, "An empty string is not NAN");
                assertEqual(isNAN("abc"), false, "A string is not NAN");
                assertEqual(isNAN([]), false, "An empty array is not NAN");
                assertEqual(isNAN([0]), false, "A vector is not NAN");
                assertEqual(isNAN(0/0), true, "A divisioon by zero produces NAN");
            }
        }
        // test core/type/isInfinity()
        testModule("isInfinity()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(isInfinity(), false, "No parameter, not infinity");
            }
            testUnit("parameter", 11) {
                assertEqual(isInfinity(undef), false, "Undef is not infinity");
                assertEqual(isInfinity(false), false, "A boolean is not infinity");
                assertEqual(isInfinity(42), false, "A finite number is not infinity");
                assertEqual(isInfinity(""), false, "An empty string is not infinity");
                assertEqual(isInfinity("abc"), false, "A string is not infinity");
                assertEqual(isInfinity([]), false, "An empty array is not infinity");
                assertEqual(isInfinity([0]), false, "A vector is not infinity");
                assertEqual(isInfinity(INFINITY), true, "Positive constant");
                assertEqual(isInfinity(-INFINITY), true, "Negative constant");
                assertEqual(isInfinity(1e308*100), true, "Positive infinity");
                assertEqual(isInfinity(-1e308*100), true, "Negative infinity");
            }
        }
        // test core/type/isNumber()
        testModule("isNumber()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(isNumber(), false, "No parameter, not a number");
            }
            testUnit("parameter", 13) {
                assertEqual(isNumber(undef), false, "Undef is not a numeric");
                assertEqual(isNumber(false), false, "False is not a number");
                assertEqual(isNumber(true), false, "True is not a number");
                assertEqual(isNumber(0), true, "0 is a number");
                assertEqual(isNumber(0.0), true, "0.0 is a number");
                assertEqual(isNumber(12), true, "12 is a number");
                assertEqual(isNumber(3.14), true, "3.14 is a number");
                assertEqual(isNumber(-2), true, "-2 is a number");
                assertEqual(isNumber(-4.66), true, "-4.66 is a number");
                assertEqual(isNumber(""), false, "An empty string is not a number");
                assertEqual(isNumber("0"), false, "A string is not a number");
                assertEqual(isNumber([]), false, "An empty array is not a number");
                assertEqual(isNumber([0]), false, "A vector is not a number");
            }
        }
        // test core/type/isInteger()
        testModule("isInteger()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(isInteger(), false, "No parameter, not an integer");
            }
            testUnit("parameter", 13) {
                assertEqual(isInteger(undef), false, "Undef is not an integer");
                assertEqual(isInteger(false), false, "False is not an integer");
                assertEqual(isInteger(true), false, "True is not an integer");
                assertEqual(isInteger(0), true, "0 is an integer");
                assertEqual(isInteger(0.0), true, "0.0 is an integer");
                assertEqual(isInteger(12), true, "12 is an integer");
                assertEqual(isInteger(3.14), false, "3.14 is not an integer");
                assertEqual(isInteger(-2), true, "-2 is an integer");
                assertEqual(isInteger(-5.88), false, "-5.88 is not an integer");
                assertEqual(isInteger(""), false, "An empty string is not an integer");
                assertEqual(isInteger("0"), false, "A string is not an integer");
                assertEqual(isInteger([]), false, "An empty array is not an integer");
                assertEqual(isInteger([0]), false, "A vector is not an integer");
            }
        }
        // test core/type/isZero()
        testModule("isZero()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(isZero(), false, "No parameter, not a number");
            }
            testUnit("parameter", 21) {
                assertEqual(isZero(undef), false, "Undef is not a number");
                assertEqual(isZero(false), false, "False is not a number");
                assertEqual(isZero(true), false, "True is not a number");
                assertEqual(isZero(0), true, "0 is a equal to 0");
                assertEqual(isZero(0.0), true, "0.0 is equal to 0");
                assertEqual(isZero(1e-7), false, "1e-7 is not equal to 0");
                assertEqual(isZero(1e-9), true, "1e-9 is considered equal to 0");
                assertEqual(isZero(1e-15), true, "1e-15 is considered equal to 0");
                assertEqual(isZero(floor(.2)), true, "floor(.2) is equal to 0");
                assertEqual(isZero(floor(.12345)), true, "floor(.12345) is equal to 0");
                assertEqual(isZero(2 - floor(2)), true, "2 - floor(2) is equal to 0");
                assertEqual(isZero(3 - floor(3.22)), true, "3 - floor(3.22) is equal to 0");
                assertEqual(isZero(32 - floor(32.23)), true, "32 - floor(32.23) is equal to 0");
                assertEqual(isZero(12), false, "12 is not equal to 0");
                assertEqual(isZero(3.14), false, "3.14 is not equal to 0");
                assertEqual(isZero(-2), false, "-2 is not equal to 0");
                assertEqual(isZero(-5.88), false, "-5.88 is not equal to 0");
                assertEqual(isZero(""), false, "An empty string is not equal to 0");
                assertEqual(isZero("0"), false, "A string is not equal to 0");
                assertEqual(isZero([]), false, "An empty array is not equal to 0");
                assertEqual(isZero([0]), false, "A vector is not equal to 0");
            }
        }
        // test core/type/isBoolean()
        testModule("isBoolean()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(isBoolean(), false, "No parameter, not a boolean");
            }
            testUnit("parameter", 14) {
                assertEqual(isBoolean(undef), false, "Undef is not a boolean");
                assertEqual(isBoolean(false), true, "False is a boolean");
                assertEqual(isBoolean(true), true, "True is a boolean");
                assertEqual(isBoolean(0), false, "0 is not a boolean");
                assertEqual(isBoolean(0.0), false, "0.0 is not a boolean");
                assertEqual(isBoolean(12), false, "12 is not a boolean");
                assertEqual(isBoolean(3.14), false, "3.14 is not a boolean");
                assertEqual(isBoolean(-2), false, "-2 is not a boolean");
                assertEqual(isBoolean(""), false, "An empty string is not a boolean");
                assertEqual(isBoolean("true"), false, "A string containing boolean is not a boolean");
                assertEqual(isBoolean([]), false, "An empty array is not a boolean");
                assertEqual(isBoolean([true]), false, "A array of booleans is not a boolean");
                assertEqual(isBoolean([true, false, true]), false, "A array of booleans is not a boolean");
                assertEqual(isBoolean([0, true, 2]), false, "A array that does not only contain numbers is not a boolean");
            }
        }
        // test core/type/isString()
        testModule("isString()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(isString(), false, "No parameter, not a string");
            }
            testUnit("parameter", 15) {
                assertEqual(isString(undef), false, "Undef is not a string");
                assertEqual(isString(false), false, "False is not a string");
                assertEqual(isString(true), false, "True is not a string");
                assertEqual(isString(0), false, "0 is not a string");
                assertEqual(isString(0.0), false, "0.0 is not a string");
                assertEqual(isString(12), false, "12 is not a string");
                assertEqual(isString(3.14), false, "3.14 is not a string");
                assertEqual(isString(-2), false, "-2 is not a string");
                assertEqual(isString(""), true, "An empty string is a string");
                assertEqual(isString("0"), true, "A string containing numbers is a string");
                assertEqual(isString("abc"), true, "A string containing letters is a string");
                assertEqual(isString([]), false, "An empty array is not a string");
                assertEqual(isString(["abc"]), false, "A array of strings is not a string");
                assertEqual(isString(["0", "1", "2"]), false, "A array of strings is not a string");
                assertEqual(isString([0, "1", 2]), false, "A array that does not only contain numbers is not a string");
            }
        }
        // test core/type/isArray()
        testModule("isArray()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(isArray(), false, "No parameter, not an array");
            }
            testUnit("parameter", 15) {
                assertEqual(isArray(undef), false, "Undef is not an array");
                assertEqual(isArray(false), false, "False is not an array");
                assertEqual(isArray(true), false, "True is not an array");
                assertEqual(isArray(0), false, "0 is not an array");
                assertEqual(isArray(0.0), false, "0.0 is not an array");
                assertEqual(isArray(12), false, "12 is not an array");
                assertEqual(isArray(3.14), false, "3.14 is not an array");
                assertEqual(isArray(-2), false, "-2 is not an array");
                assertEqual(isArray(""), false, "An empty string is not an array");
                assertEqual(isArray("0"), false, "A string is not an array");
                assertEqual(isArray([]), true, "An empty array is an array");
                assertEqual(isArray([0]), true, "A array with a number is an array");
                assertEqual(isArray([0, 1, 2]), true, "A array of numbers is an array");
                assertEqual(isArray([[0, 1], [2, 3]]), true, "A array of vectors is an array");
                assertEqual(isArray([0, "1", 2]), true, "A array that does not only contain numbers is an array");
            }
        }
        // test core/type/isVector()
        testModule("isVector()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(isVector(), false, "No parameter, not a vector");
            }
            testUnit("parameter", 15) {
                assertEqual(isVector(undef), false, "Undef is not a vector");
                assertEqual(isVector(false), false, "False is not a vector");
                assertEqual(isVector(true), false, "True is not a vector");
                assertEqual(isVector(0), false, "0 is not a vector");
                assertEqual(isVector(0.0), false, "0.0 is not a vector");
                assertEqual(isVector(12), false, "12 is not a vector");
                assertEqual(isVector(3.14), false, "3.14 is not a vector");
                assertEqual(isVector(-2), false, "-2 is not a vector");
                assertEqual(isVector(""), false, "An empty string is not a vector");
                assertEqual(isVector("0"), false, "A string is not a vector");
                assertEqual(isVector([]), true, "An empty array is a vector");
                assertEqual(isVector([0]), true, "A array with a number is a vector");
                assertEqual(isVector([0, 1, 2]), true, "A array of numbers is a vector");
                assertEqual(isVector([[0, 1], [2, 3]]), true, "A array of vectors is a vector");
                assertEqual(isVector([0, "1", 2]), false, "A array that does not only contain numbers is not a vector");
            }
        }
        // test core/type/isVectorN()
        testModule("isVectorN()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(isVectorN(), false, "No parameter, not a vector");
            }
            testUnit("parameter", 26) {
                assertEqual(isVectorN(undef), false, "Undef is not a vector");
                assertEqual(isVectorN(undef, undef), false, "Undef is not a vector");
                assertEqual(isVectorN(false), false, "False is not a vector");
                assertEqual(isVectorN(false, false), false, "False is not a vector");
                assertEqual(isVectorN(true), false, "True is not a vector");
                assertEqual(isVectorN(true, true), false, "True is not a vector");
                assertEqual(isVectorN(0), false, "0 is not a vector");
                assertEqual(isVectorN(0, 0), false, "0 is not a vector");
                assertEqual(isVectorN(0.0), false, "0.0 is not a vector");
                assertEqual(isVectorN(12), false, "12 is not a vector");
                assertEqual(isVectorN(12, 0), false, "12 is not a vector");
                assertEqual(isVectorN(3.14), false, "3.14 is not a vector");
                assertEqual(isVectorN(3.14, 0), false, "3.14 is not a vector");
                assertEqual(isVectorN(-2), false, "-2 is not a vector");
                assertEqual(isVectorN(-2, 0), false, "-2 is not a vector");
                assertEqual(isVectorN(""), false, "An empty string is not a vector");
                assertEqual(isVectorN("", 0), false, "An empty string is not a vector");
                assertEqual(isVectorN("0"), false, "A string is not a vector");
                assertEqual(isVectorN("0", 0), false, "A string is not a vector");
                assertEqual(isVectorN([], 0), true, "An empty array is a vector of 0");
                assertEqual(isVectorN([], 1), false, "An empty array is not a vector of 1");
                assertEqual(isVectorN([0], 0), false, "A array with a number is not a vector of 0");
                assertEqual(isVectorN([0], 1), true, "A array with a number is a vector of 1");
                assertEqual(isVectorN([0, 1], 2), true, "A array of 2 numbers is a vector of 2");
                assertEqual(isVectorN([0, 1, 2], 3), true, "A array of 3 numbers is a vector of 3");
                assertEqual(isVectorN([0, "1", 2], 3), false, "A array that does not only contain numbers is not a vector");
            }
        }
        // test core/type/isVector2D()
        testModule("isVector2D()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(isVector2D(), false, "No parameter, not a vector");
            }
            testUnit("parameter", 16) {
                assertEqual(isVector2D(undef), false, "Undef is not a 2D vector");
                assertEqual(isVector2D(false), false, "False is not a 2D vector");
                assertEqual(isVector2D(true), false, "True is not a 2D vector");
                assertEqual(isVector2D(0), false, "0 is not a 2D vector");
                assertEqual(isVector2D(0.0), false, "0.0 is not a 2D vector");
                assertEqual(isVector2D(12), false, "12 is not a 2D vector");
                assertEqual(isVector2D(3.14), false, "3.14 is not a 2D vector");
                assertEqual(isVector2D(-2), false, "-2 is not a 2D vector");
                assertEqual(isVector2D(""), false, "An empty string is not a 2D vector");
                assertEqual(isVector2D("0"), false, "A string is not a 2D vector");
                assertEqual(isVector2D([]), false, "An empty array is not a 2D vector");
                assertEqual(isVector2D([0]), false, "A array with 1 number is not a 2D vector");
                assertEqual(isVector2D([0, 1]), true, "A array of 2 numbers is a 2D vector");
                assertEqual(isVector2D([0, 1, 2]), false, "A array of 3 numbers is not a 2D vector");
                assertEqual(isVector2D([0, 1, 2, 3]), false, "A array of 4 numbers is not a 2D vector");
                assertEqual(isVector2D([0, "1"]), false, "A array that does not only contain numbers is not a 2D vector");
            }
        }
        // test core/type/isVector3D()
        testModule("isVector3D()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(isVector3D(), false, "No parameter, not a vector");
            }
            testUnit("parameter", 16) {
                assertEqual(isVector3D(undef), false, "Undef is not a 3D vector");
                assertEqual(isVector3D(false), false, "False is not a 3D vector");
                assertEqual(isVector3D(true), false, "True is not a 3D vector");
                assertEqual(isVector3D(0), false, "0 is not a 3D vector");
                assertEqual(isVector3D(0.0), false, "0.0 is not a 3D vector");
                assertEqual(isVector3D(12), false, "12 is not a 3D vector");
                assertEqual(isVector3D(3.14), false, "3.14 is not a 3D vector");
                assertEqual(isVector3D(-2), false, "-2 is not a 3D vector");
                assertEqual(isVector3D(""), false, "An empty string is not a 3D vector");
                assertEqual(isVector3D("0"), false, "A string is not a 3D vector");
                assertEqual(isVector3D([]), false, "An empty array is not a 3D vector");
                assertEqual(isVector3D([0]), false, "A array with 1 number is not a 3D vector");
                assertEqual(isVector3D([0, 1]), false, "A array of 2 numbers is not a 3D vector");
                assertEqual(isVector3D([0, 1, 2]), true, "A array of 3 numbers is a 3D vector");
                assertEqual(isVector3D([0, 1, 2, 3]), false, "A array of 4 numbers is not a 3D vector");
                assertEqual(isVector3D([0, "1", 2]), false, "A array that does not only contain numbers is not a 3D vector");
            }
        }
        // test core/type/number()
        testModule("number()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(number(), 0, "Should return a 0");
            }
            testUnit("parameter", 14) {
                assertEqual(number(undef), 0, "Undef should be converted to 0");
                assertEqual(number(false), 0, "False should be converted to 0");
                assertEqual(number(true), 1, "True should be converted to 1");
                assertEqual(number(""), 0, "An empty string should be converted to 0");
                assertEqual(number("10"), 0, "An string containing a number should be converted to 0");
                assertEqual(number("abc"), 0, "An string containing letters should be converted to 0");
                assertEqual(number([]), 0, "An empty array should be converted to 0");
                assertEqual(number([1]), 0, "A vector should be converted to 0");
                assertEqual(number(["1"]), 0, "An array should be converted to 0");
                assertEqual(number(0), 0, "A zero value should be kept");
                assertEqual(number(4), 4, "An integer value should be kept");
                assertEqual(number(3.14), 3.14, "A float value should be kept");
                assertEqual(number(-5), -5, "A negative integer value should be kept");
                assertEqual(number(-3.14), -3.14, "A negative float value should be kept");
            }
        }
        // test core/type/float()
        testModule("float()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(float(), 0, "Should return a 0");
            }
            testUnit("parameter", 14) {
                assertEqual(float(undef), 0, "Undef should be converted to 0");
                assertEqual(float(false), 0, "False should be converted to 0");
                assertEqual(float(true), 0, "True should be converted to 0");
                assertEqual(float(""), 0, "An empty string should be converted to 0");
                assertEqual(float("10"), 0, "An string containing a number should be converted to 0");
                assertEqual(float("abc"), 0, "An string containing letters should be converted to 0");
                assertEqual(float([]), 0, "An empty array should be converted to 0");
                assertEqual(float([1]), 0, "A vector should be converted to 0");
                assertEqual(float(["1"]), 0, "An array should be converted to 0");
                assertEqual(float(0), 0, "A zero value should be kept");
                assertEqual(float(4), 4, "An integer value should be kept");
                assertEqual(float(3.14), 3.14, "A float value should be kept");
                assertEqual(float(-5), -5, "A negative integer value should be kept");
                assertEqual(float(-3.14), -3.14, "A negative float value should be kept");
            }
        }
        // test core/type/divisor()
        testModule("divisor()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(divisor(), 1, "A safe divisor should be returned even if no parameter is provided");
            }
            testUnit("wrong types", 3) {
                assertEqual(divisor(false), 1, "A boolean should be converted to a safe divisor");
                assertEqual(divisor("foo"), 1, "A string should be converted to a safe divisor");
                assertEqual(divisor([15]), 1, "A vector should be converted to a safe divisor");
            }
            testUnit("number", 5) {
                assertEqual(divisor(0), 1, "A safe divisor should be returned if 0 is provided");
                assertEqual(divisor(2), 2, "The provided number should be returned if is a safe divisor");
                assertEqual(divisor(0.001), 0.001, "The provided number should be returned if is a safe divisor");
                assertEqual(divisor(-1), -1, "The provided number should be returned if is a safe divisor");
                assertEqual(divisor(-3.876), -3.876, "The provided number should be returned if is a safe divisor");
            }
        }
        // test core/type/integer()
        testModule("integer()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(integer(), 0, "Should return a 0");
            }
            testUnit("parameter", 14) {
                assertEqual(integer(undef), 0, "Undef should be converted to 0");
                assertEqual(integer(false), 0, "False should be converted to 0");
                assertEqual(integer(true), 0, "True should be converted to 0");
                assertEqual(integer(""), 0, "An empty string should be converted to 0");
                assertEqual(integer("10"), 0, "An string containing a number should be converted to 0");
                assertEqual(integer("abc"), 0, "An string containing letters should be converted to 0");
                assertEqual(integer([]), 0, "An empty array should be converted to 0");
                assertEqual(integer([1]), 0, "A vector should be converted to 0");
                assertEqual(integer(["1"]), 0, "An array should be converted to 0");
                assertEqual(integer(0), 0, "A zero value should be kept");
                assertEqual(integer(4), 4, "An integer value should be kept");
                assertEqual(integer(3.14), 3, "A float value should be truncated");
                assertEqual(integer(-5), -5, "A negative integer value should be kept");
                assertEqual(integer(-3.14), -3, "A negative float value should be truncated");
            }
        }
        // test core/type/boolean()
        testModule("boolean()", 2) {
            testUnit("no parameter", 1) {
                assertEqual(boolean(), false, "Should return false");
            }
            testUnit("parameter", 14) {
                assertEqual(boolean(undef), false, "Undef should be converted to false");
                assertEqual(boolean(false), false, "False should be kept");
                assertEqual(boolean(true), true, "True should be kept");
                assertEqual(boolean(""), false, "An empty string should be converted to false");
                assertEqual(boolean("10"), true, "An string containing a number should be converted to true");
                assertEqual(boolean("abc"), true, "An string containing letters should be converted to true");
                assertEqual(boolean("true"), true, "An string containing true should be converted to true");
                assertEqual(boolean("false"), false, "An string containing false should be converted to false");
                assertEqual(boolean([]), false, "An empty array should be converted to false");
                assertEqual(boolean([1]), true, "A vector should be converted to true");
                assertEqual(boolean(["1"]), true, "An array should be converted to true");
                assertEqual(boolean(0), false, "A zero value should be converted to false");
                assertEqual(boolean(1), true, "An integer value should be converted to true");
                assertEqual(boolean(3.14), true, "A float value should be converted to true");
            }
        }
        // test core/type/string()
        testModule("string()", 2) {
            testUnit("no parameter", 1) {
                assertEmptyString(string());
            }
            testUnit("parameter", 12) {
                assertEqual(string(undef), "", "Undef should be converted to an empty string");
                assertEqual(string(false), "false", "False should be converted to \"false\"");
                assertEqual(string(true), "true", "True should be converted to \"true\"");
                assertEqual(string(""), "", "An empty string should be kept");
                assertEqual(string("10"), "10", "A string containing a number should be kept");
                assertEqual(string("abc"), "abc", "A string containing letters should be kept");
                assertEqual(string([]), "[]", "An empty array should be converted to \"[]\"");
                assertEqual(string([1]), "[1]", "A vector should be converted to a string");
                assertEqual(string(["1"]), "[\"1\"]", "An array should be converted to a string");
                assertEqual(string(0), "0", "A zero value should be converted to \"0\"");
                assertEqual(string(1), "1", "An integer value should be converted to a string");
                assertEqual(string(3.14), "3.14", "A float value should be converted to a string");
            }
        }
        // test core/type/array()
        testModule("array()", 2) {
            testUnit("no parameter", 1) {
                assertEmptyArray(array());
            }
            testUnit("parameter", 12) {
                assertEqual(array(undef), [], "Undef should be converted to an empty array");
                assertEqual(array(false), [false], "False should be converted to [false]");
                assertEqual(array(true), [true], "True should be converted to [true]");
                assertEqual(array(""), [""], "An empty string should be converted to [\"\"]");
                assertEqual(array("10"), ["10"], "An string containing a number should be converted to array of strings");
                assertEqual(array("abc"), ["abc"], "An string containing letters should be converted to array of strings");
                assertEqual(array([]), [], "An empty array should be kept");
                assertEqual(array([1]), [1], "A vector should be kept");
                assertEqual(array(["1"]), ["1"], "An array should be kept");
                assertEqual(array(0), [0], "A zero value should be converted to [0]");
                assertEqual(array(1), [1], "An integer value should be converted to an array of integers");
                assertEqual(array(3.14), [3.14], "A float value should be converted to an array of floats");
            }
        }
        // test core/type/vector()
        testModule("vector()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(vector());
            }
            testUnit("not vector", 9) {
                assertEmptyArray(vector(1), "A number and no length");
                assertEmptyArray(vector(true), "A boolean and no length");
                assertEmptyArray(vector("foo"), "A string and no length");
                assertEqual(vector(1, 2), [1, 1], "A number and a length");
                assertEqual(vector(true, 2), [0, 0], "A boolean and a length");
                assertEqual(vector([true]), [0], "An array of booleans and no length");
                assertEqual(vector([true], 2), [0, 0], "An array of booleans and a length");
                assertEqual(vector(["foo", "bar"]), [0, 0], "An array of strings and no length");
                assertEqual(vector(["foo", "bar"], 1), [0], "An array of strings and a length");
            }
            testUnit("vector", 6) {
                assertEqual(vector([1], 0), [], "A vector and a length of 0");
                assertEqual(vector([1], true), [], "A vector but a wrong length");
                assertEqual(vector([1], "2"), [], "A vector but a wrong length");
                assertEqual(vector([1], 2), [1, 0], "A vector and a longer length");
                assertEqual(vector([1, 2], 2), [1, 2], "A vector and the exact length");
                assertEqual(vector([1, 2, 3], 2), [1, 2], "A vector and a shorter length");
            }
        }
    }
}

testCoreType();
