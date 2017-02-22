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
 * Unit tests: Lines handling.
 *
 * @package test/core/line
 * @author jsconan
 */
module testCoreLine() {
    testPackage("core/line.scad", 3) {
        // test core/line/arc()
        testModule("arc()", 7) {
            testUnit("no parameter", 1) {
                assertEqual(arc(), [], "Cannot build an arc without parameters, should return an empty array");
            }
            testUnit("wrong type", 3) {
                assertEqual(arc("1", "1"), [], "Cannot build an arc using strings, should return an empty array");
                assertEqual(arc(true, true), [], "Cannot build an arc using booleans, should return an empty array");
                assertEqual(arc(1, [1]), [], "Cannot build an arc using vector angle, should return an empty array");
            }
            testUnit("empty", 6) {
                assertEqual(arc(0), [], "Cannot build a circle arc with a null radius, should return an empty array");
                assertEqual(arc([0, 0]), [], "Cannot build an ellipse arc with a null radius, should return an empty array");
                assertEqual(arc([0, 1]), [], "Cannot build an ellipse arc if one of the radius is 0 (x), should return an empty array");
                assertEqual(arc([1, 0]), [], "Cannot build an ellipse arc if one of the radius is 0 (y), should return an empty array");
                assertEqual(arc(1, 0), [], "Cannot build a 0° circle arc, should return an empty array");
                assertEqual(arc([1, 1], 0), [], "Cannot build a 0° ellipse arc, should return an empty array");
            }
            testUnit("circle", 4) {
                assertEqual(arc(1, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 3 facets (triangle)");
                assertEqual(arc(1, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 4 facets (square)");
                assertEqual(arc(1, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 6 facets (hexagon)");
                assertEqual(arc(5, $fa=12, $fs=2), [ for (a = [astep(5, $fa=12, $fs=2) : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a radius of 1 and 16 facets");
            }
            testUnit("ellipse", 4) {
                assertEqual(arc([1, 2], $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(arc([1, 2], $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 4 facets (square)");
                assertEqual(arc([1, 2], $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(arc([5, 6], $fa=12, $fs=2), [ for (a = [0 : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], "Should return a list of points to draw an ellipse with a radius of [5, 6] and 20 facets");
            }
            testUnit("circle arc", 8) {
                assertEqual(arc(1, a=30, $fn=3), [ for (a = [0 : 30 : 30]) _rotP(a, 1, 1) ], "Should return a list of points to draw a 30° arc with a radius of 1 and 3 facets (triangle)");
                assertEqual(arc(1, a=140, $fn=3), concat([ for (a = [0 : 120 : 140]) _rotP(a, 1, 1) ], [_rotP(140, 1, 1)]), "Should return a list of points to draw a 140° arc with a radius of 1 and 3 facets (triangle)");
                assertEqual(arc(1, a=140, $fn=4), concat([ for (a = [0 : 90 : 140]) _rotP(a, 1, 1) ], [_rotP(140, 1, 1)]), "Should return a list of points to draw a 140° arc with a radius of 1 and 4 facets (square)");
                assertEqual(arc(1, a=200, $fn=4), concat([ for (a = [0 : 90 : 200]) _rotP(a, 1, 1) ], [_rotP(200, 1, 1)]), "Should return a list of points to draw a 200° arc with a radius of 1 and 4 facets (square)");
                assertEqual(arc(1, a=140, $fn=6), concat([ for (a = [0 : 60 : 140]) _rotP(a, 1, 1) ], [_rotP(140, 1, 1)]), "Should return a list of points to draw a 140° arc with a radius of 1 and 6 facets (hexagon)");
                assertEqual(arc(1, a=200, $fn=6), concat([ for (a = [0 : 60 : 200]) _rotP(a, 1, 1) ], [_rotP(200, 1, 1)]), "Should return a list of points to draw a 200° arc with a radius of 1 and 6 facets (hexagon)");
                assertEqual(arc(5, a=80, $fa=12, $fs=2), concat([ for (a = [0 : astep(5, $fa=12, $fs=2) : 80]) _rotP(a, 5, 5) ], [_rotP(80, 5, 5)]), "Should return a list of points to draw a 30° arc with a radius of 1 and 16 facets");
                assertEqual(arc(5, a=160, $fa=12, $fs=2), concat([ for (a = [0 : astep(5, $fa=12, $fs=2) : 160]) _rotP(a, 5, 5) ], [_rotP(160, 5, 5)]), "Should return a list of points to draw a 30° arc with a radius of 1 and 16 facets");
            }
            testUnit("ellipse arc", 8) {
                assertEqual(arc([1, 2], a=30, $fn=3), [ for (a = [0 : 30 : 30]) _rotP(a, 1, 2) ], "Should return a list of points to draw a 30° arc with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(arc([1, 2], a=140, $fn=3), concat([ for (a = [0 : 120 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° arc with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(arc([1, 2], a=140, $fn=4), concat([ for (a = [0 : 90 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° arc with a radius of [1, 2] and 4 facets (square)");
                assertEqual(arc([1, 2], a=200, $fn=4), concat([ for (a = [0 : 90 : 200]) _rotP(a, 1, 2) ], [_rotP(200, 1, 2)]), "Should return a list of points to draw a 200° arc with a radius of [1, 2] and 4 facets (square)");
                assertEqual(arc([1, 2], a=140, $fn=6), concat([ for (a = [0 : 60 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° arc with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(arc([1, 2], a=200, $fn=6), concat([ for (a = [0 : 60 : 200]) _rotP(a, 1, 2) ], [_rotP(200, 1, 2)]), "Should return a list of points to draw a 200° arc with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(arc([5, 6], a=80, $fa=12, $fs=2), concat([ for (a = [0 : astep(6, $fa=12, $fs=2) : 80]) _rotP(a, 5, 6) ], [_rotP(80, 5, 6)]), "Should return a list of points to draw a 30° arc with a radius of [5, 6] and 16 facets");
                assertEqual(arc([5, 6], a=160, $fa=12, $fs=2), concat([ for (a = [0 : astep(6, $fa=12, $fs=2) : 160]) _rotP(a, 5, 6) ], [_rotP(160, 5, 6)]), "Should return a list of points to draw a 30° arc with a radius of [5, 6] and 16 facets");
            }
        }
        // test core/line/sinusoid()
        testModule("sinusoid()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(sinusoid(), [], "Cannot build a sinusoid without parameters, should return an empty array");
            }
            testUnit("wrong type", 3) {
                assertEqual(sinusoid("1", "1"), [], "Cannot build a sinusoid using strings, should return an empty array");
                assertEqual(sinusoid(true, true), [], "Cannot build a sinusoid using booleans, should return an empty array");
                assertEqual(sinusoid([1], [1]), [], "Cannot build a sinusoid using vectors, should return an empty array");
            }
            testUnit("straight", 5) {
                assertEqual(sinusoid(1, $fn=6), [ for (a = [0 : 1/6 : 1]) [a, sin(360 * a)] ], "Should build a simple sinusoid with a length of 1 and 6 segments");
                assertEqual(sinusoid(1, 2, $fn=6), [ for (a = [0 : 1/6 : 1]) [a, sin(360 * a / 2)] ], "Should build a simple sinusoid with a length of 1, a period of 2 and 6 segments");
                assertEqual(sinusoid(1, 2, 4, $fn=6), [ for (a = [0 : 1/6 : 1]) [a, 4 * sin(360 * a / 2)] ], "Should build a simple sinusoid with a length of 1, a period of 2, an amplitude of 4 and 6 segments");
                assertEqual(sinusoid(1, 2, 4, 6, $fn=6), [ for (a = [0 : 1/6 : 1]) [a, 4 * sin(360 * a / 2 + 6)] ], "Should build a simple sinusoid with a length of 1, a period of 2, an amplitude of 4, a delay of 6 and 6 segments");
                assertEqual(sinusoid(1, 2, 4, 6, 8, $fn=6), [ for (a = [0 : 1/6 : 1]) [a, 4 * sin(360 * a / 2 + 6) + 8] ], "Should build a simple sinusoid with a length of 1, a period of 2, an amplitude of 4, a delay of 6, an offset of 8 and 6 segments");
            }
            testUnit("rotated", 5) {
                assertEqual(sinusoid(3, a=70, $fn=8), [ for (a = [0 : 3/8 : 3]) _rot2([a, sin(360 * a)], 70) ], "Should build a sinusoid rotated by 70° with a length of 1 and 6 segments");
                assertEqual(sinusoid(3, 2, a=70, $fn=8), [ for (a = [0 : 3/8 : 3]) _rot2([a, sin(360 * a / 2)], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2 and 6 segments");
                assertEqual(sinusoid(3, 2, 4, a=70, $fn=8), [ for (a = [0 : 3/8 : 3]) _rot2([a, 4 * sin(360 * a / 2)], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2, an amplitude of 4 and 6 segments");
                assertEqual(sinusoid(3, 2, 4, 6, a=70, $fn=8), [ for (a = [0 : 3/8 : 3]) _rot2([a, 4 * sin(360 * a / 2 + 6)], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2, an amplitude of 4, a delay of 6 and 6 segments");
                assertEqual(sinusoid(3, 2, 4, 6, 8, a=70, $fn=8), [ for (a = [0 : 3/8 : 3]) _rot2([a, 4 * sin(360 * a / 2 + 6) + 8], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2, an amplitude of 4, a delay of 6, an offset of 8 and 6 segments");
            }
        }
        // test core/line/cosinusoid()
        testModule("cosinusoid()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(cosinusoid(), [], "Cannot build a sinusoid without parameters, should return an empty array");
            }
            testUnit("wrong type", 3) {
                assertEqual(cosinusoid("1", "1"), [], "Cannot build a sinusoid using strings, should return an empty array");
                assertEqual(cosinusoid(true, true), [], "Cannot build a sinusoid using booleans, should return an empty array");
                assertEqual(cosinusoid([1], [1]), [], "Cannot build a sinusoid using vectors, should return an empty array");
            }
            testUnit("straight", 5) {
                assertEqual(cosinusoid(1, $fn=6), [ for (a = [0 : 1/6 : 1]) [cos(360 * a), a] ], "Should build a simple sinusoid with a length of 1 and 6 segments");
                assertEqual(cosinusoid(1, 2, $fn=6), [ for (a = [0 : 1/6 : 1]) [cos(360 * a / 2), a] ], "Should build a simple sinusoid with a length of 1, a period of 2 and 6 segments");
                assertEqual(cosinusoid(1, 2, 4, $fn=6), [ for (a = [0 : 1/6 : 1]) [4 * cos(360 * a / 2), a] ], "Should build a simple sinusoid with a length of 1, a period of 2, an amplitude of 4 and 6 segments");
                assertEqual(cosinusoid(1, 2, 4, 6, $fn=6), [ for (a = [0 : 1/6 : 1]) [4 * cos(360 * a / 2 + 6), a] ], "Should build a simple sinusoid with a length of 1, a period of 2, an amplitude of 4, a delay of 6 and 6 segments");
                assertEqual(cosinusoid(1, 2, 4, 6, 8, $fn=6), [ for (a = [0 : 1/6 : 1]) [4 * cos(360 * a / 2 + 6) + 8, a] ], "Should build a simple sinusoid with a length of 1, a period of 2, an amplitude of 4, a delay of 6, an offset of 8 and 6 segments");
            }
            testUnit("rotated", 5) {
                assertEqual(cosinusoid(3, a=70, $fn=8), [ for (a = [0 : 3/8 : 3]) _rot2([cos(360 * a), a], 70) ], "Should build a sinusoid rotated by 70° with a length of 1 and 6 segments");
                assertEqual(cosinusoid(3, 2, a=70, $fn=8), [ for (a = [0 : 3/8 : 3]) _rot2([cos(360 * a / 2), a], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2 and 6 segments");
                assertEqual(cosinusoid(3, 2, 4, a=70, $fn=8), [ for (a = [0 : 3/8 : 3]) _rot2([4 * cos(360 * a / 2), a], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2, an amplitude of 4 and 6 segments");
                assertEqual(cosinusoid(3, 2, 4, 6, a=70, $fn=8), [ for (a = [0 : 3/8 : 3]) _rot2([4 * cos(360 * a / 2 + 6), a], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2, an amplitude of 4, a delay of 6 and 6 segments");
                assertEqual(cosinusoid(3, 2, 4, 6, 8, a=70, $fn=8), [ for (a = [0 : 3/8 : 3]) _rot2([4 * cos(360 * a / 2 + 6) + 8, a], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2, an amplitude of 4, a delay of 6, an offset of 8 and 6 segments");
            }
        }
    }
    function _rot2(v, a) = [
        v[0] * cos(a) - v[1] * sin(a),
        v[1] * cos(a) + v[0] * sin(a)
    ];
    function _rotP(a, x, y) = [cos(a) * x, sin(a) * y];
}

testCoreLine();
