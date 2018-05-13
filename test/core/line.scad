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
    testPackage("core/line.scad", 4) {
        // test core/line/arc()
        testModule("arc()", 9) {
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
            testUnit("circle", 5) {
                assertEqual(arc(1, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 3 facets (triangle)");
                assertEqual(arc(1, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 4 facets (square)");
                assertEqual(arc(1, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 6 facets (hexagon)");
                assertEqual(arc(5, $fa=12, $fs=2), [ for (a = [astep(5, $fa=12, $fs=2) : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a radius of 1 and 16 facets");
                assertEqual(arc(10, $fn=36), [ for (a = [10 : 10 : 360]) _rotP(a, 10, 10) ], "Should return a list of points to draw a circle with a radius of 10 and 36 facets");
            }
            testUnit("ellipse", 5) {
                assertEqual(arc([1, 2], $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(arc([1, 2], $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 4 facets (square)");
                assertEqual(arc([1, 2], $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(arc([5, 6], $fa=12, $fs=2), [ for (a = [0 : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], "Should return a list of points to draw an ellipse with a radius of [5, 6] and 20 facets");
                assertEqual(arc([10, 20], $fn=36), [ for (a = [10 : 10 : 360]) _rotP(a, 10, 20) ], "Should return a list of points to draw an ellipse with a radius of [10, 20] and 36 facets");
            }
            testUnit("circle arc from origin", 12) {
                assertEqual(arc(1, a=30, $fn=3), [ for (a = [0 : 30 : 30]) _rotP(a, 1, 1) ], "Should return a list of points to draw a 30° arc with a radius of 1 and 3 facets (triangle)");
                assertEqual(arc(1, a=140, $fn=3), concat([ for (a = [0 : 120 : 140]) _rotP(a, 1, 1) ], [_rotP(140, 1, 1)]), "Should return a list of points to draw a 140° arc with a radius of 1 and 3 facets (triangle)");
                assertEqual(arc(1, a=140, $fn=4), concat([ for (a = [0 : 90 : 140]) _rotP(a, 1, 1) ], [_rotP(140, 1, 1)]), "Should return a list of points to draw a 140° arc with a radius of 1 and 4 facets (square)");
                assertEqual(arc(1, a=200, $fn=4), concat([ for (a = [0 : 90 : 200]) _rotP(a, 1, 1) ], [_rotP(200, 1, 1)]), "Should return a list of points to draw a 200° arc with a radius of 1 and 4 facets (square)");
                assertEqual(arc(1, a=140, $fn=6), concat([ for (a = [0 : 60 : 140]) _rotP(a, 1, 1) ], [_rotP(140, 1, 1)]), "Should return a list of points to draw a 140° arc with a radius of 1 and 6 facets (hexagon)");
                assertEqual(arc(1, a=200, $fn=6), concat([ for (a = [0 : 60 : 200]) _rotP(a, 1, 1) ], [_rotP(200, 1, 1)]), "Should return a list of points to draw a 200° arc with a radius of 1 and 6 facets (hexagon)");
                assertEqual(arc(5, a=80, $fa=12, $fs=2), concat([ for (a = [0 : astep(5, $fa=12, $fs=2) : 80]) _rotP(a, 5, 5) ], [_rotP(80, 5, 5)]), "Should return a list of points to draw a 80° arc with a radius of 1 and 16 facets");
                assertEqual(arc(5, a=160, $fa=12, $fs=2), concat([ for (a = [0 : astep(5, $fa=12, $fs=2) : 160]) _rotP(a, 5, 5) ], [_rotP(160, 5, 5)]), "Should return a list of points to draw a 160° arc with a radius of 1 and 16 facets");
                assertEqual(arc(10, a=300, $fn=36), [ for (a = [0 : 10 : 300]) _rotP(a, 10, 10) ], "Should return a list of points to draw a 300° arc with a radius of 10 and 36 facets");
                assertEqual(arc(10, a=360, $fn=36), [ for (a = [10 : 10 : 360]) _rotP(a, 10, 10) ], "Should return a list of points to draw a 360° arc with a radius of 10 and 36 facets");
                assertEqual(arc(10, a=660, $fn=36), [ for (a = [0 : 10 : 300]) _rotP(a, 10, 10) ], "Should return a list of points to draw a 660° arc with a radius of 10 and 36 facets");
                assertEqual(arc(10, a=720, $fn=36), [ for (a = [10 : 10 : 360]) _rotP(a, 10, 10) ], "Should return a list of points to draw a 720° arc with a radius of 10 and 36 facets");
            }
            testUnit("ellipse arc from origin", 12) {
                assertEqual(arc([1, 2], a=30, $fn=3), [ for (a = [0 : 30 : 30]) _rotP(a, 1, 2) ], "Should return a list of points to draw a 30° arc with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(arc([1, 2], a=140, $fn=3), concat([ for (a = [0 : 120 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° arc with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(arc([1, 2], a=140, $fn=4), concat([ for (a = [0 : 90 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° arc with a radius of [1, 2] and 4 facets (square)");
                assertEqual(arc([1, 2], a=200, $fn=4), concat([ for (a = [0 : 90 : 200]) _rotP(a, 1, 2) ], [_rotP(200, 1, 2)]), "Should return a list of points to draw a 200° arc with a radius of [1, 2] and 4 facets (square)");
                assertEqual(arc([1, 2], a=140, $fn=6), concat([ for (a = [0 : 60 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° arc with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(arc([1, 2], a=200, $fn=6), concat([ for (a = [0 : 60 : 200]) _rotP(a, 1, 2) ], [_rotP(200, 1, 2)]), "Should return a list of points to draw a 200° arc with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(arc([5, 6], a=80, $fa=12, $fs=2), concat([ for (a = [0 : astep(6, $fa=12, $fs=2) : 80]) _rotP(a, 5, 6) ], [_rotP(80, 5, 6)]), "Should return a list of points to draw a 80° arc with a radius of [5, 6] and 16 facets");
                assertEqual(arc([5, 6], a=160, $fa=12, $fs=2), concat([ for (a = [0 : astep(6, $fa=12, $fs=2) : 160]) _rotP(a, 5, 6) ], [_rotP(160, 5, 6)]), "Should return a list of points to draw a 160° arc with a radius of [5, 6] and 16 facets");
                assertEqual(arc([10, 20], a=300, $fn=36), [ for (a = [0 : 10 : 300]) _rotP(a, 10, 20) ], "Should return a list of points to draw a 300° arc with a radius of [10, 20] and 36 facets");
                assertEqual(arc([10, 20], a=360, $fn=36), [ for (a = [10 : 10 : 360]) _rotP(a, 10, 20) ], "Should return a list of points to draw a 360° arc with a radius of [10, 20] and 36 facets");
                assertEqual(arc([10, 20], a=660, $fn=36), [ for (a = [0 : 10 : 300]) _rotP(a, 10, 20) ], "Should return a list of points to draw a 660° arc with a radius of [10, 20] and 36 facets");
                assertEqual(arc([10, 20], a=720, $fn=36), [ for (a = [10 : 10 : 360]) _rotP(a, 10, 20) ], "Should return a list of points to draw a 720° arc with a radius of [10, 20] and 36 facets");
            }
            testUnit("circle arc arbitrary angle", 14) {
                assertEqual(arc(1, a1=30, a2=60, $fn=36), [ for (a = [30 : 10 : 60]) _rotP(a, 1, 1) ], "Should return a list of points to draw an arc from 30° to 60° with a radius of 1");
                assertEqual(arc(1, a1=60, a2=30, $fn=36), [ for (a = [60 : -10 : 30]) _rotP(a, 1, 1) ], "Should return a list of points to draw an arc from 60° to 30° with a radius of 1");
                assertEqual(arc(1, a1=45, a=30, $fn=36), [ for (a = [45 : 10 : 75]) _rotP(a, 1, 1) ], "Should return a list of points to draw a 30° arc from 45° with a radius of 1");
                assertEqual(arc(1, a1=45, a=-30, $fn=36), [ for (a = [45 : -10 : 15]) _rotP(a, 1, 1) ], "Should return a list of points to draw a -30° arc from 45° with a radius of 1");
                assertEqual(arc(1, a1=-45, a=30, $fn=36), [ for (a = [-45 : 10 : -15]) _rotP(a, 1, 1) ], "Should return a list of points to draw a 30° arc from -45° with a radius of 1");
                assertEqual(arc(1, a1=-45, a=-30, $fn=36), [ for (a = [-45 : -10 : -75]) _rotP(a, 1, 1) ], "Should return a list of points to draw a -30° arc from -45° with a radius of 1");
                assertEqual(arc(1, a1=405, a=390, $fn=36), [ for (a = [45 : 10 : 75]) _rotP(a, 1, 1) ], "Should return a list of points to draw a 390° arc from 405° with a radius of 1");
                assertEqual(arc(1, a1=405, a=-390, $fn=36), [ for (a = [45 : -10 : 15]) _rotP(a, 1, 1) ], "Should return a list of points to draw a -390° arc from 405° with a radius of 1");
                assertEqual(arc(1, a1=-30, a2=-60, $fn=36), [ for (a = [-30 : -10 : -60]) _rotP(a, 1, 1) ], "Should return a list of points to draw an arc from -30° to -60° with a radius of 1");
                assertEqual(arc(1, a1=-60, a2=-30, $fn=36), [ for (a = [-60 : 10 : -30]) _rotP(a, 1, 1) ], "Should return a list of points to draw an arc from -60° to -30° with a radius of 1");
                assertEqual(arc(1, a1=-30, a2=30, $fn=36), [ for (a = [-30 : 10 : 30]) _rotP(a, 1, 1) ], "Should return a list of points to draw an arc from -30° to 30° with a radius of 1");
                assertEqual(arc(1, a1=30, a2=-30, $fn=36), [ for (a = [30 : -10 : -30]) _rotP(a, 1, 1) ], "Should return a list of points to draw an arc from 30° to -30° with a radius of 1");
                assertEqual(arc(1, a1=-390, a2=390, $fn=36), [ for (a = [-30 : 10 : 30]) _rotP(a, 1, 1) ], "Should return a list of points to draw an arc from -390° to 390° with a radius of 1");
                assertEqual(arc(1, a1=390, a2=-390, $fn=36), [ for (a = [30 : -10 : -30]) _rotP(a, 1, 1) ], "Should return a list of points to draw an arc from 390° to -390° with a radius of 1");
            }
            testUnit("ellipse arc arbitrary angle", 14) {
                assertEqual(arc([1, 2], a1=30, a2=60, $fn=36), [ for (a = [30 : 10 : 60]) _rotP(a, 1, 2) ], "Should return a list of points to draw an arc from 30° to 60° with a radius of [1, 2]");
                assertEqual(arc([1, 2], a1=60, a2=30, $fn=36), [ for (a = [60 : -10 : 30]) _rotP(a, 1, 2) ], "Should return a list of points to draw an arc from 60° to 30° with a radius of [1, 2]");
                assertEqual(arc([1, 2], a1=45, a=30, $fn=36), [ for (a = [45 : 10 : 75]) _rotP(a, 1, 2) ], "Should return a list of points to draw a 30° arc from 45° with a radius of [1, 2]");
                assertEqual(arc([1, 2], a1=45, a=-30, $fn=36), [ for (a = [45 : -10 : 15]) _rotP(a, 1, 2) ], "Should return a list of points to draw a -30° arc from 45° with a radius of [1, 2]");
                assertEqual(arc([1, 2], a1=-45, a=30, $fn=36), [ for (a = [-45 : 10 : -15]) _rotP(a, 1, 2) ], "Should return a list of points to draw a 30° arc from -45° with a radius of [1, 2]");
                assertEqual(arc([1, 2], a1=-45, a=-30, $fn=36), [ for (a = [-45 : -10 : -75]) _rotP(a, 1, 2) ], "Should return a list of points to draw a -30° arc from -45° with a radius of [1, 2]");
                assertEqual(arc([1, 2], a1=405, a=390, $fn=36), [ for (a = [45 : 10 : 75]) _rotP(a, 1, 2) ], "Should return a list of points to draw a 390° arc from 405° with a radius of [1, 2]");
                assertEqual(arc([1, 2], a1=405, a=-390, $fn=36), [ for (a = [45 : -10 : 15]) _rotP(a, 1, 2) ], "Should return a list of points to draw a -390° arc from 405° with a radius of [1, 2]");
                assertEqual(arc([1, 2], a1=-30, a2=-60, $fn=36), [ for (a = [-30 : -10 : -60]) _rotP(a, 1, 2) ], "Should return a list of points to draw an arc from -30° to -60° with a radius of [1, 2]");
                assertEqual(arc([1, 2], a1=-60, a2=-30, $fn=36), [ for (a = [-60 : 10 : -30]) _rotP(a, 1, 2) ], "Should return a list of points to draw an arc from -60° to -30° with a radius of [1, 2]");
                assertEqual(arc([1, 2], a1=-30, a2=30, $fn=36), [ for (a = [-30 : 10 : 30]) _rotP(a, 1, 2) ], "Should return a list of points to draw an arc from -30° to 30° with a radius of [1, 2]");
                assertEqual(arc([1, 2], a1=30, a2=-30, $fn=36), [ for (a = [30 : -10 : -30]) _rotP(a, 1, 2) ], "Should return a list of points to draw an arc from 30° to -30° with a radius of [1, 2]");
                assertEqual(arc([1, 2], a1=-390, a2=390, $fn=36), [ for (a = [-30 : 10 : 30]) _rotP(a, 1, 2) ], "Should return a list of points to draw an arc from -390° to 390° with a radius of [1, 2]");
                assertEqual(arc([1, 2], a1=390, a2=-390, $fn=36), [ for (a = [30 : -10 : -30]) _rotP(a, 1, 2) ], "Should return a list of points to draw an arc from 390° to -390° with a radius of [1, 2]");
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
                $fn = 6;
                step = 1 / $fn;
                assertEqual(sinusoid(1), [ for (a = [0 : step : 1]) [a, sin(360 * a)] ], "Should build a simple sinusoid with a length of 1 and 6 segments");
                assertEqual(sinusoid(1, 2), [ for (a = [0 : step*2 : 1]) [a, sin(360 * a / 2)] ], "Should build a simple sinusoid with a length of 1, a period of 2 and 6 segments");
                assertEqual(sinusoid(1, 2, 4), [ for (a = [0 : step*2 : 1]) [a, 4 * sin(360 * a / 2)] ], "Should build a simple sinusoid with a length of 1, a period of 2, an amplitude of 4 and 6 segments");
                assertEqual(sinusoid(1, 2, 4, 6), [ for (a = [0 : step*2 : 1]) [a, 4 * sin(360 * a / 2 + 6)] ], "Should build a simple sinusoid with a length of 1, a period of 2, an amplitude of 4, a delay of 6 and 6 segments");
                assertEqual(sinusoid(1, 2, 4, 6, 8), [ for (a = [0 : step*2 : 1]) [a, 4 * sin(360 * a / 2 + 6) + 8] ], "Should build a simple sinusoid with a length of 1, a period of 2, an amplitude of 4, a delay of 6, an offset of 8 and 6 segments");
            }
            testUnit("rotated", 5) {
                $fn = 8;
                step = 1 / $fn;
                assertEqual(sinusoid(3, a=70), [ for (a = [0 : step : 3]) _rot2([a, sin(360 * a)], 70) ], "Should build a sinusoid rotated by 70° with a length of 1 and 6 segments");
                assertEqual(sinusoid(3, 2, a=70), [ for (a = [0 : step*2 : 3]) _rot2([a, sin(360 * a / 2)], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2 and 6 segments");
                assertEqual(sinusoid(3, 2, 4, a=70), [ for (a = [0 : step*2 : 3]) _rot2([a, 4 * sin(360 * a / 2)], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2, an amplitude of 4 and 6 segments");
                assertEqual(sinusoid(3, 2, 4, 6, a=70), [ for (a = [0 : step*2 : 3]) _rot2([a, 4 * sin(360 * a / 2 + 6)], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2, an amplitude of 4, a delay of 6 and 6 segments");
                assertEqual(sinusoid(3, 2, 4, 6, 8, a=70), [ for (a = [0 : step*2 : 3]) _rot2([a, 4 * sin(360 * a / 2 + 6) + 8], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2, an amplitude of 4, a delay of 6, an offset of 8 and 6 segments");
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
                $fn = 6;
                step = 1 / $fn;
                assertEqual(cosinusoid(1), [ for (a = [0 : step : 1]) [cos(360 * a), a] ], "Should build a simple sinusoid with a length of 1 and 6 segments");
                assertEqual(cosinusoid(1, 2), [ for (a = [0 : step*2 : 1]) [cos(360 * a / 2), a] ], "Should build a simple sinusoid with a length of 1, a period of 2 and 6 segments");
                assertEqual(cosinusoid(1, 2, 4), [ for (a = [0 : step*2 : 1]) [4 * cos(360 * a / 2), a] ], "Should build a simple sinusoid with a length of 1, a period of 2, an amplitude of 4 and 6 segments");
                assertEqual(cosinusoid(1, 2, 4, 6), [ for (a = [0 : step*2 : 1]) [4 * cos(360 * a / 2 + 6), a] ], "Should build a simple sinusoid with a length of 1, a period of 2, an amplitude of 4, a delay of 6 and 6 segments");
                assertEqual(cosinusoid(1, 2, 4, 6, 8), [ for (a = [0 : step*2 : 1]) [4 * cos(360 * a / 2 + 6) + 8, a] ], "Should build a simple sinusoid with a length of 1, a period of 2, an amplitude of 4, a delay of 6, an offset of 8 and 6 segments");
            }
            testUnit("rotated", 5) {
                $fn = 8;
                step = 1 / $fn;
                assertEqual(cosinusoid(3, a=70), [ for (a = [0 : step : 3]) _rot2([cos(360 * a), a], 70) ], "Should build a sinusoid rotated by 70° with a length of 1 and 6 segments");
                assertEqual(cosinusoid(3, 2, a=70, $fn=8), [ for (a = [0 : step*2 : 3]) _rot2([cos(360 * a / 2), a], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2 and 6 segments");
                assertEqual(cosinusoid(3, 2, 4, a=70, $fn=8), [ for (a = [0 : step*2 : 3]) _rot2([4 * cos(360 * a / 2), a], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2, an amplitude of 4 and 6 segments");
                assertEqual(cosinusoid(3, 2, 4, 6, a=70, $fn=8), [ for (a = [0 : step*2 : 3]) _rot2([4 * cos(360 * a / 2 + 6), a], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2, an amplitude of 4, a delay of 6 and 6 segments");
                assertEqual(cosinusoid(3, 2, 4, 6, 8, a=70, $fn=8), [ for (a = [0 : step*2 : 3]) _rot2([4 * cos(360 * a / 2 + 6) + 8, a], 70) ], "Should build a sinusoid rotated by 70° with a length of 1, a period of 2, an amplitude of 4, a delay of 6, an offset of 8 and 6 segments");
            }
        }
        // test core/line/path()
        testModule("path()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(path(), [], "Cannot build a line without parameters, should return an empty array");
            }
            testUnit("wrong type", 3) {
                assertEqual(path("1", "1"), [[0, 0]], "Cannot build a line using strings");
                assertEqual(path(true, true), [true], "Cannot build a line using booleans");
                assertEqual(path(1, 1), [1], "Cannot build a line using numbers");
            }
            testUnit("path only", 55) {
                // point
                assertEqual(path([["P"]]), [[0, 0]], "Path with 1 empty point");
                assertEqual(path([["P", 10, 20]]), [[10, 20]], "Path with 1 absolute point, using coordinates");
                assertEqual(path([["P", [10, 20]]]), [[10, 20]], "Path with 1 absolute point, using point value");
                assertEqual(path([["P", 10, 20], ["P"]]), [[10, 20]], "Path with 1 absolute point and 1 empty point");
                assertEqual(path([["P", 10, 20], ["P", 0, 5]]), [[10, 20], [0, 5]], "Path with 2 absolute points");
                assertEqual(path([["P", 10, 20], ["P", 0, 5], ["P", 7, 4]]), [[10, 20], [0, 5], [7, 4]], "Path with 3 absolute points");

                // line
                assertEqual(path([["L"]]), [[0, 0]], "Path with 1 empty line");
                assertEqual(path([["L", 10, 20]]), [[0, 0], [10, 20]], "Path with 1 line, using coordinates");
                assertEqual(path([["L", [10, 20]]]), [[0, 0], [10, 20]], "Path with 1 line, using point value");
                assertEqual(path([["P", 5, 6], ["L", 10, 20]]), [[5, 6], [15, 26]], "Path with 1 line from an absolute point");
                assertEqual(path([["P", 5, 6], ["L"]]), [[5, 6]], "Path with 1 empty line from an absolute point");

                // horizontal line
                assertEqual(path([["H"]]), [[0, 0]], "Path with 1 empty horizontal line");
                assertEqual(path([["H", 10]]), [[0, 0], [10, 0]], "Path with 1 horizontal line");
                assertEqual(path([["P", 5, 6], ["H", 10]]), [[5, 6], [15, 6]], "Path with 1 horizontal line from an absolute point");
                assertEqual(path([["P", 5, 6], ["H"]]), [[5, 6]], "Path with 1 empty horizontal line from an absolute point");

                // vertical line
                assertEqual(path([["V"]]), [[0, 0]], "Path with 1 empty vertical line");
                assertEqual(path([["V", 10]]), [[0, 0], [0, 10]], "Path with 1 vertical line");
                assertEqual(path([["P", 5, 6], ["V", 10]]), [[5, 6], [5, 16]], "Path with 1 vertical line from an absolute point");
                assertEqual(path([["P", 5, 6], ["V"]]), [[5, 6]], "Path with 1 empty vertical line from an absolute point");

                // intersection line
                assertEqual(path([["I"]]), [[0, 0]], "Path with 1 empty intersection line");
                assertEqual(path([["I", [3, 3], [1, 3], [6, -2]]]), [[0, 0], [2, 2]], "Path with 1 intersection line");
                assertEqual(path([["P", 5, 6], ["I", [8, 9], [6, 9], [11, 4]]]), [[5, 6], [7, 8]], "Path with 1 intersection line from an absolute point");
                assertEqual(path([["P", 5, 6], ["I"]]), [[5, 6]], "Path with 1 empty intersection line from an absolute point");

                // tangent line
                assertEqual(path([["T"]]), [[0, 0]], "Path with 1 empty tangent line");
                assertEqual(path([["T", 8, 6, 2]]), [[0, 0], arcPoint(sqrt(96), atan2(6, 8) + asin(2 / 10))], "Path with 1 tangent line, using coordinates");
                assertEqual(path([["T", [8, 6], 2]]), [[0, 0], arcPoint(sqrt(96), atan2(6, 8) + asin(2 / 10))], "Path with 1 tangent line, using point value");
                assertEqual(path([["P", 11, 5], ["T", 19, 11, 2]]), [[11, 5], [11, 5] + arcPoint(sqrt(96), atan2(6, 8) + asin(2 / 10))], "Path with 1 tangent line from an absolute point");
                assertEqual(path([["P", 5, 6], ["T"]]), [[5, 6]], "Path with 1 empty tangent line from an absolute point");

                // leaned line
                assertEqual(path([["A"]]), [[0, 0]], "Path with 1 empty leaned line");
                assertEqual(path([["A", 50, 20]]), [[0, 0], _rotP(50, 20, 20)], "Path with 1 leaned line");
                assertEqual(path([["P", 5, 6], ["A", 40, 15]]), [[5, 6], [5, 6] + _rotP(40, 15, 15)], "Path with 1 leaned line from an absolute point");
                assertEqual(path([["P", 5, 6], ["A"]]), [[5, 6]], "Path with 1 empty leaned line from an absolute point");

                // circle
                assertEqual(path([["C"]]), [[0, 0]], "Path with 1 empty circle arc");
                assertEqual(path([["C", 20]]), [ for (a = [astep(360) : astep(360) : 360]) _rotP(180, 20, 20) + _rotP(a, 20, 20) ], "Path with 1 full circle");
                assertEqual(path([["C", 20, 40, 80]]), concat([ for (a = [40 : astep(20) : 80]) _rotP(220, 20, 20) + _rotP(a, 20, 20) ], [_rotP(220, 20, 20) + _rotP(80, 20, 20)]), "Path with 1 circle arc");
                assertEqual(path([["C", 20, 80, 40]]), concat([ for (a = [80 : -astep(20) : 40]) _rotP(260, 20, 20) + _rotP(a, 20, 20) ], [_rotP(260, 20, 20) + _rotP(40, 20, 20)]), "Path with 1 negative circle arc");
                assertEqual(path([["P", 5, 6], ["C", 20, 40, 80]]), concat([ for (a = [40 : astep(20) : 80]) [5, 6] + _rotP(220, 20, 20) + _rotP(a, 20, 20) ], [[5, 6] + _rotP(220, 20, 20) + _rotP(80, 20, 20)]), "Path with 1 circle arc from an absolute point");
                assertEqual(path([["P", 5, 6], ["C", 20, 80, 40]]), concat([ for (a = [80 : -astep(20) : 40]) [5, 6] + _rotP(260, 20, 20) + _rotP(a, 20, 20) ], [[5, 6] + _rotP(260, 20, 20) + _rotP(40, 20, 20)]), "Path with 1 negative circle arc from an absolute point");
                assertEqual(path([["P", 5, 6], ["C"]]), [[5, 6]], "Path with 1 empty circle arc from an absolute point");

                // bezier point
                assertEqual(path([["B"]]), [[0, 0]], "Path with 1 empty bezier");
                assertEqual(path([["P", 5, 6], ["B"]]), [[5, 6]], "Path with 1 empty bezier from an absolute point");

                assertEqual(path([["B", [7, 8]]]), [[0, 0], [7, 8]], "Path with 1 bezier point");
                assertEqual(path([["P", 5, 6], ["B", [7, 8]]]), [[5, 6], [12, 14]], "Path with 1 bezier point from an absolute point");

                // quadratic bezier
                quadratic1 = path([["B", [7, 8], [9, 10]]]);
                assertEqual(len(quadratic1), 5, "Path with 1 quadratic bezier should produce a list of points");
                assertEqual(quadratic1[0], [0, 0], "Path with 1 quadratic bezier should start at the origin");
                assertEqual(quadratic1[4], [9, 10], "Path with 1 quadratic bezier should end with the last control point");

                quadratic2 = path([["P", 5, 6], ["B", [7, 8], [9, 10]]]);
                assertEqual(len(quadratic2), 5, "Path with 1 quadratic bezier from an absolute point should produce a list of points");
                assertEqual(quadratic2[0], [5, 6], "Path with 1 quadratic bezier from an absolute point should start at the provided point");
                assertEqual(quadratic2[4], [14, 16], "Path with 1 quadratic bezier from an absolute point should end with the last control point");

                // cubic bezier
                cubic1 = path([["B", [7, 8], [9, 10], [11, 12]]]);
                assertEqual(len(cubic1), 5, "Path with 1 cubic bezier should produce a list of points");
                assertEqual(cubic1[0], [0, 0], "Path with 1 cubic bezier should start at the origin");
                assertEqual(cubic1[4], [11, 12], "Path with 1 cubic bezier should end with the last control point");

                cubic2 = path([["P", 5, 6], ["B", [7, 8], [9, 10], [11, 12]]]);
                assertEqual(len(cubic2), 5, "Path with 1 cubic bezier from an absolute point should produce a list of points");
                assertEqual(cubic2[0], [5, 6], "Path with 1 cubic bezier from an absolute point should start at the provided point");
                assertEqual(cubic2[4], [16, 18], "Path with 1 cubic bezier from an absolute point should end with the last control point");
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
