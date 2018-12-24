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
 * Unit tests: 2D vectors handling.
 *
 * @package test/core/vector
 * @author jsconan
 */
module testCoreVector2D() {
    testPackage("core/vector-2d.scad", 32) {
        // test core/vector-2d/vector2D()
        testModule("vector2D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(vector2D(), [0, 0], "Should always produce a 2D vector, even if input is wrong");
            }
            testUnit("not vector", 5) {
                assertEqual(vector2D(1), [1, 1], "Should produce a 2D vector with the input number as a coordinate");
                assertEqual(vector2D(true), [0, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(vector2D("1"), [0, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(vector2D(["1"]), [0, 0], "Should produce a 2D vector filled with 0 if input is wrong");
                assertEqual(vector2D(["1", 1]), [0, 1], "Should produce a corrected 2D vector if input is wrong");
            }
            testUnit("vector", 3) {
                assertEqual(vector2D([1]), [1, 0], "Should complete incomplete 2D vector");
                assertEqual(vector2D([1, 2]), [1, 2], "Should keep correct and complete 2D vector");
                assertEqual(vector2D([1, 2, 3]), [1, 2], "Should truncate too big vector");
            }
        }
        // test core/vector-2d/divisor2D()
        testModule("divisor2D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(divisor2D(), [1, 1], "Should always produce a 2D vector, even if input is wrong");
            }
            testUnit("not vector", 6) {
                assertEqual(divisor2D(1), [1, 1], "Should produce a 2D vector with the input number as a coordinate");
                assertEqual(divisor2D(true), [1, 1], "Should produce a 2D vector filled with 1 if input is wrong");
                assertEqual(divisor2D(false), [1, 1], "Should produce a 2D vector filled with 1 if input is wrong");
                assertEqual(divisor2D("2"), [1, 1], "Should produce a 2D vector filled with 1 if input is wrong");
                assertEqual(divisor2D(["3"]), [1, 1], "Should produce a 2D vector filled with 1 if input is wrong");
                assertEqual(divisor2D(["4", 3]), [1, 3], "Should produce a corrected 2D vector if input is wrong");
            }
            testUnit("vector", 4) {
                assertEqual(divisor2D([2]), [2, 1], "Should complete incomplete 2D vector");
                assertEqual(divisor2D([0, 0]), [1, 1], "Should correct 0 2D vector");
                assertEqual(divisor2D([1, 2]), [1, 2], "Should keep correct and complete 2D vector");
                assertEqual(divisor2D([1, 2, 3]), [1, 2], "Should truncate too big vector");
            }
        }
        // test core/vector-2d/apply2D()
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
        // test core/vector-2d/norm2D()
        testModule("norm2D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(norm2D(), 0, "Cannot compute the length if no vector is provided, should return 0");
            }
            testUnit("not vector", 5) {
                assertEqual(norm2D(3), sqrt(18), "Should translate a number into a 2D vector, then compute the length");
                assertEqual(norm2D(true), 0, "Cannot compute the length if no vector is provided (boolean given), should return 0");
                assertEqual(norm2D("1"), 0, "Cannot compute the length if no vector is provided (string given), should return 0");
                assertEqual(norm2D(["1"]), 0, "Cannot compute the length if no vector is provided (array of strings given), should return 0");
                assertEqual(norm2D(["1", 1]), 1, "Cannot compute the length if no vector is provided (array given), should return 0");
            }
            testUnit("vector", 3) {
                assertEqual(norm2D([1]), 1, "Should complete incomplete 2D vector");
                assertEqual(norm2D([1, 2]), sqrt(5), "Should return an orthogonal 2D vector");
                assertEqual(norm2D([1, 2, 3]), sqrt(5), "Should truncate too big vector");
            }
        }
        // test core/vector-2d/unit2D()
        testModule("unit2D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(unit2D(), [0, 0], "Should always produce a normalized 2D vector, even if input is wrong");
            }
            testUnit("not vector", 6) {
                assertEqual(unit2D(1), [1, 1] / norm2D([1, 1]), "Should produce a normalized 2D vector with the input number as a coordinate");
                assertEqual(unit2D(true), [0, 0], "Should produce a normalized 2D vector filled with 0 if input is wrong");
                assertEqual(unit2D("1"), [0, 0], "Should produce a normalized 2D vector filled with 0 if input is wrong");
                assertEqual(unit2D(["1"]), [0, 0], "Should produce a normalized 2D vector filled with 0 if input is wrong");
                assertEqual(unit2D(["1", 1]), [0, 1] / norm2D([0, 1]), "Should produce a normalized corrected 2D vector if input is wrong");
                assertEqual(unit2D(["1", 1, 1]), [0, 1] / norm2D([0, 1]), "Should produce a normalized corrected 2D vector if input is wrong");
            }
            testUnit("vector", 3) {
                assertEqual(unit2D([1]), [1, 0] / norm2D([1, 0]), "Should complete incomplete 2D vector and returns a normalized 2D vector");
                assertEqual(unit2D([1, 2]), [1, 2] / norm2D([1, 2]), "Should return a normalized 2D vector");
                assertEqual(unit2D([1, 2, 3]), [1, 2] / norm2D([1, 2]), "Should truncate too big vector and returns a normalized 2D vector");
            }
        }
        // test core/vector-2d/normal()
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
        // test core/vector-2d/flip()
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
        // test core/vector-2d/middle2D()
        testModule("middle2D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(middle2D(), [0, 0], "Should always produce a 2D vector, even if input is wrong");
            }
            testUnit("not vector", 12) {
                assertEqual(middle2D(a=1), [0.5, 0.5], "If the second point is missing, assume its the origin");
                assertEqual(middle2D(b=1), [0.5, 0.5], "If the first point is missing, assume its the origin");
                assertEqual(middle2D(a=[1], b=1), [1, 0.5], "Should complete the first point if incomplete, should translate the second point to vector if number given");
                assertEqual(middle2D(a=1, b=[1]), [1, 0.5], "Should translate the first point to vector if number given, should complete the second point if incomplete");
                assertEqual(middle2D(a=true), [0, 0], "Should produce a 2D vector filled with 0 if first point is boolean");
                assertEqual(middle2D(b=true), [0, 0], "Should produce a 2D vector filled with 0 if second point is boolean");
                assertEqual(middle2D(a="1"), [0, 0], "Should produce a 2D vector filled with 0 if first point is string");
                assertEqual(middle2D(b="1"), [0, 0], "Should produce a 2D vector filled with 0 if second point is string");
                assertEqual(middle2D(a=["1"]), [0, 0], "Should produce a 2D vector filled with 0 if first point is array of strings");
                assertEqual(middle2D(b=["1"]), [0, 0], "Should produce a 2D vector filled with 0 if second point is array of strings");
                assertEqual(middle2D(a=["1", 1]), [0, .5], "Should produce a corrected 2D vector if first point is wrong");
                assertEqual(middle2D(b=["1", 1]), [0, .5], "Should produce a corrected 2D vector if second point is wrong");
            }
            testUnit("vector", 6) {
                assertEqual(middle2D([1]), [.5, 0], "Should complete incomplete 2D vector, assume missing point to origin");
                assertEqual(middle2D([1], [2]), [1.5, 0], "Should complete incomplete 2D vector");
                assertEqual(middle2D([1, 2]), [0.5, 1], "Should returns a 2D vector, assume missing point to origin");
                assertEqual(middle2D([1, 2], [2, 3]), [1.5, 2.5], "Should returns a 2D vector");
                assertEqual(middle2D([1, 2, 3]), [0.5, 1], "Should truncate too big vector, assume missing point to origin");
                assertEqual(middle2D([1, 2, 3], [4, 5, 6]), [2.5, 3.5], "Should truncate too big vectors");
            }
        }
        // test core/vector-2d/move2D()
        testModule("move2D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(move2D(), [0, 0], "Should always produce a 2D vector, even if input is wrong");
            }
            testUnit("not vector", 15) {
                assertEqual(move2D(1), [1, 1], "Should translate number to 2D vector (no direction vector)");
                assertEqual(move2D(1, 1), [1, 1], "Should translate number to 2D vector (direction vector but not distance)");
                assertEqual(move2D(1, 1, 1), [1, 1] + [1, 1] / norm2D([1, 1]), "Should translate number to 2D vector (direction vector and distance)");

                assertEqual(move2D(true), [0, 0], "Should produce a default 2D vector if input is boolean (no direction vector)");
                assertEqual(move2D(true, true), [0, 0], "Should produce a default 2D vector if input is boolean (direction vector but not distance)");
                assertEqual(move2D(true, true, true), [0, 0], "Should produce a default 2D vector if input is boolean (direction vector and distance)");

                assertEqual(move2D("1"), [0, 0], "Should produce a default 2D vector if input is string (no direction vector)");
                assertEqual(move2D("1", "1"), [0, 0], "Should produce a default 2D vector if input is string (direction vector but not distance)");
                assertEqual(move2D("1", "1", "1"), [0, 0], "Should produce a default 2D vector if input is string (direction vector and distance)");

                assertEqual(move2D(["1"]), [0, 0], "Should produce a default 2D vector if input is array (no direction vector)");
                assertEqual(move2D(["1"], ["1"]), [0, 0], "Should produce a default 2D vector if input is array (direction vector but not distance)");
                assertEqual(move2D(["1"], ["1"], ["1"]), [0, 0], "Should produce a default 2D vector if input is array (direction vector and distance)");

                assertEqual(move2D(["1", 1]), [0, 1], "Should produce a corrected 2D vector if input is wrong (no direction vector)");
                assertEqual(move2D(["1", 1], ["1", 1]), [0, 1], "Should produce a corrected 2D vector if input is wrong (direction vector but not distance)");
                assertEqual(move2D(["1", 1], ["1", 1], 1), [0, 2], "Should produce a corrected 2D vector if input is wrong (direction vector and distance)");
            }
            testUnit("vector", 9) {
                assertEqual(move2D([1]), [1, 0], "Should complete incomplete 2D vector (no direction vector)");
                assertEqual(move2D([1], [1]), [1, 0], "Should complete incomplete 2D vector (direction vector but not distance)");
                assertEqual(move2D([1], [1], 1), [2, 0], "Should complete incomplete 2D vector (direction vector and distance)");
                assertEqual(move2D([1, 2]), [1, 2], "Should return the provided 2D vector (no direction vector)");
                assertEqual(move2D([1, 2], [1, 2]), [1, 2], "Should return the provided 2D vector (direction vector but not distance)");
                assertEqual(move2D([1, 2], [1, 2], 1), [1, 2] + [1, 2] / norm2D([1, 2]), "Should return a 2D vector (direction vector and distance)");
                assertEqual(move2D([1, 2, 3]), [1, 2], "Should truncate too big vector and returns a 2D vector (no direction vector)");
                assertEqual(move2D([1, 2, 3], [1, 2, 3]), [1, 2], "Should truncate too big vector and returns a 2D vector (direction vector but not distance)");
                assertEqual(move2D([1, 2, 3], [1, 2, 3], 1), [1, 2] + [1, 2] / norm2D([1, 2]), "Should truncate too big vector and returns a 2D vector (direction vector and distance)");
            }
        }
        // test core/vector-2d/extend2D()
        testModule("extend2D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(extend2D(), [0, 0], "Should always produce a 2D vector, even if input is wrong");
            }
            testUnit("not vector", 15) {
                assertEqual(extend2D(1), [1, 1], "Should translate number to 2D vector (only origin)");
                assertEqual(extend2D(1, 1), [1, 1], "Should translate number to 2D vector (origin and second point)");
                assertEqual(extend2D(1, 2, 3), [1, 1] + unit2D([1, 1]) * 3, "Should translate number to 2D vector (all parameters)");

                assertEqual(extend2D(true), [0, 0], "Should produce a default 2D vector if input is boolean (only origin)");
                assertEqual(extend2D(true, true), [0, 0], "Should produce a default 2D vector if input is boolean (origin and second point)");
                assertEqual(extend2D(true, true, true), [0, 0], "Should produce a default 2D vector if input is boolean (all parameters)");

                assertEqual(extend2D("1"), [0, 0], "Should produce a default 2D vector if input is string (only origin)");
                assertEqual(extend2D("1", "1"), [0, 0], "Should produce a default 2D vector if input is string (origin and second point)");
                assertEqual(extend2D("1", "1", "1"), [0, 0], "Should produce a default 2D vector if input is string (all parameters)");

                assertEqual(extend2D(["1"]), [0, 0], "Should produce a default 2D vector if input is array (only origin)");
                assertEqual(extend2D(["1"], ["1"]), [0, 0], "Should produce a default 2D vector if input is array (origin and second point)");
                assertEqual(extend2D(["1"], ["1"], ["1"]), [0, 0], "Should produce a default 2D vector if input is array (all parameters)");

                assertEqual(extend2D(["1", 1]), [0, 1], "Should produce a corrected 2D vector if input is wrong (only origin)");
                assertEqual(extend2D(["1", 1], ["1", 1]), [0, 1], "Should produce a corrected 2D vector if input is wrong (origin and second point)");
                assertEqual(extend2D(["1", 1], ["1", 1], 1), [0, 1], "Should produce a corrected 2D vector if input is wrong (all parameters)");
            }
            testUnit("vector", 9) {
                assertEqual(extend2D([1]), [1, 0], "Should complete incomplete 2D vector (only origin)");
                assertEqual(extend2D([1], [1]), [1, 0], "Should complete incomplete 2D vector (origin and second point)");
                assertEqual(extend2D([1], [1], 1), [1, 0], "Should complete incomplete 2D vector (all parameters)");
                assertEqual(extend2D([1, 2]), [1, 2], "Should return the provided 2D vector (only origin)");
                assertEqual(extend2D([1, 2], [3, 4]), [1, 2], "Should return the provided 2D vector (origin and second point)");
                assertEqual(extend2D([1, 2], [3, 4], 3), [1, 2] + unit2D([2, 2]) * 3, "Should return a 2D vector (all parameters)");
                assertEqual(extend2D([1, 2, 3]), [1, 2], "Should truncate too big vector and returns a 2D vector (only origin)");
                assertEqual(extend2D([1, 2, 3], [4, 5, 6]), [1, 2], "Should truncate too big vector and returns a 2D vector (origin and second point)");
                assertEqual(extend2D([1, 2, 3], [3, 4, 5], 3), [1, 2] + unit2D([2, 2]) * 3, "Should truncate too big vector and returns a 2D vector (all parameters)");
            }
        }
        // test core/vector-2d/center2D()
        testModule("center2D()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(center2D(), [0, 0], "Without parameter the function should return the origin");
            }
            testUnit("wrong type", 5) {
                assertEqual(center2D("10", "10", "10"), [0, 0], "Cannot compute center of strings, should return the origin");
                assertEqual(center2D(true, true, true), [0, 0], "Cannot compute center of boolean, should return the origin");
                assertEqual(center2D([], [], []), [0, 0], "Cannot compute center of empty arrays, should return the origin");
                assertEqual(center2D(["1"], ["2"], ["3"]), [0, 0], "Cannot compute center of arrays, should return the origin");
                assertEqual(center2D([1, 1], [2, 2], [2]), [2, 1], "Cannot compute center with a vector radius, should return the point at the middle");
            }
            testUnit("positive", 5) {
                assertEqual(center2D(1, 2, 1), [2, 1], "Numbers should be converted to vectors");
                assertEqual(center2D([10, 20], [8, 16], 10), [9, 18] + ([-4, 2] / norm([-4, 2])) * sqrt(100 - pow(norm([-2, -4]) / 2, 2)), "Should compute the center of the circle");
                assertEqual(center2D([10], [8], 10), [9, 0] + ([0, 2] / norm([0, 2])) * sqrt(100 - pow(norm([2, 0]) / 2, 2)), "Should accept vector smaller than 2D, then upscale them and compute the center of the circle using 2D");
                assertEqual(center2D([10, 20, 30], [8, 16, 32], 10), [9, 18] + ([-4, 2] / norm([-4, 2])) * sqrt(100 - pow(norm([-2, -4]) / 2, 2)), "Should accept vector bigger than 2D, but should only compute the center of the circle using 2D");
                assertEqual(center2D([10, 20], [8, 16], 1), [9, 18], "Cannot compute the center if the radius is smaller than the distance between the points, should return the point at the middle");
            }
            testUnit("negative", 5) {
                assertEqual(center2D(1, 2, 1, true), [1, 2], "Numbers should be converted to vectors");
                assertEqual(center2D([10, 20], [8, 16], 10, true), [9, 18] + ([4, -2] / norm([4, -2])) * sqrt(100 - pow(norm([2, 4]) / 2, 2)), "Should compute the center of the circle");
                assertEqual(center2D([10], [8], 10, true), [9, 0] + ([0, -2] / norm([0, -2])) * sqrt(100 - pow(norm([-2, 0]) / 2, 2)), "Should accept vector smaller than 2D, then upscale them and compute the center of the circle using 2D");
                assertEqual(center2D([10, 20, 30], [8, 16, 32], 10, true), [9, 18] + ([4, -2] / norm([4, -2])) * sqrt(100 - pow(norm([2, 4]) / 2, 2)), "Should accept vector bigger than 2D, but should only compute the center of the circle using 2D");
                assertEqual(center2D([10, 20], [8, 16], 1, true), [9, 18], "Cannot compute the center if the radius is smaller than the distance between the points, should return the point at the middle");
            }
        }
        // test core/vector-2d/parallel2D()
        testModule("parallel2D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(parallel2D(), [[0, 0], [0, 0]], "Without parameter the function should return the origin");
            }
            testUnit("wrong type", 4) {
                assertEqual(parallel2D("10", "10", "10"), [[0, 0], [0, 0]], "Cannot compute parallel of strings");
                assertEqual(parallel2D(true, true, true), [[0, 0], [0, 0]], "Cannot compute parallel of boolean");
                assertEqual(parallel2D([], [], []), [[0, 0], [0, 0]], "Cannot compute parallel of empty arrays");
                assertEqual(parallel2D(["1"], ["2"], ["3"]), [[0, 0], [0, 0]], "Cannot compute parallel of arrays");
            }
            testUnit("check", 9) {
                assertApproxEqual(parallel2D(0, 1, 2), [[-2 * cos(135), -2 * sin(135)], [1 - 2 * cos(135), 1 - 2 * sin(135)]], "Numbers should be converted to vectors");
                assertApproxEqual(parallel2D([0, 0], [1, 1], 2), [[-2 * cos(135), -2 * sin(135)], [1 - 2 * cos(135), 1 - 2 * sin(135)]], "45° positive line with a distance of 2");
                assertApproxEqual(parallel2D([0, 0], [1, 1], -2), [[2 * cos(135), 2 * sin(135)], [1 + 2 * cos(135), 1 + 2 * sin(135)]], "45° positive line with a distance of -2");
                assertApproxEqual(parallel2D([0, 0], [-1, -1], 2), [[2 * cos(135), 2 * sin(135)], [-1 + 2 * cos(135), -1 + 2 * sin(135)]], "45° negative line with a distance of 2");
                assertApproxEqual(parallel2D([0, 0], [-1, -1], -2), [[-2 * cos(135), -2 * sin(135)], [-1 - 2 * cos(135), -1 - 2 * sin(135)]], "45° negative line with a distance of -2");
                assertEqual(parallel2D([0, 2], [3, 2], 3), [[0, -1], [3, -1]], "horizontal line with a distance of 3");
                assertEqual(parallel2D([0, 2], [3, 2], -3), [[0, 5], [3, 5]], "horizontal line with a distance of -3");
                assertEqual(parallel2D([4, -2], [4, 8], 3), [[7, -2], [7, 8]], "vertical line with a distance of 3");
                assertEqual(parallel2D([4, -2], [4, 8], -3), [[1, -2], [1, 8]], "vertical line with a distance of -3");
            }
        }
        // test core/vector-2d/intersect2D()
        testModule("intersect2D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(intersect2D(), [0, 0], "Without parameter the function should return the origin");
            }
            testUnit("wrong type", 4) {
                assertEqual(intersect2D("10", "10", "10", "10"), [0, 0], "Cannot compute intersection of strings, should return the origin");
                assertEqual(intersect2D(true, true, true, true), [0, 0], "Cannot compute intersection of boolean, should return the origin");
                assertEqual(intersect2D([], [], [], []), [0, 0], "Cannot compute intersection of empty arrays, should return the origin");
                assertEqual(intersect2D(["1"], ["2"], ["3"], ["4"]), [0, 0], "Cannot compute intersection of arrays, should return the origin");
            }
            testUnit("intersection", 6) {
                assertEqual(intersect2D(1, 2, 3, 4), [1, 1], "Numbers should be converted to vectors");
                assertEqual(intersect2D([1, 1], [2, 2], [3, 1], [4, 2]), [1, 1], "Parallel lines");
                assertEqual(intersect2D([1, 1], [2, 2], [1, 2], [2, 1]), [1.5, 1.5], "Perpendicular lines");
                assertEqual(intersect2D([0, -3], [1, 0], [0, 3], [1, 0]), [1, 0], "Lines crossing on X axis");
                assertEqual(intersect2D([-3, 0], [0, 1], [3, 0], [0, 1]), [0, 1], "Lines crossing on Y axis");
                assertEqual(intersect2D([-3, 1], [3, 8], [-2, 5], [7, 3]), [-3, 1] + (-38 / -75) * [6, 7], "Lines crossing on Y axis");
            }
        }
        // test core/vector-2d/tangent2D()
        testModule("tangent2D()", 5) {
            testUnit("no parameter", 1) {
                assertEqual(tangent2D(), [0, 0], "Without parameter the function should return the origin");
            }
            testUnit("wrong type", 4) {
                assertEqual(tangent2D("10", "10", "10"), [0, 0], "Cannot compute tangent of strings, should return the origin");
                assertEqual(tangent2D(true, true, true), [0, 0], "Cannot compute tangent of boolean, should return the origin");
                assertEqual(tangent2D([], [], []), [0, 0], "Cannot compute tangent of empty arrays, should return the origin");
                assertEqual(tangent2D(["1"], ["2"], ["3"]), [0, 0], "Cannot compute tangent of arrays, should return the origin");
            }
            testUnit("inside circle", 2) {
                assertApproxEqual(tangent2D(1, 2, 3), [1, 1], "Numbers should be converted to vectors");
                assertApproxEqual(tangent2D([6, 4], [5, 6], 3), [6, 4], "The point is inside the circle");
            }
            testUnit("positive", 9) {
                assertApproxEqual(tangent2D(3, 2, 1), [3, 2], "Numbers should be converted to vectors");
                assertApproxEqual(tangent2D([11, 5], [19, 11], 2), [11, 5] + arcPoint(sqrt(96), atan2(6, 8) + asin(2 / 10)), "First quadrant, a cicle on the right");
                assertApproxEqual(tangent2D([19, 11], [11, 5], 2), [19, 11] + arcPoint(sqrt(96), atan2(-6, -8) + asin(2 / 10)), "First quadrant, a cicle on the left");
                assertApproxEqual(tangent2D([-11, 5], [-19, 11], 2), [-11, 5] + arcPoint(sqrt(96), atan2(6, -8) + asin(2 / 10)), "Second quadrant, a cicle on the left");
                assertApproxEqual(tangent2D([-19, 11], [-11, 5], 2), [-19, 11] + arcPoint(sqrt(96), atan2(-6, 8) + asin(2 / 10)), "Second quadrant, a cicle on the right");
                assertApproxEqual(tangent2D([-11, -5], [-19, -11], 2), [-11, -5] + arcPoint(sqrt(96), atan2(-6, -8) + asin(2 / 10)), "Third quadrant, a cicle on the left");
                assertApproxEqual(tangent2D([-19, -11], [-11, -5], 2), [-19, -11] + arcPoint(sqrt(96), atan2(6, 8) + asin(2 / 10)), "Third quadrant, a cicle on the right");
                assertApproxEqual(tangent2D([11, -5], [19, -11], 2), [11, -5] + arcPoint(sqrt(96), atan2(-6, 8) + asin(2 / 10)), "Fourth quadrant, a cicle on the right");
                assertApproxEqual(tangent2D([19, -11], [11, -5], 2), [19, -11] + arcPoint(sqrt(96), atan2(6, -8) + asin(2 / 10)), "Fourth quadrant, a cicle on the left");
            }
            testUnit("negative", 9) {
                assertApproxEqual(tangent2D(3, 2, -1), [2, 3], "Numbers should be converted to vectors");
                assertApproxEqual(tangent2D([11, 5], [19, 11], -2), [11, 5] + arcPoint(sqrt(96), atan2(6, 8) + asin(-2 / 10)), "First quadrant, a cicle on the right");
                assertApproxEqual(tangent2D([19, 11], [11, 5], -2), [19, 11] + arcPoint(sqrt(96), atan2(-6, -8) + asin(-2 / 10)), "First quadrant, a cicle on the left");
                assertApproxEqual(tangent2D([-11, 5], [-19, 11], -2), [-11, 5] + arcPoint(sqrt(96), atan2(6, -8) + asin(-2 / 10)), "Second quadrant, a cicle on the left");
                assertApproxEqual(tangent2D([-19, 11], [-11, 5], -2), [-19, 11] + arcPoint(sqrt(96), atan2(-6, 8) + asin(-2 / 10)), "Second quadrant, a cicle on the right");
                assertApproxEqual(tangent2D([-11, -5], [-19, -11], -2), [-11, -5] + arcPoint(sqrt(96), atan2(-6, -8) + asin(-2 / 10)), "Third quadrant, a cicle on the left");
                assertApproxEqual(tangent2D([-19, -11], [-11, -5], -2), [-19, -11] + arcPoint(sqrt(96), atan2(6, 8) + asin(-2 / 10)), "Third quadrant, a cicle on the right");
                assertApproxEqual(tangent2D([11, -5], [19, -11], -2), [11, -5] + arcPoint(sqrt(96), atan2(-6, 8) + asin(-2 / 10)), "Fourth quadrant, a cicle on the right");
                assertApproxEqual(tangent2D([19, -11], [11, -5], -2), [19, -11] + arcPoint(sqrt(96), atan2(6, -8) + asin(-2 / 10)), "Fourth quadrant, a cicle on the left");
            }
        }
        // test core/vector-2d/circleLineIntersect2D()
        testModule("circleLineIntersect2D()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(circleLineIntersect2D(), [[0, 0], [0, 0]], "Without parameter the function cannot compute the intersection");
            }
            testUnit("wrong type", 4) {
                assertEqual(circleLineIntersect2D("10", "10", "10", "10"), [[0, 0], [0, 0]], "Cannot compute intersection of strings");
                assertEqual(circleLineIntersect2D(true, true, true, true), [[0, 0], [0, 0]], "Cannot compute intersection of booleans");
                assertEqual(circleLineIntersect2D([], [], [], []), [[0, 0], [0, 0]], "Cannot compute intersection of empty arrays");
                assertEqual(circleLineIntersect2D(["10"], ["10"], ["10"], ["10"]), [[0, 0], [0, 0]], "Cannot compute intersection of arrays");
            }
            testUnit("positive", 15) {
                assertApproxEqual(circleLineIntersect2D(1, 2, 3, 4), [vector2D((12 - sqrt(128)) / 4), vector2D((12 + sqrt(128)) / 4)], "Numbers should be converted to vectors");
                assertApproxEqual(circleLineIntersect2D([1, -1], [5, 3], [5, 4], 2), [vector2D((22 - sqrt(28)) / 4) - [0, 2], vector2D((22 + sqrt(28)) / 4) - [0, 2]], "45° line");
                assertApproxEqual(circleLineIntersect2D([1, 1], [5, 1], [3, 1], 1), [[2, 1], [4, 1]], "Horizontal centered line");
                assertApproxEqual(circleLineIntersect2D([1, 1], [1, 5], [1, 3], 1), [[1, 2], [1, 4]], "Vertical centered line");
                assertApproxEqual(circleLineIntersect2D([1, 1], [5, 1], [3, 2], 2), [[3 - sqrt(3), 1], [3 + sqrt(3), 1]], "Horizontal shifted line");
                assertApproxEqual(circleLineIntersect2D([1, 1], [1, 5], [2, 3], 2), [[1, 3 - sqrt(3)], [1, 3 + sqrt(3)]], "Vertical shifted line");
                assertApproxEqual(circleLineIntersect2D([1, 1], [5, 1], [3, 2], 1), [[3, 1], [3, 1]], "Horizontal tangent line");
                assertApproxEqual(circleLineIntersect2D([1, 1], [1, 5], [2, 3], 1), [[1, 3], [1, 3]], "Vertical tangent line");
                assertApproxEqual(circleLineIntersect2D([8, 0], [2, 12], [4, 3], sqrt(5)), [[6, 4], [6, 4]], "Leaned tangent line");
                assertApproxEqual(circleLineIntersect2D([6, 4], [6, 4], [4, 3], sqrt(5)), [[6, 4], [6, 4]], "Tangent point");
                assertApproxEqual(circleLineIntersect2D([2, 5], [8, 3], [5, 4], 3), [
                    vmul(vector2D((100 / 9 - sqrt(40)) / (20 / 9)), [1, -1 / 3]) + [0, 17 / 3],
                    vmul(vector2D((100 / 9 + sqrt(40)) / (20 / 9)), [1, -1 / 3]) + [0, 17 / 3]
                ], "Leaned line");
                assertApproxEqual(circleLineIntersect2D([2, 5], [8, 3], [10, 15], 3), [], "Leaned line, no intersection");
                assertApproxEqual(circleLineIntersect2D([1, 1], [5, 1], [3, 3], 1), [], "Horizontal line, no intersection");
                assertApproxEqual(circleLineIntersect2D([1, 1], [1, 5], [3, 3], 1), [], "Vertical line, no intersection");
                assertApproxEqual(circleLineIntersect2D([1, 1], [1, 1], [3, 3], 1), [], "Point, no intersection");
            }
            testUnit("negative", 15) {
                assertApproxEqual(circleLineIntersect2D(-1, -2, -3, -4), [vector2D((-12 - sqrt(128)) / 4), vector2D((-12 + sqrt(128)) / 4)], "Numbers should be converted to vectors");
                assertApproxEqual(circleLineIntersect2D([-1, 1], [-5, -3], [-5, -4], -2), [vector2D((-22 - sqrt(28)) / 4) + [0, 2], vector2D((-22 + sqrt(28)) / 4) + [0, 2]], "45° line");
                assertApproxEqual(circleLineIntersect2D([-1, -1], [-5, -1], [-3, -1], -1), [[-4, -1], [-2, -1]], "Horizontal centered line");
                assertApproxEqual(circleLineIntersect2D([-1, -1], [-1, -5], [-1, -3], -1), [[-1, -4], [-1, -2]], "Vertical centered line");
                assertApproxEqual(circleLineIntersect2D([-1, -1], [-5, -1], [-3, -2], -2), [[-3 - sqrt(3), -1], [-3 + sqrt(3), -1]], "Horizontal shifted line");
                assertApproxEqual(circleLineIntersect2D([-1, -1], [-1, -5], [-2, -3], -2), [[-1, -3 - sqrt(3)], [-1, -3 + sqrt(3)]], "Vertical shifted line");
                assertApproxEqual(circleLineIntersect2D([-1, -1], [-5, -1], [-3, -2], -1), [[-3, -1], [-3, -1]], "Horizontal tangent line");
                assertApproxEqual(circleLineIntersect2D([-1, -1], [-1, -5], [-2, -3], -1), [[-1, -3], [-1, -3]], "Vertical tangent line");
                assertApproxEqual(circleLineIntersect2D([-8, 0], [-2, -12], [-4, -3], sqrt(5)), [[-6, -4], [-6, -4]], "Leaned tangent line");
                assertApproxEqual(circleLineIntersect2D([-6, -4], [-6, -4], [-4, -3], sqrt(5)), [[-6, -4], [-6, -4]], "Tangent point");
                assertApproxEqual(circleLineIntersect2D([-2, -5], [-8, -3], [-5, -4], -3), [
                    vmul(vector2D((-100 / 9 - sqrt(40)) / (20 / 9)), [1, -1 / 3]) - [0, 17 / 3],
                    vmul(vector2D((-100 / 9 + sqrt(40)) / (20 / 9)), [1, -1 / 3]) - [0, 17 / 3]
                ], "Leaned line");
                assertApproxEqual(circleLineIntersect2D([-2, -5], [-8, -3], [-10, -15], -3), [], "Leaned line, no intersection");
                assertApproxEqual(circleLineIntersect2D([-1, -1], [-5, -1], [-3, -3], -1), [], "Horizontal line, no intersection");
                assertApproxEqual(circleLineIntersect2D([-1, -1], [-1, -5], [-3, -3], -1), [], "Vertical line, no intersection");
                assertApproxEqual(circleLineIntersect2D([-1, -1], [-1, -1], [-3, -3], -1), [], "Point, no intersection");
            }
        }
        // test core/vector-2d/circleIntersect2D()
        testModule("circleIntersect2D()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(circleIntersect2D(), [], "Without parameter the function cannot compute the intersection");
            }
            testUnit("wrong type", 4) {
                assertEqual(circleIntersect2D("10", "10", "10", "10"), [], "Cannot compute intersection of strings");
                assertEqual(circleIntersect2D(true, true, true, true), [], "Cannot compute intersection of booleans");
                assertEqual(circleIntersect2D([], [], [], []), [], "Cannot compute intersection of empty arrays");
                assertEqual(circleIntersect2D(["10"], ["10"], ["10"], ["10"]), [], "Cannot compute intersection of arrays");
            }
            testUnit("positive", 13) {
                assertApproxEqual(circleIntersect2D(1, 2, 3, 4), [[(2 - sqrt(28)) / 4, 1 - (2 - sqrt(28)) / 4], [(2 + sqrt(28)) / 4, 1 - (2 + sqrt(28)) / 4]], "Numbers should be converted to vectors");
                assertApproxEqual(circleIntersect2D([1, 1], 2, [3, 3], 4), [[(2 - sqrt(28)) / 4, 1 - (2 - sqrt(28)) / 4], [(2 + sqrt(28)) / 4, 1 - (2 + sqrt(28)) / 4]], "Circles aligned at 45°");
                assertApproxEqual(circleIntersect2D([3, 2], 3, [4, 5], 2), [
                    [((25 - 3 * sqrt(15)) / 3) / (20 / 9), 11 / 2 - ((25 - 3 * sqrt(15)) / 3) / (20 / 9) / 3],
                    [((25 + 3 * sqrt(15)) / 3) / (20 / 9), 11 / 2 - ((25 + 3 * sqrt(15)) / 3) / (20 / 9) / 3]
                ], "Intersecting circles");
                assertApproxEqual(circleIntersect2D([1, 1], 2, [3, 1], 2), [[0, 1 + sqrt(3)], [2, 1 + sqrt(3)]], "Circles aligned on horizontal axis");
                assertApproxEqual(circleIntersect2D([1, 1], 2, [1, 3], 2), [[1 + sqrt(3), 0], [1 + sqrt(3), 2]], "Circles aligned on vertical axis");
                assertApproxEqual(circleIntersect2D([1, 1], 2, [5, 1], 2), [[3, 1], [3, 1]], "Tangent circles on horizontal axis");
                assertApproxEqual(circleIntersect2D([1, 1], 2, [1, 5], 2), [[1, 3], [1, 3]], "Tangent circles on vertical axis");
                assertApproxEqual(circleIntersect2D([1, 1], 2, [1, 1] + [4 * cos(45), 4 * sin(45)], 2), [[1, 1] + [2 * cos(45), 2 * sin(45)], [1, 1] + [2 * cos(45), 2 * sin(45)]], "Tangent circles");
                assertApproxEqual(circleIntersect2D([1, 1], 2, [6, 1], 2), [], "Not intersecting circles aligned on horizontal axis");
                assertApproxEqual(circleIntersect2D([1, 1], 2, [1, 6], 2), [], "Not intersecting circles aligned on vertical axis");
                assertApproxEqual(circleIntersect2D([1, 1], 2, [1, 1], 3), [], "Concentric circles");
                assertApproxEqual(circleIntersect2D([1, 1], 2, [1, 1], 2), [], "Concentric and equal circles");
                assertApproxEqual(circleIntersect2D([1, 4], 2, [8, 3], 2), [], "Not intersecting circles");
            }
            testUnit("negative", 13) {
                assertApproxEqual(circleIntersect2D(-1, -2, -3, -4), [[(-2 - sqrt(28)) / 4, -1 - (-2 - sqrt(28)) / 4], [(-2 + sqrt(28)) / 4, -1 - (-2 + sqrt(28)) / 4]], "Numbers should be converted to vectors");
                assertApproxEqual(circleIntersect2D([-1, -1], -2, [-3, -3], -4), [[(-2 - sqrt(28)) / 4, -1 - (-2 - sqrt(28)) / 4], [(-2 + sqrt(28)) / 4, -1 - (-2 + sqrt(28)) / 4]], "Circles aligned at 45°");
                assertApproxEqual(circleIntersect2D([-3, -2], -3, [-4, -5], -2), [
                    [((-25 - 3 * sqrt(15)) / 3) / (20 / 9), -11 / 2 - ((-25 - 3 * sqrt(15)) / 3) / (20 / 9) / 3],
                    [((-25 + 3 * sqrt(15)) / 3) / (20 / 9), -11 / 2 - ((-25 + 3 * sqrt(15)) / 3) / (20 / 9) / 3]
                ], "Intersecting circles");
                assertApproxEqual(circleIntersect2D([-1, -1], -2, [-3, -1], -2), [[0, -1 + sqrt(3)], [-2, -1 + sqrt(3)]], "Circles aligned on horizontal axis");
                assertApproxEqual(circleIntersect2D([-1, -1], -2, [-1, -3], -2), [[-1 + sqrt(3), 0], [-1 + sqrt(3), -2]], "Circles aligned on vertical axis");
                assertApproxEqual(circleIntersect2D([-1, -1], -2, [-5, -1], -2), [[-3, -1], [-3, -1]], "Tangent circles on horizontal axis");
                assertApproxEqual(circleIntersect2D([-1, -1], -2, [-1, -5], -2), [[-1, -3], [-1, -3]], "Tangent circles on vertical axis");
                assertApproxEqual(circleIntersect2D([-1, -1], -2, [-1, -1] - [4 * cos(45), 4 * sin(45)], 2), [[-1, -1] - [2 * cos(45), 2 * sin(45)], [-1, -1] - [2 * cos(45), 2 * sin(45)]], "Tangent circles");
                assertApproxEqual(circleIntersect2D([-1, -1], -2, [-6, -1], -2), [], "Not intersecting circles aligned on horizontal axis");
                assertApproxEqual(circleIntersect2D([-1, -1], -2, [-1, -6], -2), [], "Not intersecting circles aligned on vertical axis");
                assertApproxEqual(circleIntersect2D([-1, -1], -2, [-1, -1], -3), [], "Concentric circles");
                assertApproxEqual(circleIntersect2D([-1, -1], -2, [-1, -1], -2), [], "Concentric and equal circles");
                assertApproxEqual(circleIntersect2D([-1, -4], -2, [-8, -3], -2), [], "Not intersecting circles");
            }
        }
        // test core/vector-2d/isosceles2D()
        testModule("isosceles2D()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(isosceles2D(), [0, 0], "Without parameter the function should return the origin");
            }
            testUnit("wrong type", 4) {
                assertEqual(isosceles2D("10", "10", "10"), [0, 0], "Cannot compute edge of strings, should return the origin");
                assertEqual(isosceles2D(true, true, true), [0, 0], "Cannot compute edge of boolean, should return the origin");
                assertEqual(isosceles2D([], [], []), [0, 0], "Cannot compute intersection of edge arrays, should return the origin");
                assertEqual(isosceles2D(["1"], ["2"], ["3"]), [0, 0], "Cannot compute edge of arrays, should return the origin");
            }
            testUnit("height", 7) {
                assertApproxEqual(isosceles2D(1, 2, 3), [1, 1] + arcPoint(pythagore(3, norm2D([1, 1]) / 2), 45 + atan2(3, norm2D([1, 1]) / 2)), "Numbers should be converted to vectors");
                assertApproxEqual(isosceles2D([10, 5], [20, 5], 10), [10, 5] + arcPoint(pythagore(10, 5), atan2(10, 5)), "Horizontal triangle, edge on the top");
                assertApproxEqual(isosceles2D([20, 5], [10, 5], 10), [20, 5] - arcPoint(pythagore(10, 5), atan2(10, 5)), "Horizontal triangle, edge on the bottom");
                assertApproxEqual(isosceles2D([5, 10], [5, 20], 10), [5, 10] + arcPoint(pythagore(10, 5), atan2(5, -10)), "Vertical triangle, edge on the left");
                assertApproxEqual(isosceles2D([5, 20], [5, 10], 10), [5, 20] - arcPoint(pythagore(10, 5), atan2(5, -10)), "Vertical triangle, edge on the right");
                assertApproxEqual(isosceles2D([10, 10], [18, 16], 10), [10, 10] + arcPoint(pythagore(10, 5), atan2(10, 5) + atan2(6, 8)), "Tilted triangle, edge on the top");
                assertApproxEqual(isosceles2D([18, 16], [10, 10], 10), [18, 16] - arcPoint(pythagore(10, 5), atan2(10, 5) + atan2(6, 8)), "Tilted triangle, edge on the bottom");
            }
            testUnit("angle", 7) {
                assertApproxEqual(isosceles2D(1, 2, angle=45), [1, 2], "Numbers should be converted to vectors");
                assertApproxEqual(isosceles2D([10, 5], [20, 5], angle=45), [15, 10], "Horizontal triangle, edge on the top");
                assertApproxEqual(isosceles2D([20, 5], [10, 5], angle=45), [15, 0], "Horizontal triangle, edge on the bottom");
                assertApproxEqual(isosceles2D([5, 10], [5, 20], angle=45), [0, 15], "Vertical triangle, edge on the left");
                assertApproxEqual(isosceles2D([5, 20], [5, 10], angle=45), [10, 15], "Vertical triangle, edge on the right");
                assertApproxEqual(isosceles2D([10, 10], [18, 16], angle=45), [11, 17], "Tilted triangle, edge on the top");
                assertApproxEqual(isosceles2D([18, 16], [10, 10], angle=45), [17, 9], "Tilted triangle, edge on the bottom");
            }
        }
        // test core/vector-2d/protractor()
        testModule("protractor()", 2) {
            testUnit("default value", 3) {
                assertEqual(protractor(), 0, "Should return 0 if no point was provided");
                assertEqual(protractor("1", "2"), 0, "Cannot compute angle of strings");
                assertEqual(protractor(true, true), 0, "Cannot compute angle of booleans");
            }
            testUnit("compute angle", 6) {
                assertEqual(protractor(1, 2), 45, "When single numbers are provided, they should be translated to vector.");
                assertEqual(protractor([3, 5], [3, 9]), 90, "Positive straight angle");
                assertEqual(protractor([3, 9], [3, 5]), -90, "Negative straight angle");
                assertEqual(protractor([3, 2], [6, 7]), atan2(5, 3), "Angle of a positive line");
                assertEqual(protractor([6, 7], [3, 2]), atan2(-5, -3), "Angle of a negative line");
                assertEqual(protractor([3, 2], [3, 2]), 0, "Angle of a point");
            }
        }
        // test core/vector-2d/angle2D()
        testModule("angle2D()", 2) {
            testUnit("default value", 3) {
                assertEqual(angle2D(), 0, "Should return 0 if no vector was provided");
                assertEqual(angle2D("1", "2"), 0, "Cannot compute angle of strings");
                assertEqual(angle2D(true, true), 0, "Cannot compute angle of booleans");
            }
            testUnit("compute angle", 5) {
                assertEqual(round(angle2D(1, 2)), 0, "When single numbers are provided, they should be translated to vector. Vectors with same direction does not have angle.");
                assertEqual(angle2D([1, 0], [0, 1]), 90, "Orthogonal vectors have an angle of 90°");
                assertEqual(angle2D([1, 0], [0, -1]), 90, "Orthogonal vectors have an angle of 90°, whatever their direction");
                assertEqual(angle2D([1, 0], [-1, 0]), 180, "Vectors with opposite direction have an angle of 180°");
                assertEqual(round(angle2D([1, 2], rotp([1, 2], 75))), 75, "Should have an angle of 75°");
            }
        }
        // test core/vector-2d/sinp()
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
        // test core/vector-2d/cosp()
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
        // test core/vector-2d/rotp()
        testModule("rotp()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(rotp(), [undef, undef], "Cannot compute rotation if no parameter is provided");
            }
            testUnit("wrong types", 5) {
                assertEqual(rotp("1", "2"), [undef, undef], "Cannot compute rotation from strings");
                assertEqual(rotp(1, 2), [undef, undef], "Cannot compute rotation from number");
                assertEqual(rotp([1], [2]), [undef, undef], "Cannot compute rotation from arrays");
                assertEqual(rotp([1], 90), [undef, undef], "Cannot compute rotation from incomplete vector");
                assertEqual(rotp(true, true), [undef, undef], "Cannot compute rotation from booleans");
            }
            testUnit("vector and angle", 4) {
                assertEqual(rotp([23, 67], 0), [23, 67], "Should return [23, 67]");
                assertEqual(rotp([23, 67], 290), _rot2([23, 67], 290), "Should return [23, 67] rotated by 290°");
                assertEqual(rotp([23, 67], -76), _rot2([23, 67], -76), "Should return [23, 67] rotated by -76°");
                assertEqual(rotp([23, 67], 464), _rot2([23, 67], 104), "Should return [23, 67] rotated by 104°");
            }
        }
        // test core/vector-2d/mirp()
        testModule("mirp()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(mirp(), [undef, undef], "Cannot compute mirror if no parameter is provided");
            }
            testUnit("wrong types", 5) {
                assertEqual(mirp("1", "2"), [undef, undef], "Cannot compute mirror from strings");
                assertEqual(mirp(1, 2), [undef, undef], "Cannot compute mirror from number");
                assertEqual(mirp([1], [2]), [undef, undef], "Cannot compute mirror from arrays");
                assertEqual(mirp([1], 90), [undef, undef], "Cannot compute mirror from incomplete vector");
                assertEqual(mirp(true, true), [undef, undef], "Cannot compute mirror from booleans");
            }
            testUnit("vector and axis", 3) {
                assertApproxEqual(mirp([23, 67], [1, 0]), [23, -67], "Should return [23, 67] mirrored around X");
                assertApproxEqual(mirp([23, 67], [0, 1]), [-23, 67], "Should return [23, 67] mirrored around Y");
                assertApproxEqual(mirp([23, 67], [1, 1]), [67, 23], "Should return [23, 67] mirrored around XY");
            }
        }
        // test core/vector-2d/arcp()
        testModule("arcp()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(arcp(), [undef, undef], "Cannot compute the point if no parameter is provided");
            }
            testUnit("wrong types", 4) {
                assertEqual(arcp("1", "2"), [undef, undef], "Cannot compute the point from strings");
                assertEqual(arcp(1, 1), [undef, undef], "Cannot compute the point from numbers");
                assertEqual(arcp(true, true), [undef, undef], "Cannot compute the point from booleans");
                assertEqual(arcp(["1", "2"]), [undef, undef], "Cannot compute the point from arrays");
            }
            testUnit("vector", 6) {
                assertEqual(arcp([]), [undef, undef], "Cannot compute the point from empty vector");
                assertEqual(arcp([], 30), [undef, undef], "Cannot compute the point from empty vector, event if angle is provided");
                assertEqual(arcp([10, 10]), [undef, undef], "Cannot compute the point without angle");
                assertEqual(arcp([10, 10], 45), [cos(45)*10, sin(45)*10], "Angle of 45 degrees");
                assertEqual(arcp([20, 10], 30), [cos(30)*20, sin(30)*10], "Angle of 30 degrees");
                assertEqual(arcp([10, 20], 60), [cos(60)*10, sin(60)*20], "Angle of 60 degrees");
            }
        }
        // test core/vector-2d/arcPoint()
        testModule("arcPoint()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(arcPoint(), [0, 0], "Should return [0, 0]");
            }
            testUnit("wrong types", 3) {
                assertEqual(arcPoint("1", "2"), [0, 0], "Strings are not valids, the function should return [0, 0]");
                assertEqual(arcPoint(true, true), [0, 0], "Booleans are not valids, the function should return [0, 0]");
                assertEqual(arcPoint(["1", "2"], ["1"]), [0, 0], "Arrays are not valids, the function should return [0, 0]");
            }
            testUnit("vector", 12) {
                assertEqual(arcPoint([]), [0, 0], "An empty vector should produce [0, 0]");
                assertEqual(arcPoint([], 30), [0, 0], "An empty vector should produce [0, 0], whatever the angle is");
                assertEqual(arcPoint(10), [10, 0], "A single number should be converted to vector");
                assertEqual(arcPoint([10, 10]), [10, 0], "Without angle, the vector should be projected on the X axis");
                assertEqual(arcPoint([10, 10], 45), [cos(45)*10, sin(45)*10], "Angle of 45 degrees");
                assertEqual(arcPoint([20, 10], 30), [cos(30)*20, sin(30)*10], "Angle of 30 degrees");
                assertEqual(arcPoint([10, 20], 60), [cos(60)*10, sin(60)*20], "Angle of 60 degrees");
                assertEqual(arcPoint([10, 20], 60, 30, 50), [cos(60)*30, sin(60)*50], "The X and Y parameters should replace the vector's coordinates");
                assertEqual(arcPoint(a=60, x=30, y=50), [cos(60)*30, sin(60)*50], "Should accept the radius as separated coordinates");
                assertEqual(arcPoint([10, 20], 360), [cos(0)*10, sin(0)*20], "Angle of 360 degrees should be equal to 0 degrees");
                assertEqual(arcPoint([10, 20], 420), [cos(60)*10, sin(60)*20], "Angle of 420 degrees should be equal to 60 degrees");
                assertEqual(arcPoint([10, 20], -20), [cos(340)*10, sin(340)*20], "Angle of -20 degrees should be equal to 340 degrees");
            }
        }
        // test core/vector-2d/rotate2D()
        testModule("rotate2D()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(rotate2D(), "Cannot rotate an empty list of points");
            }
            testUnit("wrong types", 3) {
                assertEqual(rotate2D("1", "2"), [[0, 0]], "Cannot rotate a string");
                assertEmptyArray(rotate2D(1, 1), [], "Cannot rotate a number");
                assertEmptyArray(rotate2D(true, true), [], "Cannot rotate a boolean");
            }
            testUnit("points", 6) {
                assertEqual(rotate2D([23, 67]), [[23, 23], [67, 67]], "Should upscale the numbers to vector 2D");
                assertEqual(rotate2D([23, 67], 290), [_rot2([23, 23], 290), _rot2([67, 67], 290)], "Should upscale the numbers to vector 2D and rotate them by 290°");

                assertEqual(rotate2D([[23, 67], [12, 9]]), [[23, 67], [12, 9]], "Should return [[23, 67], [12, 9]]");
                assertEqual(rotate2D([[23, 67], [12, 9]], 290), [_rot2([23, 67], 290), _rot2([12, 9], 290)], "Should return [[23, 67], [12, 9]] rotated by 290°");
                assertEqual(rotate2D([[23, 67], [12, 9]], -76), [_rot2([23, 67], -76), _rot2([12, 9], -76)], "Should return [[23, 67], [12, 9]] rotated by -76°");
                assertEqual(rotate2D([[23, 67], [12, 9]], 464), [_rot2([23, 67], 104), _rot2([12, 9], 104)], "Should return [[23, 67], [12, 9]] rotated by 104°");
            }
        }
        // test core/vector-2d/scale2D()
        testModule("scale2D()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(scale2D(), "Should return an empty list of points");
            }
            testUnit("wrong types", 3) {
                assertEqual(scale2D("1", "2"), [[0, 0]], "Cannot scale strings");
                assertEqual(scale2D([1], [2]), [[0, 0]], "Incomplete vectors should be adjusted");
                assertEqual(scale2D(true, true), [], "Cannot scale booleans");
            }
            testUnit("points", 4) {
                assertEqual(scale2D([[1, 1], [2, 2]]), [[1, 1], [2, 2]], "A default scale factor should be utilized if none is provided");
                assertEqual(scale2D([[1, 2], [5, 9]], 2), [[2, 4], [10, 18]], "When the scale factor is a single number it should be applied to all elements");
                assertEqual(scale2D([[3, 1.5], [2.3, 7]], [0.6, 1.5]), [[3*0.6, 1.5*1.5], [2.3*0.6, 7*1.5]], "When the scale factor is a vector its elements are applied respectively to each elements of the listed points");
                assertEqual(scale2D([[1], [8]], 3), [[3, 0], [24, 0]], "Incomplete vectors should be adjusted");
            }
        }
        // test core/vector-2d/resize2D()
        testModule("resize2D()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(resize2D(), "Should return an empty list of points");
            }
            testUnit("wrong types", 3) {
                assertEqual(resize2D("1", "2"), [[0, 0]], "Cannot resize strings");
                assertEqual(resize2D([1], [2]), [[0, 0]], "Incomplete vectors should be adjusted");
                assertEqual(resize2D(true, true), [], "Cannot resize booleans");
            }
            testUnit("points", 4) {
                assertEqual(resize2D([[1, 3], [5, 9]]), [[1, 3], [5, 9]], "No change will be made if no size is provided");
                assertEqual(resize2D([[1, 3], [5, 9]], 2), [[1*2/4, 3*2/6], [5*2/4, 9*2/6]], "When the size is a single number it should be applied to all elements");
                assertEqual(resize2D([[1, 3], [5, 9]], [2, 3]), [[1*2/4, 3*3/6], [5*2/4, 9*3/6]], "When the size is a vector its elements are applied respectively to each elements of the listed points");
                assertEqual(resize2D([[1], [8]], 3), [[1*3/7, 0], [8*3/7, 0]], "Incomplete vectors should be adjusted");
            }
        }
        // test core/vector-2d/mirror2D()
        testModule("mirror2D()", 3) {
            testUnit("no parameter", 1) {
                assertEmptyArray(mirror2D(), "Should return an empty list of points");
            }
            testUnit("wrong types", 3) {
                assertEqual(mirror2D("1", "2"), [[0, 0]], "Cannot mirror strings");
                assertApproxEqual(mirror2D([1]), [[-1, 1]], "Incomplete vectors should be adjusted");
                assertEmptyArray(mirror2D(true, true), "Cannot mirror booleans");
            }
            testUnit("points", 6) {
                assertApproxEqual(mirror2D([[5, 9]]), [[-5, 9]], "Should mirror the points around the Y axis (default)");
                assertApproxEqual(mirror2D([[5, 9]], [1, 0]), [[5, -9]], "Should mirror the points around the X axis");
                assertApproxEqual(mirror2D([[3, 4]], [1, 1]), [[4, 3]], "Should mirror the points around the diagonal XY axis");

                assertApproxEqual(mirror2D([[1, 3], [5, 9]]), [[-1, 3], [-5, 9]], "Should mirror the points around the Y axis (default)");
                assertApproxEqual(mirror2D([[1, 3], [5, 9]], [1, 0]), [[1, -3], [5, -9]], "Should mirror the points around the X axis");
                assertApproxEqual(mirror2D([[1, 3], [5, 9]], [1, 1]), [[3, 1], [9, 5]], "Should mirror the points around the XY axis");
            }
        }
        // test core/vector-2d/scaleFactor2D()
        testModule("scaleFactor2D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(scaleFactor2D(), [1, 1], "If no list nor size are provided, should return a neutral scale factor");
            }
            testUnit("wrong types", 3) {
                assertEqual(scaleFactor2D("1", "2"), [1, 1], "Cannot resize strings, should return a neutral scale factor");
                assertEqual(scaleFactor2D([1], [2]), [2, 1], "Incomplete vectors should be adjusted, should return a neutral scale factor");
                assertEqual(scaleFactor2D(true, true), [1, 1], "Cannot resize booleans, should return a neutral scale factor");
            }
            testUnit("vectors", 9) {
                assertEqual(scaleFactor2D([[1], [5]]), [1, 1], "Should return a default scale factor if no size is provided, incomplete vectors should be completed");
                assertEqual(scaleFactor2D([[1, 2, 3], [5, 9, 2]]), [1, 1], "Should return a default scale factor if no size is provided, 2D vectors should be supported");
                assertEqual(scaleFactor2D([[1, 2, 3, 4], [5, 9, 2, -3]]), [1, 1], "Should return a default scale factor if no size is provided, too big vectors should be truncated");

                assertEqual(scaleFactor2D([[1], [5]], 2), [2/4, 2], "When the size is a single number it should be applied to all elements, incomplete vectors should be completed");
                assertEqual(scaleFactor2D([[1, 2, 3], [5, 9, 2]], 2), [2/4, 2/7], "When the size is a single number it should be applied to all elements, 2D vectors should be supported");
                assertEqual(scaleFactor2D([[1, 2, 3, 4], [5, 9, 2, 7]], 2), [2/4, 2/7], "When the size is a single number it should be applied to all elements, too big vectors should be truncated");

                assertEqual(scaleFactor2D([[1], [5]], [2]), [2/4, 1], "When the size is a vector its elements are applied respectively to each elements of the listed points, incomplete vectors should be completed");
                assertEqual(scaleFactor2D([[1, 2], [5, 9]], [2, 3]), [2/4, 3/7], "When the size is a vector its elements are applied respectively to each elements of the listed points, 2D vectors should be supported");
                assertEqual(scaleFactor2D([[1, 2, 3, 4], [5, 9, 2, 7]], [2, 3, 4]), [2/4, 3/7], "When the size is a vector its elements are applied respectively to each elements of the listed points, too big vectors should be truncated");
            }
        }
        // test core/vector-2d/dimensions2D()
        testModule("dimensions2D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(dimensions2D(), [0, 0], "Cannot get dimensions if the list is missing");
            }
            testUnit("wrong types", 3) {
                assertEqual(dimensions2D("2"), [0, 0], "Cannot get dimensions from string");
                assertEqual(dimensions2D(2), [0, 0], "Cannot get dimensions from single number");
                assertEqual(dimensions2D(true), [0, 0], "Cannot get dimensions from boolean");
            }
            testUnit("vectors", 9) {
                assertEqual(dimensions2D([[1]]), [0, 0], "A single point has no dimensions, incomplete vectors should be completed");
                assertEqual(dimensions2D([[1, 2]]), [0, 0], "A single point has no dimensions, 2D vectors should be supported");
                assertEqual(dimensions2D([[1, 2, 3, 4]]), [0, 0], "A single point has no dimensions, too big vectors should be truncated");

                assertEqual(dimensions2D([[1], [5]]), [4, 0], "Should return a the dimensions if at least 2 points are provided, incomplete vectors should be completed");
                assertEqual(dimensions2D([[1, 2, 3], [5, 9, -2]]), [4, 7], "Should return a the dimensions if at least 2 points are provided, 2D vectors should be supported");
                assertEqual(dimensions2D([[1, 2, 3], [5, 9, -2]]), [4, 7], "Should return a the dimensions if at least 2 points are provided, too big vectors should be truncated");

                assertEqual(dimensions2D([[1], [5], [3], [-2]]), [7, 0], "Should return a the dimensions with respect to all points, incomplete vectors should be completed");
                assertEqual(dimensions2D([[1, 2, 3], [5, 9], [3, 2], [-2, -6]]), [7, 15], "Should return a the dimensions with respect to all points, 2D vectors should be supported");
                assertEqual(dimensions2D([[1, 2, 3, 4], [5, 9, -2, -5], [3, 2, 7, 8], [-2, -6, 0, 3]]), [7, 15], "Should return a the dimensions with respect to all points, too big vectors should be truncated");
            }
        }
        // test core/vector-2d/boundaries2D()
        testModule("boundaries2D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(boundaries2D(), [[0, 0], [0, 0]], "Cannot get boundaries if the list is missing");
            }
            testUnit("wrong types", 3) {
                assertEqual(boundaries2D("2"), [[0, 0], [0, 0]], "Cannot get boundaries from string");
                assertEqual(boundaries2D(2), [[0, 0], [0, 0]], "Cannot get boundaries from single number");
                assertEqual(boundaries2D(true), [[0, 0], [0, 0]], "Cannot get boundaries from boolean");
            }
            testUnit("vectors", 9) {
                assertEqual(boundaries2D([[1]]), [[1, 0], [1, 0]], "A single point is its own boundaries, incomplete vectors should be completed");
                assertEqual(boundaries2D([[1, 2]]), [[1, 2], [1, 2]], "A single point is its own boundaries, 2D vectors should be supported");
                assertEqual(boundaries2D([[1, 2, 3, 4]]), [[1, 2], [1, 2]], "A single point is its own boundaries, too big vectors should be truncated");

                assertEqual(boundaries2D([[1], [5]]), [[1, 0], [5, 0]], "Boundaries of 2 points, incomplete vectors should be completed");
                assertEqual(boundaries2D([[1, 2], [5, 9]]), [[1, 2], [5, 9]], "Boundaries of 2 points, 2D vectors should be supported");
                assertEqual(boundaries2D([[1, 2, 3, 4], [5, 9, -2, 8]]), [[1, 2], [5, 9]], "Boundaries of 2 points, too big vectors should be truncated");

                assertEqual(boundaries2D([[1], [5], [3], [-2]]), [[-2, 0], [5, 0]], "Boundaries of several points, incomplete vectors should be completed");
                assertEqual(boundaries2D([[1, 2], [5, 9], [3, 2], [-2, -6]]), [[-2, -6], [5, 9]], "Boundaries of several points, 2D vectors should be supported");
                assertEqual(boundaries2D([[1, 2, 3, 4], [5, 9, -2, 8], [3, 2, 7, 5], [-2, -6, 0, 1]]), [[-2, -6], [5, 9]], "Boundaries of several points, too big vectors should be truncated");
            }
        }
    }
    function _rot2(v, a) = [
        v[0] * cos(a) - v[1] * sin(a),
        v[1] * cos(a) + v[0] * sin(a)
    ];
}

testCoreVector2D();
