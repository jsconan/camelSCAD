/**
 * @license
 * MIT License
 *
 * Copyright (c) 2017-2019 Jean-Sebastien CONAN
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
 * Unit tests: Operations on strings.
 *
 * @package test/core/string
 * @author jsconan
 */
module testCoreString() {
    testPackage("core/string.scad", 8) {
        // test core/string/wrap()
        testModule("wrap()", 7) {
            testUnit("no parameters", 1) {
                assertEmptyString(wrap(), "Without parameters it should produce an empty string");
            }
            testUnit("empty parameters", 1) {
                assertEmptyString(wrap("", "", ""), "When the content is empty it should produce an empty string");
            }
            testUnit("prefix but no content", 1) {
                assertEmptyString(wrap("[", ""), "When the content is empty it should produce an empty string even if wrapper is provided");
            }
            testUnit("prefix and suffix but no content", 1) {
                assertEmptyString(wrap("[", "", "]"), "When the content is empty it should produce an empty string even if wrapper is provided");
            }
            testUnit("prefix only and content", 1) {
                assertEqual(wrap("[", "test"), "[test[", "Should return a wrapped string");
            }
            testUnit("prefix, suffix and content", 1) {
                assertEqual(wrap("[", "test", "]"), "[test]", "Should return a wrapped string");
            }
            testUnit("content without prefix or suffix", 1) {
                assertEqual(wrap(content="test"), "test", "Should return a string without wrapping");
            }
        }
        // test core/string/substr()
        testModule("substr()", 3) {
            testUnit("no parameters", 1) {
                assertEmptyString(substr(), "Without parameters it should produce an empty string");
            }
            testUnit("not string", 3) {
                assertEqual(substr(1, 0, 2), "1", "Number should be casted to string");
                assertEqual(substr(true, 0, 2), "tr", "Boolean should be casted to string");
                assertEqual(substr(["a", "b", "c"], 0, 2), "[\"", "Array should be casted to string");
            }
            testUnit("string", 8) {
                assertEqual(substr("this is a test"), "this is a test", "Should return the exact string if no boundaries are provided");
                assertEqual(substr("this is a test", 0, 1), "t", "Should return the first char of the string");
                assertEqual(substr("this is a test", 5), "is a test", "Should return the end of the string from the position if the length is not provided");
                assertEqual(substr("this is a test", length=7), "this is", "Should return the start of the string if only the length is provided");
                assertEqual(substr("this is a test", 5, 2), "is", "Should return the exact substring if position and length are provided");
                assertEqual(substr("this is a test", 5, 20), "is a test", "Should return the subtring up to the end if the request length is too big");
                assertEqual(substr("this is a test", -4), "test", "Should return the subtring from the end if the position is negative");
                assertEqual(substr("this is a test", 15), "", "Should return an empty string if the position is after the end");
            }
        }
        // test core/string/indexOf()
        testModule("indexOf()", 3) {
            testUnit("no parameters", 1) {
                assertEqual(indexOf(), -1, "Without parameters it should return -1");
            }
            testUnit("not string", 3) {
                assertEqual(indexOf(123, 2), 1, "Number should be casted to string");
                assertEqual(indexOf(true, true), 0, "Boolean should be casted to string");
                assertEqual(indexOf([1], [1]), 0, "Array should be casted to string");
            }
            testUnit("string", 6) {
                assertEqual(indexOf("foo", "bar"), -1, "Should not find an inexisting substring");
                assertEqual(indexOf("a fool is a fool", "foo"), 2, "Should find the first occurence of the substring");
                assertEqual(indexOf("a fool is a fool", "foo", 3), 12, "Should find the next occurence of the substring");
                assertEqual(indexOf("", "foo"), -1, "Cannot search in an empty string, it should return -1");
                assertEqual(indexOf("a fo", "foo"), -1, "When the seached substring is partially present, nothing should be found");
                assertEqual(indexOf("oo", "foo"), -1, "When the seached substring is partially present, nothing should be found");
            }
        }
        // test core/string/lastIndexOf()
        testModule("lastIndexOf()", 3) {
            testUnit("no parameters", 1) {
                assertEqual(lastIndexOf(), -1, "Without parameters it should return -1");
            }
            testUnit("not string", 3) {
                assertEqual(lastIndexOf(1, 1), 0, "Number should be casted to string");
                assertEqual(lastIndexOf(true, true), 0, "Boolean should be casted to string");
                assertEqual(lastIndexOf([1], [1]), 0, "Array should be casted to string");
            }
            testUnit("string", 6) {
                assertEqual(lastIndexOf("foo", "bar"), -1, "Should not find an inexisting substring");
                assertEqual(lastIndexOf("a fool is a fool", "foo"), 12, "Should find the last occurence of the substring");
                assertEqual(lastIndexOf("a fool is a fool", "foo", 11), 2, "Should find the next occurence of the substring");
                assertEqual(lastIndexOf("", "foo"), -1, "Cannot search in an empty string, it should return -1");
                assertEqual(lastIndexOf("a fo", "foo"), -1, "When the seached substring is partially present, nothing should be found");
                assertEqual(lastIndexOf("oo", "foo"), -1, "When the seached substring is partially present, nothing should be found");
            }
        }
        // test core/string/join()
        testModule("join()", 8) {
            testUnit("no parameters", 1) {
                assertEmptyString(join(), "Without parameters it should produce an empty string");
            }
            testUnit("empty parameters", 2) {
                assertEmptyString(join([]), "With an empty array, it should produce an empty string");
                assertEmptyString(join([], "-"), "With an empty array, it should produce an empty string even if a glue is provided");
            }
            testUnit("no glue and 2 terms", 1) {
                assertEqual(join(["1", "2"]), "12", "Should return a string without any glue");
            }
            testUnit("glue and 2 terms", 1) {
                assertEqual(join(["1", "2"], "-"), "1-2", "Should return a string with the provided glue between terms");
            }
            testUnit("no glue and 4 terms", 1) {
                assertEqual(join(["1", "2", "abc", "def"]), "12abcdef", "Should return a string without any glue");
            }
            testUnit("glue and 4 terms", 1) {
                assertEqual(join(["1", "2", "abc", "def"], "-"), "1-2-abc-def", "Should return a string with the provided glue between terms");
            }
            testUnit("no glue and string as array", 1) {
                assertEqual(join("123"), "123", "Should return a string without any glue");
            }
            testUnit("glue and string as array", 1) {
                assertEqual(join("123", "-"), "123", "String cannot be joined as it is already a string");
            }
        }
        // test core/string/split()
        testModule("split()", 3) {
            testUnit("no parameters", 1) {
                assertEmptyArray(split(), "Without parameters it should produce an empty Array");
            }
            testUnit("not string", 3) {
                assertEmptyArray(split(1, 1), "Cannot split a number, it should return an empty array");
                assertEmptyArray(split(true, true), "Cannot split a boolean, it should return an empty array");
                assertEmptyArray(split([1, 2, 3], 1), "Cannot split an array, it should return an empty array");
            }
            testUnit("string", 7) {
                assertEqual(split("", "e"), [""], "Should return an array containing the original string if the string is empty");
                assertEqual(split("abcd", "e"), ["abcd"], "Should not split the string if the separator was not found, it should return an array containing the original string");
                assertEqual(split("abcd", "a"), ["", "bcd"], "Should split the string even if the separator was found at first position");
                assertEqual(split("abcd", "d"), ["abc", ""], "Should split the string even if the separator was found at last position");
                assertEqual(split("foo;bar", ";"), ["foo", "bar"], "Should split the string if the separator was found at the middle");
                assertEqual(split("foo;bar;abc;def", ";"), ["foo", "bar", "abc", "def"], "Should split the string each time the separator is found");
                assertEqual(split("abcFOOdefFOOjkl", "FOO"), ["abc", "def", "jkl"], "Separator longer than 1 char should be allowed to split the string");
            }
        }
        // test core/string/replace()
        testModule("replace()", 3) {
            testUnit("no parameters", 1) {
                assertEmptyString(replace(), "Without parameters it should produce an empty string");
            }
            testUnit("not string", 3) {
                assertEqual(replace(123, 2, 3), "133", "Number should be casted to string");
                assertEqual(replace(true, true, false), "false", "Boolean should be casted to string");
                assertEqual(replace([1, 2, 3], 1, 2), "[2, 2, 3]", "Array should be casted to string");
            }
            testUnit("string", 10) {
                assertEqual(replace("abcd"), "abcd", "Should return the original string if there is nothing to replace");
                assertEqual(replace("abcd", "a", "b"), "bbcd", "Should replace the unique occurences of the subtring, at the start");
                assertEqual(replace("abcd", "b", "a"), "aacd", "Should replace the unique occurences of the subtring, at the middle");
                assertEqual(replace("baba", "b", "a"), "aaaa", "Should replace each occurences of the subtring");
                assertEqual(replace("a fool", "foo", "bar"), "a barl", "Should replace the unique occurences of the subtring");
                assertEqual(replace("abcd", "foo", "bar"), "abcd", "Should not replace inexisting occurences of the subtring");
                assertEqual(replace("", "foo", "bar"), "", "Should not replace anything in an empty string");
                assertEqual(replace("123", 1, 2), "223", "Numbers should be converted to string");
                assertEqual(replace("true", true, false), "false", "Booleans should be converted to string");
                assertEqual(replace("[1][2][3]", [1], [2]), "[2][2][3]", "Arrays should be converted to string");
            }
        }
        // test core/string/occurences()
        testModule("occurences()", 4) {
            testUnit("no parameters", 1) {
                assertEmptyArray(occurences(), "Without parameters it should return an empty array");
            }
            testUnit("not string", 3) {
                assertEqual(occurences(1, 1), [0], "Number should be casted to string");
                assertEqual(occurences(true, true), [0], "Boolean should be casted to string");
                assertEqual(occurences([1], [1]), [0], "Array should be casted to string");
            }
            testUnit("string", 6) {
                assertEmptyArray(occurences("foo", "bar"), "Should not find an inexisting substring");
                assertEqual(occurences("a fool is a fool", "foo"), [2, 12], "Should find all the occurences of the substring");
                assertEqual(occurences("aaaa", "a"), [0, 1, 2, 3], "Should find all the occurences of the substring");
                assertEmptyArray(occurences("", "foo"), "Cannot search in an empty string, it should return an empty array");
                assertEmptyArray(occurences("a fo", "foo"), "When the seached substring is partially present, nothing should be found");
                assertEmptyArray(occurences("oo", "foo"), "When the seached substring is partially present, nothing should be found");
            }
            testUnit("string reverse", 6) {
                assertEmptyArray(occurences("foo", "bar", true), "Should not find an inexisting substring");
                assertEqual(occurences("a fool is a fool", "foo", true), [12, 2], "Should find all the occurences of the substring");
                assertEqual(occurences("aaaa", "a", true), [3, 2, 1, 0], "Should find all the occurences of the substring");
                assertEmptyArray(occurences("", "foo", true), "Cannot search in an empty string, it should return an empty array");
                assertEmptyArray(occurences("a fo", "foo", true), "When the seached substring is partially present, nothing should be found");
                assertEmptyArray(occurences("oo", "foo", true), "When the seached substring is partially present, nothing should be found");
            }
        }
    }
}

testCoreString();
