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
 * Unit tests: Operations on vectors.
 *
 * @package test/core/vector
 * @author jsconan
 */
module testCoreVector() {
    testPackage("core/vector.scad", 17) {
        // test core/vector/normal()
        testModule("normal()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(normal(), [0, 0], "Should always produce a 2D vector, even if input is wrong");
            }
            testUnit("not vector", 5) {
                assertEqual(normal(1), [1, -1], "Should produce a 2D vector with the input number as a coordinate");
                assertEqual(normal(true), [0, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(normal("1"), [0, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(normal(["1"]), [0, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(normal(["1", 1]), [1, 0], "Should produce a corrected 2D vector if input is wrong");
            }
            testUnit("vector", 3) {
                assertEqual(normal([1]), [0, -1], "Should complete incomplete 2D vector");
                assertEqual(normal([1, 2]), [2, -1], "Should return an orthogonal 2D vector");
                assertEqual(normal([1, 2, 3]), [2, -1], "Should truncate too big vector");
            }
        }
        // test core/vector/flip()
        testModule("flip()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(flip(), [0, 0], "Should always produce a 2D vector, even if input is wrong");
            }
            testUnit("not vector", 5) {
                assertEqual(flip(1), [1, 1], "Should produce a 2D vector with the input number as a coordinate");
                assertEqual(flip(true), [0, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(flip("1"), [0, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(flip(["1"]), [0, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(flip(["1", 1]), [1, 0], "Should produce a corrected 2D vector if input is wrong");
            }
            testUnit("vector", 3) {
                assertEqual(flip([1]), [0, 1], "Should complete incomplete 2D vector");
                assertEqual(flip([1, 2]), [2, 1], "Should return an orthogonal 2D vector");
                assertEqual(flip([1, 2, 3]), [2, 1], "Should truncate too big vector");
            }
        }
        // test core/vector/norm2()
        testModule("norm2()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(norm2(), 0, "Should always produce the norm2 of a 3D vector, even if input is wrong");
            }
            testUnit("not vector", 6) {
                assertEqual(norm2(1), 3, "Should produce the norm2 of a 3D vector with the input number as a coordinate");
                assertEqual(norm2(true), 0, "Should produce the norm2 of a 3D vector filled with 0 if input is wrong");
                assertEqual(norm2("1"), 0, "Should produce the norm2 of a 3D vector filled with 0 if input is wrong");
                assertEqual(norm2(["1"]), 0, "Should produce the norm2 of a 3D vector filled with 0 if input is wrong");
                assertEqual(norm2(["1", 1]), 1, "Should produce the norm2 of a corrected 3D vector if input is wrong");
                assertEqual(norm2(["1", 1, 1]), 2, "Should produce the norm2 of a corrected 3D vector if input is wrong");
            }
            testUnit("vector", 4) {
                assertEqual(norm2([1]), 1, "Should complete incomplete 3D vector and returns its norm2");
                assertEqual(norm2([1, 2]), 5, "Should complete incomplete 3D vector and returns its norm2");
                assertEqual(norm2([1, 2, 3]), 14, "Should return the norm2 of a 3D vector");
                assertEqual(norm2([1, 2, 3, 4]), 14, "Should truncate too big vector and returns its norm2");
            }
        }
        // test core/vector/normalize()
        testModule("normalize()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(normalize(), [0, 0, 0], "Should always produce a normalized 3D vector, even if input is wrong");
            }
            testUnit("not vector", 6) {
                assertEqual(normalize(1), [1, 1, 1] / norm([1, 1, 1]), "Should produce a normalized 3D vector with the input number as a coordinate");
                assertEqual(normalize(true), [0, 0, 0], "Should produce a normalized 3D vector filled with 0 if input is wrong");
                assertEqual(normalize("1"), [0, 0, 0], "Should produce a normalized 3D vector filled with 0 if input is wrong");
                assertEqual(normalize(["1"]), [0, 0, 0], "Should produce a normalized 3D vector filled with 0 if input is wrong");
                assertEqual(normalize(["1", 1]), [0, 1, 0] / norm([0, 1, 0]), "Should produce a normalized corrected 3D vector if input is wrong");
                assertEqual(normalize(["1", 1, 1]), [0, 1, 1] / norm([0, 1, 1]), "Should produce a normalized corrected 3D vector if input is wrong");
            }
            testUnit("vector", 4) {
                assertEqual(normalize([1]), [1, 0, 0] / norm([1, 0, 0]), "Should complete incomplete 3D vector and returns a normalized 3D vector");
                assertEqual(normalize([1, 2]), [1, 2, 0] / norm([1, 2, 0]), "Should complete incomplete 3D vector and returns a normalized 3D vector");
                assertEqual(normalize([1, 2, 3]), [1, 2, 3] / norm([1, 2, 3]), "Should return a normalized 3D vector");
                assertEqual(normalize([1, 2, 3, 4]), [1, 2, 3] / norm([1, 2, 3]), "Should truncate too big vector and returns a normalized 3D vector");
            }
        }
        // test core/vector/vadd()
        testModule("vadd()", 5) {
            testUnit("no parameter", 1) {
                assertEmptyArray(vadd());
            }
            testUnit("not array", 3) {
                assertEmptyArray(vadd(0, 1), "A number is not an array");
                assertEmptyArray(vadd(true, false), "A boolean is not an array");
                assertEmptyArray(vadd("foo", "bar"), "A string is not an array");
            }
            testUnit("not vector", 1) {
                assertEqual(vadd([1, "2", 3], 2), [3, 2, 5], "Add 2 to each terms");
            }
            testUnit("not number", 3) {
                assertEqual(vadd([1, "2", 3], true), [1, 0, 3], "Add not a number to each terms");
                assertEqual(vadd([1, "2", 3], "2"), [1, 0, 3], "Add not a number to each terms");
                assertEqual(vadd([1, "2", 3], [2]), [1, 0, 3], "Add not a number to each terms");
            }
            testUnit("vector", 2) {
                assertEqual(vadd([], 2), [], "Add 2 to an empty vector");
                assertEqual(vadd([3, 2, 1], 2), [5, 4, 3], "Add 2 to each terms");
            }
        }
        // test core/vector/vsub()
        testModule("vsub()", 5) {
            testUnit("no parameter", 1) {
                assertEmptyArray(vsub());
            }
            testUnit("not array", 3) {
                assertEmptyArray(vsub(0, 1), "A number is not an array");
                assertEmptyArray(vsub(true, false), "A boolean is not an array");
                assertEmptyArray(vsub("foo", "bar"), "A string is not an array");
            }
            testUnit("not vector", 1) {
                assertEqual(vsub([1, "2", 3], 2), [-1, -2, 1], "Subtract 2 from each terms");
            }
            testUnit("not number", 3) {
                assertEqual(vsub([1, "2", 3], true), [1, 0, 3], "Subtract not a number from each terms");
                assertEqual(vsub([1, "2", 3], "2"), [1, 0, 3], "Subtract not a number from each terms");
                assertEqual(vsub([1, "2", 3], [2]), [1, 0, 3], "Subtract not a number from each terms");
            }
            testUnit("vector", 2) {
                assertEqual(vsub([], 2), [], "Subtract 2 from an empty vector");
                assertEqual(vsub([3, 2, 1], 2), [1, 0, -1], "Subtract 2 from each terms");
            }
        }
        // test core/vector/vmul()
        testModule("vmul()", 4) {
            testUnit("no parameter", 1) {
                assertEmptyArray(vmul());
            }
            testUnit("not array", 5) {
                assertEmptyArray(vmul(0, 1), "A number is not an array");
                assertEmptyArray(vmul(true, false), "A boolean is not an array");
                assertEmptyArray(vmul("foo", "bar"), "A string is not an array");
                assertEmptyArray(vmul("foo", [1, 2]), "A string is not an array");
                assertEmptyArray(vmul([1, 2], "bar"), "A string is not an array");
            }
            testUnit("not vector", 3) {
                assertEqual(vmul([1, "2", 3], [2, 2, 2]), [2, 0, 6], "Multiply 2 arrays");
                assertEqual(vmul([1, "2", 3], [2, "2", 2]), [2, 0, 6], "Multiply 2 arrays");
                assertEqual(vmul([1, 2, 3], [2, "2", 2]), [2, 0, 6], "Multiply 2 arrays");
            }
            testUnit("vector", 3) {
                assertEqual(vmul([1, 2, 3], [3, 2, 1]), [3, 4, 3], "Multiply 2 vector of same length");
                assertEqual(vmul([1, 2, 3, 4], [3, 2, 1]), [3, 4, 3, 0], "Multiply 2 vector of diffent lengths");
                assertEqual(vmul([1, 2, 3], [4, 3, 2, 1]), [4, 6, 6, 0], "Multiply 2 vector of diffent lengths");
            }
        }
        // test core/vector/vdiv()
        testModule("vdiv()", 4) {
            testUnit("no parameter", 1) {
                assertEmptyArray(vdiv());
            }
            testUnit("not array", 5) {
                assertEmptyArray(vdiv(0, 1), "A number is not an array");
                assertEmptyArray(vdiv(true, false), "A boolean is not an array");
                assertEmptyArray(vdiv("foo", "bar"), "A string is not an array");
                assertEmptyArray(vdiv("foo", [1, 2]), "A string is not an array");
                assertEmptyArray(vdiv([1, 2], "bar"), "A string is not an array");
            }
            testUnit("not vector", 3) {
                assertEqual(vdiv([1, "2", 3], [2, 2, 2]), [0.5, 0, 1.5], "Divide 2 arrays");
                assertEqual(vdiv([1, "2", 3], [2, "2", 2]), [0.5, 0, 1.5], "Divide 2 arrays");
                assertEqual(vdiv([1, 2, 3], [2, "2", 2]), [0.5, 2, 1.5], "Divide 2 arrays");
            }
            testUnit("vector", 4) {
                assertEqual(vdiv([6, 2, 3], [3, 2, 1]), [2, 1, 3], "Divide 2 vector of same length");
                assertEqual(vdiv([1, 2, 3], [0, 0, 0]), [1, 2, 3], "Protect against divide by 0");
                assertEqual(vdiv([1, 2, 3, 4], [2, 2, 1]), [0.5, 1, 3, 4], "Divide 2 vector of diffent lengths");
                assertEqual(vdiv([1, 2, 3], [4, 3, 2, 1]), [0.25, 2/3, 1.5, 0], "Divide 2 vector of diffent lengths");
            }
        }
        // test core/vector/vmin()
        testModule("vmin()", 5) {
            testUnit("no parameter", 1) {
                assertEmptyArray(vmin());
            }
            testUnit("not array", 3) {
                assertEmptyArray(vmin(0, 1), "A number is not an array");
                assertEmptyArray(vmin(true, false), "A boolean is not an array");
                assertEmptyArray(vmin("foo", "bar"), "A string is not an array");
            }
            testUnit("not vector", 1) {
                assertEqual(vmin([1, "2", 3], 2), [1, 0, 2], "Gets the values under 2 from an array");
            }
            testUnit("not number", 3) {
                assertEqual(vmin([1, "2", 3], true), [0, 0, 0], "Gets the values under not a number from an array");
                assertEqual(vmin([1, "2", 3], "2"), [0, 0, 0], "Gets the values under not a number from an array");
                assertEqual(vmin([1, "2", 3], [2]), [0, 0, 0], "Gets the values under not a number from an array");
            }
            testUnit("vector", 2) {
                assertEqual(vmin([], 2), [], "Gets the values under 2 from an empty vector");
                assertEqual(vmin([3, 2, 1], 2), [2, 2, 1], "Gets the values under 2 from a vector");
            }
        }
        // test core/vector/vmax()
        testModule("vmax()", 5) {
            testUnit("no parameter", 1) {
                assertEmptyArray(vmax());
            }
            testUnit("not array", 3) {
                assertEmptyArray(vmax(0, 1), "A number is not an array");
                assertEmptyArray(vmax(true, false), "A boolean is not an array");
                assertEmptyArray(vmax("foo", "bar"), "A string is not an array");
            }
            testUnit("not vector", 1) {
                assertEqual(vmax([1, "2", 3], 2), [2, 2, 3], "Gets the values above 2 from an array");
            }
            testUnit("not number", 3) {
                assertEqual(vmax([1, "2", 3], true), [1, 0, 3], "Gets the values above not a number from an array");
                assertEqual(vmax([1, "2", 3], "2"), [1, 0, 3], "Gets the values above not a number from an array");
                assertEqual(vmax([1, "2", 3], [2]), [1, 0, 3], "Gets the values above not a number from an array");
            }
            testUnit("vector", 2) {
                assertEqual(vmax([], 2), [], "Gets the values above 2 from an empty vector");
                assertEqual(vmax([3, 2, 1], 2), [3, 2, 2], "Gets the values above 2 from a vector");
            }
        }
        // test core/vector/vpow()
        testModule("vpow()", 5) {
            testUnit("no parameter", 1) {
                assertEmptyArray(vpow());
            }
            testUnit("not array", 3) {
                assertEmptyArray(vpow(0, 1), "A number is not an array");
                assertEmptyArray(vpow(true, false), "A boolean is not an array");
                assertEmptyArray(vpow("foo", "bar"), "A string is not an array");
            }
            testUnit("not vector", 1) {
                assertEqual(vpow([1, "2", 3], 2), [1, 0, 9], "Gets the power of 2 for each values from an array");
            }
            testUnit("not number", 3) {
                assertEqual(vpow([1, "2", 3], true), [1, 1, 1], "Gets the power of not a number for each values from an array");
                assertEqual(vpow([1, "2", 3], "2"), [1, 1, 1], "Gets the power of not a number for each values from an array");
                assertEqual(vpow([1, "2", 3], [2]), [1, 1, 1], "Gets the power of not a number for each values from an array");
            }
            testUnit("vector", 3) {
                assertEqual(vpow([], 2), [], "Gets the power of 2 from an empty vector");
                assertEqual(vpow([3, 2, 1], 3), [27, 8, 1], "Gets the power of 3 for each values from a vector");
                assertEqual(vpow([3, 2, 1]), [9, 4, 1], "Gets the power of 2 for each values from a vector");
            }
        }
        // test core/vector/vabs()
        testModule("vabs()", 4) {
            testUnit("no parameter", 1) {
                assertEmptyArray(vabs());
            }
            testUnit("not array", 3) {
                assertEmptyArray(vabs(0), "A number is not an array");
                assertEmptyArray(vabs(true), "A boolean is not an array");
                assertEmptyArray(vabs("foo"), "A string is not an array");
            }
            testUnit("not vector", 1) {
                assertEqual(vabs([-1, "2", 3]), [1, 0, 3], "Gets positive values from an array");
            }
            testUnit("vector", 2) {
                assertEqual(vabs([]), [], "Gets positive values from an empty vector");
                assertEqual(vabs([-3, 2, -1]), [3, 2, 1], "Gets positive values from a vector");
            }
        }
        // test core/vector/vsum()
        testModule("vsum()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(vsum(), 0, "The sum of a missing array");
            }
            testUnit("not array", 3) {
                assertEqual(vsum(0), 0, "A number is not an array");
                assertEqual(vsum(true), 0, "A boolean is not an array");
                assertEqual(vsum("foo"), 0, "A string is not an array");
            }
            testUnit("not vector", 1) {
                assertEqual(vsum([-1, "2", 3]), 2, "Gets the sum from an array");
            }
            testUnit("vector", 7) {
                assertEqual(vsum([]), 0, "Gets the sum of an empty vector");
                assertEqual(vsum([3]), 3, "Gets the sum of a vector[1]");
                assertEqual(vsum([3, 2]), 5, "Gets the sum of a vector[2]");
                assertEqual(vsum([3, 2, 1]), 6, "Gets the sum of a vector[3]");
                assertEqual(vsum([-3, 2, -1]), -2, "Gets the sum of a vector");
                assertEqual(vsum([-3, 2, -1, 4, -3, 6]), 5, "Gets the sum of a vector[6]");
                assertEqual(vsum(range(50)), (50 * 51) / 2, "Gets the sum of a range");
            }
        }
        // test core/vector/average()
        testModule("average()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(average(), 0, "The sum of a missing array");
            }
            testUnit("not array", 3) {
                assertEqual(average(0), 0, "A number is not an array");
                assertEqual(average(true), 0, "A boolean is not an array");
                assertEqual(average("foo"), 0, "A string is not an array");
            }
            testUnit("not vector", 1) {
                assertEqual(average([-1, "2", 3]), 2/3, "Gets the average from an array");
            }
            testUnit("vector", 3) {
                assertEqual(average([]), 0, "Gets the average of an empty vector");
                assertEqual(average([3, 2, 1]), 2, "Gets the average of a vector");
                assertEqual(average([-4, 3, -2]), -1, "Gets the average of a vector");
            }
        }
        // test core/vector/vfactorial()
        testModule("vfactorial()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(vfactorial(), [], "No parameter, no factorial, should return an empty array");
            }
            testUnit("not a number", 3) {
                assertEqual(vfactorial(true), [], "Boolean is not a number, should return an empty array");
                assertEqual(vfactorial("23"), [], "String is not a number, should return an empty array");
                assertEqual(vfactorial([3]), [], "Vector is not a number, should return an empty array");
            }
            testUnit("number", 11) {
                assertEqual(vfactorial(0), [1], "The factorial of 0 is 1");
                assertEqual(vfactorial(1), [1, 1], "The factorial of 1 is 1");
                assertEqual(vfactorial(2), [1, 1, 2], "The factorial of 2 is 2");
                assertEqual(vfactorial(3), [1, 1, 2, 6], "The factorial of 3 is 6");
                assertEqual(vfactorial(4), [1, 1, 2, 6, 24], "The factorial of 4 is 24");
                assertEqual(vfactorial(5), [1, 1, 2, 6, 24, 120], "The factorial of 5 is 120");
                assertEqual(vfactorial(6), [1, 1, 2, 6, 24, 120, 720], "The factorial of 6 is 720");
                assertEqual(vfactorial(7), [1, 1, 2, 6, 24, 120, 720, 5040], "The factorial of 7 is 5040");
                assertEqual(vfactorial(8), [1, 1, 2, 6, 24, 120, 720, 5040, 40320], "The factorial of 8 is 40320");
                assertEqual(vfactorial(9), [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880], "The factorial of 9 is 362880");
                assertEqual(vfactorial(10), [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800], "The factorial of 10 is 3628800");
            }
        }
        // test core/vector/vfactor()
        testModule("vfactor()", 4) {
            testUnit("no parameters", 1) {
                assertEqual(vfactor(), -1, "With no parameter whould produce -1");
            }
            testUnit("not array", 4) {
                assertEqual(vfactor(0), -1, "Zero should produce -1");
                assertEqual(vfactor(2), 1, "Non zero integer should produce 1");
                assertEqual(vfactor(""), -1, "Empty string should produce -1");
                assertEqual(vfactor("foo"), 1, "Not empty string should produce 1");
            }
            testUnit("empty array", 1) {
                assertEqual(vfactor([]), [], "And empty array should be returned");
            }
            testUnit("filled array", 3) {
                assertEqual(vfactor([0, 10, 15, 0]), [-1, 1, 1, -1], "Array of integers should produce array of -1 and 1");
                assertEqual(vfactor(["", "foo", "bar", ""]), [-1, 1, 1, -1], "Array of strings should produce array of -1 and 1");
                assertEqual(vfactor([[], [0], [1], []]), [-1, 1, 1, -1], "Array of arrays should produce array of -1 and 1");
            }
        }
        // test core/vector/vboolean()
        testModule("vboolean()", 4) {
            testUnit("no parameters", 1) {
                assertEqual(vboolean(), 0, "With no parameter whould produce 0");
            }
            testUnit("not array", 8) {
                assertEqual(vboolean(0), 0, "Zero should produce O if boolean type was not requested");
                assertEqual(vboolean(0, true), false, "Zero should produce false if boolean type was requested");
                assertEqual(vboolean(2), 1, "Non zero integer should produce 1 if boolean type was not requested");
                assertEqual(vboolean(2, true), true, "Non zero integer should produce true if boolean type was requested");
                assertEqual(vboolean(""), 0, "Empty string should produce 0 if boolean type was not requested");
                assertEqual(vboolean("", true), false, "Empty string should produce false if boolean type was requested");
                assertEqual(vboolean("foo"), 1, "Not empty string should produce 1 if boolean type was not requested");
                assertEqual(vboolean("foo", true), true, "Not empty string should produce true if boolean type was requested");
            }
            testUnit("empty array", 1) {
                assertEqual(vboolean([]), [], "And empty array should be returned");
            }
            testUnit("filled array", 6) {
                assertEqual(vboolean([0, 10, 15, 0]), [0, 1, 1, 0], "Array of integers should produce array of 0 and 1 if boolean type was not requested");
                assertEqual(vboolean([0, 10, 15, 0], true), [false, true, true, false], "Array of integers should produce array of false and true if boolean type was requested");
                assertEqual(vboolean(["", "foo", "bar", ""]), [0, 1, 1, 0], "Array of strings should produce array of 0 and 1 if boolean type was not requested");
                assertEqual(vboolean(["", "foo", "bar", ""], true), [false, true, true, false], "Array of strings should produce array of false and true if boolean type was requested");
                assertEqual(vboolean([[], [0], [1], []]), [0, 1, 1, 0], "Array of arrays should produce array of 0 and 1 if boolean type was not requested");
                assertEqual(vboolean([[], [0], [1], []], true), [false, true, true, false], "Array of arrays should produce array of false and true if boolean type was requested");
            }
        }
    }
}

testCoreVector();
