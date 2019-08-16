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
 * Unit tests: Lines handling.
 *
 * @package test/core/line
 * @author jsconan
 */
module testCoreLine() {
    testPackage("core/line.scad", 8) {
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
        testModule("path()", 15) {
            testUnit("no parameter", 1) {
                assertEqual(path(), [], "Cannot build a line without parameters, should return an empty array");
            }
            testUnit("wrong type", 3) {
                assertEqual(path("1", "1"), [[0, 0]], "Strings should be casted to array");
                assertEqual(path(true, true), [[0, 0]], "Booleans should be casted to array");
                assertEqual(path(1, 1), [[1, 1]], "Numbers should be casted to array");
            }
            testUnit("point", 6) {
                assertEqual(path([["P"]]), [[0, 0]], "Path with 1 empty point");
                assertEqual(path([["P", 10, 20]]), [[10, 20]], "Path with 1 absolute point, using coordinates");
                assertEqual(path([["P", [10, 20]]]), [[10, 20]], "Path with 1 absolute point, using point value");
                assertEqual(path([["P", 10, 20], ["P"]]), [[10, 20]], "Path with 1 absolute point and 1 empty point");
                assertEqual(path([["P", 10, 20], ["P", 0, 5]]), [[10, 20], [0, 5]], "Path with 2 absolute points");
                assertEqual(path([["P", 10, 20], ["P", 0, 5], ["P", 7, 4]]), [[10, 20], [0, 5], [7, 4]], "Path with 3 absolute points");
            }
            testUnit("line", 5) {
                assertEqual(path([["L"]]), [[0, 0]], "Path with 1 empty line");
                assertEqual(path([["L", 10, 20]]), [[0, 0], [10, 20]], "Path with 1 line, using coordinates");
                assertEqual(path([["L", [10, 20]]]), [[0, 0], [10, 20]], "Path with 1 line, using point value");
                assertEqual(path([["P", 5, 6], ["L", 10, 20]]), [[5, 6], [15, 26]], "Path with 1 line from an absolute point");
                assertEqual(path([["P", 5, 6], ["L"]]), [[5, 6]], "Path with 1 empty line from an absolute point");
            }
            testUnit("horizontal line", 4) {
                assertEqual(path([["H"]]), [[0, 0]], "Path with 1 empty horizontal line");
                assertEqual(path([["H", 10]]), [[0, 0], [10, 0]], "Path with 1 horizontal line");
                assertEqual(path([["P", 5, 6], ["H", 10]]), [[5, 6], [15, 6]], "Path with 1 horizontal line from an absolute point");
                assertEqual(path([["P", 5, 6], ["H"]]), [[5, 6]], "Path with 1 empty horizontal line from an absolute point");
            }
            testUnit("vertical line", 4) {
                assertEqual(path([["V"]]), [[0, 0]], "Path with 1 empty vertical line");
                assertEqual(path([["V", 10]]), [[0, 0], [0, 10]], "Path with 1 vertical line");
                assertEqual(path([["P", 5, 6], ["V", 10]]), [[5, 6], [5, 16]], "Path with 1 vertical line from an absolute point");
                assertEqual(path([["P", 5, 6], ["V"]]), [[5, 6]], "Path with 1 empty vertical line from an absolute point");
            }
            testUnit("intersection line", 4) {
                assertEqual(path([["I"]]), [[0, 0]], "Path with 1 empty intersection line");
                assertEqual(path([["I", [3, 3], [1, 3], [6, -2]]]), [[0, 0], [2, 2]], "Path with 1 intersection line");
                assertEqual(path([["P", 5, 6], ["I", [8, 9], [6, 9], [11, 4]]]), [[5, 6], [7, 8]], "Path with 1 intersection line from an absolute point");
                assertEqual(path([["P", 5, 6], ["I"]]), [[5, 6]], "Path with 1 empty intersection line from an absolute point");
            }
            testUnit("tangent line", 5) {
                assertEqual(path([["T"]]), [[0, 0]], "Path with 1 empty tangent line");
                assertEqual(path([["T", 8, 6, 2]]), [[0, 0], arcPoint(sqrt(96), atan2(6, 8) + asin(2 / 10))], "Path with 1 tangent line, using coordinates");
                assertEqual(path([["T", [8, 6], 2]]), [[0, 0], arcPoint(sqrt(96), atan2(6, 8) + asin(2 / 10))], "Path with 1 tangent line, using point value");
                assertEqual(path([["P", 11, 5], ["T", 19, 11, 2]]), [[11, 5], [11, 5] + arcPoint(sqrt(96), atan2(6, 8) + asin(2 / 10))], "Path with 1 tangent line from an absolute point");
                assertEqual(path([["P", 5, 6], ["T"]]), [[5, 6]], "Path with 1 empty tangent line from an absolute point");
            }
            testUnit("leaned line", 4) {
                assertEqual(path([["A"]]), [[0, 0]], "Path with 1 empty leaned line");
                assertEqual(path([["A", 50, 20]]), [[0, 0], _rotP(50, 20, 20)], "Path with 1 leaned line");
                assertEqual(path([["P", 5, 6], ["A", 40, 15]]), [[5, 6], [5, 6] + _rotP(40, 15, 15)], "Path with 1 leaned line from an absolute point");
                assertEqual(path([["P", 5, 6], ["A"]]), [[5, 6]], "Path with 1 empty leaned line from an absolute point");
            }
            testUnit("circle", 7) {
                assertEqual(path([["C"]]), [[0, 0]], "Path with 1 empty circle arc");
                assertEqual(path([["C", 20]]), [ for (a = [astep(360) : astep(360) : 360]) _rotP(180, 20, 20) + _rotP(a, 20, 20) ], "Path with 1 full circle");
                assertEqual(path([["C", 20, 40, 80]]), concat([ for (a = [40 : astep(20) : 80]) _rotP(220, 20, 20) + _rotP(a, 20, 20) ], [_rotP(220, 20, 20) + _rotP(80, 20, 20)]), "Path with 1 circle arc");
                assertEqual(path([["C", 20, 80, 40]]), concat([ for (a = [80 : -astep(20) : 40]) _rotP(260, 20, 20) + _rotP(a, 20, 20) ], [_rotP(260, 20, 20) + _rotP(40, 20, 20)]), "Path with 1 negative circle arc");
                assertEqual(path([["P", 5, 6], ["C", 20, 40, 80]]), concat([ for (a = [40 : astep(20) : 80]) [5, 6] + _rotP(220, 20, 20) + _rotP(a, 20, 20) ], [[5, 6] + _rotP(220, 20, 20) + _rotP(80, 20, 20)]), "Path with 1 circle arc from an absolute point");
                assertEqual(path([["P", 5, 6], ["C", 20, 80, 40]]), concat([ for (a = [80 : -astep(20) : 40]) [5, 6] + _rotP(260, 20, 20) + _rotP(a, 20, 20) ], [[5, 6] + _rotP(260, 20, 20) + _rotP(40, 20, 20)]), "Path with 1 negative circle arc from an absolute point");
                assertEqual(path([["P", 5, 6], ["C"]]), [[5, 6]], "Path with 1 empty circle arc from an absolute point");
            }
            testUnit("bezier point", 4) {
                assertEqual(path([["B"]]), [[0, 0]], "Path with 1 empty bezier");
                assertEqual(path([["P", 5, 6], ["B"]]), [[5, 6]], "Path with 1 empty bezier from an absolute point");

                assertEqual(path([["B", [7, 8]]]), [[0, 0], [7, 8]], "Path with 1 bezier point");
                assertEqual(path([["P", 5, 6], ["B", [7, 8]]]), [[5, 6], [12, 14]], "Path with 1 bezier point from an absolute point");
            }
            testUnit("quadratic bezier", 6) {
                quadratic1 = path([["B", [7, 8], [9, 10]]]);
                assertEqual(len(quadratic1), 5, "Path with 1 quadratic bezier should produce a list of points");
                assertEqual(quadratic1[0], [0, 0], "Path with 1 quadratic bezier should start at the origin");
                assertEqual(quadratic1[4], [9, 10], "Path with 1 quadratic bezier should end with the last control point");

                quadratic2 = path([["P", 5, 6], ["B", [7, 8], [9, 10]]]);
                assertEqual(len(quadratic2), 5, "Path with 1 quadratic bezier from an absolute point should produce a list of points");
                assertEqual(quadratic2[0], [5, 6], "Path with 1 quadratic bezier from an absolute point should start at the provided point");
                assertEqual(quadratic2[4], [14, 16], "Path with 1 quadratic bezier from an absolute point should end with the last control point");
            }
            testUnit("cubic bezier", 6) {
                cubic1 = path([["B", [7, 8], [9, 10], [11, 12]]]);
                assertEqual(len(cubic1), 5, "Path with 1 cubic bezier should produce a list of points");
                assertEqual(cubic1[0], [0, 0], "Path with 1 cubic bezier should start at the origin");
                assertEqual(cubic1[4], [11, 12], "Path with 1 cubic bezier should end with the last control point");

                cubic2 = path([["P", 5, 6], ["B", [7, 8], [9, 10], [11, 12]]]);
                assertEqual(len(cubic2), 5, "Path with 1 cubic bezier from an absolute point should produce a list of points");
                assertEqual(cubic2[0], [5, 6], "Path with 1 cubic bezier from an absolute point should start at the provided point");
                assertEqual(cubic2[4], [16, 18], "Path with 1 cubic bezier from an absolute point should end with the last control point");
            }
            testUnit("nested path", 3) {
                assertEqual(path([
                    ["P", 0, 0],
                    ["N", [
                        ["H", 5],
                        ["V", 2]
                    ]]
                ]), [[0, 0], [5, 0], [5, 2]], "Simple nested path");

                assertEqual(path([
                    ["P", 0, 0],
                    ["N", [
                        ["L", 10, 20],
                        ["H", 5],
                        ["V", 2],
                        ["C", 20, 80, 40]
                    ]]
                ]), path([
                    ["P", 0, 0],
                    ["L", 10, 20],
                    ["H", 5],
                    ["V", 2],
                    ["C", 20, 80, 40]
                ]), "Complex nested path");

                assertEqual(path([
                    ["P", 0, 0],
                    ["H", 3],
                    ["N", [
                        ["H", 5],
                        ["N", [
                            ["L", 10, 20],
                            ["H", 5],
                            ["V", 2],
                            ["C", 20, 80, 40]
                        ]],
                        ["V", 2]
                    ]]
                ]), path([
                    ["P", 0, 0],
                    ["H", 3],
                    ["H", 5],
                    ["L", 10, 20],
                    ["H", 5],
                    ["V", 2],
                    ["C", 20, 80, 40],
                    ["V", 2]
                ]), "Deep nested path");
            }
            testUnit("repeat path", 3) {
                assertEqual(path([
                    ["P", 0, 0],
                    ["R", 3, [
                        ["H", 5],
                        ["V", 2]
                    ]]
                ]), [[0, 0], [5, 0], [5, 2], [10, 2], [10, 4], [15, 4], [15, 6]], "Repeat 3 times the sub path of H and V");

                assertEqual(path([
                    ["P", 0, 0],
                    ["H", 3],
                    ["R", 3, [
                        ["H", 5],
                        ["V", 2]
                    ]],
                    ["V", 3],
                    ["H", -2],
                    ["R", 3, [
                        ["V", -2],
                        ["H", -5]
                    ]]
                ]), path([
                    ["P", 0, 0],
                    ["H", 3],
                    ["H", 5],
                    ["V", 2],
                    ["H", 5],
                    ["V", 2],
                    ["H", 5],
                    ["V", 2],
                    ["V", 3],
                    ["H", -2],
                    ["V", -2],
                    ["H", -5],
                    ["V", -2],
                    ["H", -5],
                    ["V", -2],
                    ["H", -5]
                ]), "Several repeat");

                assertEqual(path([
                    ["P", 0, 0],
                    ["H", 3],
                    ["R", 4, [
                        ["V", 5],
                        ["R", 3, [
                            ["H", 5],
                            ["V", 2]
                        ]]
                    ]]
                ]), path([
                    ["P", 0, 0],
                    ["H", 3],
                    ["V", 5],
                    ["H", 5],
                    ["V", 2],
                    ["H", 5],
                    ["V", 2],
                    ["H", 5],
                    ["V", 2],
                    ["V", 5],
                    ["H", 5],
                    ["V", 2],
                    ["H", 5],
                    ["V", 2],
                    ["H", 5],
                    ["V", 2],
                    ["V", 5],
                    ["H", 5],
                    ["V", 2],
                    ["H", 5],
                    ["V", 2],
                    ["H", 5],
                    ["V", 2],
                    ["V", 5],
                    ["H", 5],
                    ["V", 2],
                    ["H", 5],
                    ["V", 2],
                    ["H", 5],
                    ["V", 2]
                ]), "Nested repeat");
            }
        }
        // test core/line/outline()
        testModule("outline()", 5) {
            testUnit("no parameter", 1) {
                assertEqual(outline(), [], "Cannot build an outline without parameters");
            }
            testUnit("wrong type", 3) {
                assertEqual(outline("1", "1"), ["1"], "Cannot build an outline using strings");
                assertEqual(outline(true, true), [true], "Cannot build an outline using booleans");
                assertEqual(outline([1], [1]), [1], "Cannot build an outline using vectors");
            }
            testUnit("short line", 2) {
                assertEqual(outline([0], 1), [0], "The outline needs at least 3 points");
                assertEqual(outline([0, 1], 1), [0, 1], "The outline needs at least 3 points");
            }
            testUnit("ouside", 2) {
                assertEqual(outline([[1, 1], [2, 1], [2, 2], [1, 2]], 1), [[0, 0], [3, 0], [3, 3], [0, 3]], "Outline of a square");
                assertEqual(outline([[2, 1], [1, 1], [1, 2], [-1, 2], [-1, 1], [-2, 1], [-2, -1], [-1, -1], [-1, -2], [1, -2], [1, -1], [2, -1]], 1), [[3, 2], [2, 2], [2, 3], [-2, 3], [-2, 2], [-3, 2], [-3, -2], [-2, -2], [-2, -3], [2, -3], [2, -2], [3, -2]], "Outline of a cross");
            }
            testUnit("inside", 2) {
                assertEqual(outline([[0, 0], [3, 0], [3, 3], [0, 3]], -1), [[1, 1], [2, 1], [2, 2], [1, 2]], "Outline of a square");
                assertEqual(outline([[3, 2], [2, 2], [2, 3], [-2, 3], [-2, 2], [-3, 2], [-3, -2], [-2, -2], [-2, -3], [2, -3], [2, -2], [3, -2]], -1), [[2, 1], [1, 1], [1, 2], [-1, 2], [-1, 1], [-2, 1], [-2, -1], [-1, -1], [-1, -2], [1, -2], [1, -1], [2, -1]], "Outline of a cross");
            }
        }
        // test core/line/lineAdd()
        testModule("lineAdd()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(lineAdd(), [], "Cannot add value to an empty line");
            }
            testUnit("wrong type", 3) {
                assertEqual(lineAdd("1", "1"), [[0, 0]], "Cannot add value to strings");
                assertEqual(lineAdd(true, true), [[0, 0]], "Cannot add value to booleans");
                assertEqual(lineAdd([], []), [], "Cannot add value to empty vectors");
            }
            testUnit("2D vectors", 5) {
                assertEqual(lineAdd(1, 1), [[2, 2]], "Simple values should be converted to 2D vectors");
                assertEqual(lineAdd([0, 1], 1), [[1, 1], [2, 2]], "Single value points should be converted to 2D vectors");
                assertEqual(lineAdd([[2, 3], [1, -2]], [1, 2]), [[3, 5], [2, 0]], "Add 2D vector");
                assertEqual(lineAdd([[2, 3], [1, -2]], [1]), [[3, 3], [2, -2]], "Add truncated 2D vector");
                assertEqual(lineAdd([[2], [-2]], [1, 2]), [[3, 2], [-1, 2]], "Add 2D vector to truncated points");
            }
            testUnit("3D vectors", 6) {
                assertEqual(lineAdd(1, [1, 2, 3]), [[2, 3, 4]], "Simple values should be converted to 3D vectors if vector to add is 3D");
                assertEqual(lineAdd([[1, 2, 3]], 1), [[2, 3, 4]], "Simple values should be converted to 3D vectors if line is 3D");
                assertEqual(lineAdd([0, 1], [1, 1, 1]), [[1, 1, 1], [2, 2, 2]], "Single value points should be converted to 3D vectors if vector to add is 3D");
                assertEqual(lineAdd([[2, 3, 1], [1, -2, -1]], [1, 2, 3]), [[3, 5, 4], [2, 0, 2]], "Add 3D vector");
                assertEqual(lineAdd([[2, 3, 4], [1, -2, 1]], [1]), [[3, 3, 4], [2, -2, 1]], "Add truncated 3D vector");
                assertEqual(lineAdd([[2], [-2]], [1, 2, 3]), [[3, 2, 3], [-1, 2, 3]], "Add 3D vector to truncated points");
            }
        }
        // test core/line/simplePolyhedronFaces()
        testModule("simplePolyhedronFaces()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(simplePolyhedronFaces(), [], "Cannot get faces for an empty polyhedron");
            }
            testUnit("wrong type", 3) {
                assertEqual(simplePolyhedronFaces("1"), [], "Cannot get faces for a wrong polyhedron (strings)");
                assertEqual(simplePolyhedronFaces(true), [], "Cannot get faces for a wrong polyhedron (booleans)");
                assertEqual(simplePolyhedronFaces([]), [], "Cannot get faces for a wrong polyhedron (vectors)");
            }
            testUnit("invalid polyhedron", 3) {
                assertEqual(simplePolyhedronFaces(0), [], "Cannot get faces for an invalid polyhedron (0)");
                assertEqual(simplePolyhedronFaces(1), [], "Cannot get faces for an invalid polyhedron (1)");
                assertEqual(simplePolyhedronFaces(2), [], "Cannot get faces for an invalid polyhedron (2)");
            }
            testUnit("polyhedron", 4) {
                assertEqual(simplePolyhedronFaces(3), [
                    [0, 1, 2],
                    [5, 4, 3],
                    [3, 4, 1, 0],
                    [4, 5, 2, 1],
                    [5, 3, 0, 2]
                ], "Polyhedron with 3 edges");
                assertEqual(simplePolyhedronFaces(4), [
                    [0, 1, 2, 3],
                    [7, 6, 5, 4],
                    [4, 5, 1, 0],
                    [5, 6, 2, 1],
                    [6, 7, 3, 2],
                    [7, 4, 0, 3]
                ], "Polyhedron with 4 edges");
                assertEqual(simplePolyhedronFaces(5), [
                    [0, 1, 2, 3, 4],
                    [9, 8, 7, 6, 5],
                    [5, 6, 1, 0],
                    [6, 7, 2, 1],
                    [7, 8, 3, 2],
                    [8, 9, 4, 3],
                    [9, 5, 0, 4]
                ], "Polyhedron with 5 edges");
                assertEqual(simplePolyhedronFaces(12), [
                    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
                    [23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12],
                    [12, 13, 1, 0],
                    [13, 14, 2, 1],
                    [14, 15, 3, 2],
                    [15, 16, 4, 3],
                    [16, 17, 5, 4],
                    [17, 18, 6, 5],
                    [18, 19, 7, 6],
                    [19, 20, 8, 7],
                    [20, 21, 9, 8],
                    [21, 22, 10, 9],
                    [22, 23, 11, 10],
                    [23, 12, 0, 11]
                ], "Polyhedron with 12 edges");
            }
        }
        // test core/line/simplePolyhedronPoints()
        testModule("simplePolyhedronPoints()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(simplePolyhedronPoints(), [], "Cannot get points for an empty polyhedron");
            }
            testUnit("wrong type", 3) {
                assertEqual(simplePolyhedronPoints("1"), [[0, 0, 0], [0, 0, 0]], "Cannot get points for a wrong polyhedron (strings)");
                assertEqual(simplePolyhedronPoints(true), [[0, 0, 0], [0, 0, 0]], "Cannot get points for a wrong polyhedron (booleans)");
                assertEqual(simplePolyhedronPoints([]), [], "Cannot get points for a wrong polyhedron (vectors)");
            }
            testUnit("polyhedron", 67) {
                assertEqual(simplePolyhedronPoints([1, 2, 3], [4, 5, 6]), [[1, 1, 1], [2, 2, 2], [3, 3, 3], [4, 4, 4], [5, 5, 5], [6, 6, 6]], "Simple numbers should be converted into 3D vectors: bottom and top");
                assertEqual(simplePolyhedronPoints(points=[1, 2, 3]), [[1, 1, 1], [2, 2, 2], [3, 3, 3], [1, 1, 1], [2, 2, 2], [3, 3, 3]], "Simple numbers should be converted into 3D vectors: points");
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]]
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [4, 4, 4], [5, 5, 5], [6, 6, 6]],
                    "Concat bottom and top"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = 1
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 5, 5], [6, 6, 6], [7, 7, 7]],
                    "Concat bottom and top, add distance as a number"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = [1, 2, 3]
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 6, 7], [6, 7, 8], [7, 8, 9]],
                    "Concat bottom and top, add distance as a vector"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = [1]
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 4, 4], [6, 5, 5], [7, 6, 6]],
                    "Concat bottom and top, complete and add distance (1)"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = [1, 2]
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 6, 4], [6, 7, 5], [7, 8, 6]],
                    "Concat bottom and top, complete and add distance (2)"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = 1
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 2, 2], [3, 3, 3], [4, 4, 4]],
                    "Compose from points, convert distance"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2, 3]
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 4], [3, 4, 5], [4, 5, 6]],
                    "Compose from points, add distance"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1]
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 1, 1], [3, 2, 2], [4, 3, 3]],
                    "Compose from points, complete distance (1)"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2]
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 1], [3, 4, 2], [4, 5, 3]],
                    "Compose from points, complete distance (2)"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = 1
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 2, 2], [3, 3, 3], [4, 4, 4]],
                    "Compose from bottom, convert distance"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2, 3]
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 4], [3, 4, 5], [4, 5, 6]],
                    "Compose from bottom, add distance"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1]
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 1, 1], [3, 2, 2], [4, 3, 3]],
                    "Compose from bottom, complete distance (1)"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2]
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 1], [3, 4, 2], [4, 5, 3]],
                    "Compose from bottom, complete distance (2)"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = 1
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 2, 2], [3, 3, 3], [4, 4, 4]],
                    "Compose from top, convert distance"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2, 3]
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 4], [3, 4, 5], [4, 5, 6]],
                    "Compose from top, add distance"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1]
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 1, 1], [3, 2, 2], [4, 3, 3]],
                    "Compose from top, complete distance (1)"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2]
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 1], [3, 4, 2], [4, 5, 3]],
                    "Compose from top, complete distance (2)"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = 1,
                        x = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [6, 5, 5], [7, 6, 6], [8, 7, 7]],
                    "Concat bottom and top, add distance as a number and set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = 1,
                        y = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 6, 5], [6, 7, 6], [7, 8, 7]],
                    "Concat bottom and top, add distance as a number and set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = 1,
                        z = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 5, 6], [6, 6, 7], [7, 7, 8]],
                    "Concat bottom and top, add distance as a number and set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = [1, 2, 3],
                        x = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [8, 6, 7], [9, 7, 8], [10, 8, 9]],
                    "Concat bottom and top, add distance as a vector and set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = [1, 2, 3],
                        y = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 8, 7], [6, 9, 8], [7, 10, 9]],
                    "Concat bottom and top, add distance as a vector and set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = [1, 2, 3],
                        z = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 6, 8], [6, 7, 9], [7, 8, 10]],
                    "Concat bottom and top, add distance as a vector and set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = [1],
                        x = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [6, 4, 4], [7, 5, 5], [8, 6, 6]],
                    "Concat bottom and top, complete and add distance (1), set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = [1],
                        y = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 6, 4], [6, 7, 5], [7, 8, 6]],
                    "Concat bottom and top, complete and add distance (1), set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = [1],
                        z = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 4, 6], [6, 5, 7], [7, 6, 8]],
                    "Concat bottom and top, complete and add distance (1), set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = [1, 2],
                        x = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [8, 6, 4], [9, 7, 5], [10, 8, 6]],
                    "Concat bottom and top, complete and add distance (2), set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = [1, 2],
                        y = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 8, 4], [6, 9, 5], [7, 10, 6]],
                    "Concat bottom and top, complete and add distance (2), set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        top = [[4, 4, 4], [5, 5, 5], [6, 6, 6]],
                        distance = [1, 2],
                        z = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 6, 8], [6, 7, 9], [7, 8, 10]],
                    "Concat bottom and top, complete and add distance (2), set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = 1,
                        x = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [3, 2, 2], [4, 3, 3], [5, 4, 4]],
                    "Compose from points, convert distance and set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = 1,
                        y = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 2], [3, 4, 3], [4, 5, 4]],
                    "Compose from points, convert distance and set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = 1,
                        z = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 2, 3], [3, 3, 4], [4, 4, 5]],
                    "Compose from points, convert distance and set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2, 3],
                        x = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 3, 4], [6, 4, 5], [7, 5, 6]],
                    "Compose from points, add distance, set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2, 3],
                        y = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 5, 4], [3, 6, 5], [4, 7, 6]],
                    "Compose from points, add distance, set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2, 3],
                        z = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 5], [3, 4, 6], [4, 5, 7]],
                    "Compose from points, add distance, set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1],
                        x = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [3, 1, 1], [4, 2, 2], [5, 3, 3]],
                    "Compose from points, complete distance (1), set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1],
                        y = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 1], [3, 4, 2], [4, 5, 3]],
                    "Compose from points, complete distance (1), set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1],
                        z = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 1, 3], [3, 2, 4], [4, 3, 5]],
                    "Compose from points, complete distance (1), set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2],
                        x = 3
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [4, 3, 1], [5, 4, 2], [6, 5, 3]],
                    "Compose from points, complete distance (2), set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2],
                        y = 3
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 4, 1], [3, 5, 2], [4, 6, 3]],
                    "Compose from points, complete distance (2), set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        points = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2],
                        z = 3
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 4], [3, 4, 5], [4, 5, 6]],
                    "Compose from points, complete distance (2), set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = 1,
                        x = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [3, 2, 2], [4, 3, 3], [5, 4, 4]],
                    "Compose from bottom, convert distance and set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = 1,
                        y = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 2], [3, 4, 3], [4, 5, 4]],
                    "Compose from bottom, convert distance and set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = 1,
                        z = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 2, 3], [3, 3, 4], [4, 4, 5]],
                    "Compose from bottom, convert distance and set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2, 3],
                        x = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 3, 4], [6, 4, 5], [7, 5, 6]],
                    "Compose from bottom, add distance, set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2, 3],
                        y = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 5, 4], [3, 6, 5], [4, 7, 6]],
                    "Compose from bottom, add distance, set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2, 3],
                        z = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 5], [3, 4, 6], [4, 5, 7]],
                    "Compose from bottom, add distance, set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1],
                        x = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [3, 1, 1], [4, 2, 2], [5, 3, 3]],
                    "Compose from bottom, complete distance (1), set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1],
                        y = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 1], [3, 4, 2], [4, 5, 3]],
                    "Compose from bottom, complete distance (1), set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1],
                        z = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 1, 3], [3, 2, 4], [4, 3, 5]],
                    "Compose from bottom, complete distance (1), set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2],
                        x = 3
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [4, 3, 1], [5, 4, 2], [6, 5, 3]],
                    "Compose from bottom, complete distance (2), set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2],
                        y = 3
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 4, 1], [3, 5, 2], [4, 6, 3]],
                    "Compose from bottom, complete distance (2), set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        bottom = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2],
                        z = 3
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 4], [3, 4, 5], [4, 5, 6]],
                    "Compose from bottom, complete distance (2), set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = 1,
                        x = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [3, 2, 2], [4, 3, 3], [5, 4, 4]],
                    "Compose from top, convert distance and set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = 1,
                        y = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 2], [3, 4, 3], [4, 5, 4]],
                    "Compose from top, convert distance and set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = 1,
                        z = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 2, 3], [3, 3, 4], [4, 4, 5]],
                    "Compose from top, convert distance and set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2, 3],
                        x = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 3, 4], [6, 4, 5], [7, 5, 6]],
                    "Compose from top, add distance, set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2, 3],
                        y = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 5, 4], [3, 6, 5], [4, 7, 6]],
                    "Compose from top, add distance, set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2, 3],
                        z = 4
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 5], [3, 4, 6], [4, 5, 7]],
                    "Compose from top, add distance, set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1],
                        x = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [3, 1, 1], [4, 2, 2], [5, 3, 3]],
                    "Compose from top, complete distance (1), set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1],
                        y = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 1], [3, 4, 2], [4, 5, 3]],
                    "Compose from top, complete distance (1), set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1],
                        z = 2
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 1, 3], [3, 2, 4], [4, 3, 5]],
                    "Compose from top, complete distance (1), set z"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2],
                        x = 3
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [4, 3, 1], [5, 4, 2], [6, 5, 3]],
                    "Compose from top, complete distance (2), set x"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2],
                        y = 3
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 4, 1], [3, 5, 2], [4, 6, 3]],
                    "Compose from top, complete distance (2), set y"
                );
                assertEqual(
                    simplePolyhedronPoints(
                        top = [[1, 1, 1], [2, 2, 2], [3, 3, 3]],
                        distance = [1, 2],
                        z = 3
                    ),
                    [[1, 1, 1], [2, 2, 2], [3, 3, 3], [2, 3, 4], [3, 4, 5], [4, 5, 6]],
                    "Compose from top, complete distance (2), set z"
                );
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
