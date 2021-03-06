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
 * Unit tests: Bezier and other parametric curves.
 *
 * @package test/core/bezier
 * @author jsconan
 */
module testCoreBezier() {
    testPackage("core/bezier.scad", 4) {
        // test core/bezier/quadraticBezierPoint()
        testModule("quadraticBezierPoint()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(quadraticBezierPoint(), [0,0], "Cannot compute a bezier point without parameters");
            }
            testUnit("wrong type", 3) {
                assertEqual(quadraticBezierPoint("1", "1"), [0, 0], "Cannot compute a bezier point using strings");
                assertEqual(quadraticBezierPoint(true, true), [0, 0], "Cannot compute a bezier point using booleans");
                assertEqual(quadraticBezierPoint([1], [true]), [0, 0], "Cannot compute a bezier point using vectors");
            }
            testUnit("control points", 5) {
                p0 = [-5, -5];
                p1 = [0, 5];
                p2 = [5, 5];
                assertEqual(quadraticBezierPoint(0, p0, p1, p2), p0, "At t=0 should return the first control point");
                assertApproxEqual(quadraticBezierPoint(0.2, p0, p1, p2), [(p0[0] * 16 + p1[0] * 8 + p2[0]) / 25, (p0[1] * 16 + p1[1] * 8 + p2[1]) / 25], "At t=0.2 should return the at point on the beginning of the curve");
                assertEqual(quadraticBezierPoint(0.5, p0, p1, p2), [(p0[0] + p1[0] * 2 + p2[0]) / 4, (p0[1] + p1[1] * 2 + p2[1]) / 4], "At t=0.5 should return the at point on the middle of the curve");
                assertApproxEqual(quadraticBezierPoint(0.8, p0, p1, p2), [(p0[0] + p1[0] * 8 + p2[0] * 16) / 25, (p0[1] + p1[1] * 8 + p2[1] * 16) / 25], "At t=0.8 should return the at point on the end of the curve");
                assertEqual(quadraticBezierPoint(1, p0, p1, p2), p2, "At t=1 should return the last control point");
            }
        }
        // test core/bezier/cubicBezierPoint()
        testModule("cubicBezierPoint()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(cubicBezierPoint(), [0,0], "Cannot compute a bezier point without parameters");
            }
            testUnit("wrong type", 3) {
                assertEqual(cubicBezierPoint("1", "1"), [0, 0], "Cannot compute a bezier point using strings");
                assertEqual(cubicBezierPoint(true, true), [0, 0], "Cannot compute a bezier point using booleans");
                assertEqual(cubicBezierPoint([1], [true]), [0, 0], "Cannot compute a bezier point using vectors");
            }
            testUnit("control points", 5) {
                p0 = [-5, -5];
                p1 = [-5, 5];
                p2 = [5, 5];
                p3 = [5, -5];
                assertEqual(cubicBezierPoint(0, p0, p1, p2, p3), p0, "At t=0 should return the first control point");
                assertApproxEqual(cubicBezierPoint(0.2, p0, p1, p2, p3), [(p0[0] * 64 + p1[0] * 48 + p2[0] * 12 + p3[0]) / 125, (p0[1] * 64 + p1[1] * 48 + p2[1] * 12 + p3[1]) / 125], "At t=0.2 should return the at point on the beginning of the curve");
                assertEqual(cubicBezierPoint(0.5, p0, p1, p2, p3), [(p0[0] + p1[0] * 3 + p2[0] * 3 + p3[0]) / 8, (p0[1] + p1[1] * 3 + p2[1] * 3 + p3[1]) / 8], "At t=0.5 should return the at point on the middle of the curve");
                assertApproxEqual(cubicBezierPoint(0.8, p0, p1, p2, p3), [(p0[0] + p1[0] * 12 + p2[0] * 48 + p3[0] * 64) / 125, (p0[1] + p1[1] * 12 + p2[1] * 48 + p3[1] * 64) / 125], "At t=0.8 should return the at point on the end of the curve");
                assertEqual(cubicBezierPoint(1, p0, p1, p2, p3), p3, "At t=1 should return the last control point");
            }
        }
        // test core/bezier/quadraticBezierCurve()
        testModule("quadraticBezierCurve()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(quadraticBezierCurve(), [[0, 0], [0, 0]], "Cannot compute a bezier curve without parameters");
            }
            testUnit("wrong type", 3) {
                assertEqual(quadraticBezierCurve("1", "1"), [[0, 0], [0, 0]], "Cannot compute a bezier curve using strings");
                assertEqual(quadraticBezierCurve(true, true), [[0, 0], [0, 0]], "Cannot compute a bezier curve using booleans");
                assertEqual(quadraticBezierCurve([true], [true]), [[0, 0], [0, 0]], "Cannot compute a bezier curve using arrays");
            }
            testUnit("control points", 3) {
                p0 = [-5, -5];
                p1 = [-5, 5];
                p2 = [5, 5];
                testUnitContext("mode dirty", 3) {
                    $fa = facetAngle(MODE_DIRTY);
                    $fs = facetSize(MODE_DIRTY);
                    curve = quadraticBezierCurve(p0, p1, p2);
                    assertEqual(len(curve), 6, "Should produce 6 points");
                    assertEqual(curve[0], p0, "The first point should be the first control point");
                    assertEqual(curve[5], p2, "The last point should be the last control point");
                }
                testUnitContext("mode dev", 3) {
                    $fa = facetAngle(MODE_DEV);
                    $fs = facetSize(MODE_DEV);
                    curve = quadraticBezierCurve(p0, p1, p2);
                    assertEqual(len(curve), 10, "Should produce 10 points");
                    assertEqual(curve[0], p0, "The first point should be the first control point");
                    assertEqual(curve[9], p2, "The last point should be the last control point");
                }
                testUnitContext("mode prod", 3) {
                    $fa = facetAngle(MODE_PROD);
                    $fs = facetSize(MODE_PROD);
                    curve = quadraticBezierCurve(p0, p1, p2);
                    assertEqual(len(curve), 18, "Should produce 18 points");
                    assertEqual(curve[0], p0, "The first point should be the first control point");
                    assertEqual(curve[17], p2, "The last point should be the last control point");
                }
            }
        }
        // test core/bezier/cubicBezierCurve()
        testModule("cubicBezierCurve()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(cubicBezierCurve(), [[0, 0], [0, 0]], "Cannot compute a bezier curve without parameters");
            }
            testUnit("wrong type", 3) {
                assertEqual(cubicBezierCurve("1", "1"), [[0, 0], [0, 0]], "Cannot compute a bezier curve using strings");
                assertEqual(cubicBezierCurve(true, true), [[0, 0], [0, 0]], "Cannot compute a bezier curve using booleans");
                assertEqual(cubicBezierCurve([true], [true]), [[0, 0], [0, 0]], "Cannot compute a bezier curve using arrays");
            }
            testUnit("control points", 3) {
                p0 = [-5, -5];
                p1 = [-5, 5];
                p2 = [5, 5];
                p3 = [5, -5];
                testUnitContext("mode dirty", 3) {
                    $fa = facetAngle(MODE_DIRTY);
                    $fs = facetSize(MODE_DIRTY);
                    curve = cubicBezierCurve(p0, p1, p2, p3);
                    assertEqual(len(curve), 10, "Should produce 10 points");
                    assertEqual(curve[0], p0, "The first point should be the first control point");
                    assertEqual(curve[9], p3, "The last point should be the last control point");
                }
                testUnitContext("mode dev", 3) {
                    $fa = facetAngle(MODE_DEV);
                    $fs = facetSize(MODE_DEV);
                    curve = cubicBezierCurve(p0, p1, p2, p3);
                    assertEqual(len(curve), 18, "Should produce 18 points");
                    assertEqual(curve[0], p0, "The first point should be the first control point");
                    assertEqual(curve[17], p3, "The last point should be the last control point");
                }
                testUnitContext("mode prod", 3) {
                    $fa = facetAngle(MODE_PROD);
                    $fs = facetSize(MODE_PROD);
                    curve = cubicBezierCurve(p0, p1, p2, p3);
                    assertEqual(len(curve), 34, "Should produce 34 points");
                    assertEqual(curve[0], p0, "The first point should be the first control point");
                    assertEqual(curve[33], p3, "The last point should be the last control point");
                }
            }
        }
    }
}

testCoreBezier();
