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
 * Unit tests: 2D and 3D points handling.
 *
 * @package test/core/point
 * @author jsconan
 */
module testCorePoint() {
    testPackage("core/point.scad", 16) {
        // test core/point/apply2D()
        testModule("apply2D()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(apply2D(), [0, 0], "Should always produce a 2D vector, even if input is wrong");
            }
            testUnit("not vector", 15) {
                assertEqual(apply2D(1), [1, 1], "Should produce a 2D vector with the input number as a coordinate");
                assertEqual(apply2D(1, 2), [2, 1], "Should produce a 2D vector with the input number as a coordinate");
                assertEqual(apply2D(1, 2, 3), [2, 3], "Should produce a 2D vector with the input number as a coordinate");
                assertEqual(apply2D(true), [0, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(apply2D(true, 1), [1, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(apply2D(true, 1, 2), [1, 2], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(apply2D("1"), [0, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(apply2D("1", 1), [1, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(apply2D("1", 1, 2), [1, 2], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(apply2D(["1"]), [0, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(apply2D(["1"], 1), [1, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(apply2D(["1"], 1, 2), [1, 2], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(apply2D(["1", 1]), [0, 1], "Should produce a corrected 2D vector if input is wrong");
                assertEqual(apply2D(["1", 1], 1), [1, 1], "Should produce a corrected 2D vector if input is wrong");
                assertEqual(apply2D(["1", 1], 1, 2), [1, 2], "Should produce a corrected 2D vector if input is wrong");
            }
            testUnit("vector", 10) {
                assertEqual(apply2D([1]), [1, 0], "Should complete incomplete 2D vector");
                assertEqual(apply2D([1], y=2), [1, 2], "Should complete incomplete 2D vector");
                assertEqual(apply2D([1], 2, 3), [2, 3], "Should complete incomplete 2D vector");
                assertEqual(apply2D([1, 2]), [1, 2], "Should keep correct and complete 2D vector");
                assertEqual(apply2D([1, 2], 3, 4), [3, 4], "Should keep correct and complete 2D vector");
                assertEqual(apply2D([1, 2, 3]), [1, 2], "Should truncate too big vector");
                assertEqual(apply2D([1, 2, 3], 5, 6), [5, 6], "Should truncate too big vector");
                assertEqual(apply2D(x=5), [5, 0], "Should create the vector from the provided X coordinate");
                assertEqual(apply2D(y=6), [0, 6], "Should create the vector from the provided Y coordinate)");
                assertEqual(apply2D(x=5, y=6), [5, 6], "Should create the vector from the provided coordinates");
            }
            testUnit("circle", 6) {
                assertEqual(apply2D([1, 2], r=3), [6, 6], "Should apply the radius as coordinates of the 2D vector");
                assertEqual(apply2D([1, 2], d=3), [3, 3], "Should apply the diameter as coordinates of the 2D vector");
                assertEqual(apply2D([1, 2], x=4, r=3), [4, 6], "Should apply the radius as coordinates of the 2D vector, but the X");
                assertEqual(apply2D([1, 2], y=5, d=3), [3, 5], "Should apply the diameter as coordinates of the 2D vector, but the Y");
                assertEqual(apply2D(r=5), [10, 10], "Should create the vector from the provided radius");
                assertEqual(apply2D(d=6), [6, 6], "Should create the vector from the provided diameter");
            }
        }
        // test core/point/apply3D()
        testModule("apply3D()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(apply3D(), [0, 0, 0], "Should always produce a 3D vector, even if input is wrong");
            }
            testUnit("not vector", 16) {
                assertEqual(apply3D(1), [1, 1, 1], "Should produce a 3D vector with the input number as a coordinate");
                assertEqual(apply3D(1, 2), [2, 1, 1], "Should produce a 3D vector with the input number as a coordinate");
                assertEqual(apply3D(1, 2, 3), [2, 3, 1], "Should produce a 3D vector with the input number as a coordinate");
                assertEqual(apply3D(1, 2, 3, 4), [2, 3, 4], "Should produce a 3D vector with the input number as a coordinate");
                assertEqual(apply3D(true), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(apply3D(true, 1), [1, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(apply3D(true, 1, 2), [1, 2, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(apply3D("1"), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(apply3D("1", 1), [1, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(apply3D("1", 1, 2), [1, 2, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(apply3D(["1"]), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(apply3D(["1"], 1), [1, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(apply3D(["1"], 1, 2), [1, 2, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(apply3D(["1", 1]), [0, 1, 0], "Should produce a corrected 3D vector if input is wrong");
                assertEqual(apply3D(["1", 1], 1), [1, 1, 0], "Should produce a corrected 3D vector if input is wrong");
                assertEqual(apply3D(["1", 1], 1, 2), [1, 2, 0], "Should produce a corrected 3D vector if input is wrong");
            }
            testUnit("vector", 16) {
                assertEqual(apply3D([1]), [1, 0, 0], "Should complete incomplete 3D vector");
                assertEqual(apply3D([1], y=2), [1, 2, 0], "Should complete incomplete 3D vector");
                assertEqual(apply3D([1], z=2), [1, 0, 2], "Should complete incomplete 3D vector");
                assertEqual(apply3D([1], 2, 3), [2, 3, 0], "Should complete incomplete 3D vector");
                assertEqual(apply3D([1], 2, 3, 4), [2, 3, 4], "Should complete incomplete 3D vector");
                assertEqual(apply3D([1, 2], z=3), [1, 2, 3], "Should complete incomplete 3D vector");
                assertEqual(apply3D([1, 2], 2, 3, 4), [2, 3, 4], "Should complete incomplete 3D vector");
                assertEqual(apply3D([1, 2, 3]), [1, 2, 3], "Should keep correct and complete 3D vector");
                assertEqual(apply3D([1, 2, 3], 3, 4), [3, 4, 3], "Should keep correct and complete 3D vector");
                assertEqual(apply3D([1, 2, 3, 4]), [1, 2, 3], "Should truncate too big vector");
                assertEqual(apply3D([1, 2, 3, 4], 5, 6), [5, 6, 3], "Should truncate too big vector");
                assertEqual(apply3D([1, 2, 3, 4], 5, 6, 7), [5, 6, 7], "Should truncate too big vector");
                assertEqual(apply3D(x=5), [5, 0, 0], "Should create the vector from the provided X coordinate");
                assertEqual(apply3D(y=6), [0, 6, 0], "Should create the vector from the provided Y coordinate)");
                assertEqual(apply3D(z=7), [0, 0, 7], "Should create the vector from the provided Z coordinate)");
                assertEqual(apply3D(x=5, y=6, z=7), [5, 6, 7], "Should create the vector from the provided coordinates");
            }
            testUnit("sphere", 7) {
                assertEqual(apply3D([1, 2, 3], r=3), [6, 6, 6], "Should apply the radius as coordinates of the 3D vector");
                assertEqual(apply3D([1, 2, 3], d=7), [7, 7, 7], "Should apply the diameter as coordinates of the 3D vector");
                assertEqual(apply3D([1, 2, 3], x=4, r=3), [4, 6, 6], "Should apply the radius as coordinates of the 3D vector, but the X");
                assertEqual(apply3D([1, 2, 3], y=8, d=3), [3, 8,3], "Should apply the diameter as coordinates of the 3D vector, but the Y");
                assertEqual(apply3D([1, 2, 3], z=-2, d=3), [3, 3, -2], "Should apply the diameter as coordinates of the 3D vector, but the Z");
                assertEqual(apply3D(r=5), [10, 10, 10], "Should create the vector from the provided radius");
                assertEqual(apply3D(d=6), [6, 6, 6], "Should create the vector from the provided diameter)");
            }
        }
        // test core/point/project()
        testModule("project()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(project(), [0, 0], "Should return [0, 0]");
            }
            testUnit("wrong types", 3) {
                assertEqual(project("1", "2"), [0, 0], "Strings are not valids, the function should return [0, 0]");
                assertEqual(project(true, true), [0, 0], "Booleans are not valids, the function should return [0, 0]");
                assertEqual(project(["1", "2"], ["1"]), [0, 0], "Arrays are not valids, the function should return [0, 0]");
            }
            testUnit("vector", 11) {
                assertEqual(project([]), [0, 0], "An empty vector should produce [0, 0]");
                assertEqual(project([], 30), [0, 0], "An empty vector should produce [0, 0], whatever the angle is");
                assertEqual(project(10), [10, 0], "A single number should be converted to vector");
                assertEqual(project([10, 10]), [10, 0], "Without angle, the vector should be project on the X axis");
                assertEqual(project([10, 10], 45), [cos(45)*10, sin(45)*10], "Angle of 45 degrees");
                assertEqual(project([20, 10], 30), [cos(30)*20, sin(30)*10], "Angle of 30 degrees");
                assertEqual(project([10, 20], 60), [cos(60)*10, sin(60)*20], "Angle of 60 degrees");
                assertEqual(project([10, 20], 60, 30, 50), [cos(60)*30, sin(60)*50], "The X and Y parameters should replace the vector's coordinates");
                assertEqual(project([10, 20], 360), [cos(0)*10, sin(0)*20], "Angle of 360 degrees should be equal to 0 degrees");
                assertEqual(project([10, 20], 420), [cos(60)*10, sin(60)*20], "Angle of 420 degrees should be equal to 60 degrees");
                assertEqual(project([10, 20], -20), [cos(340)*10, sin(340)*20], "Angle of -20 degrees should be equal to 340 degrees");
            }
        }
        // test core/point/sinp()
        testModule("sinp()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(sinp(), [0, 0], "Should return [0, 0]");
            }
            testUnit("wrong types", 3) {
                assertEqual(sinp("1", "2", "3", "4", "5"), [0, 0], "Cannot use strings to build the point, should return [0, 0]");
                assertEqual(sinp([1], [2], [3], [4], [5]), [0, 0], "Cannot use vectors to build the point, should return [0, 0]");
                assertEqual(sinp(true, true, true, true, true), [0, 0], "Cannot use booleans to build the point, should return [0, 0]");
            }
            testUnit("number", 5) {
                assertEqual(sinp(1), [1, 0], "Should return [1, 0]");
                assertEqual(sinp(0.1, 2), [0.1, sin(18)], "Should return [0.1, sin(18)]");
                assertEqual(sinp(0.2, 2, 6), [0.2, 6 * sin(36)], "Should return [0.2, 6 * sin(36)]");
                assertEqual(sinp(0.5, 2, 6, 10), [0.5, 6 * sin(100)], "Should return [0.5, 6 * sin(100)]");
                assertEqual(sinp(0.8, 2, 6, 10, 15), [0.8, 15 + 6 * sin(154)], "Should return [0.8, 15 + 6 * sin(100)]");
            }
        }
        // test core/point/cosp()
        testModule("cosp()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(cosp(), [1, 0], "Should return [1, 0]");
            }
            testUnit("wrong types", 3) {
                assertEqual(cosp("1", "2", "3", "4", "5"), [1, 0], "Cannot use strings to build the point, should return [1, 0]");
                assertEqual(cosp([1], [2], [3], [4], [5]), [1, 0], "Cannot use vectors to build the point, should return [1, 0]");
                assertEqual(cosp(true, true, true, true, true), [1, 0], "Cannot use booleans to build the point, should return [1, 0]");
            }
            testUnit("number", 5) {
                assertEqual(cosp(1), [1, 1], "Should return [1, 1]");
                assertEqual(cosp(0.1, 2), [cos(18), 0.1], "Should return [cos(18), 0.1]");
                assertEqual(cosp(0.2, 2, 6), [6 * cos(36), 0.2], "Should return [6 * cos(36), 0.2]");
                assertEqual(cosp(0.5, 2, 6, 10), [6 * cos(100), 0.5], "Should return [6 * cos(100), 0.5]");
                assertEqual(cosp(0.8, 2, 6, 10, 15), [15 + 6 * cos(154), 0.8], "Should return [15 + 6 * cos(100), 0.8]");
            }
        }
        // test core/point/boundaries()
        testModule("boundaries()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(boundaries(), [[0, 0, 0], [0, 0, 0]], "Cannot get boundaries if the list is missing, should return 0");
            }
            testUnit("wrong types", 3) {
                assertEqual(boundaries("2"), [[0, 0, 0], [0, 0, 0]], "Cannot get boundaries from string, should return 0");
                assertEqual(boundaries(2), [[0, 0, 0], [0, 0, 0]], "Cannot get boundaries from single number, should return 0");
                assertEqual(boundaries(true), [[0, 0, 0], [0, 0, 0]], "Cannot get boundaries from boolean, should return 0");
            }
            testUnit("vectors", 9) {
                assertEqual(boundaries([[1, 2]]), [[1, 2, 0], [1, 2, 0]], "A single point is its own boundaries, 2D vectors are upscaled to 3D");
                assertEqual(boundaries([[1, 2, 3]]), [[1, 2, 3], [1, 2, 3]], "A single point is its own boundaries, 3D vectors are supported");
                assertEqual(boundaries([[1, 2, 3, 4]]), [[1, 2, 3], [1, 2, 3]], "A single point is its own boundaries, 4D vectors and more are truncated");

                assertEqual(boundaries([[1, 2], [5, 9]]), [[1, 2, 0], [5, 9, 0]], "Boundaries of 2 points, 2D vectors are upscaled to 3D");
                assertEqual(boundaries([[1, 2, 3], [5, 9, -2]]), [[1, 2, -2], [5, 9, 3]], "Boundaries of 2 points, 3D vectors are supported");
                assertEqual(boundaries([[1, 2, 3, 4], [5, 9, -2, 8]]), [[1, 2, -2], [5, 9, 3]], "Boundaries of 2 points, 4D vectors and more are truncated");

                assertEqual(boundaries([[1, 2], [5, 9], [3, 2], [-2, -6]]), [[-2, -6, 0], [5, 9, 0]], "Boundaries of several points, 2D vectors are upscaled to 3D");
                assertEqual(boundaries([[1, 2, 3], [5, 9, -2], [3, 2, 7], [-2, -6, 0]]), [[-2, -6, -2], [5, 9, 7]], "Boundaries of several points, 3D vectors are supported");
                assertEqual(boundaries([[1, 2, 3, 4], [5, 9, -2, 8], [3, 2, 7, 5], [-2, -6, 0, 1]]), [[-2, -6, -2], [5, 9, 7]], "Boundaries of several points, 4D vectors and more are truncated");
            }
        }
        // test core/point/dimensions()
        testModule("dimensions()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(dimensions(), [0, 0, 0], "Cannot get dimensions if the list is missing, should return 0");
            }
            testUnit("wrong types", 3) {
                assertEqual(dimensions("2"), [0, 0, 0], "Cannot get dimensions from string, should return 0");
                assertEqual(dimensions(2), [0, 0, 0], "Cannot get dimensions from single number, should return 0");
                assertEqual(dimensions(true), [0, 0, 0], "Cannot get dimensions from boolean, should return 0");
            }
            testUnit("vectors", 9) {
                assertEqual(dimensions([[1, 2]]), [0, 0, 0], "A single point has no dimensions, 2D vectors are upscaled to 3D");
                assertEqual(dimensions([[1, 2, 3]]), [0, 0, 0], "A single point has no dimensions, 3D vectors are supported");
                assertEqual(dimensions([[1, 2, 3, 4]]), [0, 0, 0], "A single point has no dimensions, 4D vectors and more are truncated");

                assertEqual(dimensions([[1, 2], [5, 9]]), [4, 7, 0], "Should return a the dimensions if at least 2 points are provided, 2D vectors are upscaled to 3D");
                assertEqual(dimensions([[1, 2, 3], [5, 9, -2]]), [4, 7, 5], "Should return a the dimensions if at least 2 points are provided, 3D vectors are supported");
                assertEqual(dimensions([[1, 2, 3], [5, 9, -2]]), [4, 7, 5], "Should return a the dimensions if at least 2 points are provided, 4D vectors and more are truncated");

                assertEqual(dimensions([[1, 2], [5, 9], [3, 2], [-2, -6]]), [7, 15, 0], "Should return a the dimensions with respect to all points, 2D vectors are upscaled to 3D");
                assertEqual(dimensions([[1, 2, 3], [5, 9, -2], [3, 2, 7], [-2, -6, 0]]), [7, 15, 9], "Should return a the dimensions with respect to all points, 3D vectors are supported");
                assertEqual(dimensions([[1, 2, 3, 4], [5, 9, -2, -5], [3, 2, 7, 8], [-2, -6, 0, 3]]), [7, 15, 9], "Should return a the dimensions with respect to all points, 4D vectors and more are truncated");
            }
        }
        // test core/point/scaleFactor()
        testModule("scaleFactor()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(scaleFactor(), [1, 1, 1], "If no list nor size are provided, should return a neutral scale factor");
            }
            testUnit("wrong types", 3) {
                assertEqual(scaleFactor("1", "2"), [1, 1, 1], "Cannot resize strings, should return a neutral scale factor");
                assertEqual(scaleFactor([1], [2]), [2, 1, 1], "Incomplete vectors should be adjusted, should return a neutral scale factor");
                assertEqual(scaleFactor(true, true), [1, 1, 1], "Cannot resize booleans, should return a neutral scale factor");
            }
            testUnit("vectors", 10) {
                assertEqual(scaleFactor([[1, 2], [5, 9]]), [1, 1, 1], "Should return a default scale factor if no size is provided, 2D vectors are upscaled to 3D");
                assertEqual(scaleFactor([[1, 2, 3], [5, 9, 2]]), [1, 1, 1], "Should return a default scale factor if no size is provided, 3D vectors are supported");
                assertEqual(scaleFactor([[1, 2, 3, 4], [5, 9, 2, -3]]), [1, 1, 1], "Should return a default scale factor if no size is provided, 4D vectors and more are truncated");

                assertEqual(scaleFactor([[1, 2], [5, 9]], 2), [2/4, 2/7, 2], "When the size is a single number it should be applied to all elements, 2D vectors are upscaled to 3D");
                assertEqual(scaleFactor([[1, 2, 3], [5, 9, 2]], 2), [2/4, 2/7, 2], "When the size is a single number it should be applied to all elements, 3D vectors are supported");
                assertEqual(scaleFactor([[1, 2, 3, 4], [5, 9, 2, 7]], 2), [2/4, 2/7, 2], "When the size is a single number it should be applied to all elements, 4D vectors and more are truncated");

                assertEqual(scaleFactor([[1, 2], [5, 9]], [2, 3]), [2/4, 3/7, 1], "When the size is a vector its elements are applied respectively to each elements of the listed points, 2D vectors are upscaled to 3D");
                assertEqual(scaleFactor([[1, 2, 3], [5, 9, 2]], [2, 3, 4]), [2/4, 3/7, 4], "When the size is a vector its elements are applied respectively to each elements of the listed points, 3D vectors are supported");
                assertEqual(scaleFactor([[1, 2, 3, 4], [5, 9, 2, 7]], [2, 3, 4]), [2/4, 3/7, 4], "When the size is a vector its elements are applied respectively to each elements of the listed points, 4D vectors and more are truncated");

                assertEqual(scaleFactor([[1], [8]], 3), [3/7, 3, 3], "Incomplete vectors should be adjusted");
            }
        }
        // test core/point/scale2D()
        testModule("scale2D()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(scale2D(), "Should return an empty list of points");
            }
            testUnit("wrong types", 3) {
                assertEqual(scale2D("1", "2"), [[0, 0]], "Cannot scale strings");
                assertEqual(scale2D([1], [2]), [[0, 0]], "Incomplete vectors should be adjusted");
                assertEqual(scale2D(true, true), [], "Cannot scale booleans");
            }
            testUnit("vectors", 4) {
                assertEqual(scale2D([[1, 1], [2, 2]]), [[1, 1], [2, 2]], "A default scale factor should be utilized if none is provided");
                assertEqual(scale2D([[1, 2], [5, 9]], 2), [[2, 4], [10, 18]], "When the scale factor is a single number it should be applied to all elements");
                assertEqual(scale2D([[3, 1.5], [2.3, 7]], [0.6, 1.5]), [[3*0.6, 1.5*1.5], [2.3*0.6, 7*1.5]], "When the scale factor is a vector its elements are applied respectively to each elements of the listed points");
                assertEqual(scale2D([[1], [8]], 3), [[3, 0], [24, 0]], "Incomplete vectors should be adjusted");
            }
        }
        // test core/point/resize2D()
        testModule("resize2D()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(resize2D(), "Should return an empty list of points");
            }
            testUnit("wrong types", 3) {
                assertEqual(resize2D("1", "2"), [[0, 0]], "Cannot resize strings");
                assertEqual(resize2D([1], [2]), [[0, 0]], "Incomplete vectors should be adjusted");
                assertEqual(resize2D(true, true), [], "Cannot resize booleans");
            }
            testUnit("vectors", 4) {
                assertEqual(resize2D([[1, 3], [5, 9]]), [[1, 3], [5, 9]], "No change will be made if no size is provided");
                assertEqual(resize2D([[1, 3], [5, 9]], 2), [[1*2/4, 3*2/6], [5*2/4, 9*2/6]], "When the size is a single number it should be applied to all elements");
                assertEqual(resize2D([[1, 3], [5, 9]], [2, 3]), [[1*2/4, 3*3/6], [5*2/4, 9*3/6]], "When the size is a vector its elements are applied respectively to each elements of the listed points");
                assertEqual(resize2D([[1], [8]], 3), [[1*3/7, 0], [8*3/7, 0]], "Incomplete vectors should be adjusted");
            }
        }
        // test core/point/rotate2D()
        testModule("rotate2D()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(rotate2D(), [0, 0], "Should return [0, 0]");
            }
            testUnit("wrong types", 3) {
                assertEqual(rotate2D("1", "2"), [0, 0], "Cannot use strings to rotate the point, should return [0, 0]");
                assertEqual(rotate2D([1], [2]), [1, 0], "Cannot use vectors to rotate the point, should return [1, 0]");
                assertEqual(rotate2D(true, true), [0, 0], "Cannot use booleans to rotate the point, should return [0, 0]");
            }
            testUnit("number", 4) {
                assertEqual(rotate2D(5), [5, 5], "Should return [5, 5]");
                assertEqual(rotate2D(5, 45), _rot2([5, 5], 45), "Should return [5, 5] rotated by 45°");
                assertEqual(rotate2D(5, -45), _rot2([5, 5], -45), "Should return [5, 5] rotated by -45°");
                assertEqual(rotate2D(5, 464), _rot2([5, 5], 104), "Should return [5, 5] rotated by 104°");
            }
            testUnit("vector", 4) {
                assertEqual(rotate2D([23, 67]), [23, 67], "Should return [23, 67]");
                assertEqual(rotate2D([23, 67], 290), _rot2([23, 67], 290), "Should return [23, 67] rotated by 290°");
                assertEqual(rotate2D([23, 67], -76), _rot2([23, 67], -76), "Should return [23, 67] rotated by -76°");
                assertEqual(rotate2D([23, 67], 464), _rot2([23, 67], 104), "Should return [23, 67] rotated by 104°");
            }
        }
        // test core/point/rotate3DX()
        testModule("rotate3DX()") {
            testUnit("no parameter", 1) {
                assertEqual(rotate3DX(), [0, 0, 0], "Should return [0, 0, 0]");
            }
            testUnit("wrong types", 3) {
                assertEqual(rotate3DX("1", "2"), [0, 0, 0], "Cannot use strings to rotate the point, should return [0, 0, 0]");
                assertEqual(rotate3DX([1], [2]), [1, 0, 0], "Cannot use vectors to rotate the point, should return [1, 0, 0]");
                assertEqual(rotate3DX(true, true), [0, 0, 0], "Cannot use booleans to rotate the point, should return [0, 0, 0]");
            }
            testUnit("number", 4) {
                assertEqual(rotate3DX(5), [5, 5, 5], "Should return [5, 5, 5]");
                assertEqual(rotate3DX(5, 45), [5, _rot2([5, 5], 45)[0], _rot2([5, 5], 45)[1]], "Should return [5, 5, 5] rotated by 45° around X");
                assertEqual(rotate3DX(5, -45), [5, _rot2([5, 5], -45)[0], _rot2([5, 5], -45)[1]], "Should return [5, 5, 5] rotated by -45° around X");
                assertEqual(rotate3DX(5, 464), [5, _rot2([5, 5], 104)[0], _rot2([5, 5], 104)[1]], "Should return [5, 5, 5] rotated by 104° around X");
            }
            testUnit("vector", 4) {
                assertEqual(rotate3DX([23, 67, 51]), [23, 67, 51], "Should return [23, 67, 51]");
                assertEqual(rotate3DX([23, 67, 51], 290), [23, _rot2([67, 51], 290)[0], _rot2([67, 51], 290)[1]], "Should return [23, 67, 51] rotated by 290° around X");
                assertEqual(rotate3DX([23, 67, 51], -76), [23, _rot2([67, 51], -76)[0], _rot2([67, 51], -76)[1]], "Should return [23, 67, 51] rotated by -76° around X");
                assertEqual(rotate3DX([23, 67, 51], 464), [23, _rot2([67, 51], 104)[0], _rot2([67, 51], 104)[1]], "Should return [23, 67, 51] rotated by 104° around X");
            }
        }
        // test core/point/rotate3DY()
        testModule("rotate3DY()") {
            testUnit("no parameter", 1) {
                assertEqual(rotate3DY(), [0, 0, 0], "Should return [0, 0, 0]");
            }
            testUnit("wrong types", 3) {
                assertEqual(rotate3DY("1", "2"), [0, 0, 0], "Cannot use strings to rotate the point, should return [0, 0, 0]");
                assertEqual(rotate3DY([1], [2]), [1, 0, 0], "Cannot use vectors to rotate the point, should return [1, 0, 0]");
                assertEqual(rotate3DY(true, true), [0, 0, 0], "Cannot use booleans to rotate the point, should return [0, 0, 0]");
            }
            testUnit("number", 4) {
                assertEqual(rotate3DY(5), [5, 5, 5], "Should return [5, 5, 5]");
                assertEqual(rotate3DY(5, 45), [_rot2([5, 5], 45)[0], 5, _rot2([5, 5], 45)[1]], "Should return [5, 5, 5] rotated by 45° around Y");
                assertEqual(rotate3DY(5, -45), [_rot2([5, 5], -45)[0], 5, _rot2([5, 5], -45)[1]], "Should return [5, 5, 5] rotated by -45° around Y");
                assertEqual(rotate3DY(5, 464), [_rot2([5, 5], 104)[0], 5, _rot2([5, 5], 104)[1]], "Should return [5, 5, 5] rotated by 104° around Y");
            }
            testUnit("vector", 4) {
                assertEqual(rotate3DY([23, 67, 51]), [23, 67, 51], "Should return [23, 67, 51]");
                assertEqual(rotate3DY([23, 67, 51], 290), [_rot2([51, 23], 290)[0], 67, _rot2([51, 23], 290)[1]], "Should return [23, 67, 51] rotated by 290° around Y");
                assertEqual(rotate3DY([23, 67, 51], -76), [_rot2([51, 23], -76)[0], 67, _rot2([51, 23], -76)[1]], "Should return [23, 67, 51] rotated by -76° around Y");
                assertEqual(rotate3DY([23, 67, 51], 464), [_rot2([51, 23], 104)[0], 67, _rot2([51, 23], 104)[1]], "Should return [23, 67, 51] rotated by 104° around Y");
            }
        }
        // test core/point/rotate3DZ()
        testModule("rotate3DZ()") {
            testUnit("no parameter", 1) {
                assertEqual(rotate3DZ(), [0, 0, 0], "Should return [0, 0, 0]");
            }
            testUnit("wrong types", 3) {
                assertEqual(rotate3DZ("1", "2"), [0, 0, 0], "Cannot use strings to rotate the point, should return [0, 0, 0]");
                assertEqual(rotate3DZ([1], [2]), [1, 0, 0], "Cannot use vectors to rotate the point, should return [1, 0, 0]");
                assertEqual(rotate3DZ(true, true), [0, 0, 0], "Cannot use booleans to rotate the point, should return [0, 0, 0]");
            }
            testUnit("number", 4) {
                assertEqual(rotate3DZ(5), [5, 5, 5], "Should return [5, 5, 5]");
                assertEqual(rotate3DZ(5, 45), [_rot2([5, 5], 45)[0], _rot2([5, 5], 45)[1], 5], "Should return [5, 5, 5] rotated by 45° around Z");
                assertEqual(rotate3DZ(5, -45), [_rot2([5, 5], -45)[0], _rot2([5, 5], -45)[1], 5], "Should return [5, 5, 5] rotated by -45° around Z");
                assertEqual(rotate3DZ(5, 464), [_rot2([5, 5], 104)[0], _rot2([5, 5], 104)[1], 5], "Should return [5, 5, 5] rotated by 104° around Z");
            }
            testUnit("vector", 4) {
                assertEqual(rotate3DZ([23, 67, 51]), [23, 67, 51], "Should return [23, 67, 51]");
                assertEqual(rotate3DZ([23, 67, 51], 290), [_rot2([23, 67], 290)[0], _rot2([23, 67], 290)[1], 51], "Should return [23, 67, 51] rotated by 290° around Z");
                assertEqual(rotate3DZ([23, 67, 51], -76), [_rot2([23, 67], -76)[0], _rot2([23, 67], -76)[1], 51], "Should return [23, 67, 51] rotated by -76° around Z");
                assertEqual(rotate3DZ([23, 67, 51], 464), [_rot2([23, 67], 104)[0], _rot2([23, 67], 104)[1], 51], "Should return [23, 67, 51] rotated by 104° around Z");
            }
        }
        // test core/point/middle()
        testModule("middle()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(middle(), [0, 0, 0], "Should always produce a 3D vector, even if input is wrong");
            }
            testUnit("not vector", 14) {
                assertEqual(middle(a=1), [0.5, 0.5, 0.5], "Should produce a 3D vector with the input number as a coordinate");
                assertEqual(middle(b=1), [0.5, 0.5, 0.5], "Should produce a 3D vector with the input number as a coordinate");
                assertEqual(middle(a=[1], b=1), [1, 0.5, 0.5], "Should produce a 3D vector with the input number as a coordinate");
                assertEqual(middle(a=1, b=[1]), [1, 0.5, 0.5], "Should produce a 3D vector with the input number as a coordinate");
                assertEqual(middle(a=true), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(middle(b=true), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(middle(a="1"), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(middle(b="1"), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(middle(a=["1"]), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(middle(b=["1"]), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(middle(a=["1", 1]), [0, .5, 0], "Should produce a corrected 3D vector if input is wrong");
                assertEqual(middle(a=["1", 1, 1]), [0, .5, .5], "Should produce a corrected 3D vector if input is wrong");
                assertEqual(middle(b=["1", 1]), [0, .5, 0], "Should produce a corrected 3D vector if input is wrong");
                assertEqual(middle(b=["1", 1, 1]), [0, .5, .5], "Should produce a corrected 3D vector if input is wrong");
            }
            testUnit("vector", 7) {
                assertEqual(middle([1]), [.5, 0, 0], "Should complete incomplete 3D vector and returns a 3D vector");
                assertEqual(middle([1], [2]), [1.5, 0, 0], "Should complete incomplete 3D vector and returns a 3D vector");
                assertEqual(middle([1, 2]), [0.5, 1, 0], "Should complete incomplete 3D vector and returns a 3D vector");
                assertEqual(middle([1, 2], [2, 3]), [1.5, 2.5, 0], "Should complete incomplete 3D vector and returns a 3D vector");
                assertEqual(middle([1, 2, 3]), [0.5, 1, 1.5], "Should return a normalized 3D vector");
                assertEqual(middle([1, 2, 3], [4, 5, 6]), [2.5, 3.5, 4.5], "Should return a normalized 3D vector");
                assertEqual(middle([1, 2, 3, 4], [4, 5, 6, 7]), [2.5, 3.5, 4.5], "Should truncate too big vector and returns a 3D vector");
            }
        }
        // test core/point/move()
        testModule("move()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(move(), [0, 0, 0], "Should always produce a 3D vector, even if input is wrong");
            }
            testUnit("not vector", 18) {
                assertEqual(move(1), [1, 1, 1], "Should produce a 3D vector with the input number as a coordinate");
                assertEqual(move(1, 1), [1, 1, 1], "Should produce a 3D vector with the input number as a coordinate");
                assertEqual(move(1, 1, 1), [1, 1, 1] + [1, 1, 1] / norm([1, 1, 1]), "Should produce a 3D vector with the input number as a coordinate");
                assertEqual(move(true), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(move(true, true), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(move(true, true, true), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(move("1"), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(move("1", "1"), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(move("1", "1", "1"), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(move(["1"]), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(move(["1"], ["1"]), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(move(["1"], ["1"], ["1"]), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(move(["1", 1]), [0, 1, 0], "Should produce a corrected 3D vector if input is wrong");
                assertEqual(move(["1", 1], ["1", 1]), [0, 1, 0], "Should produce a corrected 3D vector if input is wrong");
                assertEqual(move(["1", 1], ["1", 1], 1), [0, 1, 0] + [0, 1, 0] / norm([0, 1, 0]), "Should produce a corrected 3D vector if input is wrong");
                assertEqual(move(["1", 1, 1]), [0, 1, 1], "Should produce a corrected 3D vector if input is wrong");
                assertEqual(move(["1", 1, 1], ["1", 1, 1]), [0, 1, 1], "Should produce a corrected 3D vector if input is wrong");
                assertEqual(move(["1", 1, 1], ["1", 1, 1], 1), [0, 1, 1] + [0, 1, 1] / norm([0, 1, 1]), "Should produce a corrected 3D vector if input is wrong");
            }
            testUnit("vector", 12) {
                assertEqual(move([1]), [1, 0, 0], "Should complete incomplete 3D vector and returns a normalized 3D vector");
                assertEqual(move([1], [1]), [1, 0, 0], "Should complete incomplete 3D vector and returns a normalized 3D vector");
                assertEqual(move([1], [1], 1), [1, 0, 0] + [1, 0, 0] / norm([1, 0, 0]), "Should complete incomplete 3D vector and returns a normalized 3D vector");
                assertEqual(move([1, 2]), [1, 2, 0], "Should complete incomplete 3D vector and returns a normalized 3D vector");
                assertEqual(move([1, 2], [1, 2]), [1, 2, 0], "Should complete incomplete 3D vector and returns a normalized 3D vector");
                assertEqual(move([1, 2], [1, 2], 1), [1, 2, 0] + [1, 2, 0] / norm([1, 2, 0]), "Should complete incomplete 3D vector and returns a normalized 3D vector");
                assertEqual(move([1, 2, 3]), [1, 2, 3], "Should return a normalized 3D vector");
                assertEqual(move([1, 2, 3], [1, 2, 3]), [1, 2, 3], "Should return a normalized 3D vector");
                assertEqual(move([1, 2, 3], [1, 2, 3], 1), [1, 2, 3] + [1, 2, 3] / norm([1, 2, 3]), "Should return a normalized 3D vector");
                assertEqual(move([1, 2, 3, 4]), [1, 2, 3], "Should truncate too big vector and returns a normalized 3D vector");
                assertEqual(move([1, 2, 3, 4], [1, 2, 3, 4]), [1, 2, 3], "Should truncate too big vector and returns a normalized 3D vector");
                assertEqual(move([1, 2, 3, 4], [1, 2, 3, 4], 1), [1, 2, 3] + [1, 2, 3] / norm([1, 2, 3]), "Should truncate too big vector and returns a normalized 3D vector");
            }
        }
    }
    function _rot2(v, a) = [
        v[0] * cos(a) - v[1] * sin(a),
        v[1] * cos(a) + v[0] * sin(a)
    ];
}

testCorePoint();
