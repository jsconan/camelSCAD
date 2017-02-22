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
 * Unit tests: Operations on lists.
 *
 * @package test/core/list
 * @author jsconan
 */
module testCoreList() {
    testPackage("core/list.scad", 18) {
        // test core/list/fill()
        testModule("fill()", 4) {
            testUnit("no parameter", 1) {
                assertEmptyArray(fill(), "Without parameters it should produce an empty array");
            }
            testUnit("missing length", 1) {
                assertEmptyArray(fill(1), "Without the length it should produce an empty array");
            }
            testUnit("not a number length", 3) {
                assertEmptyArray(fill(1, true), "The length should be a number not a boolean");
                assertEmptyArray(fill(1, "1"), "The length should be a number not a string");
                assertEmptyArray(fill(1, [1]), "The length should be a number not an array");
            }
            testUnit("number length", 7) {
                assertEmptyArray(fill(1, 0), "With 0 as length it should produce an empty array");
                assertEmptyArray(fill(1, -2), "With a negative value as length it should produce an empty array");
                assertEqual(fill(1, 1), [1], "Should produce a vector filled with 1 and a length of 1");
                assertEqual(fill(3, 5), [3, 3, 3, 3, 3], "Should produce a vector filled with 3 and a length of 5");
                assertEqual(fill("10", 1), ["10"], "Should produce an array filled with \"10\" and a length of 1");
                assertEqual(fill("foo", 5), ["foo", "foo", "foo", "foo", "foo"], "Should produce an array filled with \"foo\" and a length of 5");
                assertEqual(fill([1, 2], 3), [[1, 2], [1, 2], [1, 2]], "Should produce an array filled with [1, 2] and a length of 3");
            }
        }
        // test core/list/range()
        testModule("range()", 5) {
            testUnit("no parameter", 1) {
                assertEmptyArray(range(), "Without parameters it should produce an empty array");
            }
            testUnit("not numbers", 9) {
                assertEmptyArray(range("1"), "Range boundaries should be numbers not single string");
                assertEmptyArray(range("1", "10", "2"), "Range boundaries should be numbers not strings");
                assertEmptyArray(range(true), "Range boundaries should be numbers not single boolean");
                assertEmptyArray(range(false, true, true), "Range boundaries should be numbers not booleans");
                assertEmptyArray(range([1]), "Range boundaries should be numbers not single vector");
                assertEmptyArray(range([0], [10], [2]), "Range boundaries should be numbers not vectors");
                assertEqual(range(0, 2, true), [0, 1, 2], "The step should be a number, otherwise it should be forced to 1 if boolean");
                assertEqual(range(0, 2, "2"), [0, 1, 2], "The step should be a number, otherwise it should be forced to 1 if string");
                assertEqual(range(0, 2, [2]), [0, 1, 2], "The step should be a number, otherwise it should be forced to 1 if vector");
            }
            testUnit("no step", 4) {
                assertEmptyArray(range(0, 0), "When the range is 0 it should produce an empty array");
                assertEqual(range(0, 2), [0, 1, 2], "The step should be forced to 1 if missing and start > end");
                assertEqual(range(2, 0), [2, 1, 0], "The step should be forced to -1 if missing and end > start");
                assertEqual(range(0, 2, 0), [0, 1, 2], "The step should be forced to 1 if 0");
            }
            testUnit("step", 9) {
                assertEmptyArray(range(0, 0, 1), "When the range is 0 it should produce an empty array, even if step is provided");
                assertEmptyArray(range(2, 0, 1), "Should produce an empty array when the range is negative and the step positive");
                assertEmptyArray(range(0, 2, -1), "Should produce an empty array when the range is positive and the step negative");
                assertEqual(range(0, 2, 1), [0, 1, 2], "Step is 1");
                assertEqual(range(2, 0, -1), [2, 1, 0], "Step is -1");
                assertEqual(range(0, 9, 2), [0, 2, 4, 6, 8], "Step is 2, and start is 0");
                assertEqual(range(1, 9, 2), [1, 3, 5, 7, 9], "Step is 2, and start is 1");
                assertEqual(range(0, 9, 3), [0, 3, 6, 9], "Step is 3");
                assertEqual(range(0, 9, 4), [0, 4, 8], "Step is 4");
            }
            testUnit("simple range", 3) {
                assertEmptyArray(range(0), "When the range is 0 it should produce an empty array");
                assertEqual(range(3), [0, 1, 2, 3], "Range of 3");
                assertEqual(range(-3), [0, -1, -2, -3], "Range of -3");
            }
        }
        // test core/list/steps()
        testModule("steps()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(steps(), [0:0:0], "Should return a null range");
            }
            testUnit("wrong types", 3) {
                assertEqual(steps(true, false, true), [0:0:0], "Cannot build a range from booleans, should return a null range");
                assertEqual(steps("1", "1", "2"), [0:0:0], "Cannot build a range from strings, should return a null range");
                assertEqual(steps([1], [1], [2]), [0:0:0], "Cannot build a range from vectors, should return a null range");
            }
            testUnit("number", 5) {
                assertEqual(steps(0, 2, 10), [0:10:10], "Should build the range [0:10:10]");
                assertEqual(steps(0, 3, 10), [0:5:10], "Should build the range [0:5:10]");
                assertEqual(steps(10, 3, 0), [10:-5:0], "Should build the range [10:-5:0]");
                assertEqual(steps(end=18, count=4), [0:6:18], "Should build the range [0:6:18]");
                assertEqual(steps(end=-18, count=4), [0:-6:-18], "Should build the range [0:-6:-18]");
            }
        }
        // test core/list/flatten()
        testModule("flatten()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(flatten(), "Without parameters it should produce an empty array");
            }
            testUnit("not array", 3) {
                assertEmptyArray(flatten(1), "Cannot flatten a number, it should produce an empty array");
                assertEmptyArray(flatten("foo"), "Cannot flatten a string, it should produce an empty array");
                assertEmptyArray(flatten(true), "Cannot flatten a boolean, it should produce an empty array");
            }
            testUnit("array", 5) {
                assertEqual(flatten([1, 2, 3]), [1, 2, 3], "An already flat vector cannot be flattened more");
                assertEqual(flatten(["foo", "bar"]), ["foo", "bar"], "An already flat array of strings cannot be flattened more");
                assertEqual(flatten([[1, 2, 3], [4, 5, 6]]), [1, 2, 3, 4, 5, 6], "Should flatten an array of vectors to a vector");
                assertEqual(flatten([["foo", "abc"], ["bar", "cde"]]), ["foo", "abc", "bar", "cde"], "Should flatten an array of arrays to an array");
                assertEqual(flatten([[[1, 2], 3], [[4, 5], 6]]), [[1, 2], 3, [4, 5], 6], "Should only flatten the first level of a multi-dimensional array of vectors");
            }
        }
        // test core/list/reverse()
        testModule("reverse()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(reverse(), "Without parameters it should produce an empty array");
            }
            testUnit("not array", 3) {
                assertEmptyArray(reverse(1), "Cannot reverse a number, it should produce an empty array");
                assertEmptyArray(reverse("foo"), "Cannot reverse a string, it should produce an empty array");
                assertEmptyArray(reverse(true), "Cannot reverse a boolean, it should produce an empty array");
            }
            testUnit("array", 4) {
                assertEqual(reverse([1, 2, 3]), [3, 2, 1], "The vector should be reversed");
                assertEqual(reverse(["foo", "bar"]), ["bar", "foo"], "The array should be reversed");
                assertEqual(reverse([1]), [1], "Should return the vector");
                assertEqual(reverse(["foo"]), ["foo"], "Should return the array");
            }
        }
        // test core/list/find()
        testModule("find()", 6) {
            testUnit("no parameter", 1) {
                assertEqual(find(), -1, "Cannot find in an undefined value, should return -1");
            }
            testUnit("not array", 6) {
                assertEqual(find(1), -1, "Cannot find in a number, should return -1");
                assertEqual(find(1, 1), -1, "Cannot find in a number, should return -1");

                assertEqual(find(true), -1, "Cannot find in a boolean, should return -1");
                assertEqual(find(true, true), -1, "Cannot find in a boolean, should return -1");

                assertEqual(find("abc"), -1, "Cannot find in a string, should return -1");
                assertEqual(find("abc", "a"), -1, "Cannot find in a string, should return -1");
            }
            testUnit("array but nothing to search", 5) {
                assertEqual(find([0, 1, 2]), -1, "Nothing to search for, should return -1");
                assertEqual(find(["1", "2"]), -1, "Nothing to search for, should return -1");
                assertEqual(find([false, true]), -1, "Nothing to search for, should return -1");
                assertEqual(find([]), -1, "Nothing to search for, should return -1");
                assertEqual(find([[1]]), -1, "Nothing to search for, should return -1");
            }
            testUnit("simple array and key", 4) {
                assertEqual(find([1, 2, 3], 2), 1, "Should find the index of 2, should return 1");
                assertEqual(find([1, 2, 3], 4), -1, "Should not find the index of 4, should return -1");
                assertEqual(find(["3", "4", "5", "2"], "2"), 3, "Should find the index of '2', should return 3");
                assertEqual(find(["3", "4", "5", "2"], "6"), -1, "Should not find the index of '6', should return -1");
            }
            testUnit("collection and string key", 10) {
                map = [
                    ["key1", 10],
                    ["key2", 20],
                    ["key3", 30]
                ];
                assertEqual(find(map, 0), -1, "The key 0 should not exists, should return -1");
                assertEqual(find(map, 1), -1, "The key 1 should not exists, should return -1");
                assertEqual(find(map, 2), -1, "The key 2 should not exists, should return -1");
                assertEqual(find(map, 3), -1, "The key 3 should not exists, should return -1");
                assertEqual(find(map, 4), -1, "The key 4 should not exists, should return -1");
                assertEqual(find(map, "key"), -1, "The key 'key' should not exists, should return -1");
                assertEqual(find(map, "key1"), 0, "The key 'key1' should exist, should return 0");
                assertEqual(find(map, "key2"), 1, "The key 'key2' should exist, should return 1");
                assertEqual(find(map, "key3"), 2, "The key 'key3' should exist, should return 2");
                assertEqual(find(map, "key4"), -1, "The key 'key4' should not exist, should return -1");
            }
            testUnit("collection and numeric key", 10) {
                map = [
                    [1, 10],
                    [2, 20],
                    [3, 30]
                ];
                assertEqual(find(map, 0), -1, "The key 0 should not exists, should return -1");
                assertEqual(find(map, 1), 0, "The key 1 should exists, should return 0");
                assertEqual(find(map, 2), 1, "The key 2 should exists, should return 1");
                assertEqual(find(map, 3), 2, "The key 3 should exists, should return 2");
                assertEqual(find(map, 4), -1, "The key 4 should not exists, should return -1");
                assertEqual(find(map, "key"), -1, "The key 'key' should not exists, should return -1");
                assertEqual(find(map, "key1"), -1, "The key 'key1' should not exist, should return -1");
                assertEqual(find(map, "key2"), -1, "The key 'key2' should not exist, should return -1");
                assertEqual(find(map, "key3"), -1, "The key 'key3' should not exist, should return -1");
                assertEqual(find(map, "key4"), -1, "The key 'key4' should not exist, should return -1");
            }
        }
        // test core/list/fetch()
        testModule("fetch()", 6) {
            testUnit("no parameter", 1) {
                assertUndef(fetch(), "Cannot fetch in an undefined value, should return undef");
            }
            testUnit("not array", 6) {
                assertUndef(fetch(1), "Cannot fetch in a number, should return undef");
                assertUndef(fetch(1, 1), "Cannot fetch in a number, should return undef");

                assertUndef(fetch(true), "Cannot fetch in a boolean, should return undef");
                assertUndef(fetch(true, true), "Cannot fetch in a boolean, should return undef");

                assertUndef(fetch("abc"), "Cannot fetch in a string, should return undef");
                assertUndef(fetch("abc", "a"), "Cannot fetch in a string, should return undef");
            }
            testUnit("array but nothing to search", 5) {
                assertUndef(fetch([0, 1, 2]), "Nothing to search for, should return undef");
                assertUndef(fetch(["1", "2"]), "Nothing to search for, should return undef");
                assertUndef(fetch([false, true]), "Nothing to search for, should return undef");
                assertUndef(fetch([]), "Nothing to search for, should return undef");
                assertUndef(fetch([[1]]), "Nothing to search for, should return undef");
            }
            testUnit("simple array and key", 4) {
                assertEqual(fetch([1, 2, 3], 2), 2, "Should fetch the record at index of 2");
                assertUndef(fetch([1, 2, 3], 4), "Should not fetch the record at index of 4");
                assertEqual(fetch(["3", "4", "5", "2"], "2"), "2", "Should fetch the record at index of '2'");
                assertUndef(fetch(["3", "4", "5", "2"], "6"), "Should not fetch the record at index of '6'");
            }
            testUnit("collection and string key", 10) {
                map = [
                    ["key1", 10],
                    ["key2", 20],
                    ["key3", 30]
                ];
                assertUndef(fetch(map, 0), "The key 0 should not exists, should return undef");
                assertUndef(fetch(map, 1), "The key 1 should not exists, should return undef");
                assertUndef(fetch(map, 2), "The key 2 should not exists, should return undef");
                assertUndef(fetch(map, 3), "The key 3 should not exists, should return undef");
                assertUndef(fetch(map, 4), "The key 4 should not exists, should return undef");
                assertUndef(fetch(map, "key"), "The key 'key' should not exists, should return undef");
                assertEqual(fetch(map, "key1"), ["key1", 10], "The key 'key1' should exist");
                assertEqual(fetch(map, "key2"), ["key2", 20], "The key 'key2' should exist");
                assertEqual(fetch(map, "key3"), ["key3", 30], "The key 'key3' should exist");
                assertUndef(fetch(map, "key4"), "The key 'key4' should not exist, should return undef");
            }
            testUnit("collection and numeric key", 10) {
                map = [
                    [1, 10],
                    [2, 20],
                    [3, 30]
                ];
                assertUndef(fetch(map, 0), "The key 0 should not exists, should return undef");
                assertEqual(fetch(map, 1), [1, 10], "The key 1 should exists");
                assertEqual(fetch(map, 2), [2, 20], "The key 2 should exists");
                assertEqual(fetch(map, 3), [3, 30], "The key 3 should exists");
                assertUndef(fetch(map, 4), "The key 4 should not exists, should return undef");
                assertUndef(fetch(map, "key"), "The key 'key' should not exists, should return undef");
                assertUndef(fetch(map, "key1"), "The key 'key1' should not exist, should return undef");
                assertUndef(fetch(map, "key2"), "The key 'key2' should not exist, should return undef");
                assertUndef(fetch(map, "key3"), "The key 'key3' should not exist, should return undef");
                assertUndef(fetch(map, "key4"), "The key 'key4' should not exist, should return undef");
            }
        }
        // test core/list/inArray()
        testModule("inArray()", 3) {
            testUnit("no parameter", 1) {
                assertFalse(inArray(), "Cannot search in an undefined value, should return false");
            }
            testUnit("not array", 3) {
                assertFalse(inArray(1, 1), "Cannot search in a number, should return false");
                assertFalse(inArray("1", "1"), "Cannot search in a string, should return false");
                assertFalse(inArray(true, true), "Cannot search in a boolean, should return false");
            }
            testUnit("array", 5) {
                assertFalse(inArray([], 1), "With an empty array should return false");
                assertTrue(inArray([1], 1), "The element 1 should exist in the array");
                assertTrue(inArray([1, 2, 3, 4, 5], 3), "The element 3 should exist in the array");
                assertFalse(inArray([1, 2, 3, 4, 5], 6), "The element 6 should not exist in the array");
                assertFalse(inArray([1, 2, 3, 4, 5], "2"), "The element \"2\" should not exist in the array");
            }
        }
        // test core/list/complete()
        testModule("complete()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(complete(), [], "Cannot complete an inexistin list, should return an empty array");
            }
            testUnit("wrong type", 4) {
                assertEqual(complete("1"), [], "Cannot complete a string, should return an empty array");
                assertEqual(complete(true), [], "Cannot complete a boolean, should return an empty array");
                assertEqual(complete("1", "foo", "bar"), ["foo", "bar"], "Cannot complete a string, but should return an array containing the provided start and end points");
                assertEqual(complete(true, true, false), [true], "Cannot complete a boolean, but should return an array containing the provided start and end points");
            }
            testUnit("array", 5) {
                assertEqual(complete([], 1, 2), [1, 2], "Should accept numbers as elements");
                assertEqual(complete([], [1, 0], [2, 3]), [[1, 0], [2, 3]], "Should accept vectors as elements");
                assertEqual(complete([[1, 0], [5, 7], [2, 3]], [1, 0], [2, 3]), [[1, 0], [5, 7], [2, 3]], "Should not complete the elements if start and end are already there");
                assertEqual(complete([[5, 7], [2, 3]], [1, 0], [2, 3]), [[1, 0], [5, 7], [2, 3]], "Should only complete the elements if start and end are not already there (missing start)");
                assertEqual(complete([[1, 0], [5, 7]], [1, 0], [2, 3]), [[1, 0], [5, 7], [2, 3]], "Should only complete the elements if start and end are not already there (missing end)");
            }
        }
        // test core/list/slice()
        testModule("slice()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(slice(), "Parameters are needed to produce a sliced array, otherwise return []");
            }
            testUnit("not array", 3) {
                assertEmptyArray(slice(1, 1, 1), "Cannot slice a number, should return []");
                assertEmptyArray(slice("123", 1, 2), "Cannot slice a string, should return []");
                assertEmptyArray(slice(true, false, true), "Cannot slice a boolean, should return []");
            }
            testUnit("array", 10) {
                assertEqual(slice([1, 2, 3, 4, 5]), [1, 2, 3, 4, 5], "Without the boundaries it should return the full array");
                assertEqual(slice([1, 2, 3, 4, 5], 2), [3, 4, 5], "When only the start boundary is provided it should return all elements from the start boundary");
                assertEqual(slice([1, 2, 3, 4, 5], 1, 3), [2, 3], "When only both boundaries are provided it should return the elements in the range");
                assertEqual(slice([1, 2, 3, 4, 5], -2), [4, 5], "When only the start boundary is provided as negative value it should return the lasts elements from length - start");
                assertEqual(slice([1, 2, 3, 4, 5], end=3), [1, 2, 3], "When only the end boundary is provided it should return all elements till the end boundary");
                assertEqual(slice([1, 2, 3, 4, 5], end=-2), [1, 2, 3], "When only the end boundary is provided as negative value it should return all elements till length - end");
                assertEqual(slice([1, 2, 3, 4, 5], -3, -2), [3], "When only both boundaries are provided as negative values it should return all elements within the range of [length - start, length - end]");
                assertEqual(slice([1, 2, 3, 4, 5], 1, 20), [2, 3, 4, 5], "When the end boundary is longer than the length it should return all elements till the length is reached");
                assertEqual(slice([1, 2, 3, 4, 5], 10), [], "When the start boundary is longer than the length it should return an empty array");
                assertEqual(slice([1], end=-1), [], "When the end boundary is leser than the start it should return an empty array");
            }
        }
        // test core/list/first()
        testModule("first()", 3) {
            testUnit("no parameter", 1) {
                assertUndef(first(), "Without parameter it should return undef");
            }
            testUnit("not array", 3) {
                assertUndef(first(1), "Cannot return the first element of a number, it should return undef");
                assertUndef(first("123"), "Cannot return the first element of a string, it should return undef");
                assertUndef(first(true), "Cannot return the first element of a boolean, it should return undef");
            }
            testUnit("array", 7) {
                assertUndef(first([]), "Cannot return the first element of an empty array, it should return undef");
                assertEqual(first([1]), 1, "Should return the first element of an array, if the length is at least 1");
                assertEqual(first([1, 2, 3]), 1, "Should return the first element of a vector");
                assertEqual(first(["abc", "def"]), "abc", "Should return the first element of an array");
                assertEqual(first([1, 2, 3, 4, 5], 2), [1, 2], "Should return the N first elements of a vector, if the length is greater or equal");
                assertEqual(first(["abc", "def", "ghi", "jkl"], 2), ["abc", "def"], "Should return the N first elements of an array, if the length is greater or equal");
                assertEqual(first([1, 2], 3), [1, 2], "Should return the N first elements of a vector, up to the length if N is greater");
            }
        }
        // test core/list/last()
        testModule("last()", 3) {
            testUnit("no parameter", 1) {
                assertUndef(last(), "Without parameter it should return undef");
            }
            testUnit("not array", 3) {
                assertUndef(last(1), "Cannot return the last element of a number, it should return undef");
                assertUndef(last("123"), "Cannot return the last element of a string, it should return undef");
                assertUndef(last(true), "Cannot return the last element of a boolean, it should return undef");
            }
            testUnit("array", 7) {
                assertUndef(last([]), "Cannot return the last element of an empty array, it should return undef");
                assertEqual(last([1]), 1, "Should return the last element of an array, if the length is at least 1");
                assertEqual(last([1, 2, 3]), 3, "Should return the last element of a vector");
                assertEqual(last(["abc", "def"]), "def", "Should return the last element of an array");
                assertEqual(last([1, 2, 3, 4, 5], 2), [4, 5], "Should return the N last elements of a vector, if the length is greater or equal");
                assertEqual(last(["abc", "def", "ghi", "jkl"], 2), ["ghi", "jkl"], "Should return the N last elements of an array, if the length is greater or equal");
                assertEqual(last([1, 2], 3), [1, 2], "Should return the N last elements of a vector, up to the length if N is greater");
            }
        }
        // test core/list/pop()
        testModule("pop()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(pop(), "Without parameter it should return an empty array");
            }
            testUnit("not array", 3) {
                assertEmptyArray(pop(1), "Cannot slice a number, it should return an empty array");
                assertEmptyArray(pop("123"), "Cannot slice a string, it should return an empty array");
                assertEmptyArray(pop(true), "Cannot slice a boolean, it should return an empty array");
            }
            testUnit("array", 4) {
                assertEqual(pop([]), [], "Cannot slice an empty array");
                assertEqual(pop([1]), [], "If the array has a length of 1, it should return an empty array");
                assertEqual(pop([1, 2]), [1], "Should return the remaining part of the array after pop");
                assertEqual(pop([1, 2, 3]), [1, 2], "Should return the remaining part of the array after pop");
            }
        }
        // test core/list/shift()
        testModule("shift()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(shift(), "Without parameter it should return an empty array");
            }
            testUnit("not array", 3) {
                assertEmptyArray(shift(1), "Cannot slice a number, it should return an empty array");
                assertEmptyArray(shift("123"), "Cannot slice a string, it should return an empty array");
                assertEmptyArray(shift(true), "Cannot slice a boolean, it should return an empty array");
            }
            testUnit("array", 4) {
                assertEqual(shift([]), [], "Cannot slice an empty array");
                assertEqual(shift([1]), [], "If the array has a length of 1, it should return an empty array");
                assertEqual(shift([1, 2]), [2], "Should return the remaining part of the array after shift");
                assertEqual(shift([1, 2, 3]), [2, 3], "Should return the remaining part of the array after shift");
            }
        }
        // test core/list/push()
        testModule("push()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(push(), [undef], "Without parameter it should return an array containing an undef");
            }
            testUnit("not array", 3) {
                assertEqual(push(1, 1), [1], "Cannot add element to a number, should return an array that only contains the added element");
                assertEqual(push("123", "a"), ["a"], "Cannot add element to a string, should return an array that only contains the added element");
                assertEqual(push(true, false), [false], "Cannot add element to a boolean, should return an array that only contains the added element");
            }
            testUnit("array", 5) {
                assertEqual(push([]), [undef], "An element to add should be provided, otherwise an undef will be pushed");
                assertEqual(push([], 1), [1], "An empty array becomes an array with one element");
                assertEqual(push([1, 2], 4), [1, 2, 4], "The number should be added to the end of the vector");
                assertEqual(push([1, 2], [1]), [1, 2, [1]], "The array should be added to the end of the array");
                assertEqual(push([1, 2], "1"), [1, 2, "1"], "The string should be added to the end of the array");
            }
        }
        // test core/list/unshift()
        testModule("unshift()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(unshift(), [undef], "Without parameter it should return an array containing an undef");
            }
            testUnit("not array", 3) {
                assertEqual(unshift(1, 1), [1], "Cannot add element to a number, should return an array that only contains the added element");
                assertEqual(unshift("123", "a"), ["a"], "Cannot add element to a string, should return an array that only contains the added element");
                assertEqual(unshift(true, false), [false], "Cannot add element to a boolean, should return an array that only contains the added element");
            }
            testUnit("array", 5) {
                assertEqual(unshift([]), [undef], "An element to add should be provided, otherwise an undef will be pushed");
                assertEqual(unshift([], 1), [1], "An empty array becomes an array with one element");
                assertEqual(unshift([1, 2], 4), [4, 1, 2], "The number should be added to the begin of the vector");
                assertEqual(unshift([1, 2], [1]), [[1], 1, 2], "The array should be added to the begin of the array");
                assertEqual(unshift([1, 2], "1"), ["1", 1, 2], "The string should be added to the begin of the array");
            }
        }
        // test core/list/pick()
        testModule("pick()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(pick(), "Without parameter it should return an empty array");
            }
            testUnit("not array", 3) {
                assertEmptyArray(pick(1, 1), "Cannot build an array from a number, should return an empty array");
                assertEmptyArray(pick("123", "12"), "Cannot build an array from a string, should return an empty array");
                assertEmptyArray(pick(true, false), "Cannot build an array from a boolean, should return an empty array");
            }
            testUnit("array", 6) {
                assertEqual(pick([], []), [], "Empty arrays produce empty array");
                assertEqual(pick([], [1, 2, 3]), [], "Cannot pick anything from an empty array");
                assertEqual(pick([1, 2, 3], [4, 3, 5]), [], "Cannot pick inexisting elements");
                assertEqual(pick(["1", "2", "3"], [1, 3, 2]), ["2", "3"], "Pick existing elements");
                assertEqual(pick(["1", "2", "3"], [2, 0, 1]), ["3", "1", "2"], "Pick elements in any order");
                assertEqual(pick(["1", "2", "3"], [1, 1, 1]), ["2", "2", "2"], "Can also pick same elements several times");
            }
        }
        // test core/list/sort()
        testModule("sort()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(sort(), "Without parameter it should return an empty array");
            }
            testUnit("not array", 3) {
                assertEmptyArray(sort(1), "Cannot sort a number, should return an empty array");
                assertEmptyArray(sort("123"), "Cannot sort a string, should return an empty array");
                assertEmptyArray(sort(true), "Cannot sort a boolean, should return an empty array");
            }
            testUnit("array", 7) {
                assertEqual(sort([]), [], "Empty array remain empty array");
                assertEqual(sort([1, 2, 3]), [1, 2, 3], "Should keep intact ordered vector");
                assertEqual(sort([2]), [2], "Should sort the 1D vector");
                assertEqual(sort([3, 2]), [2, 3], "Should sort the 2D vector");
                assertEqual(sort([3, 1, 2]), [1, 2, 3], "Should sort the 3D vector");
                assertEqual(sort([3, 1, 5, 6, 2, 4, 7]), [1, 2, 3, 4, 5, 6, 7], "Should sort the vector");
                assertEqual(sort(["foo", "abc", "bar", "baz"]), ["abc", "bar", "baz", "foo"], "Should sort the array of strings");
            }
        }
    }
}

testCoreList();
