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

use <../../../full.scad>

/**
 * Part of the camelSCAD library.
 *
 * Unit tests: Ellipse shapes.
 *
 * @package test/shape/2D
 * @author jsconan
 */
module testShape2dEllipse() {
    testPackage("shape/2D/ellipse.scad", 4) {
        // test shape/2D/ellipse/sizeEllipse()
        testModule("sizeEllipse()", 5) {
            testUnit("default values", 3) {
                assertEqual(sizeEllipse(), [1, 1], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeEllipse("12", "12", "12", "12", "12", "12"), [1, 1], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeEllipse(true, true, true, true, true, true), [1, 1], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("number instead of vector", 2) {
                assertEqual(sizeEllipse(3), [3, 3], "Should produce a radius vector from a single number radius");
                assertEqual(sizeEllipse(d=3), [1.5, 1.5], "Should produce a radius vector from a single number diameter");
            }
            testUnit("vector", 2) {
                assertEqual(sizeEllipse([3, 4]), [3, 4], "Should keep the provided radius vector");
                assertEqual(sizeEllipse(d=[3, 4]), [1.5, 2], "Should translate the provided diameter vector to a radius vector");
            }
            testUnit("vector and override", 8) {
                assertEqual(sizeEllipse([3, 4], rx=5), [5, 4], "Should set the X radius with the provided radius in the provided radius vector");
                assertEqual(sizeEllipse([3, 4], ry=5), [3, 5], "Should set the Y radius with the provided radius in the provided radius vector");

                assertEqual(sizeEllipse([3, 4], dx=5), [2.5, 4], "Should replace the X radius with the provided diameter in the provided radius vector");
                assertEqual(sizeEllipse([3, 4], dy=5), [3, 2.5], "Should replace the Y radius with the provided diameter in the provided radius vector");

                assertEqual(sizeEllipse(d=[3, 4], rx=5), [5, 2], "Should set the X radius with the provided radius in the provided provided vector");
                assertEqual(sizeEllipse(d=[3, 4], ry=5), [1.5, 5], "Should set the Y radius with the provided radius in the provided provided vector");

                assertEqual(sizeEllipse(d=[3, 4], dx=5), [2.5, 2], "Should replace the X radius with the provided diameter in the provided provided vector");
                assertEqual(sizeEllipse(d=[3, 4], dy=5), [1.5, 2.5], "Should replace the Y radius with the provided diameter in the provided provided vector");
            }
            testUnit("separated parameters", 8) {
                assertEqual(sizeEllipse(rx=3), [3, 1], "Should compose a radius vector from the provided X radius");
                assertEqual(sizeEllipse(ry=3), [1, 3], "Should compose a radius vector from the provided Y radius");
                assertEqual(sizeEllipse(rx=7, ry=3), [7, 3], "Should compose a radius vector from the provided X and Y radius");

                assertEqual(sizeEllipse(dx=3), [1.5, 1], "Should compose a radius vector from the provided X diameter");
                assertEqual(sizeEllipse(dy=3), [1, 1.5], "Should compose a radius vector from the provided Y diameter");
                assertEqual(sizeEllipse(dx=7, dy=3), [3.5, 1.5], "Should compose a radius vector from the provided X and Y diameter");

                assertEqual(sizeEllipse(rx=7, dy=3), [7, 1.5], "Should compose a radius vector from the provided X radius and the Y diameter");
                assertEqual(sizeEllipse(dx=7, ry=3), [3.5, 3], "Should compose a radius vector from the provided X diameter and the Y radius");
            }
        }
        // test shape/2D/ellipse/sizeRing()
        testModule("sizeRing()", 3) {
            testUnit("default values", 3) {
                assertEqual(sizeRing(), [[1, 1], [1, 1]], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeRing("12", "12", "12", "12", "12", "12"), [[1, 1], [1, 1]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeRing(true, true, true, true, true, true), [[1, 1], [1, 1]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("only the outer radius is provided", 20) {
                assertEqual(sizeRing(3), [[3, 3], [3, 3]], "Should produce a radius vector from a single number radius");
                assertEqual(sizeRing(d=3), [[1.5, 1.5], [1.5, 1.5]], "Should produce a radius vector from a single number diameter");

                assertEqual(sizeRing([3, 4]), [[3, 4], [3, 4]], "Should keep the provided radius vector");
                assertEqual(sizeRing(d=[3, 4]), [[1.5, 2], [1.5, 2]], "Should translate the provided diameter vector to a radius vector");

                assertEqual(sizeRing([3, 4], rx=5), [[5, 4], [5, 4]], "Should set the X radius with the provided radius in the provided radius vector");
                assertEqual(sizeRing([3, 4], ry=5), [[3, 5], [3, 5]], "Should set the Y radius with the provided radius in the provided radius vector");

                assertEqual(sizeRing([3, 4], dx=5), [[2.5, 4], [2.5, 4]], "Should replace the X radius with the provided diameter in the provided radius vector");
                assertEqual(sizeRing([3, 4], dy=5), [[3, 2.5], [3, 2.5]], "Should replace the Y radius with the provided diameter in the provided radius vector");

                assertEqual(sizeRing(d=[3, 4], rx=5), [[5, 2], [5, 2]], "Should set the X radius with the provided radius in the provided provided vector");
                assertEqual(sizeRing(d=[3, 4], ry=5), [[1.5, 5], [1.5, 5]], "Should set the Y radius with the provided radius in the provided provided vector");

                assertEqual(sizeRing(d=[3, 4], dx=5), [[2.5, 2], [2.5, 2]], "Should replace the X radius with the provided diameter in the provided provided vector");
                assertEqual(sizeRing(d=[3, 4], dy=5), [[1.5, 2.5], [1.5, 2.5]], "Should replace the Y radius with the provided diameter in the provided provided vector");

                assertEqual(sizeRing(rx=3), [[3, 1], [3, 1]], "Should compose a radius vector from the provided X radius");
                assertEqual(sizeRing(ry=3), [[1, 3], [1, 3]], "Should compose a radius vector from the provided Y radius");
                assertEqual(sizeRing(rx=7, ry=3), [[7, 3], [7, 3]], "Should compose a radius vector from the provided X and Y radius");

                assertEqual(sizeRing(dx=3), [[1.5, 1], [1.5, 1]], "Should compose a radius vector from the provided X diameter");
                assertEqual(sizeRing(dy=3), [[1, 1.5], [1, 1.5]], "Should compose a radius vector from the provided Y diameter");
                assertEqual(sizeRing(dx=7, dy=3), [[3.5, 1.5], [3.5, 1.5]], "Should compose a radius vector from the provided X and Y diameter");

                assertEqual(sizeRing(rx=7, dy=3), [[7, 1.5], [7, 1.5]], "Should compose a radius vector from the provided X radius and the Y diameter");
                assertEqual(sizeRing(dx=7, ry=3), [[3.5, 3], [3.5, 3]], "Should compose a radius vector from the provided X diameter and the Y radius");
            }
            testUnit("outer radius and ring width are provided", 26) {
                assertEqual(sizeRing(3, 2), [[3, 3], [1, 1]], "Should produce a radius vector from a single number radius");
                assertEqual(sizeRing(d=3, w=2), [[1.5, 1.5], [0, 0]], "Should produce a radius vector from a single number diameter");

                assertEqual(sizeRing(3, [2, 1]), [[3, 3], [1, 2]], "Should produce a radius vector from a single number radius and the width as vector");
                assertEqual(sizeRing(d=3, w=[2, 1]), [[1.5, 1.5], [0, 0.5]], "Should produce a radius vector from a single number diameter and the width as vector");

                assertEqual(sizeRing([3, 4], 2), [[3, 4], [1, 2]], "Should keep the provided radius vector");
                assertEqual(sizeRing(d=[3, 4], w=1), [[1.5, 2], [0.5, 1]], "Should translate the provided diameter vector to a radius vector");

                assertEqual(sizeRing([3, 4], [2, 1]), [[3, 4], [1, 3]], "Should keep the provided radius vector");
                assertEqual(sizeRing(d=[3, 4], w=[1, 0.5]), [[1.5, 2], [0.5, 1.5]], "Should translate the provided diameter vector to a radius vector");

                assertEqual(sizeRing([3, 4], 2, rx=5), [[5, 4], [3, 2]], "Should set the X radius with the provided radius in the provided radius vector");
                assertEqual(sizeRing([3, 4], 2, ry=5), [[3, 5], [1, 3]], "Should set the Y radius with the provided radius in the provided radius vector");

                assertEqual(sizeRing([3, 4], 2, rx=5, wx=1), [[5, 4], [4, 2]], "Should set the X radius with the provided radius in the provided radius vector");
                assertEqual(sizeRing([3, 4], 2, ry=5, wy=1), [[3, 5], [1, 4]], "Should set the Y radius with the provided radius in the provided radius vector");

                assertEqual(sizeRing([3, 4], 2, dx=5), [[2.5, 4], [0.5, 2]], "Should replace the X radius with the provided diameter in the provided radius vector");
                assertEqual(sizeRing([3, 4], 2, dy=5), [[3, 2.5], [1, 0.5]], "Should replace the Y radius with the provided diameter in the provided radius vector");

                assertEqual(sizeRing(d=[3, 4], w=2, rx=5), [[5, 2], [3, 0]], "Should set the X radius with the provided radius in the provided provided vector");
                assertEqual(sizeRing(d=[3, 4], w=2, ry=5), [[1.5, 5], [0, 3]], "Should set the Y radius with the provided radius in the provided provided vector");

                assertEqual(sizeRing(d=[3, 4], w=2, dx=5), [[2.5, 2], [0.5, 0]], "Should replace the X radius with the provided diameter in the provided provided vector");
                assertEqual(sizeRing(d=[3, 4], w=2, dy=5), [[1.5, 2.5], [0, 0.5]], "Should replace the Y radius with the provided diameter in the provided provided vector");

                assertEqual(sizeRing(w=0.5, rx=3), [[3, 1], [2.5, 0.5]], "Should compose a radius vector from the provided X radius");
                assertEqual(sizeRing(w=0.5, ry=3), [[1, 3], [0.5, 2.5]], "Should compose a radius vector from the provided Y radius");
                assertEqual(sizeRing(w=2, rx=7, ry=3), [[7, 3], [5, 1]], "Should compose a radius vector from the provided X and Y radius");

                assertEqual(sizeRing(w=0.5, dx=3), [[1.5, 1], [1, 0.5]], "Should compose a radius vector from the provided X diameter");
                assertEqual(sizeRing(w=0.5, dy=3), [[1, 1.5], [0.5, 1]], "Should compose a radius vector from the provided Y diameter");
                assertEqual(sizeRing(w=1, dx=7, dy=3), [[3.5, 1.5], [2.5, 0.5]], "Should compose a radius vector from the provided X and Y diameter");

                assertEqual(sizeRing(w=1, rx=7, dy=3), [[7, 1.5], [6, 0.5]], "Should compose a radius vector from the provided X radius and the Y diameter");
                assertEqual(sizeRing(w=1, dx=7, ry=3), [[3.5, 3], [2.5, 2]], "Should compose a radius vector from the provided X diameter and the Y radius");
            }
        }
        // test shape/2D/ellipse/drawEllipse()
        testModule("drawEllipse()", 3) {
            testUnit("default values", 3) {
                assertEqual(drawEllipse($fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 3 facets (triangle)");
                assertEqual(drawEllipse($fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 4 facets (square)");
                assertEqual(drawEllipse($fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 6 facets (hexagon)");
            }
            testUnit("circle", 8) {
                assertEqual(drawEllipse(2, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a radius of 2 and 3 facets (triangle)");
                assertEqual(drawEllipse(3, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 3, 3) ], "Should return a list of points to draw a circle with a radius of 3 and 4 facets (square)");
                assertEqual(drawEllipse(4, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 4, 4) ], "Should return a list of points to draw a circle with a radius of 4 and 6 facets (hexagon)");
                assertEqual(drawEllipse(5, $fa=12, $fs=2), [ for (a = [astep(5, $fa=12, $fs=2) : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a radius of 5 and 16 facets");

                assertEqual(drawEllipse(d=2, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a diameter of 2 and 3 facets (triangle)");
                assertEqual(drawEllipse(d=3, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1.5, 1.5) ], "Should return a list of points to draw a circle with a diameter of 3 and 4 facets (square)");
                assertEqual(drawEllipse(d=4, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a diameter of 4 and 6 facets (hexagon)");
                assertEqual(drawEllipse(d=5, $fa=12, $fs=2), [ for (a = [astep(2.5, $fa=12, $fs=2) : astep(2.5, $fa=12, $fs=2) : 360]) _rotP(a, 2.5, 2.5) ], "Should return a list of points to draw a circle with a diameter of 5 and 16 facets");
            }
            testUnit("ellipse", 16) {
                assertEqual(drawEllipse([1, 2], $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawEllipse([1, 2], $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawEllipse([1, 2], $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawEllipse([5, 6], $fa=12, $fs=2), complete([ for (a = [astep(6, $fa=12, $fs=2) : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], _rotP(0, 5, 6), _rotP(360, 5, 6)), "Should return a list of points to draw an ellipse with a radius of [5, 6] and 20 facets");

                assertEqual(drawEllipse(d=[1, 2], $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 3 facets (triangle)");
                assertEqual(drawEllipse(d=[1, 2], $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 4 facets (square)");
                assertEqual(drawEllipse(d=[1, 2], $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawEllipse(d=[10, 12], $fa=12, $fs=2), complete([ for (a = [astep(6, $fa=12, $fs=2) : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], _rotP(0, 5, 6), _rotP(360, 5, 6)), "Should return a list of points to draw an ellipse with a diameter of [10, 12] and 20 facets");

                assertEqual(drawEllipse(rx=1, ry=2, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawEllipse(rx=1, ry=2, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawEllipse(rx=1, ry=2, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawEllipse(rx=5, ry=6, $fa=12, $fs=2), complete([ for (a = [astep(6, $fa=12, $fs=2) : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], _rotP(0, 5, 6), _rotP(360, 5, 6)), "Should return a list of points to draw an ellipse with a radius of x=5, y=6 and 20 facets");

                assertEqual(drawEllipse(dx=1, dy=2, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawEllipse(dx=1, dy=2, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 4 facets (square)");
                assertEqual(drawEllipse(dx=1, dy=2, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawEllipse(dx=10, dy=12, $fa=12, $fs=2), complete([ for (a = [astep(6, $fa=12, $fs=2) : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], _rotP(0, 5, 6), _rotP(360, 5, 6)), "Should return a list of points to draw an ellipse with a diameter of x=10, y=12 and 20 facets");
            }
        }
        // test shape/2D/ellipse/drawPie()
        testModule("drawPie()", 5) {
            testUnit("default values", 4) {
                assertEqual(drawPie($fn=3), [ [0, 0], _rotP(0, 1, 1), _rotP(90, 1, 1) ], "Should return a list of points to draw a 90° pie with a radius of 1 and 3 facets");
                assertEqual(drawPie($fn=4), [ [0, 0], _rotP(0, 1, 1), _rotP(90, 1, 1) ], "Should return a list of points to draw a 90° pie with a radius of 1 and 4 facets");
                assertEqual(drawPie($fn=6), [ [0, 0], _rotP(0, 1, 1), _rotP(60, 1, 1), _rotP(90, 1, 1) ], "Should return a list of points to draw a 90° pie with a radius of 1 and 6 facets");
                assertEmptyArray(drawPie(a=0), "Cannot draw a pie with angle of 0");
            }
            testUnit("circle", 8) {
                assertEqual(drawPie(2, a=360, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a radius of 2 and 3 facets (triangle)");
                assertEqual(drawPie(3, a=360, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 3, 3) ], "Should return a list of points to draw a circle with a radius of 3 and 4 facets (square)");
                assertEqual(drawPie(4, a=360, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 4, 4) ], "Should return a list of points to draw a circle with a radius of 4 and 6 facets (hexagon)");
                assertEqual(drawPie(5, a=360, $fa=12, $fs=2), [ for (a = [astep(5, $fa=12, $fs=2) : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a radius of 5 and 16 facets");

                assertEqual(drawPie(d=2, a=360, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a diameter of 2 and 3 facets (triangle)");
                assertEqual(drawPie(d=3, a=360, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1.5, 1.5) ], "Should return a list of points to draw a circle with a diameter of 3 and 4 facets (square)");
                assertEqual(drawPie(d=4, a=360, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a diameter of 4 and 6 facets (hexagon)");
                assertEqual(drawPie(d=5, a=360, $fa=12, $fs=2), [ for (a = [astep(2.5, $fa=12, $fs=2) : astep(2.5, $fa=12, $fs=2) : 360]) _rotP(a, 2.5, 2.5) ], "Should return a list of points to draw a circle with a diameter of 5 and 16 facets");
            }
            testUnit("ellipse", 16) {
                assertEqual(drawPie([1, 2], a=360, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawPie([1, 2], a=360, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawPie([1, 2], a=360, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawPie([5, 6], a=360, $fa=12, $fs=2), complete([ for (a = [astep(6, $fa=12, $fs=2) : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], _rotP(0, 5, 6), _rotP(360, 5, 6)), "Should return a list of points to draw an ellipse with a radius of [5, 6] and 20 facets");

                assertEqual(drawPie(d=[1, 2], a=360, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 3 facets (triangle)");
                assertEqual(drawPie(d=[1, 2], a=360, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 4 facets (square)");
                assertEqual(drawPie(d=[1, 2], a=360, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawPie(d=[10, 12], a=360, $fa=12, $fs=2), complete([ for (a = [astep(6, $fa=12, $fs=2) : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], _rotP(0, 5, 6), _rotP(360, 5, 6)), "Should return a list of points to draw an ellipse with a diameter of [10, 12] and 20 facets");

                assertEqual(drawPie(rx=1, ry=2, a1=0, a2=360, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawPie(rx=1, ry=2, a1=0, a2=360, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawPie(rx=1, ry=2, a1=0, a2=360, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawPie(rx=5, ry=6, a1=0, a2=360, $fa=12, $fs=2), complete([ for (a = [astep(6, $fa=12, $fs=2) : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], _rotP(0, 5, 6), _rotP(360, 5, 6)), "Should return a list of points to draw an ellipse with a radius of x=5, y=6 and 20 facets");

                assertEqual(drawPie(dx=1, dy=2, a1=0, a2=360, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawPie(dx=1, dy=2, a1=0, a2=360, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 4 facets (square)");
                assertEqual(drawPie(dx=1, dy=2, a1=0, a2=360, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawPie(dx=10, dy=12, a1=0, a2=360, $fa=12, $fs=2), complete([ for (a = [astep(6, $fa=12, $fs=2) : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], _rotP(0, 5, 6), _rotP(360, 5, 6)), "Should return a list of points to draw an ellipse with a diameter of x=10, y=12 and 20 facets");
            }
            testUnit("circle pie", 8) {
                assertEqual(drawPie(1, a=30, $fn=3), concat([[0, 0]], [ for (a = [0 : 30 : 30]) _rotP(a, 1, 1) ]), "Should return a list of points to draw a 30° pie with a radius of 1 and 3 facets (triangle)");
                assertEqual(drawPie(1, a=140, $fn=3), concat([[0, 0]], [ for (a = [0 : 120 : 140]) _rotP(a, 1, 1) ], [_rotP(140, 1, 1)]), "Should return a list of points to draw a 140° pie with a radius of 1 and 3 facets (triangle)");
                assertEqual(drawPie(1, a=140, $fn=4), concat([[0, 0]], [ for (a = [0 : 90 : 140]) _rotP(a, 1, 1) ], [_rotP(140, 1, 1)]), "Should return a list of points to draw a 140° pie with a radius of 1 and 4 facets (square)");
                assertEqual(drawPie(1, a=200, $fn=4), concat([[0, 0]], [ for (a = [0 : 90 : 200]) _rotP(a, 1, 1) ], [_rotP(200, 1, 1)]), "Should return a list of points to draw a 200° pie with a radius of 1 and 4 facets (square)");
                assertEqual(drawPie(1, a=140, $fn=6), concat([[0, 0]], [ for (a = [0 : 60 : 140]) _rotP(a, 1, 1) ], [_rotP(140, 1, 1)]), "Should return a list of points to draw a 140° pie with a radius of 1 and 6 facets (hexagon)");
                assertEqual(drawPie(1, a=200, $fn=6), concat([[0, 0]], [ for (a = [0 : 60 : 200]) _rotP(a, 1, 1) ], [_rotP(200, 1, 1)]), "Should return a list of points to draw a 200° pie with a radius of 1 and 6 facets (hexagon)");
                assertEqual(drawPie(5, a=80, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 80]) _rotP(a, 5, 5) ], [5 * _rotP(80, 1, 1)]), "Should return a list of points to draw a 30° pie with a radius of 1 and 16 facets");
                assertEqual(drawPie(5, a=160, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 160]) _rotP(a, 5, 5) ], [5 * _rotP(160, 1, 1)]), "Should return a list of points to draw a 30° pie with a radius of 1 and 16 facets");
            }
            testUnit("ellipse pie", 24) {
                assertEqual(drawPie([1, 2], a=30, $fn=3), concat([[0, 0]], [ for (a = [0 : 30 : 30]) _rotP(a, 1, 2) ]), "Should return a list of points to draw a 30° pie with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawPie([1, 2], a=140, $fn=3), concat([[0, 0]], [ for (a = [0 : 120 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° pie with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawPie([1, 2], a=140, $fn=4), concat([[0, 0]], [ for (a = [0 : 90 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° pie with a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawPie([1, 2], a=200, $fn=4), concat([[0, 0]], [ for (a = [0 : 90 : 200]) _rotP(a, 1, 2) ], [_rotP(200, 1, 2)]), "Should return a list of points to draw a 200° pie with a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawPie([1, 2], a=140, $fn=6), concat([[0, 0]], [ for (a = [0 : 60 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° pie with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawPie([1, 2], a=200, $fn=6), concat([[0, 0]], [ for (a = [0 : 60 : 200]) _rotP(a, 1, 2) ], [_rotP(200, 1, 2)]), "Should return a list of points to draw a 200° pie with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawPie([5, 6], a=80, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [0 : astep(6, $fa=12, $fs=2) : 80]) _rotP(a, 5, 6) ], [_rotP(80, 5, 6)]), "Should return a list of points to draw a 30° pie with a radius of [5, 6] and 16 facets");
                assertEqual(drawPie([5, 6], a=160, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [0 : astep(6, $fa=12, $fs=2) : 160]) _rotP(a, 5, 6) ], [_rotP(160, 5, 6)]), "Should return a list of points to draw a 30° pie with a radius of [5, 6] and 16 facets");

                assertEqual(drawPie(rx=1, ry=2, a1=0, a2=30, $fn=3), concat([[0, 0]], [ for (a = [0 : 30 : 30]) _rotP(a, 1, 2) ]), "Should return a list of points to draw a 30° pie with a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawPie(rx=1, ry=2, a1=0, a2=140, $fn=3), concat([[0, 0]], [ for (a = [0 : 120 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° pie with a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawPie(rx=1, ry=2, a1=0, a2=140, $fn=4), concat([[0, 0]], [ for (a = [0 : 90 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° pie with a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawPie(rx=1, ry=2, a1=0, a2=200, $fn=4), concat([[0, 0]], [ for (a = [0 : 90 : 200]) _rotP(a, 1, 2) ], [_rotP(200, 1, 2)]), "Should return a list of points to draw a 200° pie with a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawPie(rx=1, ry=2, a1=0, a2=140, $fn=6), concat([[0, 0]], [ for (a = [0 : 60 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° pie with a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawPie(rx=1, ry=2, a1=0, a2=200, $fn=6), concat([[0, 0]], [ for (a = [0 : 60 : 200]) _rotP(a, 1, 2) ], [_rotP(200, 1, 2)]), "Should return a list of points to draw a 200° pie with a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawPie(rx=5, ry=6, a1=0, a2=80, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [0 : astep(6, $fa=12, $fs=2) : 80]) _rotP(a, 5, 6) ], [_rotP(80, 5, 6)]), "Should return a list of points to draw a 30° pie with a radius of x=5, y=6 and 16 facets");
                assertEqual(drawPie(rx=5, ry=6, a1=0, a2=160, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [0 : astep(6, $fa=12, $fs=2) : 160]) _rotP(a, 5, 6) ], [_rotP(160, 5, 6)]), "Should return a list of points to draw a 30° pie with a radius of x=5, y=6 and 16 facets");

                assertEqual(drawPie(dx=2, dy=4, a1=0, a2=30, $fn=3), concat([[0, 0]], [ for (a = [0 : 30 : 30]) _rotP(a, 1, 2) ]), "Should return a list of points to draw a 30° pie with a diameter of x=2, y=4 and 3 facets (triangle)");
                assertEqual(drawPie(dx=2, dy=4, a1=0, a2=140, $fn=3), concat([[0, 0]], [ for (a = [0 : 120 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° pie with a diameter of x=2, y=4 and 3 facets (triangle)");
                assertEqual(drawPie(dx=2, dy=4, a1=0, a2=140, $fn=4), concat([[0, 0]], [ for (a = [0 : 90 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° pie with a diameter of x=2, y=4 and 4 facets (square)");
                assertEqual(drawPie(dx=2, dy=4, a1=0, a2=200, $fn=4), concat([[0, 0]], [ for (a = [0 : 90 : 200]) _rotP(a, 1, 2) ], [_rotP(200, 1, 2)]), "Should return a list of points to draw a 200° pie with a diameter of x=2, y=4 and 4 facets (square)");
                assertEqual(drawPie(dx=2, dy=4, a1=0, a2=140, $fn=6), concat([[0, 0]], [ for (a = [0 : 60 : 140]) _rotP(a, 1, 2) ], [_rotP(140, 1, 2)]), "Should return a list of points to draw a 140° pie with a diameter of x=2, y=4 and 6 facets (hexagon)");
                assertEqual(drawPie(dx=2, dy=4, a1=0, a2=200, $fn=6), concat([[0, 0]], [ for (a = [0 : 60 : 200]) _rotP(a, 1, 2) ], [_rotP(200, 1, 2)]), "Should return a list of points to draw a 200° pie with a diameter of x=2, y=4 and 6 facets (hexagon)");
                assertEqual(drawPie(dx=10, dy=12, a1=0, a2=80, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [0 : astep(6, $fa=12, $fs=2) : 80]) _rotP(a, 5, 6) ], [_rotP(80, 5, 6)]), "Should return a list of points to draw a 30° pie with a diameter of x=10, y=12 and 16 facets");
                assertEqual(drawPie(dx=10, dy=12, a1=0, a2=160, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [0 : astep(6, $fa=12, $fs=2) : 160]) _rotP(a, 5, 6) ], [_rotP(160, 5, 6)]), "Should return a list of points to draw a 30° pie with a diameter of x=10, y=12 and 16 facets");
            }
        }
    }
    function _rotP(a, x, y) = [cos(a) * x, sin(a) * y];
}

testShape2dEllipse();
