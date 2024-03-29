/**
 * @license
 * MIT License
 *
 * Copyright (c) 2017-2022 Jean-Sebastien CONAN
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
 * Unit tests: 3D vectors handling.
 *
 * @package test/core/vector
 * @author jsconan
 */
module testCoreVector3D() {
    testPackage("core/vector-3d.scad", 21) {
        // test core/vector-3d/vector3D()
        testModule("vector3D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(vector3D(), [0, 0, 0], "Should always produce a 3D vector, even if input is wrong");
            }
            testUnit("not vector", 5) {
                assertEqual(vector3D(1), [1, 1, 1], "Should produce a 3D vector with the input number as a coordinate");
                assertEqual(vector3D(true), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(vector3D("1"), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(vector3D(["1"]), [0, 0, 0], "Should produce a 3D vector filled with 0 if input is wrong");
                assertEqual(vector3D(["1", 1]), [0, 1, 0], "Should produce a corrected 3D vector if input is wrong");
            }
            testUnit("vector", 4) {
                assertEqual(vector3D([1]), [1, 0, 0], "Should complete incomplete 3D vector");
                assertEqual(vector3D([1, 2]), [1, 2, 0], "Should complete incomplete 3D vector");
                assertEqual(vector3D([1, 2, 3]), [1, 2, 3], "Should keep correct and complete 3D vector");
                assertEqual(vector3D([1, 2, 3, 4]), [1, 2, 3], "Should truncate too big vector");
            }
        }
        // test core/vector-3d/divisor3D()
        testModule("divisor3D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(divisor3D(), [1, 1, 1], "Should always produce a 3D vector, even if input is wrong");
            }
            testUnit("not vector", 6) {
                assertEqual(divisor3D(1), [1, 1, 1], "Should produce a 3D vector with the input number as a coordinate");
                assertEqual(divisor3D(true), [1, 1, 1], "Should produce a 3D vector filled with 1 if input is wrong");
                assertEqual(divisor3D(false), [1, 1, 1], "Should produce a 3D vector filled with 1 if input is wrong");
                assertEqual(divisor3D("2"), [1, 1, 1], "Should produce a 3D vector filled with 1 if input is wrong");
                assertEqual(divisor3D(["3"]), [1, 1, 1], "Should produce a 3D vector filled with 1 if input is wrong");
                assertEqual(divisor3D(["4", 3]), [1, 3, 1], "Should produce a corrected 3D vector if input is wrong");
            }
            testUnit("vector", 5) {
                assertEqual(divisor3D([2]), [2, 1, 1], "Should complete incomplete 3D vector");
                assertEqual(divisor3D([0, 0, 0]), [1, 1, 1], "Should correct 0 3D vector");
                assertEqual(divisor3D([3, 2]), [3, 2, 1], "Should complete incomplete 3D vector");
                assertEqual(divisor3D([1, 2, 3]), [1, 2, 3], "Should keep correct and complete 3D vector");
                assertEqual(divisor3D([1, 2, 3, 4]), [1, 2, 3], "Should truncate too big vector");
            }
        }
        // test core/vector-3d/apply3D()
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
        // test core/vector-3d/xAxis3D()
        testModule("xAxis3D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(xAxis3D(), [1, 0, 0], "Should always produce a 3D vector with a default value for the X-axis");
            }
            testUnit("not number", 4) {
                assertEqual(xAxis3D(undef), [1, 0, 0], "Should always produce a 3D vector with a default value for the X-axis when the value is undefined");
                assertEqual(xAxis3D(true), [1, 0, 0], "Should always produce a 3D vector with a default value for the X-axis when the value is a boolean");
                assertEqual(xAxis3D("2"), [1, 0, 0], "Should always produce a 3D vector with a default value for the X-axis when the value is a string");
                assertEqual(xAxis3D([3, 4]), [1, 0, 0], "Should always produce a 3D vector with a default value for the X-axis when the value is a vector");
            }
            testUnit("number", 3) {
                assertEqual(xAxis3D(3), [3, 0, 0], "Should take the given value for the X-axis: [3, 0, 0]");
                assertEqual(xAxis3D(5.4), [5.4, 0, 0], "Should take the given value for the X-axis: [5.4, 0, 0]");
                assertEqual(xAxis3D(-1.2), [-1.2, 0, 0], "Should take the given value for the X-axis: [-1.2, 0, 0]");
            }
        }
        // test core/vector-3d/yAxis3D()
        testModule("yAxis3D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(yAxis3D(), [0, 1, 0], "Should always produce a 3D vector with a default value for the Y-axis");
            }
            testUnit("not number", 4) {
                assertEqual(yAxis3D(undef), [0, 1, 0], "Should always produce a 3D vector with a default value for the Y-axis when the value is undefined");
                assertEqual(yAxis3D(true), [0, 1, 0], "Should always produce a 3D vector with a default value for the Y-axis when the value is a boolean");
                assertEqual(yAxis3D("2"), [0, 1, 0], "Should always produce a 3D vector with a default value for the Y-axis when the value is a string");
                assertEqual(yAxis3D([3, 4]), [0, 1, 0], "Should always produce a 3D vector with a default value for the Y-axis when the value is a vector");
            }
            testUnit("number", 3) {
                assertEqual(yAxis3D(3), [0, 3, 0], "Should take the given value for the Y-axis: [0, 3, 0]");
                assertEqual(yAxis3D(5.4), [0, 5.4, 0], "Should take the given value for the Y-axis: [0, 5.4, 0]");
                assertEqual(yAxis3D(-1.2), [0, -1.2, 0], "Should take the given value for the Y-axis: [0, -1.2, 0]");
            }
        }
        // test core/vector-3d/zAxis3D()
        testModule("zAxis3D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(zAxis3D(), [0, 0, 1], "Should always produce a 3D vector with a default value for the Z-axis");
            }
            testUnit("not number", 4) {
                assertEqual(zAxis3D(undef), [0, 0, 1], "Should always produce a 3D vector with a default value for the Z-axis when the value is undefined");
                assertEqual(zAxis3D(true), [0, 0, 1], "Should always produce a 3D vector with a default value for the Z-axis when the value is a boolean");
                assertEqual(zAxis3D("2"), [0, 0, 1], "Should always produce a 3D vector with a default value for the Z-axis when the value is a string");
                assertEqual(zAxis3D([3, 4]), [0, 0, 1], "Should always produce a 3D vector with a default value for the Z-axis when the value is a vector");
            }
            testUnit("number", 3) {
                assertEqual(zAxis3D(3), [0, 0, 3], "Should take the given value for the Z-axis: [0, 0, 3]");
                assertEqual(zAxis3D(5.4), [0, 0, 5.4], "Should take the given value for the Z-axis: [0, 0, 5.4]");
                assertEqual(zAxis3D(-1.2), [0, 0, -1.2], "Should take the given value for the Z-axis: [0, 0, -1.2]");
            }
        }
        // test core/vector-3d/unit3D()
        testModule("unit3D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(unit3D(), [0, 0, 0], "Should always produce a normalized 3D vector, even if input is wrong");
            }
            testUnit("not vector", 6) {
                assertEqual(unit3D(1), [1, 1, 1] / norm([1, 1, 1]), "Should produce a normalized 3D vector with the input number as a coordinate");
                assertEqual(unit3D(true), [0, 0, 0], "Should produce a normalized 3D vector filled with 0 if input is wrong");
                assertEqual(unit3D("1"), [0, 0, 0], "Should produce a normalized 3D vector filled with 0 if input is wrong");
                assertEqual(unit3D(["1"]), [0, 0, 0], "Should produce a normalized 3D vector filled with 0 if input is wrong");
                assertEqual(unit3D(["1", 1]), [0, 1, 0] / norm([0, 1, 0]), "Should produce a normalized corrected 3D vector if input is wrong");
                assertEqual(unit3D(["1", 1, 1]), [0, 1, 1] / norm([0, 1, 1]), "Should produce a normalized corrected 3D vector if input is wrong");
            }
            testUnit("vector", 4) {
                assertEqual(unit3D([1]), [1, 0, 0] / norm([1, 0, 0]), "Should complete incomplete 3D vector and returns a normalized 3D vector");
                assertEqual(unit3D([1, 2]), [1, 2, 0] / norm([1, 2, 0]), "Should complete incomplete 3D vector and returns a normalized 3D vector");
                assertEqual(unit3D([1, 2, 3]), [1, 2, 3] / norm([1, 2, 3]), "Should return a normalized 3D vector");
                assertEqual(unit3D([1, 2, 3, 4]), [1, 2, 3] / norm([1, 2, 3]), "Should truncate too big vector and returns a normalized 3D vector");
            }
        }
        // test core/vector-3d/middle3D()
        testModule("middle3D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(middle3D(), [0, 0, 0], "Should always produce a 3D vector, even if input is wrong");
            }
            testUnit("not vector", 14) {
                assertEqual(middle3D(a=1), [0.5, 0.5, 0.5], "If the second point is missing, assume its the origin");
                assertEqual(middle3D(b=1), [0.5, 0.5, 0.5], "If the first point is missing, assume its the origin");
                assertEqual(middle3D(a=[1], b=1), [1, 0.5, 0.5], "Should complete the first point if incomplete, should translate the second point to vector if number given");
                assertEqual(middle3D(a=1, b=[1]), [1, 0.5, 0.5], "Should translate the first point to vector if number given, should complete the second point if incomplete");
                assertEqual(middle3D(a=true), [0, 0, 0], "Should produce a 3D vector filled with 0 if first point is boolean");
                assertEqual(middle3D(b=true), [0, 0, 0], "Should produce a 3D vector filled with 0 if second point is boolean");
                assertEqual(middle3D(a="1"), [0, 0, 0], "Should produce a 3D vector filled with 0 if first point is string");
                assertEqual(middle3D(b="1"), [0, 0, 0], "Should produce a 3D vector filled with 0 if second point is string");
                assertEqual(middle3D(a=["1"]), [0, 0, 0], "Should produce a 3D vector filled with 0 if first point is array of strings");
                assertEqual(middle3D(b=["1"]), [0, 0, 0], "Should produce a 3D vector filled with 0 if second point is array of strings");
                assertEqual(middle3D(a=["1", 1]), [0, .5, 0], "Should produce a corrected 3D vector if first point is wrong or incomplete");
                assertEqual(middle3D(a=["1", 1, 1]), [0, .5, .5], "Should produce a corrected 3D vector if first point is wrong");
                assertEqual(middle3D(b=["1", 1]), [0, .5, 0], "Should produce a corrected 3D vector if second point is wrong or incomplete");
                assertEqual(middle3D(b=["1", 1, 1]), [0, .5, .5], "Should produce a corrected 3D vector if second point is wrong");
            }
            testUnit("vector", 7) {
                assertEqual(middle3D([1]), [.5, 0, 0], "Should complete incomplete 3D vector, assume missing point to origin");
                assertEqual(middle3D([1], [2]), [1.5, 0, 0], "Should complete incomplete 3D vector");
                assertEqual(middle3D([1, 2]), [0.5, 1, 0], "Should complete incomplete 3D vector, assume missing point to origin");
                assertEqual(middle3D([1, 2], [2, 3]), [1.5, 2.5, 0], "Should complete incomplete 3D vector");
                assertEqual(middle3D([1, 2, 3]), [0.5, 1, 1.5], "Should return a 3D vector, assume missing point to origin");
                assertEqual(middle3D([1, 2, 3], [4, 5, 6]), [2.5, 3.5, 4.5], "Should return a 3D vector");
                assertEqual(middle3D([1, 2, 3, 4], [4, 5, 6, 7]), [2.5, 3.5, 4.5], "Should truncate too big vector");
            }
        }
        // test core/vector-3d/move3D()
        testModule("move3D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(move3D(), [0, 0, 0], "Should always produce a 3D vector, even if input is wrong");
            }
            testUnit("not vector", 18) {
                assertEqual(move3D(1), [1, 1, 1], "Should translate number to 3D vector (no direction vector)");
                assertEqual(move3D(1, 1), [1, 1, 1], "Should translate number to 3D vector (direction vector but not distance)");
                assertEqual(move3D(1, 1, 1), [1, 1, 1] + [1, 1, 1] / norm([1, 1, 1]), "Should translate number to 3D vector (direction vector and distance)");

                assertEqual(move3D(true), [0, 0, 0], "Should produce a default 3D vector if input is boolean (no direction vector)");
                assertEqual(move3D(true, true), [0, 0, 0], "Should produce a default 3D vector if input is boolean (direction vector but not distance)");
                assertEqual(move3D(true, true, true), [0, 0, 0], "Should produce a default 3D vector if input is boolean (direction vector and distance)");

                assertEqual(move3D("1"), [0, 0, 0], "Should produce a default 3D vector if input is string (no direction vector)");
                assertEqual(move3D("1", "1"), [0, 0, 0], "Should produce a default 3D vector if input is string (direction vector but not distance)");
                assertEqual(move3D("1", "1", "1"), [0, 0, 0], "Should produce a default 3D vector if input is string (direction vector and distance)");

                assertEqual(move3D(["1"]), [0, 0, 0], "Should produce a default 3D vector if input is array (no direction vector)");
                assertEqual(move3D(["1"], ["1"]), [0, 0, 0], "Should produce a default 3D vector if input is array (direction vector but not distance)");
                assertEqual(move3D(["1"], ["1"], ["1"]), [0, 0, 0], "Should produce a default 3D vector if input is array (direction vector and distance)");

                assertEqual(move3D(["1", 1]), [0, 1, 0], "Should produce a corrected 3D vector if input is wrong or incomplete (no direction vector)");
                assertEqual(move3D(["1", 1], ["1", 1]), [0, 1, 0], "Should produce a corrected 3D vector if input is wrong or incomplete (direction vector but not distance)");
                assertEqual(move3D(["1", 1], ["1", 1], 1), [0, 1, 0] + [0, 1, 0] / norm([0, 1, 0]), "Should produce a corrected 3D vector if input is wrong or incomplete (direction vector and distance)");

                assertEqual(move3D(["1", 1, 1]), [0, 1, 1], "Should produce a corrected 3D vector if input is wrong (no direction vector)");
                assertEqual(move3D(["1", 1, 1], ["1", 1, 1]), [0, 1, 1], "Should produce a corrected 3D vector if input is wrong (direction vector but not distance)");
                assertEqual(move3D(["1", 1, 1], ["1", 1, 1], 1), [0, 1, 1] + [0, 1, 1] / norm([0, 1, 1]), "Should produce a corrected 3D vector if input is wrong (direction vector and distance)");
            }
            testUnit("vector", 12) {
                assertEqual(move3D([1]), [1, 0, 0], "Should complete incomplete 3D vector (no direction vector)");
                assertEqual(move3D([1], [1]), [1, 0, 0], "Should complete incomplete 3D vector (direction vector but not distance)");
                assertEqual(move3D([1], [1], 1), [1, 0, 0] + [1, 0, 0] / norm([1, 0, 0]), "Should complete incomplete 3D vector (direction vector and distance)");

                assertEqual(move3D([1, 2]), [1, 2, 0], "Should complete incomplete 3D vector (no direction vector)");
                assertEqual(move3D([1, 2], [1, 2]), [1, 2, 0], "Should complete incomplete 3D vector (direction vector but not distance)");
                assertEqual(move3D([1, 2], [1, 2], 1), [1, 2, 0] + [1, 2, 0] / norm([1, 2, 0]), "Should complete incomplete 3D vector (direction vector and distance)");

                assertEqual(move3D([1, 2, 3]), [1, 2, 3], "Should return the provided 3D vector (no direction vector)");
                assertEqual(move3D([1, 2, 3], [1, 2, 3]), [1, 2, 3], "Should return the provided 3D vector (direction vector but not distance)");
                assertEqual(move3D([1, 2, 3], [1, 2, 3], 1), [1, 2, 3] + [1, 2, 3] / norm([1, 2, 3]), "Should return a 3D vector (direction vector and distance)");

                assertEqual(move3D([1, 2, 3, 4]), [1, 2, 3], "Should truncate too big vector and returns a 3D vector (no direction vector)");
                assertEqual(move3D([1, 2, 3, 4], [1, 2, 3, 4]), [1, 2, 3], "Should truncate too big vector and returns a 3D vector (direction vector but not distance)");
                assertEqual(move3D([1, 2, 3, 4], [1, 2, 3, 4], 1), [1, 2, 3] + [1, 2, 3] / norm([1, 2, 3]), "Should truncate too big vector and returns a 3D vector (direction vector and distance)");
            }
        }
        // test core/vector-3d/extend3D()
        testModule("extend3D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(extend3D(), [0, 0, 0], "Should always produce a 3D vector, even if input is wrong");
            }
            testUnit("not vector", 18) {
                assertEqual(extend3D(1), [1, 1, 1], "Should translate number to 3D vector (only origin)");
                assertEqual(extend3D(1, 1), [1, 1, 1], "Should translate number to 3D vector (origin and second point)");
                assertEqual(extend3D(1, 2, 3), [1, 1, 1] + unit3D([1, 1, 1]) * 3, "Should translate number to 3D vector (all parameters)");

                assertEqual(extend3D(true), [0, 0, 0], "Should produce a default 3D vector if input is boolean (only origin)");
                assertEqual(extend3D(true, true), [0, 0, 0], "Should produce a default 3D vector if input is boolean (origin and second point)");
                assertEqual(extend3D(true, true, true), [0, 0, 0], "Should produce a default 3D vector if input is boolean (all parameters)");

                assertEqual(extend3D("1"), [0, 0, 0], "Should produce a default 3D vector if input is string (only origin)");
                assertEqual(extend3D("1", "1"), [0, 0, 0], "Should produce a default 3D vector if input is string (origin and second point)");
                assertEqual(extend3D("1", "1", "1"), [0, 0, 0], "Should produce a default 3D vector if input is string (all parameters)");

                assertEqual(extend3D(["1"]), [0, 0, 0], "Should produce a default 3D vector if input is array (only origin)");
                assertEqual(extend3D(["1"], ["1"]), [0, 0, 0], "Should produce a default 3D vector if input is array (origin and second point)");
                assertEqual(extend3D(["1"], ["1"], ["1"]), [0, 0, 0], "Should produce a default 3D vector if input is array (all parameters)");

                assertEqual(extend3D(["1", 1]), [0, 1, 0], "Should produce a corrected 3D vector if input is wrong or incomplete (only origin)");
                assertEqual(extend3D(["1", 1], ["1", 1]), [0, 1, 0], "Should produce a corrected 3D vector if input is wrong or incomplete (origin and second point)");
                assertEqual(extend3D(["1", 1], ["1", 1], 1), [0, 1, 0], "Should produce a corrected 3D vector if input is wrong or incomplete (all parameters)");

                assertEqual(extend3D(["1", 1, 1]), [0, 1, 1], "Should produce a corrected 3D vector if input is wrong (only origin)");
                assertEqual(extend3D(["1", 1, 1], ["1", 1, 1]), [0, 1, 1], "Should produce a corrected 3D vector if input is wrong (origin and second point)");
                assertEqual(extend3D(["1", 1, 1], ["1", 1, 1], 1), [0, 1, 1], "Should produce a corrected 3D vector if input is wrong (all parameters)");
            }
            testUnit("vector", 12) {
                assertEqual(extend3D([1]), [1, 0, 0], "Should complete incomplete 3D vector (only origin)");
                assertEqual(extend3D([1], [2]), [1, 0, 0], "Should complete incomplete 3D vector (origin and second point)");
                assertEqual(extend3D([1], [2], 3), [1, 0, 0] + unit3D([1, 0, 0]) * 3, "Should complete incomplete 3D vector (all parameters)");

                assertEqual(extend3D([1, 2]), [1, 2, 0], "Should complete incomplete 3D vector (only origin)");
                assertEqual(extend3D([1, 2], [3, 4]), [1, 2, 0], "Should complete incomplete 3D vector (origin and second point)");
                assertEqual(extend3D([1, 2], [3, 4], 3), [1, 2, 0] + unit3D([2, 2, 0]) * 3, "Should complete incomplete 3D vector (all parameters)");

                assertEqual(extend3D([1, 2, 3]), [1, 2, 3], "Should return the provided 3D vector (only origin)");
                assertEqual(extend3D([1, 2, 3], [4, 5, 6]), [1, 2, 3], "Should return the provided 3D vector (origin and second point)");
                assertEqual(extend3D([1, 2, 3], [4, 5, 6], 3), [1, 2, 3] + unit3D([3, 3, 3]) * 3, "Should return a 3D vector (all parameters)");

                assertEqual(extend3D([1, 2, 3, 4]), [1, 2, 3], "Should truncate too big vector and returns a 3D vector (only origin)");
                assertEqual(extend3D([1, 2, 3, 4], [5, 6, 7, 8]), [1, 2, 3], "Should truncate too big vector and returns a 3D vector (origin and second point)");
                assertEqual(extend3D([1, 2, 3, 4], [5, 6, 7, 8], 3), [1, 2, 3] + unit3D([4, 4, 4]) * 3, "Should truncate too big vector and returns a 3D vector (all parameters)");
            }
        }
        // test core/vector-3d/angle3D()
        testModule("angle3D()", 2) {
            testUnit("default value", 3) {
                assertEqual(angle3D(), 0, "Should return 0 if no parameter was provided");
                assertEqual(angle3D("1", "2"), 0, "Cannot compute angle of strings");
                assertEqual(angle3D(true, true), 0, "Cannot compute angle of booleans");
            }
            testUnit("compute angle", 6) {
                assertEqual(round(angle3D(1, 2)), 0, "When single numbers are provided, they should be translated to vector");
                assertEqual(angle3D([1, 0, 0], [0, 1, 0]), 90, "Orthogonal vectors have an angle of 90°");
                assertEqual(angle3D([1, 0, 0], [0, -1, 0]), 90, "Orthogonal vectors have an angle of 90°, whatever their direction");
                assertEqual(angle3D([1, 1, 1], [-1, -1, -1]), 0, "Vectors with opposite direction have an angle of 0°");
                assertEqual(round(angle3D([1, 2, 3], rotate3DX([1, 2, 3], 10))), 10, "Rotated vector should produce the expected angle");
                assertEqual(round(angle3D([1, 2, 3], rotate3DX([1, 2, 3], -10))), 10, "Vector rotated with a negative angle should produce the expected angle");
            }
        }
        // test core/vector-3d/vertexAngle3D()
        testModule("vertexAngle3D()", 2) {
            testUnit("default value", 3) {
                assertEqual(vertexAngle3D(), 0, "Should return 0 if no parameter was provided");
                assertEqual(vertexAngle3D("1", "2", "3"), 0, "Cannot compute angle of strings");
                assertEqual(vertexAngle3D(true, true, true), 0, "Cannot compute angle of booleans");
            }
            testUnit("compute angle", 6) {
                assertEqual(round(vertexAngle3D(1, 2, 3)), 0, "When single numbers are provided, they should be translated to vector");
                assertEqual(vertexAngle3D([2, 1, 1], [1, 2, 1], [1, 1, 1]), 90, "Orthogonal vectors have an angle of 90°");
                assertEqual(vertexAngle3D([2, 1, 1], [1, 0, 1], [1, 1, 1]), 90, "Orthogonal vectors have an angle of 90°, whatever their direction");
                assertEqual(vertexAngle3D([2, 2, 2], [0, 0, 0], [1, 1, 1]), 0, "Vectors with opposite direction have an angle of 0°");
                assertEqual(round(vertexAngle3D([5, 7, 9], rotate3DX([1, 2, 3], 10) + [4, 5, 6], [4, 5, 6])), 10, "Rotated vector should produce the expected angle");
                assertEqual(round(vertexAngle3D([5, 7, 9], rotate3DX([1, 2, 3], -10) + [4, 5, 6], [4, 5, 6])), 10, "Vector rotated with a negative angle should produce the expected angle");
            }
        }
        // test core/vector-3d/rotate3DX()
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
        // test core/vector-3d/rotate3DY()
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
        // test core/vector-3d/rotate3DZ()
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
        // test core/vector-3d/scaleFactor3D()
        testModule("scaleFactor3D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(scaleFactor3D(), [1, 1, 1], "If no list nor size are provided, should return a neutral scale factor");
            }
            testUnit("wrong types", 3) {
                assertEqual(scaleFactor3D("1", "2"), [1, 1, 1], "Cannot resize strings, should return a neutral scale factor");
                assertEqual(scaleFactor3D([1], [2]), [2, 1, 1], "Incomplete vectors should be adjusted, should return a neutral scale factor");
                assertEqual(scaleFactor3D(true, true), [1, 1, 1], "Cannot resize booleans, should return a neutral scale factor");
            }
            testUnit("vectors", 10) {
                assertEqual(scaleFactor3D([[1, 2], [5, 9]]), [1, 1, 1], "Should return a default scale factor if no size is provided, incomplete vectors should be completed");
                assertEqual(scaleFactor3D([[1, 2, 3], [5, 9, 2]]), [1, 1, 1], "Should return a default scale factor if no size is provided, 3D vectors should be supported");
                assertEqual(scaleFactor3D([[1, 2, 3, 4], [5, 9, 2, -3]]), [1, 1, 1], "Should return a default scale factor if no size is provided, too big vectors should be truncated");

                assertEqual(scaleFactor3D([[1, 2], [5, 9]], 2), [2/4, 2/7, 2], "When the size is a single number it should be applied to all elements, incomplete vectors should be completed");
                assertEqual(scaleFactor3D([[1, 2, 3], [5, 9, 2]], 2), [2/4, 2/7, 2], "When the size is a single number it should be applied to all elements, 3D vectors should be supported");
                assertEqual(scaleFactor3D([[1, 2, 3, 4], [5, 9, 2, 7]], 2), [2/4, 2/7, 2], "When the size is a single number it should be applied to all elements, too big vectors should be truncated");

                assertEqual(scaleFactor3D([[1, 2], [5, 9]], [2, 3]), [2/4, 3/7, 1], "When the size is a vector its elements are applied respectively to each elements of the listed points, incomplete vectors should be completed");
                assertEqual(scaleFactor3D([[1, 2, 3], [5, 9, 2]], [2, 3, 4]), [2/4, 3/7, 4], "When the size is a vector its elements are applied respectively to each elements of the listed points, 3D vectors should be supported");
                assertEqual(scaleFactor3D([[1, 2, 3, 4], [5, 9, 2, 7]], [2, 3, 4]), [2/4, 3/7, 4], "When the size is a vector its elements are applied respectively to each elements of the listed points, too big vectors should be truncated");

                assertEqual(scaleFactor3D([[1], [8]], 3), [3/7, 3, 3], "Incomplete vectors should be adjusted");
            }
        }
        // test core/vector-3d/dimensions3D()
        testModule("dimensions3D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(dimensions3D(), [0, 0, 0], "Cannot get dimensions if the list is missing");
            }
            testUnit("wrong types", 3) {
                assertEqual(dimensions3D("2"), [0, 0, 0], "Cannot get dimensions from string");
                assertEqual(dimensions3D(2), [0, 0, 0], "Cannot get dimensions from single number");
                assertEqual(dimensions3D(true), [0, 0, 0], "Cannot get dimensions from boolean");
            }
            testUnit("vectors", 9) {
                assertEqual(dimensions3D([[1, 2]]), [0, 0, 0], "A single point has no dimensions, incomplete vectors should be completed");
                assertEqual(dimensions3D([[1, 2, 3]]), [0, 0, 0], "A single point has no dimensions, 3D vectors should be supported");
                assertEqual(dimensions3D([[1, 2, 3, 4]]), [0, 0, 0], "A single point has no dimensions, too big vectors should be truncated");

                assertEqual(dimensions3D([[1, 2], [5, 9]]), [4, 7, 0], "Should return a the dimensions if at least 2 points are provided, incomplete vectors should be completed");
                assertEqual(dimensions3D([[1, 2, 3], [5, 9, -2]]), [4, 7, 5], "Should return a the dimensions if at least 2 points are provided, 3D vectors should be supported");
                assertEqual(dimensions3D([[1, 2, 3], [5, 9, -2]]), [4, 7, 5], "Should return a the dimensions if at least 2 points are provided, too big vectors should be truncated");

                assertEqual(dimensions3D([[1, 2], [5, 9], [3, 2], [-2, -6]]), [7, 15, 0], "Should return a the dimensions with respect to all points, incomplete vectors should be completed");
                assertEqual(dimensions3D([[1, 2, 3], [5, 9, -2], [3, 2, 7], [-2, -6, 0]]), [7, 15, 9], "Should return a the dimensions with respect to all points, 3D vectors should be supported");
                assertEqual(dimensions3D([[1, 2, 3, 4], [5, 9, -2, -5], [3, 2, 7, 8], [-2, -6, 0, 3]]), [7, 15, 9], "Should return a the dimensions with respect to all points, too big vectors should be truncated");
            }
        }
        // test core/vector-3d/boundaries3D()
        testModule("boundaries3D()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(boundaries3D(), [[0, 0, 0], [0, 0, 0]], "Cannot get boundaries if the list is missing");
            }
            testUnit("wrong types", 3) {
                assertEqual(boundaries3D("2"), [[0, 0, 0], [0, 0, 0]], "Cannot get boundaries from string");
                assertEqual(boundaries3D(2), [[0, 0, 0], [0, 0, 0]], "Cannot get boundaries from single number");
                assertEqual(boundaries3D(true), [[0, 0, 0], [0, 0, 0]], "Cannot get boundaries from boolean");
            }
            testUnit("vectors", 9) {
                assertEqual(boundaries3D([[1, 2]]), [[1, 2, 0], [1, 2, 0]], "A single point is its own boundaries, incomplete vectors should be completed");
                assertEqual(boundaries3D([[1, 2, 3]]), [[1, 2, 3], [1, 2, 3]], "A single point is its own boundaries, 3D vectors should be supported");
                assertEqual(boundaries3D([[1, 2, 3, 4]]), [[1, 2, 3], [1, 2, 3]], "A single point is its own boundaries, too big vectors should be truncated");

                assertEqual(boundaries3D([[1, 2], [5, 9]]), [[1, 2, 0], [5, 9, 0]], "Boundaries of 2 points, incomplete vectors should be completed");
                assertEqual(boundaries3D([[1, 2, 3], [5, 9, -2]]), [[1, 2, -2], [5, 9, 3]], "Boundaries of 2 points, 3D vectors should be supported");
                assertEqual(boundaries3D([[1, 2, 3, 4], [5, 9, -2, 8]]), [[1, 2, -2], [5, 9, 3]], "Boundaries of 2 points, too big vectors should be truncated");

                assertEqual(boundaries3D([[1, 2], [5, 9], [3, 2], [-2, -6]]), [[-2, -6, 0], [5, 9, 0]], "Boundaries of several points, incomplete vectors should be completed");
                assertEqual(boundaries3D([[1, 2, 3], [5, 9, -2], [3, 2, 7], [-2, -6, 0]]), [[-2, -6, -2], [5, 9, 7]], "Boundaries of several points, 3D vectors should be supported");
                assertEqual(boundaries3D([[1, 2, 3, 4], [5, 9, -2, 8], [3, 2, 7, 5], [-2, -6, 0, 1]]), [[-2, -6, -2], [5, 9, 7]], "Boundaries of several points, too big vectors should be truncated");
            }
        }
        // test core/vector-2d/simpleInterpolationRange3D()
        testModule("simpleInterpolationRange3D()", 5) {
            testUnit("wrong value", 4) {
                assertEqual(simpleInterpolationRange3D(), [[[0, 0], [1, 0]], [[0, 0], [1, 0]], [[0, 0], [1, 0]]], "No parameter given");
                assertEqual(simpleInterpolationRange3D("1", "2", "3", "4", "5"), [[[0, 0], [1, 0]], [[0, 0], [1, 0]], [[0, 0], [1, 0]]], "Strings given");
                assertEqual(simpleInterpolationRange3D(true, true, true, true, true), [[[0, 0], [1, 0]], [[0, 0], [1, 0]], [[0, 0], [1, 0]]], "Booleans given");
                assertEqual(simpleInterpolationRange3D([1], [2], [3], [4], [5]), [[[0, 1], [1, 2]], [[0, 0], [1, 0]], [[0, 0], [1, 0]]], "Vectors given");
            }
            testUnit("no threshold", 2) {
                assertEqual(simpleInterpolationRange3D([3, 2, 4], [8, 7, 9]), [[[0, 3], [1, 8]], [[0, 2], [1, 7]], [[0, 4], [1, 9]]], "Range [[3, 2, 4]:[8, 7, 9]]");
                assertEqual(simpleInterpolationRange3D([-3, -2, -4], [-8, -7, -9]), [[[0, -3], [1, -8]], [[0, -2], [1, -7]], [[0, -4], [1, -9]]], "Range [[-3, -2, -4]:[-8, -7, -9]]");
            }
            testUnit("threshold from computed percentage", 4) {
                assertEqual(simpleInterpolationRange3D([3, 2, 4], [8, 7, 9], 0, 1), [[[0, 3], [1, 8]], [[0, 2], [1, 7]], [[0, 4], [1, 9]]], "Range [[3, 2, 4]:[8, 7, 9]]");
                assertEqual(simpleInterpolationRange3D([3, 2, 4], [8, 7, 9], .25, .75), [[[.25, 3], [.75, 8]], [[.25, 2], [.75, 7]], [[.25, 4], [.75, 9]]], "Range [[3, 2, 4]:[8, 7, 9]], interpolated between 25% and 75%");
                assertEqual(simpleInterpolationRange3D([-3, -2, -4], [-8, -7, -9], -.25, -.75), [[[.25, -3], [.75, -8]], [[.25, -2], [.75, -7]], [[.25, -4], [.75, -9]]], "Range [[-3, -2, -4]:[-8, -7, -9]], interpolated between 25% and 75%");
                assertEqual(simpleInterpolationRange3D([3, 2, 4], [8, 7, 9], .75, .25), [[[.25, 3], [.75, 8]], [[.25, 2], [.75, 7]], [[.25, 4], [.75, 9]]], "Range [[3, 2, 4]:[8, 7, 9]], interpolated between 25% and 75% given the boundaries out of order");
            }
            testUnit("threshold from percentage to compute", 4) {
                assertEqual(simpleInterpolationRange3D([3, 2, 4], [8, 7, 9], 0, 100), [[[0, 3], [1, 8]], [[0, 2], [1, 7]], [[0, 4], [1, 9]]], "Range [[3, 2, 4]:[8, 7, 9]]");
                assertEqual(simpleInterpolationRange3D([3, 2, 4], [8, 7, 9], 25, 75), [[[.25, 3], [.75, 8]], [[.25, 2], [.75, 7]], [[.25, 4], [.75, 9]]], "Range [[3, 2, 4]:[8, 7, 9]], interpolated between 25% and 75%");
                assertEqual(simpleInterpolationRange3D([-3, -2, -4], [-8, -7, -9], -25, -75), [[[.25, -3], [.75, -8]], [[.25, -2], [.75, -7]], [[.25, -4], [.75, -9]]], "Range [[-3, -2, -4]:[-8, -7, -9]], interpolated between 25% and 75%");
                assertEqual(simpleInterpolationRange3D([3, 2, 4], [8, 7, 9], 75, 25), [[[.25, 3], [.75, 8]], [[.25, 2], [.75, 7]], [[.25, 4], [.75, 9]]], "Range [[3, 2, 4]:[8, 7, 9]], interpolated between 25% and 75% given the boundaries out of order");
            }
            testUnit("threshold from percentage to compute with scale", 4) {
                assertEqual(simpleInterpolationRange3D([3, 2, 4], [8, 7, 9], 0, 1000, 1000), [[[0, 3], [1, 8]], [[0, 2], [1, 7]], [[0, 4], [1, 9]]], "Range [[3, 2, 4]:[8, 7, 9]]");
                assertEqual(simpleInterpolationRange3D([3, 2, 4], [8, 7, 9], 250, 750, 1000), [[[.25, 3], [.75, 8]], [[.25, 2], [.75, 7]], [[.25, 4], [.75, 9]]], "Range [[3, 2, 4]:[8, 7, 9]], interpolated between 25% and 75%");
                assertEqual(simpleInterpolationRange3D([-3, -2, -4], [-8, -7, -9], -250, -750, 1000), [[[.25, -3], [.75, -8]], [[.25, -2], [.75, -7]], [[.25, -4], [.75, -9]]], "Range [[-3, -2, -4]:[-8, -7, -9]], interpolated between 25% and 75%");
                assertEqual(simpleInterpolationRange3D([3, 2, 4], [8, 7, 9], 750, 250, 1000), [[[.25, 3], [.75, 8]], [[.25, 2], [.75, 7]], [[.25, 4], [.75, 9]]], "Range [[3, 2, 4]:[8, 7, 9]], interpolated between 25% and 75% given the boundaries out of order");
            }
        }
        // test core/vector-2d/interpolationRange3D()
        testModule("interpolationRange3D()", 5) {
            testUnit("wrong value", 4) {
                assertEqual(interpolationRange3D(), [], "No parameter given");
                assertEqual(interpolationRange3D("1", "2", "3", "4"), [[[0, 0]], [[0, 0]], [[0, 0]]], "Strings given");
                assertEqual(interpolationRange3D(true, true, true, true), [[[0, 0]], [[0, 0]], [[0, 0]]], "Booleans given");
                assertEqual(interpolationRange3D([1], [2], [3], [4]), [[[0, 1]], [[0, 1]], [[0, 1]]], "Vectors given");
            }
            testUnit("no threshold", 4) {
                assertEqual(interpolationRange3D([[3, 2, 4], [8, 7, 9]]), [[[0, 3], [1, 8]], [[0, 2], [1, 7]], [[0, 4], [1, 9]]], "Range [[3, 2, 4]:[8, 7, 9]]");
                assertEqual(interpolationRange3D([[-3, -2, -4], [-8, -7, -9]]), [[[0, -3], [1, -8]], [[0, -2], [1, -7]], [[0, -4], [1, -9]]], "Range [[-3, -2, -4]:[-8, -7, -9]]");
                assertEqual(interpolationRange3D([1, 2, 3, 5, 8]), [[[0, 1], [.25, 2], [.5, 3], [.75, 5], [1, 8]], [[0, 1], [.25, 2], [.5, 3], [.75, 5], [1, 8]], [[0, 1], [.25, 2], [.5, 3], [.75, 5], [1, 8]]], "Range from values [1,2,3,5,8]");
                assertEqual(interpolationRange3D([[1, 2, 3], [2, 3, 4], [3, 4, 5], [5, 6, 7], [8, 9, 10]]), [[[0, 1], [.25, 2], [.5, 3], [.75, 5], [1, 8]], [[0, 2], [.25, 3], [.5, 4], [.75, 6], [1, 9]], [[0, 3], [.25, 4], [.5, 5], [.75, 7], [1, 10]]], "Range from values [1,2,3,5,8]");
            }
            testUnit("threshold from computed percentage", 5) {
                assertEqual(interpolationRange3D([[3, 2, 4], [8, 7, 9]], 0, 1), [[[0, 3], [1, 8]], [[0, 2], [1, 7]], [[0, 4], [1, 9]]], "Range [[3, 2, 4]:[8, 7, 9]]");
                assertEqual(interpolationRange3D([[3, 2, 4], [8, 7, 9]], .25, .75), [[[.25, 3], [.75, 8]], [[.25, 2], [.75, 7]], [[.25, 4], [.75, 9]]], "Range [[3, 2, 4]:[8, 7, 9]], interpolated between 25% and 75%");
                assertEqual(interpolationRange3D([[-3, -2, -4], [-8, -7, -9]], -.25, -.75), [[[.25, -3], [.75, -8]], [[.25, -2], [.75, -7]], [[.25, -4], [.75, -9]]], "Range [[-3, -2, -4]:[-8, -7, -9]], interpolated between 25% and 75%");
                assertEqual(interpolationRange3D([[3, 2, 4], [8, 7, 9]], .75, .25), [[[.25, 3], [.75, 8]], [[.25, 2], [.75, 7]], [[.25, 4], [.75, 9]]], "Range [[3, 2, 4]:[8, 7, 9]], interpolated between 25% and 75% given the boundaries out of order");
                assertApproxEqual(interpolationRange3D([1, 2, 3, 5, 8], .1, .9), [[[0.1, 1], [0.3, 2], [0.5, 3], [0.7, 5], [0.9, 8]], [[0.1, 1], [0.3, 2], [0.5, 3], [0.7, 5], [0.9, 8]], [[0.1, 1], [0.3, 2], [0.5, 3], [0.7, 5], [0.9, 8]]], "Range from values [1,2,3,5,8]");
            }
            testUnit("threshold from percentage to compute", 5) {
                assertEqual(interpolationRange3D([[3, 2, 4], [8, 7, 9]], 0, 100), [[[0, 3], [1, 8]], [[0, 2], [1, 7]], [[0, 4], [1, 9]]], "Range [[3, 2, 4]:[8, 7, 9]]");
                assertEqual(interpolationRange3D([[3, 2, 4], [8, 7, 9]], 25, 75), [[[.25, 3], [.75, 8]], [[.25, 2], [.75, 7]], [[.25, 4], [.75, 9]]], "Range [[3, 2, 4]:[8, 7, 9]], interpolated between 25% and 75%");
                assertEqual(interpolationRange3D([[-3, -2, -4], [-8, -7, -9]], -25, -75), [[[.25, -3], [.75, -8]], [[.25, -2], [.75, -7]], [[.25, -4], [.75, -9]]], "Range [[-3, -2, -4]:[-8, -7, -9]], interpolated between 25% and 75%");
                assertEqual(interpolationRange3D([[3, 2, 4], [8, 7, 9]], 75, 25), [[[.25, 3], [.75, 8]], [[.25, 2], [.75, 7]], [[.25, 4], [.75, 9]]], "Range [[3, 2, 4]:[8, 7, 9]], interpolated between 25% and 75% given the boundaries out of order");
                assertApproxEqual(interpolationRange3D([1, 2, 3, 5, 8], 10, 90), [[[0.1, 1], [0.3, 2], [0.5, 3], [0.7, 5], [0.9, 8]], [[0.1, 1], [0.3, 2], [0.5, 3], [0.7, 5], [0.9, 8]], [[0.1, 1], [0.3, 2], [0.5, 3], [0.7, 5], [0.9, 8]]], "Range from values [1,2,3,5,8]");
            }
            testUnit("threshold from percentage to compute with scale", 5) {
                assertEqual(interpolationRange3D([[3, 2, 4], [8, 7, 9]], 0, 1000, 1000), [[[0, 3], [1, 8]], [[0, 2], [1, 7]], [[0, 4], [1, 9]]], "Range [[3, 2, 4]:[8, 7, 9]]");
                assertEqual(interpolationRange3D([[3, 2, 4], [8, 7, 9]], 250, 750, 1000), [[[.25, 3], [.75, 8]], [[.25, 2], [.75, 7]], [[.25, 4], [.75, 9]]], "Range [[3, 2, 4]:[8, 7, 9]], interpolated between 25% and 75%");
                assertEqual(interpolationRange3D([[-3, -2, -4], [-8, -7, -9]], -250, -750, 1000), [[[.25, -3], [.75, -8]], [[.25, -2], [.75, -7]], [[.25, -4], [.75, -9]]], "Range [[-3, -2, -4]:[-8, -7, -9]], interpolated between 25% and 75%");
                assertEqual(interpolationRange3D([[3, 2, 4], [8, 7, 9]], 750, 250, 1000), [[[.25, 3], [.75, 8]], [[.25, 2], [.75, 7]], [[.25, 4], [.75, 9]]], "Range [[3, 2, 4]:[8, 7, 9]], interpolated between 25% and 75% given the boundaries out of order");
                assertApproxEqual(interpolationRange3D([1, 2, 3, 5, 8], 100, 900, 1000), [[[0.1, 1], [0.3, 2], [0.5, 3], [0.7, 5], [0.9, 8]], [[0.1, 1], [0.3, 2], [0.5, 3], [0.7, 5], [0.9, 8]], [[0.1, 1], [0.3, 2], [0.5, 3], [0.7, 5], [0.9, 8]]], "Range from values [1,2,3,5,8]");
            }
        }
        // test core/vector-3d/interpolateStep3D()
        testModule("interpolateStep3D()", 7) {
            testUnit("wrong value", 4) {
                assertEqual(interpolateStep3D(), [0, 0, 0], "No parameter given");
                assertEqual(interpolateStep3D("1", "2", "3", "4", "5"), [0, 0, 0], "Strings given");
                assertEqual(interpolateStep3D(true, true, true, true, true), [0, 0, 0], "Booleans given");
                assertEqual(interpolateStep3D([1], [2], [3], [4], [5]), [2, 0, 0], "Vectors given");
            }
            testUnit("no threshold", 3) {
                assertEqual(interpolateStep3D(0, [3, 2, 4], [8, 7, 9]), [3, 2, 4], "Step 0 of range [[3, 2, 4]:[8, 7, 9]]");
                assertEqual(interpolateStep3D(.5, [3, 2, 4], [8, 7, 9]), [5.5, 4.5, 6.5], "Step .5 of range [[3, 2, 4]:[8, 7, 9]]");
                assertEqual(interpolateStep3D(1, [3, 2, 4], [8, 7, 9]), [8, 7, 9], "Step 1 of range [[3, 2, 4]:[8, 7, 9]]");
            }
            testUnit("threshold from computed percentage", 8) {
                assertEqual(interpolateStep3D(0, [3, 2, 4], [8, 7, 9], 0, 1), [3, 2, 4], "Step 0 of range [[3, 2, 4]:[8, 7, 9]] with threshold [0%:100%]");
                assertEqual(interpolateStep3D(.15, [3, 2, 4], [8, 7, 9], 0, 1), [3.75, 2.75, 4.75], "Step .15 of range [[3, 2, 4]:[8, 7, 9]] with threshold [0%:100%]");
                assertEqual(interpolateStep3D(.5, [3, 2, 4], [8, 7, 9], 0, 1), [5.5, 4.5, 6.5], "Step .5 of range [[3, 2, 4]:[8, 7, 9]] with threshold [0%:100%]");
                assertEqual(interpolateStep3D(.8, [3, 2, 4], [8, 7, 9], 0, 1), [7, 6, 8], "Step .8 of range [[3, 2, 4]:[8, 7, 9]] with threshold [0%:100%]");
                assertEqual(interpolateStep3D(0, [3, 2, 4], [8, 7, 9], .25, .75), [3, 2, 4], "Step 0 of range [[3, 2, 4]:[8, 7, 9]] with threshold [25%:75%]");
                assertEqual(interpolateStep3D(.15, [3, 2, 4], [8, 7, 9], .25, .75), [3, 2, 4], "Step .15 of range [[3, 2, 4]:[8, 7, 9]] with threshold [25%:75%]");
                assertEqual(interpolateStep3D(.5, [3, 2, 4], [8, 7, 9], .25, .75), [5.5, 4.5, 6.5], "Step .5 of range [[3, 2, 4]:[8, 7, 9]] with threshold [25%:75%]");
                assertEqual(interpolateStep3D(.8, [3, 2, 4], [8, 7, 9], .25, .75), [8, 7, 9], "Step .8 of range [[3, 2, 4]:[8, 7, 9]] with threshold [25%:75%]");
            }
            testUnit("threshold from percentage to compute", 8) {
                assertEqual(interpolateStep3D(0, [3, 2, 4], [8, 7, 9], 0, 100), [3, 2, 4], "Step 0 of range [[3, 2, 4]:[8, 7, 9]] with threshold [0%:100%]");
                assertEqual(interpolateStep3D(.15, [3, 2, 4], [8, 7, 9], 0, 100), [3.75, 2.75, 4.75], "Step .15 of range [[3, 2, 4]:[8, 7, 9]] with threshold [0%:100%]");
                assertEqual(interpolateStep3D(.5, [3, 2, 4], [8, 7, 9], 0, 100), [5.5, 4.5, 6.5], "Step .5 of range [[3, 2, 4]:[8, 7, 9]] with threshold [0%:100%]");
                assertEqual(interpolateStep3D(.8, [3, 2, 4], [8, 7, 9], 0, 100), [7, 6, 8], "Step .8 of range [[3, 2, 4]:[8, 7, 9]] with threshold [0%:100%]");
                assertEqual(interpolateStep3D(0, [3, 2, 4], [8, 7, 9], 25, 75), [3, 2, 4], "Step 0 of range [[3, 2, 4]:[8, 7, 9]] with threshold [25%:75%]");
                assertEqual(interpolateStep3D(.15, [3, 2, 4], [8, 7, 9], 25, 75), [3, 2, 4], "Step .15 of range [[3, 2, 4]:[8, 7, 9]] with threshold [25%:75%]");
                assertEqual(interpolateStep3D(.5, [3, 2, 4], [8, 7, 9], 25, 75), [5.5, 4.5, 6.5], "Step .5 of range [[3, 2, 4]:[8, 7, 9]] with threshold [25%:75%]");
                assertEqual(interpolateStep3D(.8, [3, 2, 4], [8, 7, 9], 25, 75), [8, 7, 9], "Step .8 of range [[3, 2, 4]:[8, 7, 9]] with threshold [25%:75%]");
            }
            testUnit("threshold from percentage to compute with scale", 8) {
                assertEqual(interpolateStep3D(0, [3, 2, 4], [8, 7, 9], 0, 1000, 1000), [3, 2, 4], "Step 0 of range [[3, 2, 4]:[8, 7, 9]] with threshold [0%:100%]");
                assertEqual(interpolateStep3D(.15, [3, 2, 4], [8, 7, 9], 0, 1000, 1000), [3.75, 2.75, 4.75], "Step .15 of range [[3, 2, 4]:[8, 7, 9]] with threshold [0%:100%]");
                assertEqual(interpolateStep3D(.5, [3, 2, 4], [8, 7, 9], 0, 1000, 1000), [5.5, 4.5, 6.5], "Step .5 of range [[3, 2, 4]:[8, 7, 9]] with threshold [0%:100%]");
                assertEqual(interpolateStep3D(.8, [3, 2, 4], [8, 7, 9], 0, 1000, 1000), [7, 6, 8], "Step .8 of range [[3, 2, 4]:[8, 7, 9]] with threshold [0%:100%]");
                assertEqual(interpolateStep3D(0, [3, 2, 4], [8, 7, 9], 250, 750, 1000), [3, 2, 4], "Step 0 of range [[3, 2, 4]:[8, 7, 9]] with threshold [25%:75%]");
                assertEqual(interpolateStep3D(.15, [3, 2, 4], [8, 7, 9], 250, 750, 1000), [3, 2, 4], "Step .15 of range [[3, 2, 4]:[8, 7, 9]] with threshold [25%:75%]");
                assertEqual(interpolateStep3D(.5, [3, 2, 4], [8, 7, 9], 250, 750, 1000), [5.5, 4.5, 6.5], "Step .5 of range [[3, 2, 4]:[8, 7, 9]] with threshold [25%:75%]");
                assertEqual(interpolateStep3D(.8, [3, 2, 4], [8, 7, 9], 250, 750, 1000), [8, 7, 9], "Step .8 of range [[3, 2, 4]:[8, 7, 9]] with threshold [25%:75%]");
            }
            testUnit("list of values", 5) {
                values = [4, [2, 3, 1], 9];
                assertEqual(interpolateStep3D(0, values=values), [4, 4, 4], "Step 0 of external range");
                assertApproxEqual(interpolateStep3D(0.15, values=values), [3.4, 3.7, 3.1], "Step 0.15 of external range");
                assertApproxEqual(interpolateStep3D(0.45, values=values), [2.2, 3.1, 1.3], "Step 0.45 of external range");
                assertEqual(interpolateStep3D(0.85, values=values), [6.9, 7.2, 6.6], "Step 0.85 of external range");
                assertEqual(interpolateStep3D(1, values=values), [9, 9, 9], "Step 1 of external range");
            }
            testUnit("external range", 5) {
                range = [
                    [[0, 4], [.5, 2], [1, 9]],
                    [[0, 5], [.5, 3], [1, 8]],
                    [[0, 2], [.5, 5], [1, 3]]

                ];
                assertEqual(interpolateStep3D(0, range=range), [4, 5, 2], "Step 0 of external range");
                assertEqual(interpolateStep3D(0.15, range=range), [3.4, 4.4, 2.9], "Step 0.15 of external range");
                assertEqual(interpolateStep3D(0.45, range=range), [2.2, 3.2, 4.7], "Step 0.45 of external range");
                assertApproxEqual(interpolateStep3D(0.85, range=range), [6.9, 6.5, 3.6], "Step 0.85 of external range");
                assertEqual(interpolateStep3D(1, range=range), [9, 8, 3], "Step 1 of external range");
            }
        }
    }
    function _rot2(v, a) = [
        v[0] * cos(a) - v[1] * sin(a),
        v[1] * cos(a) + v[0] * sin(a)
    ];
}

testCoreVector3D();
