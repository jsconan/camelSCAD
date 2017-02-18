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
 * Unit tests: Comparisons and boolean operations.
 *
 * @package test/core/logic
 * @author jsconan
 */
module testCoreLogic() {
    testPackage("core/logic.scad", 20) {
        // validate OpenSCAD native behaviour
        testModule("true/false", 4) {
            testUnit("undefined", 2) {
                assertFalse(message="implicit undefined");
                assertFalse(undef, "explicit undefined");
            }
            testUnit("string", 4) {
                assertFalse("", "empty string");
                assertTrue(" ", "not empty string (space)");
                assertTrue("0", "not empty string (0)");
                assertTrue("false", "not empty string (false)");
            }
            testUnit("array/vector", 3) {
                assertFalse([], "empty array/vector");
                assertTrue([0], "not empty vector");
                assertTrue([""], "not empty array");
            }
            testUnit("numeric", 6) {
                assertFalse(0, "zero integer");
                assertFalse(0.0, "zero float");
                assertTrue(1, "positive integer");
                assertTrue(-1, "negative integer");
                assertTrue(0.1, "positive float");
                assertTrue(-0.1, "negative float");
            }
        }
        // test core/logic/or()
        testModule("or()", 3) {
            testUnit("no parameters", 1) {
                assertUndef(or());
            }
            testUnit("only the first parameter", 2) {
                assertEqual(or("1st"), "1st", "Should return the first parameter as it is true");
                assertUndef(or(""), "Should return the second parameter, that is undefined, as the first is false");
            }
            testUnit("both parameters", 2) {
                assertEqual(or("1st", "2nd"), "1st", "Should return the first parameter as it is true");
                assertEqual(or("", "2nd"), "2nd", "Should return the second parameter as the first is false");
            }
        }
        // test core/logic/and()
        testModule("and()", 3) {
            testUnit("no parameters", 1) {
                assertUndef(and());
            }
            testUnit("only the first parameter", 2) {
                assertUndef(and("1st"), "Should return the second parameter as first is true");
                assertEqual(and(""), "", "Should return the first parameter as it is false");
            }
            testUnit("both parameters", 2) {
                assertEqual(and("1st", "2nd"), "2nd", "Should return the second parameter as the first is true");
                assertEqual(and("", "2nd"), "", "Should return the first parameter as it is false");
            }
        }
        // test core/logic/xor()
        testModule("xor()", 3) {
            testUnit("no parameters", 1) {
                assertFalse(xor());
            }
            testUnit("only the first parameter", 7) {
                assertFalse(xor(undef), "Should return `false` if the first parameter is undef and the second is missing");
                assertTrue(xor("1st"), "Should return `true` if the first parameter is provided and the second is missing, if the first is equivalent to `true`");
                assertFalse(xor(""), "Should return `false` if the first parameter is provided and the second is missing, if the first is equivalent to `false`");
                assertTrue(xor(1), "Should return `true` if the first parameter is provided and the second is missing, if the first is equivalent to `true`");
                assertFalse(xor(0), "Should return `false` if the first parameter is provided and the second is missing, if the first is equivalent to `false`");
                assertTrue(xor([1]), "Should return `true` if the first parameter is provided and the second is missing, if the first is equivalent to `true`");
                assertFalse(xor([]), "Should return `false` if the first parameter is provided and the second is missing, if the first is equivalent to `false`");
            }
            testUnit("both parameters", 9) {
                assertFalse(xor("1st", "2nd"), "Should return `false` when the paramaters have the same boolean meaning");
                assertFalse(xor("foo", "foo"), "Should return `false` when the paramaters have the same boolean meaning");
                assertTrue(xor("1st", ""), "Should return `true` when the paramaters do not have the same boolean meaning");

                assertFalse(xor(1, 2), "Should return `false` when the paramaters have the same boolean meaning");
                assertFalse(xor(3, 3), "Should return `false` when the paramaters have the same boolean meaning");
                assertTrue(xor(3, 0), "Should return `true` when the paramaters do not have the same boolean meaning");

                assertFalse(xor([1], [2]), "Should return `false` when the paramaters have the same boolean meaning");
                assertFalse(xor([3], [3]), "Should return `false` when the paramaters have the same boolean meaning");
                assertTrue(xor([0], []), "Should return `true` when the paramaters do not have the same boolean meaning");
            }
        }
        // test core/logic/uor()
        testModule("uor()", 3) {
            testUnit("no parameters", 1) {
                assertUndef(uor());
            }
            testUnit("only the first parameter", 3) {
                assertEqual(uor("1st"), "1st", "Should return the first parameter as it is defined");
                assertEqual(uor(""), "", "Should return the first parameter depspite it is false as the first is defined and second is missing");
                assertUndef(uor(undef), "Should return undefined as the first parameter is undefined and the second is missing");
            }
            testUnit("both parameters", 4) {
                assertEqual(uor("1st", "2nd"), "1st", "Should return the first parameter as it is defined");
                assertEqual(uor("", "2nd"), "", "Should return the first parameter, as it is defined despite it is false");
                assertEqual(uor(undef, ""), "", "Should return the second parameter, as the first is undefined");
                assertUndef(uor(undef, undef), "Should return undefined as both parameters are undefined");
            }
        }
        // test core/logic/uand()
        testModule("uand()", 3) {
            testUnit("no parameters", 1) {
                assertUndef(uand());
            }
            testUnit("only the first parameter", 3) {
                assertUndef(uand("1st"), "Should return undefined as the first parameter is defined and the second is missing");
                assertUndef(uand(""), "Should return undefined as the first parameter is defined (despite it is false) and the second is missing");
                assertUndef(uand(undef), "Should return undefined as the first parameter is undefined");
            }
            testUnit("both parameters", 4) {
                assertEqual(uand("1st", "2nd"), "2nd", "Should return the second parameter as both parameters are defined");
                assertEqual(uand("", "2nd"), "2nd", "Should return the second parameter, as the first is defined despite it is false");
                assertUndef(uand(undef, ""), "Should return the first parameter as it is undefined");
                assertUndef(uand(undef, undef), "Should return undefined as both parameters are undefined");
            }
        }
        // test core/logic/numberOr()
        testModule("numberOr()", 3) {
            testUnit("no parameter", 1) {
                assertUndef(numberOr());
            }
            testUnit("missing default", 5) {
                assertEqual(numberOr(1), 1);
                assertEqual(numberOr(3.14), 3.14);
                assertUndef(numberOr(false));
                assertUndef(numberOr(""));
                assertUndef(numberOr([1]));
            }
            testUnit("with default", 5) {
                assertEqual(numberOr(1, 2), 1);
                assertEqual(numberOr(3.14, 2), 3.14);
                assertEqual(numberOr(false, 2), 2);
                assertEqual(numberOr("", 2), 2);
                assertEqual(numberOr([1], 2), 2);
            }
        }
        // test core/logic/integerOr()
        testModule("integerOr()", 3) {
            testUnit("no parameter", 1) {
                assertUndef(integerOr());
            }
            testUnit("missing default", 5) {
                assertEqual(integerOr(1), 1);
                assertUndef(integerOr(3.14));
                assertUndef(integerOr(false));
                assertUndef(integerOr(""));
                assertUndef(integerOr([1]));
            }
            testUnit("with default", 5) {
                assertEqual(integerOr(1, 2), 1);
                assertEqual(integerOr(3.14, 2), 2);
                assertEqual(integerOr(false, 2), 2);
                assertEqual(integerOr("", 2), 2);
                assertEqual(integerOr([1], 2), 2);
            }
        }
        // test core/logic/booleanOr()
        testModule("booleanOr()", 3) {
            testUnit("no parameter", 1) {
                assertUndef(booleanOr());
            }
            testUnit("missing default", 5) {
                assertUndef(booleanOr(1));
                assertUndef(booleanOr(3.14));
                assertEqual(booleanOr(false), false);
                assertUndef(booleanOr(""));
                assertUndef(booleanOr([1]));
            }
            testUnit("with default", 5) {
                assertEqual(booleanOr(1, true), true);
                assertEqual(booleanOr(3.14, true), true);
                assertEqual(booleanOr(false, true), false);
                assertEqual(booleanOr("", true), true);
                assertEqual(booleanOr([1], true), true);
            }
        }
        // test core/logic/stringOr()
        testModule("stringOr()", 3) {
            testUnit("no parameter", 1) {
                assertUndef(stringOr());
            }
            testUnit("missing default", 5) {
                assertUndef(stringOr(1));
                assertUndef(stringOr(3.14));
                assertUndef(stringOr(false));
                assertEqual(stringOr(""), "");
                assertUndef(stringOr([1]));
            }
            testUnit("with default", 5) {
                assertEqual(stringOr(1, "foo"), "foo");
                assertEqual(stringOr(3.14, "foo"), "foo");
                assertEqual(stringOr(false, "foo"), "foo");
                assertEqual(stringOr("", "foo"), "");
                assertEqual(stringOr([1], "foo"), "foo");
            }
        }
        // test core/logic/arrayOr()
        testModule("arrayOr()", 3) {
            testUnit("no parameter", 1) {
                assertUndef(arrayOr());
            }
            testUnit("missing default", 5) {
                assertUndef(arrayOr(1));
                assertUndef(arrayOr(3.14));
                assertUndef(arrayOr(false));
                assertUndef(arrayOr(""));
                assertEqual(arrayOr(["1"]), ["1"]);
            }
            testUnit("with default", 5) {
                assertEqual(arrayOr(1, [2]), [2]);
                assertEqual(arrayOr(3.14, [2]), [2]);
                assertEqual(arrayOr(false, [2]), [2]);
                assertEqual(arrayOr("", [2]), [2]);
                assertEqual(arrayOr(["foo"], [2]), ["foo"]);
            }
        }
        // test core/logic/vectorOr()
        testModule("vectorOr()", 3) {
            testUnit("no parameter", 1) {
                assertUndef(vectorOr());
            }
            testUnit("missing default", 6) {
                assertUndef(vectorOr(1));
                assertUndef(vectorOr(3.14));
                assertUndef(vectorOr(false));
                assertUndef(vectorOr(""));
                assertUndef(vectorOr(["1"]));
                assertEqual(vectorOr([1]), [1]);
            }
            testUnit("with default", 6) {
                assertEqual(vectorOr(1, [2]), [2]);
                assertEqual(vectorOr(3.14, [2]), [2]);
                assertEqual(vectorOr(false, [2]), [2]);
                assertEqual(vectorOr("", [2]), [2]);
                assertEqual(vectorOr(["foo"], [2]), [2]);
                assertEqual(vectorOr([1], [2]), [1]);
            }
        }
        // test core/logic/vector2DOr()
        testModule("vector2DOr()", 3) {
            testUnit("no parameter") {
                assertUndef(vector2DOr(), 1);
            }
            testUnit("missing default", 7) {
                assertUndef(vector2DOr(1));
                assertUndef(vector2DOr(3.14));
                assertUndef(vector2DOr(false));
                assertUndef(vector2DOr(""));
                assertUndef(vector2DOr(["1"]));
                assertUndef(vector2DOr([1]));
                assertEqual(vector2DOr([1, 3]), [1, 3]);
            }
            testUnit("with default", 7) {
                assertEqual(vector2DOr(1, [2]), [2]);
                assertEqual(vector2DOr(3.14, [2]), [2]);
                assertEqual(vector2DOr(false, [2]), [2]);
                assertEqual(vector2DOr("", [2]), [2]);
                assertEqual(vector2DOr(["foo"], [2]), [2]);
                assertEqual(vector2DOr([1], [2]), [2]);
                assertEqual(vector2DOr([1, 3], [2]), [1, 3]);
            }
        }
        // test core/logic/vector3DOr()
        testModule("vector3DOr()", 3) {
            testUnit("no parameter", 1) {
                assertUndef(vector3DOr());
            }
            testUnit("missing default", 8) {
                assertUndef(vector3DOr(1));
                assertUndef(vector3DOr(3.14));
                assertUndef(vector3DOr(false));
                assertUndef(vector3DOr(""));
                assertUndef(vector3DOr(["1"]));
                assertUndef(vector3DOr([1]));
                assertUndef(vector3DOr([1, 3]));
                assertEqual(vector3DOr([1, 3, 5]), [1, 3, 5]);
            }
            testUnit("with default", 8) {
                assertEqual(vector3DOr(1, [2]), [2]);
                assertEqual(vector3DOr(3.14, [2]), [2]);
                assertEqual(vector3DOr(false, [2]), [2]);
                assertEqual(vector3DOr("", [2]), [2]);
                assertEqual(vector3DOr(["foo"], [2]), [2]);
                assertEqual(vector3DOr([1], [2]), [2]);
                assertEqual(vector3DOr([1, 3], [2]), [2]);
                assertEqual(vector3DOr([1, 3, 7], [2]), [1, 3, 7]);
            }
        }
        // test core/logic/allTrue()
        testModule("allTrue()", 6) {
            testUnit("no parameters", 1) {
                assertFalse(allTrue(), "Cannot be true with no parameters");
            }
            testUnit("not array", 4) {
                assertFalse(allTrue(0), "Zero should be considered as false");
                assertTrue(allTrue(1), "Non zero integer should be considered as true");
                assertFalse(allTrue(""), "Empty string should be considered as false");
                assertTrue(allTrue("foo"), "Not empty string should be considered as true");
            }
            testUnit("empty array", 1) {
                assertFalse(allTrue([]), "An empty array should be considered as false");
            }
            testUnit("array of integers", 5) {
                assertFalse(allTrue([0]), "Array containing a zero should be considered as false");
                assertTrue(allTrue([1]), "Array containing a non zero integer should be considered as true");
                assertFalse(allTrue([0, 1]), "Array containing mixed zero and non zero integers should be considered as false");
                assertFalse(allTrue([0, 0]), "Array containing only zero integers should be considered as false");
                assertTrue(allTrue([1, 1]), "Array containing only non zero integers should be considered as true");
            }
            testUnit("array of strings", 5) {
                assertFalse(allTrue([""]), "Array containing an empty string should be considered as false");
                assertTrue(allTrue(["foo"]), "Array containing a non empty string should be considered as true");
                assertFalse(allTrue(["", "foo"]), "Array containing mixed empty and non empty strings should be considered as false");
                assertFalse(allTrue(["", ""]), "Array containing only empty strings should be considered as false");
                assertTrue(allTrue(["foo", "bar"]), "Array containing only non empty strings should be considered as true");
            }
            testUnit("array of arrays", 5) {
                assertFalse(allTrue([[]]), "Array containing an empty array should be considered as false");
                assertTrue(allTrue([[0]]), "Array containing a non empty array should be considered as true");
                assertFalse(allTrue([[], [1]]), "Array containing mixed empty and non empty arrays should be considered as false");
                assertFalse(allTrue([[], []]), "Array containing only empty arrays should be considered as false");
                assertTrue(allTrue([[1], [1]]), "Array containing only non empty arrays should be considered as true");
            }
        }
        // test core/logic/allFalse()
        testModule("allFalse()", 6) {
            testUnit("no parameters", 1) {
                assertTrue(allFalse(), "Cannot be false with no parameters");
            }
            testUnit("not array", 4) {
                assertTrue(allFalse(0), "Zero should be considered as false");
                assertFalse(allFalse(1), "Non zero integer should be considered as true");
                assertTrue(allFalse(""), "Empty string should be considered as false");
                assertFalse(allFalse("foo"), "Not empty string should be considered as true");
            }
            testUnit("empty array", 1) {
                assertTrue(allFalse([]), "An empty array should be considered as false");
            }
            testUnit("array of integers", 5) {
                assertTrue(allFalse([0]), "Array containing a zero should be considered as false");
                assertFalse(allFalse([1]), "Array containing a non zero integer should be considered as true");
                assertFalse(allFalse([0, 1]), "Array containing mixed zero and non zero integers should be considered as true");
                assertTrue(allFalse([0, 0]), "Array containing only zero integers should be considered as false");
                assertFalse(allFalse([1, 1]), "Array containing only non zero integers should be considered as false");
            }
            testUnit("array of strings", 5) {
                assertTrue(allFalse([""]), "Array containing an empty string should be considered as false");
                assertFalse(allFalse(["foo"]), "Array containing a non empty string should be considered as true");
                assertFalse(allFalse(["", "foo"]), "Array containing mixed empty and non empty strings should be considered as true");
                assertTrue(allFalse(["", ""]), "Array containing only empty strings should be considered as false");
                assertFalse(allFalse(["foo", "bar"]), "Array containing only non empty strings should be considered as true");
            }
            testUnit("array of arrays", 5) {
                assertTrue(allFalse([[]]), "Array containing an empty array should be considered as false");
                assertFalse(allFalse([[0]]), "Array containing a non empty array should be considered as true");
                assertFalse(allFalse([[], [1]]), "Array containing mixed empty and non empty arrays should be considered as true");
                assertTrue(allFalse([[], []]), "Array containing only empty arrays should be considered as false");
                assertFalse(allFalse([[1], [1]]), "Array containing only non empty arrays should be considered as true");
            }
        }
        // test core/logic/allSame()
        testModule("allSame()", 5) {
            testUnit("no parameters", 1) {
                assertTrue(allSame());
            }
            testUnit("not array", 4) {
                assertTrue(allSame(0), "Zero should be considered as an array of 1, and therefore should be true");
                assertTrue(allSame(1), "Non zero integer should be considered as an array of 1, and therefore should be true");
                assertTrue(allSame(""), "Empty string should be considered as an array of 1, and therefore should be true");
                assertTrue(allSame("foo"), "Not empty string should be considered as an array of 1, and therefore should be true");
            }
            testUnit("empty array", 1) {
                assertTrue(allSame([]), "Empty array should be true");
            }
            testUnit("array filled with same values", 6) {
                assertTrue(allSame([0]), "Array containing a zero should be true");
                assertTrue(allSame([0, 0]), "Array containing several zerosshould be true");
                assertTrue(allSame([[]]), "Array containing an array should be true");
                assertTrue(allSame([[], []]), "Array containing several equal arraysshould be true");
                assertTrue(allSame(["1"]), "Array containing a string should be true");
                assertTrue(allSame(["1", "1"]), "Array containing several equal strings should be true");
            }
            testUnit("array filled with different values", 3) {
                assertFalse(allSame([0, 1]), "Array containing several different integers should be false");
                assertFalse(allSame([[1], [2]]), "Array containing several different arrays should be false");
                assertFalse(allSame(["1", "2"]), "Array containing several different strings should be false");
            }
        }
        // test core/logic/between()
        testModule("between()", 3) {
            testUnit("no parameters", 1) {
                assertTrue(between(), "Undef parameters should be assumed to 0");
            }
            testUnit("not numbers", 9) {
                assertTrue(between("1", "0", "3"), "Strings should be assumed to 0");
                assertFalse(between("1", 2, 3), "Strings should be assumed to 0");
                assertFalse(between(1, "2", "3"), "Strings should be assumed to 0");
                assertTrue(between(true, false, true), "Booleans should be assumed to 0");
                assertFalse(between(true, 2, 3), "Booleans should be assumed to 0");
                assertFalse(between(1, false, true), "Booleans should be assumed to 0");
                assertTrue(between([1], [0], [2]), "Arrays should be assumed to 0");
                assertFalse(between([1], 2, 3), "Arrays should be assumed to 0");
                assertFalse(between(1, [0], [2]), "Arrays should be assumed to 0");
            }
            testUnit("numbers", 6) {
                assertTrue(between(1, 0, 2), "In range");
                assertTrue(between(1, 1, 2), "Match the lowest");
                assertTrue(between(2, 1, 2), "Match the highest");
                assertFalse(between(-1, 0, 2), "Out of range, below the lowest");
                assertFalse(between(3, 0, 2), "Out of range, above the highest");
                assertTrue(between(1, 2, 0), "Inverted range");
            }
        }
        // test core/logic/contains()
        testModule("contains()", 4) {
            testUnit("no parameters", 1) {
                assertFalse(contains(), "Nothing to check");
            }
            testUnit("not array", 6) {
                assertFalse(contains(0), "Number is not an array");
                assertFalse(contains(1), "Number is not an array");
                assertFalse(contains(""), "String is not an array");
                assertFalse(contains("foo"), "String is not an array");
                assertFalse(contains(true), "Boolean is not an array");
                assertFalse(contains(false), "Boolean is not an array");
            }
            testUnit("empty array", 9) {
                assertFalse(contains([]), "An empty array cannot contain anything");
                assertFalse(contains([], 0), "An empty array cannot contain anything");
                assertFalse(contains([], 1), "An empty array cannot contain anything");
                assertFalse(contains([], false), "An empty array cannot contain anything");
                assertFalse(contains([], true), "An empty array cannot contain anything");
                assertFalse(contains([], ""), "An empty array cannot contain anything");
                assertFalse(contains([], "1"), "An empty array cannot contain anything");
                assertFalse(contains([], []), "An empty array cannot contain anything");
                assertFalse(contains([], [1]), "An empty array cannot contain anything");
            }
            testUnit("not empty array", 13) {
                assertFalse(contains([1, 2]), "Nothing to search");
                assertFalse(contains(["", "foo"]), "Nothing to search");
                assertFalse(contains([[], [1]]), "Nothing to search");
                assertFalse(contains([false, true]), "Nothing to search");
                assertFalse(contains([1, 2], 0), "The number is not contained");
                assertTrue(contains([3, 2, 1], 1), "The number is contained");
                assertTrue(contains([3, 2, 1], 3), "The number is contained");
                assertFalse(contains(["foo", "bar"], "abc"), "The string is not contained");
                assertTrue(contains(["foo", "bar"], "foo"), "The string is contained");
                assertFalse(contains([true, true], false), "The boolean is not contained");
                assertTrue(contains([true, true], true), "The boolean is contained");
                assertFalse(contains([[1], [2], []], [1, 2]), "The array is not contained");
                assertTrue(contains([[1, 2], [2, 3], []], [1, 2]), "The array is contained");
            }
        }
        // test core/logic/approx()
        testModule("approx()", 3) {
            testUnit("no parameters", 1) {
                assertTrue(approx(), "Nothing to check");
            }
            testUnit("different", 6) {
                assertFalse(approx(1, 2), "1 is not approximately equal to 2");
                assertFalse(approx(1, -1), "1 is not approximately equal to -1");
                assertFalse(approx(true, false), "true is not approximately equal to false");
                assertFalse(approx("foo", "bar"), "foo is not approximately equal to bar");
                assertFalse(approx([1], [2]), "[1] is not approximately equal to [2]");
                assertFalse(approx([[1, 1, 2, 2, 3, 3]], [[1, 2, 3, 4, 5, 6]]), "Different arrays are not approximately equal");
            }
            testUnit("equal", 13) {
                assertTrue(approx(1, 1), "1 is equal to 1");
                assertTrue(approx(true, true), "true is equal to true");
                assertTrue(approx(false, false), "false is equal to false");
                assertTrue(approx("foo", "foo"), "foo is equal to foo");
                assertTrue(approx(1, 1.0000000000001), "1 is approximately equal to 1.0000000000001");
                assertTrue(approx(1, 0.9999999999999), "1 is approximately equal to 0.9999999999999");
                assertTrue(approx([1], [1]), "[1] is equal to [1]");
                assertTrue(approx([1], [1]), "[1] is approximately equal to [1]");
                assertTrue(approx([1], [1.0000000000001]), "[1] is approximately equal to [1.0000000000001]");
                assertTrue(approx([[1]], [[1.0000000000001]]), "[[1]] is approximately equal to [[1.0000000000001]]");
                assertTrue(approx([1, 2], [1.0000000000001, 1.9999999999999999]), "[1, 2] is approximately equal to [1.0000000000001, 1.9999999999999999]");
                assertTrue(approx([[1, 2], [3, 4]], [[1.0000000000001, 1.9999999999999999], [3.00000000000000000000002, 4.000000000000001]]), "[[1, 2], [3, 4]] is approximately equal to [[1.0000000000001, 1.9999999999999999], [3.00000000000000000000002, 4.000000000000001]]");
                assertTrue(approx(
                    [[1, 2], [3, 4], [5, 6], [7, 8], [9, 10]],
                    [[1.0000000000001, 1.9999999999999999], [3.00000000000000000000002, 4.000000000000001],[5.0000000000001, 5.9999999999999999],[7.00000000000000000000002, 8.000000000000001],[9.0000000000001, 9.9999999999999999]]),
                    "Arrays that contains similar values are approximately equal"
                );
            }
        }
    }
}

testCoreLogic();
