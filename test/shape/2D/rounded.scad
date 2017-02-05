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
 * coarchs of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * coarchs or substantial portions of the Software.
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
 * Unit tests: Rounded shapes.
 *
 * @package test/shape/2D
 * @author jsconan
 */
module testShape2dRounded() {
    testPackage("shape/2D/rounded.scad", 6) {
        // test shape/2D/rounded/sizeArch()
        testModule("sizeArch", 3) {
            testUnit("no parameter", 1) {
                assertEqual(sizeArch(), [[1, 1], [0.5, 1]], "Should always return a size even if not parameter has been provided");
            }
            testUnit("wrong types", 2) {
                assertEqual(sizeArch("12", "12", "12", "12", "12", "12"), [[1, 1], [0.5, 1]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeArch(true, true, true, true, true, true), [[1, 1], [0.5, 1]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("correct types", 29) {
                assertEqual(sizeArch(3), [[3, 3], [1.5, 3]], "Should produce a size from a single size number in order to draw a half-circle");
                assertEqual(sizeArch(r=3), [[6, 3], [3, 3]], "Should produce a size from a single radius number in order to draw a half-circle");
                assertEqual(sizeArch(d=3), [[3, 1.5], [1.5, 1.5]], "Should produce a size from a single diameter number in order to draw a half-circle");

                assertEqual(sizeArch(3, 2), [[3, 3], [1.5, 2]], "Should produce the size and the radius from single number size and radius");
                assertEqual(sizeArch(3, d=2), [[3, 3], [1.5, 1]], "Should produce the size and the radius from single number size and diameter");

                assertEqual(sizeArch([3, 4], [2, 2]), [[3, 4], [1.5, 2]], "Should keep the size and adjust the radius if vectors are provided");
                assertEqual(sizeArch([3, 4], d=[2, 2]), [[3, 4], [1.5, 1]], "Should keep the size and adjust the diameter if vectors are provided");
                assertEqual(sizeArch([3, 4], d=[6, 8]), [[3, 4], [1.5, 4]], "Should keep the size and adjust the diameter if vectors are provided");

                assertEqual(sizeArch([3, 4]), [[3, 4], [1.5, 4]], "Should keep the provided size vector and should produce the radius accordingly");
                assertEqual(sizeArch(r=[3, 4]), [[6, 4], [3, 4]], "Should keep the provided radius vector and should produce the size accordingly");
                assertEqual(sizeArch(d=[3, 4]), [[3, 2], [1.5, 2]], "Should translate the provided diameter vector to a radius vector and should produce the size accordingly");

                assertEqual(sizeArch([3, 4], w=5), [[5, 4], [2.5, 4]], "Should set the provided width in the provided size vector");
                assertEqual(sizeArch([3, 4], h=5), [[3, 5], [1.5, 5]], "Should set the provided height in the provided size vector");

                assertEqual(sizeArch(r=[3, 4], rx=5), [[10, 4], [5, 4]], "Should set the provided X radius in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeArch(r=[3, 4], ry=5), [[6, 5], [3, 5]], "Should set the provided Y radius in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeArch(r=[3, 4], dx=5), [[5, 4], [2.5, 4]], "Should set the provided X diameter in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeArch(r=[3, 4], dy=5), [[6, 2.5], [3, 2.5]], "Should set the provided Y diameter in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeArch(d=[3, 4], rx=5), [[10, 2], [5, 2]], "Should set the provided X radius in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeArch(d=[3, 4], ry=5), [[3, 5], [1.5, 5]], "Should set the provided Y radius in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeArch(d=[3, 4], dx=5), [[5, 2], [2.5, 2]], "Should set the provided X diameter in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeArch(d=[3, 4], dy=5), [[3, 2.5], [1.5, 2.5]], "Should set the provided Y diameter in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeArch(w=3), [[3, 1], [1.5, 1]], "Should set the provided width in the size vector and use the default for the height");
                assertEqual(sizeArch(h=4), [[1, 4], [0.5, 4]], "Should set the provided height in the size vector and use the default for the width");
                assertEqual(sizeArch(w=3, h=4), [[3, 4], [1.5, 4]], "Should set the provided width and height in the size vector");

                assertEqual(sizeArch(rx=3), [[6, 1], [3, 1]], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizeArch(ry=4), [[1, 4], [0.5, 4]], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizeArch(rx=3, ry=4), [[6, 4], [3, 4]], "Should set the provided radius in the radius vector");

                assertEqual(sizeArch(h=4, rx=3), [[6, 4], [3, 4]], "Should set the provided height in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizeArch(w=4, ry=3), [[4, 3], [2, 3]], "Should set the provided width in the size vector and set the provide Y radius in the radius vector");
            }
        }
        // test shape/2D/rounded/sizeStadium()
        testModule("sizeStadium", 3) {
            testUnit("no parameter", 1) {
                assertEqual(sizeStadium(), [[1, 1], [0.5, 0.5]], "Should always return a size even if not parameter has been provided");
            }
            testUnit("wrong types", 2) {
                assertEqual(sizeStadium("12", "12", "12", "12", "12", "12"), [[1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeStadium(true, true, true, true, true, true), [[1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("correct types", 29) {
                assertEqual(sizeStadium(3), [[3, 3], [1.5, 1.5]], "Should produce a size from a single size number in order to draw a circle");
                assertEqual(sizeStadium(r=3), [[6, 6], [3, 3]], "Should produce a size from a single radius number in order to draw a circle");
                assertEqual(sizeStadium(d=3), [[3, 3], [1.5, 1.5]], "Should produce a size from a single diameter number in order to draw a circle");

                assertEqual(sizeStadium(3, 2), [[3, 3], [1.5, 1.5]], "Should produce the size and the radius from single number size and radius");
                assertEqual(sizeStadium(3, d=2), [[3, 3], [1.5, 1]], "Should produce the size and the radius from single number size and diameter");

                assertEqual(sizeStadium([3, 4], [2, 2]), [[3, 4], [1.5, 2]], "Should keep the size and adjust the radius if vectors are provided");
                assertEqual(sizeStadium([3, 4], d=[2, 2]), [[3, 4], [1.5, 1]], "Should keep the size and adjust the diameter if vectors are provided");
                assertEqual(sizeStadium([3, 4], d=[8, 10]), [[3, 4], [1.5, 2]], "Should keep the size and adjust the diameter if vectors are provided");

                assertEqual(sizeStadium([3, 4]), [[3, 4], [1.5, 2]], "Should keep the provided size vector and should produce the radius accordingly");
                assertEqual(sizeStadium(r=[3, 4]), [[6, 8], [3, 4]], "Should keep the provided radius vector and should produce the size accordingly");
                assertEqual(sizeStadium(d=[3, 4]), [[3, 4], [1.5, 2]], "Should translate the provided diameter vector to a radius vector and should produce the size accordingly");

                assertEqual(sizeStadium([3, 4], w=5), [[5, 4], [2.5, 2]], "Should set the provided width in the provided size vector");
                assertEqual(sizeStadium([3, 4], h=5), [[3, 5], [1.5, 2.5]], "Should set the provided height in the provided size vector");

                assertEqual(sizeStadium(r=[3, 4], rx=5), [[10, 8], [5, 4]], "Should set the provided X radius in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeStadium(r=[3, 4], ry=5), [[6, 10], [3, 5]], "Should set the provided Y radius in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeStadium(r=[3, 4], dx=5), [[5, 8], [2.5, 4]], "Should set the provided X diameter in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeStadium(r=[3, 4], dy=5), [[6, 5], [3, 2.5]], "Should set the provided Y diameter in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeStadium(d=[3, 4], rx=5), [[10, 4], [5, 2]], "Should set the provided X radius in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeStadium(d=[3, 4], ry=5), [[3, 10], [1.5, 5]], "Should set the provided Y radius in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeStadium(d=[3, 4], dx=5), [[5, 4], [2.5, 2]], "Should set the provided X diameter in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeStadium(d=[3, 4], dy=5), [[3, 5], [1.5, 2.5]], "Should set the provided Y diameter in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeStadium(w=3), [[3, 1], [1.5, 0.5]], "Should set the provided width in the size vector and use the default for the height");
                assertEqual(sizeStadium(h=4), [[1, 4], [0.5, 2]], "Should set the provided height in the size vector and use the default for the width");
                assertEqual(sizeStadium(w=3, h=4), [[3, 4], [1.5, 2]], "Should set the provided width and height in the size vector");

                assertEqual(sizeStadium(rx=3), [[6, 1], [3, 0.5]], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizeStadium(ry=4), [[1, 8], [0.5, 4]], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizeStadium(rx=3, ry=4), [[6, 8], [3, 4]], "Should set the provided radius in the radius vector");

                assertEqual(sizeStadium(h=4, rx=3), [[6, 4], [3, 2]], "Should set the provided height in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizeStadium(w=4, ry=3), [[4, 6], [2, 3]], "Should set the provided width in the size vector and set the provide Y radius in the radius vector");
            }
        }
        // test shape/2D/rounded/sizeRoundedRectangle()
        testModule("sizeRoundedRectangle", 3) {
            testUnit("no parameter", 1) {
                assertEqual(sizeRoundedRectangle(), [[1, 1], [0, 0]], "Should always return a size even if not parameter has been provided");
            }
            testUnit("wrong types", 2) {
                assertEqual(sizeRoundedRectangle("12", "12", "12", "12", "12", "12"), [[1, 1], [0, 0]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeRoundedRectangle(true, true, true, true, true, true), [[1, 1], [0, 0]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("correct types", 29) {
                assertEqual(sizeRoundedRectangle(3), [[3, 3], [0, 0]], "Should produce a size from a single size number in order to draw a rectangle");
                assertEqual(sizeRoundedRectangle(r=3), [[6, 6], [3, 3]], "Should produce a size from a single radius number in order to draw a circle");
                assertEqual(sizeRoundedRectangle(d=3), [[3, 3], [1.5, 1.5]], "Should produce a size from a single diameter number in order to draw a circle");

                assertEqual(sizeRoundedRectangle(3, 2), [[3, 3], [1.5, 1.5]], "Should produce the size and the radius from single number size and radius");
                assertEqual(sizeRoundedRectangle(3, d=2), [[3, 3], [1, 1]], "Should produce the size and the radius from single number size and diameter");

                assertEqual(sizeRoundedRectangle([3, 4], [2, 2]), [[3, 4], [1.5, 2]], "Should keep the size and adjust the radius if vectors are provided");
                assertEqual(sizeRoundedRectangle([3, 4], d=[2, 2]), [[3, 4], [1, 1]], "Should keep the size and adjust the diameter if vectors are provided");
                assertEqual(sizeRoundedRectangle([3, 4], d=[8, 10]), [[3, 4], [1.5, 2]], "Should keep the size and adjust the diameter if vectors are provided");

                assertEqual(sizeRoundedRectangle([3, 4]), [[3, 4], [0, 0]], "Should keep the provided size vector and should produce the radius accordingly");
                assertEqual(sizeRoundedRectangle(r=[3, 4]), [[6, 8], [3, 4]], "Should keep the provided radius vector and should produce the size accordingly");
                assertEqual(sizeRoundedRectangle(d=[3, 4]), [[3, 4], [1.5, 2]], "Should translate the provided diameter vector to a radius vector and should produce the size accordingly");

                assertEqual(sizeRoundedRectangle([3, 4], w=5), [[5, 4], [0, 0]], "Should set the provided width in the provided size vector");
                assertEqual(sizeRoundedRectangle([3, 4], h=5), [[3, 5], [0, 0]], "Should set the provided height in the provided size vector");

                assertEqual(sizeRoundedRectangle(r=[3, 4], rx=5), [[10, 8], [5, 4]], "Should set the provided X radius in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeRoundedRectangle(r=[3, 4], ry=5), [[6, 10], [3, 5]], "Should set the provided Y radius in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeRoundedRectangle(r=[3, 4], dx=5), [[5, 8], [2.5, 4]], "Should set the provided X diameter in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeRoundedRectangle(r=[3, 4], dy=5), [[6, 5], [3, 2.5]], "Should set the provided Y diameter in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeRoundedRectangle(d=[3, 4], rx=5), [[10, 4], [5, 2]], "Should set the provided X radius in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeRoundedRectangle(d=[3, 4], ry=5), [[3, 10], [1.5, 5]], "Should set the provided Y radius in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeRoundedRectangle(d=[3, 4], dx=5), [[5, 4], [2.5, 2]], "Should set the provided X diameter in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeRoundedRectangle(d=[3, 4], dy=5), [[3, 5], [1.5, 2.5]], "Should set the provided Y diameter in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeRoundedRectangle(w=3), [[3, 1], [0, 0]], "Should set the provided width in the size vector and use the default for the height");
                assertEqual(sizeRoundedRectangle(h=4), [[1, 4], [0, 0]], "Should set the provided height in the size vector and use the default for the width");
                assertEqual(sizeRoundedRectangle(w=3, h=4), [[3, 4], [0, 0]], "Should set the provided width and height in the size vector");

                assertEqual(sizeRoundedRectangle(rx=3), [[6, 1], [0, 0]], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizeRoundedRectangle(ry=4), [[1, 8], [0, 0]], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizeRoundedRectangle(rx=3, ry=4), [[6, 8], [3, 4]], "Should set the provided radius in the radius vector");

                assertEqual(sizeRoundedRectangle(h=4, rx=3), [[6, 4], [0, 0]], "Should set the provided height in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizeRoundedRectangle(w=4, ry=3), [[4, 6], [0, 0]], "Should set the provided width in the size vector and set the provide Y radius in the radius vector");
            }
        }
        // test shape/2D/rounded/drawArch()
        testModule("drawArch", 5) {
            testUnit("no parameter", 3) {
                assertEqual(drawArch($fn=3), [ _rotP(0, 0.5, 1), _rotP(120, 0.5, 1), _rotP(180, 0.5, 1) ], "Should return a list of points to draw an arch with a radius of 1 and 3 facets and without straight walls");
                assertEqual(drawArch($fn=4), [ for (a = [0 : 360/4 : 180]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw a 90° arch with a radius of 1 and 4 facets and without straight walls");
                assertEqual(drawArch($fn=6), [ for (a = [0 : 360/6 : 180]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw a 90° arch with a radius of 1 and 6 facets and without straight walls");
            }
            testUnit("circle arch, no straight walls", 12) {
                assertEqual(drawArch([2, 1], $fn=3), [ _rotP(0, 1, 1), _rotP(120, 1, 1), _rotP(180, 1, 1) ], "Should return a list of points to draw a half-circle with a radius of 1 and 3 facets (triangle)");
                assertEqual(drawArch([2, 1], $fn=4), [ for (a = [0 : 360/4 : 180]) _rotP(a, 1, 1) ], "Should return a list of points to draw a half-circle with a radius of 1 and 4 facets (square)");
                assertEqual(drawArch([2, 1], $fn=6), [ for (a = [0 : 360/6 : 180]) _rotP(a, 1, 1) ], "Should return a list of points to draw a half-circle with a radius of 1 and 6 facets (hexagon)");
                assertEqual(drawArch([10, 5], $fa=12, $fs=2), [ for (a = [0 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 5, 5) ], "Should return a list of points to draw a half-circle with a radius of 5 and 16 facets");

                assertEqual(drawArch(r=2, $fn=3), [ _rotP(0, 2, 2), _rotP(120, 2, 2), _rotP(180, 2, 2) ], "Should return a list of points to draw a half-circle with a radius of 2 and 3 facets (triangle)");
                assertEqual(drawArch(r=3, $fn=4), [ for (a = [0 : 360/4 : 180]) _rotP(a, 3, 3) ], "Should return a list of points to draw a half-circle with a radius of 3 and 4 facets (square)");
                assertEqual(drawArch(r=4, $fn=6), [ for (a = [0 : 360/6 : 180]) _rotP(a, 4, 4) ], "Should return a list of points to draw a half-circle with a radius of 4 and 6 facets (hexagon)");
                assertEqual(drawArch(r=5, $fa=12, $fs=2), [ for (a = [0 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 5, 5) ], "Should return a list of points to draw a half-circle with a radius of 5 and 16 facets");

                assertEqual(drawArch(d=2, $fn=3), [ _rotP(0, 1, 1), _rotP(120, 1, 1), _rotP(180, 1, 1) ], "Should return a list of points to draw a half-circle with a diameter of 2 and 3 facets (triangle)");
                assertEqual(drawArch(d=3, $fn=4), [ for (a = [0 : 360/4 : 180]) _rotP(a, 1.5, 1.5) ], "Should return a list of points to draw a half-circle with a diameter of 3 and 4 facets (square)");
                assertEqual(drawArch(d=4, $fn=6), [ for (a = [0 : 360/6 : 180]) _rotP(a, 2, 2) ], "Should return a list of points to draw a half-circle with a diameter of 4 and 6 facets (hexagon)");
                assertEqual(drawArch(d=5, $fa=12, $fs=2), [ for (a = [0 : astep(2.5, $fa=12, $fs=2) : 180]) _rotP(a, 2.5, 2.5) ], "Should return a list of points to draw a half-circle with a diameter of 5 and 16 facets");
            }
            testUnit("ellipse arch, no straight walls", 16) {
                assertEqual(drawArch(2, $fn=3), [ _rotP(0, 1, 2), _rotP(120, 1, 2), _rotP(180, 1, 2) ], "Should return a list of points to draw a half-ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawArch(3, $fn=4), [ for (a = [0 : 360/4 : 180]) _rotP(a, 1.5, 3) ], "Should return a list of points to draw a half-ellipse with a radius of [1.5, 3] and 4 facets (square)");
                assertEqual(drawArch(4, $fn=6), [ for (a = [0 : 360/6 : 180]) _rotP(a, 2, 4) ], "Should return a list of points to draw a half-ellipse with a radius of [2, 4] and 6 facets (hexagon)");
                assertEqual(drawArch(5, $fa=12, $fs=2), [ for (a = [0 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 2.5, 5) ], "Should return a list of points to draw a half-ellipse with a radius of [2.5, 5] and 16 facets");

                assertEqual(drawArch(d=[1, 2], $fn=3), [ _rotP(0, 0.5, 1), _rotP(120, 0.5, 1), _rotP(180, 0.5, 1) ], "Should return a list of points to draw a half-ellipse with a diameter of [1, 2] and 3 facets (triangle)");
                assertEqual(drawArch(d=[1, 2], $fn=4), [ for (a = [0 : 360/4 : 180]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw a half-ellipse with a diameter of [1, 2] and 4 facets (square)");
                assertEqual(drawArch(d=[1, 2], $fn=6), [ for (a = [0 : 360/6 : 180]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw a half-ellipse with a diameter of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawArch(d=[10, 12], $fa=12, $fs=2), concat([ for (a = [0 : astep(6, $fa=12, $fs=2) : 180]) _rotP(a, 5, 6) ], [_rotP(180, 5, 6)]), "Should return a list of points to draw a half-ellipse with a diameter of [10, 12] and 20 facets");

                assertEqual(drawArch(rx=1, ry=2, $fn=3), [ _rotP(0, 1, 2), _rotP(120, 1, 2), _rotP(180, 1, 2) ], "Should return a list of points to draw a half-ellipse with a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawArch(rx=1, ry=2, $fn=4), [ for (a = [0 : 360/4 : 180]) _rotP(a, 1, 2) ], "Should return a list of points to draw a half-ellipse with a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawArch(rx=1, ry=2, $fn=6), [ for (a = [0 : 360/6 : 180]) _rotP(a, 1, 2) ], "Should return a list of points to draw a half-ellipse with a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawArch(rx=5, ry=6, $fa=12, $fs=2), concat([ for (a = [0 : astep(6, $fa=12, $fs=2) : 180]) _rotP(a, 5, 6) ], [_rotP(180, 5, 6)]), "Should return a list of points to draw a half-ellipse with a radius of x=5, y=6 and 20 facets");

                assertEqual(drawArch(dx=1, dy=2, $fn=3), [ _rotP(0, 0.5, 1), _rotP(120, 0.5, 1), _rotP(180, 0.5, 1) ], "Should return a list of points to draw a half-ellipse with a diameter of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawArch(dx=1, dy=2, $fn=4), [ for (a = [0 : 360/4 : 180]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw a half-ellipse with a diameter of x=1, y=2 and 4 facets (square)");
                assertEqual(drawArch(dx=1, dy=2, $fn=6), [ for (a = [0 : 360/6 : 180]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw a half-ellipse with a diameter of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawArch(dx=10, dy=12, $fa=12, $fs=2), concat([ for (a = [0 : astep(6, $fa=12, $fs=2) : 180]) _rotP(a, 5, 6) ], [_rotP(180, 5, 6)]), "Should return a list of points to draw a half-ellipse with a diameter of x=10, y=12 and 20 facets");
            }
            testUnit("circle arch, straight walls", 4) {
                assertEqual(drawArch([2, 2], r=1, $fn=3), concat([[1, 0]], [ _rotP(0, 1, 1) + [0, 1], _rotP(120, 1, 1) + [0, 1], _rotP(180, 1, 1) + [0, 1] ], [[-1, 0]]), "Should return a list of points to draw an arch with wall of 1 and a radius of 1 and 3 facets (triangle)");
                assertEqual(drawArch([2, 2], r=1, $fn=4), concat([[1, 0]], [ for (a = [0 : 360/4 : 180]) _rotP(a, 1, 1) + [0, 1] ], [[-1, 0]]), "Should return a list of points to draw an arch with wall of 1 and a radius of 1 and 4 facets (square)");
                assertEqual(drawArch([2, 2], r=1, $fn=6), concat([[1, 0]], [ for (a = [0 : 360/6 : 180]) _rotP(a, 1, 1) + [0, 1] ], [[-1, 0]]), "Should return a list of points to draw an arch with wall of 1 and a radius of 1 and 6 facets (hexagon)");
                assertEqual(drawArch([10, 10], r=5, , $fa=12, $fs=2), concat([[5, 0]], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 5, 5) + [0, 5] ], [[-5, 0]]), "Should return a list of points to draw an arch with wall of 5 and a radius of 5 and 16 facets");
            }
            testUnit("ellipse arch, straight walls", 12) {
                assertEqual(drawArch([2, 4], r=[1, 2], $fn=3), concat([[1, 0]], [ _rotP(0, 1, 2) + [0, 2], _rotP(120, 1, 2) + [0, 2], _rotP(180, 1, 2) + [0, 2] ], [[-1, 0]]), "Should return a list of points to draw an ellipse arch with wall of 1 and a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawArch([2, 4], r=[1, 2], $fn=4), concat([[1, 0]], [ for (a = [0 : 360/4 : 180]) _rotP(a, 1, 2) + [0, 2] ], [[-1, 0]]), "Should return a list of points to draw an ellipse arch with wall of 1 and a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawArch([2, 4], r=[1, 2], $fn=6), concat([[1, 0]], [ for (a = [0 : 360/6 : 180]) _rotP(a, 1, 2) + [0, 2] ], [[-1, 0]]), "Should return a list of points to draw an ellipse arch with wall of 1 and a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawArch([6, 10], r=[3, 5], $fa=12, $fs=2), concat([[3, 0]], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 3, 5) + [0, 5] ], [[-3, 0]]), "Should return a list of points to draw an ellipse arch with wall of 5 and a radius of [3, 5] and 16 facets");

                assertEqual(drawArch(w=2, h=4, rx=1, ry=2, $fn=3), concat([[1, 0]], [ _rotP(0, 1, 2) + [0, 2], _rotP(120, 1, 2) + [0, 2], _rotP(180, 1, 2) + [0, 2] ], [[-1, 0]]), "Should return a list of points to draw an ellipse arch with wall of 1 and a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawArch(w=2, h=4, rx=1, ry=2, $fn=4), concat([[1, 0]], [ for (a = [0 : 360/4 : 180]) _rotP(a, 1, 2) + [0, 2] ], [[-1, 0]]), "Should return a list of points to draw an ellipse arch with wall of 1 and a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawArch(w=2, h=4, rx=1, ry=2, $fn=6), concat([[1, 0]], [ for (a = [0 : 360/6 : 180]) _rotP(a, 1, 2) + [0, 2] ], [[-1, 0]]), "Should return a list of points to draw an ellipse arch with wall of 1 and a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawArch(w=6, h=10, rx=3, ry=5, $fa=12, $fs=2), concat([[3, 0]], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 3, 5) + [0, 5] ], [[-3, 0]]), "Should return a list of points to draw an ellipse arch with wall of 5 and a radius of x=3, y=5 and 16 facets");

                assertEqual(drawArch(w=2, h=4, dx=2, dy=4, $fn=3), concat([[1, 0]], [ _rotP(0, 1, 2) + [0, 2], _rotP(120, 1, 2) + [0, 2], _rotP(180, 1, 2) + [0, 2] ], [[-1, 0]]), "Should return a list of points to draw an ellipse arch with wall of 1 and a diameter of x=2, y=4 and 3 facets (triangle)");
                assertEqual(drawArch(w=2, h=4, dx=2, dy=4, $fn=4), concat([[1, 0]], [ for (a = [0 : 360/4 : 180]) _rotP(a, 1, 2) + [0, 2] ], [[-1, 0]]), "Should return a list of points to draw an ellipse arch with wall of 1 and a diameter of x=2, y=4 and 4 facets (square)");
                assertEqual(drawArch(w=2, h=4, dx=2, dy=4, $fn=6), concat([[1, 0]], [ for (a = [0 : 360/6 : 180]) _rotP(a, 1, 2) + [0, 2] ], [[-1, 0]]), "Should return a list of points to draw an ellipse arch with wall of 1 and a diameter of x=2, y=4 and 6 facets (hexagon)");
                assertEqual(drawArch(w=6, h=10, dx=6, dy=10, $fa=12, $fs=2), concat([[3, 0]], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 3, 5) + [0, 5] ], [[-3, 0]]), "Should return a list of points to draw an ellipse arch with wall of 5 and a diameter of x=6, y=10 and 16 facets");
            }
        }
        // test shape/2D/rounded/drawStadium()
        testModule("drawStadium", 5) {
            testUnit("no parameter", 3) {
                assertEqual(drawStadium($fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 0.5, 0.5) ], "Should return a list of points to draw a circle with a radius of 1 and 3 facets (triangle)");
                assertEqual(drawStadium($fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 0.5, 0.5) ], "Should return a list of points to draw a circle with a radius of 1 and 4 facets (square)");
                assertEqual(drawStadium($fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 0.5, 0.5) ], "Should return a list of points to draw a circle with a radius of 1 and 6 facets (hexagon)");
            }
            testUnit("circle stadium, no straight walls", 12) {
                assertEqual(drawStadium(2, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 3 facets (triangle)");
                assertEqual(drawStadium(2, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 4 facets (square)");
                assertEqual(drawStadium(2, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 6 facets (hexagon)");
                assertEqual(drawStadium(10, $fa=12, $fs=2), [ for (a = [astep(5, $fa=12, $fs=2) : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a radius of 5 and 16 facets");

                assertEqual(drawStadium(r=2, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a radius of 2 and 3 facets (triangle)");
                assertEqual(drawStadium(r=3, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 3, 3) ], "Should return a list of points to draw a circle with a radius of 3 and 4 facets (square)");
                assertEqual(drawStadium(r=4, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 4, 4) ], "Should return a list of points to draw a circle with a radius of 4 and 6 facets (hexagon)");
                assertEqual(drawStadium(r=5, $fa=12, $fs=2), [ for (a = [astep(5, $fa=12, $fs=2) : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a radius of 5 and 16 facets");

                assertEqual(drawStadium(d=2, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a diameter of 2 and 3 facets (triangle)");
                assertEqual(drawStadium(d=3, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1.5, 1.5) ], "Should return a list of points to draw a circle with a diameter of 3 and 4 facets (square)");
                assertEqual(drawStadium(d=4, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a diameter of 4 and 6 facets (hexagon)");
                assertEqual(drawStadium(d=10, $fa=12, $fs=2), [ for (a = [astep(5, $fa=12, $fs=2) : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a diameter of 5 and 16 facets");
            }
            testUnit("ellipse stadium, no straight walls", 20) {
                assertEqual(drawStadium([2, 4], $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawStadium([2, 4], $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawStadium([2, 4], $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawStadium([10, 12], $fa=12, $fs=2), [ for (a = [0 : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], "Should return a list of points to draw an ellipse with a radius of [5, 6] and 20 facets");

                assertEqual(drawStadium(r=[1, 2], $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawStadium(r=[1, 2], $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawStadium(r=[1, 2], $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawStadium(r=[5, 6], $fa=12, $fs=2), [ for (a = [0 : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], "Should return a list of points to draw an ellipse with a radius of [5, 6] and 20 facets");

                assertEqual(drawStadium(d=[1, 2], $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 3 facets (triangle)");
                assertEqual(drawStadium(d=[1, 2], $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 4 facets (square)");
                assertEqual(drawStadium(d=[1, 2], $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawStadium(d=[10, 12], $fa=12, $fs=2), [ for (a = [0 : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], "Should return a list of points to draw an ellipse with a diameter of [10, 12] and 20 facets");

                assertEqual(drawStadium(rx=1, ry=2, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawStadium(rx=1, ry=2, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawStadium(rx=1, ry=2, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawStadium(rx=5, ry=6, $fa=12, $fs=2), [ for (a = [0 : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], "Should return a list of points to draw an ellipse with a radius of x=5, y=6 and 20 facets");

                assertEqual(drawStadium(dx=1, dy=2, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawStadium(dx=1, dy=2, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 4 facets (square)");
                assertEqual(drawStadium(dx=1, dy=2, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawStadium(dx=10, dy=12, $fa=12, $fs=2), [ for (a = [0 : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], "Should return a list of points to draw an ellipse with a diameter of x=10, y=12 and 20 facets");
            }
            testUnit("circle stadium, straight walls", 4) {
                assertEqual(drawStadium([2, 4], r=1, $fn=3), [ _rotP(0, 1, 1) + [0, 1], _rotP(120, 1, 1) + [0, 1], _rotP(180, 1, 1) + [0, 1], _rotP(180, 1, 1) - [0, 1], _rotP(300, 1, 1) - [0, 1], _rotP(360, 1, 1) - [0, 1] ], "Should return a list of points to draw an stadium with wall of 1 and a radius of 1 and 3 facets (triangle)");
                assertEqual(drawStadium([2, 4], r=1, $fn=4), concat([ for (a = [0 : 360/4 : 180]) _rotP(a, 1, 1) + [0, 1] ], [ for (a = [180 : 360/4 : 360]) _rotP(a, 1, 1) - [0, 1] ]), "Should return a list of points to draw an stadium with wall of 1 and a radius of 1 and 4 facets (square)");
                assertEqual(drawStadium([2, 4], r=1, $fn=6), concat([ for (a = [0 : 360/6 : 180]) _rotP(a, 1, 1) + [0, 1] ], [ for (a = [180 : 360/6 : 360]) _rotP(a, 1, 1) - [0, 1] ]), "Should return a list of points to draw an stadium with wall of 1 and a radius of 1 and 6 facets (hexagon)");
                assertEqual(drawStadium([10, 20], r=5, , $fa=12, $fs=2), concat([ for (a = [0 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 5, 5) + [0, 5] ], [ for (a = [180 : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 5, 5) - [0, 5] ]), "Should return a list of points to draw an stadium with wall of 10 and a radius of 5 and 16 facets");
            }
            testUnit("ellipse stadium, straight walls", 12) {
                assertEqual(drawStadium([2, 8], r=[1, 2], $fn=3), [ _rotP(0, 1, 2) + [0, 2], _rotP(120, 1, 2) + [0, 2], _rotP(180, 1, 2) + [0, 2], _rotP(180, 1, 2) - [0, 2], _rotP(300, 1, 2) - [0, 2], _rotP(360, 1, 2) - [0, 2] ], "Should return a list of points to draw an ellipse stadium with wall of 1 and a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawStadium([2, 8], r=[1, 2], $fn=4), concat([ for (a = [0 : 360/4 : 180]) _rotP(a, 1, 2) + [0, 2] ], [ for (a = [180 : 360/4 : 360]) _rotP(a, 1, 2) - [0, 2] ]), "Should return a list of points to draw an ellipse stadium with wall of 1 and a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawStadium([2, 8], r=[1, 2], $fn=6), concat([ for (a = [0 : 360/6 : 180]) _rotP(a, 1, 2) + [0, 2] ], [ for (a = [180 : 360/6 : 360]) _rotP(a, 1, 2) - [0, 2] ]), "Should return a list of points to draw an ellipse stadium with wall of 1 and a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawStadium([6, 20], r=[3, 5], $fa=12, $fs=2), concat([ for (a = [0 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 3, 5) + [0, 5] ], [ for (a = [180 : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 3, 5) - [0, 5] ]), "Should return a list of points to draw an ellipse stadium with wall of 10 and a radius of [3, 5] and 16 facets");

                assertEqual(drawStadium(w=2, h=8, rx=1, ry=2, $fn=3), [ _rotP(0, 1, 2) + [0, 2], _rotP(120, 1, 2) + [0, 2], _rotP(180, 1, 2) + [0, 2], _rotP(180, 1, 2) - [0, 2], _rotP(300, 1, 2) - [0, 2], _rotP(360, 1, 2) - [0, 2] ], "Should return a list of points to draw an ellipse stadium with wall of 1 and a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawStadium(w=2, h=8, rx=1, ry=2, $fn=4), concat([ for (a = [0 : 360/4 : 180]) _rotP(a, 1, 2) + [0, 2] ], [ for (a = [180 : 360/4 : 360]) _rotP(a, 1, 2) - [0, 2] ]), "Should return a list of points to draw an ellipse stadium with wall of 1 and a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawStadium(w=2, h=8, rx=1, ry=2, $fn=6), concat([ for (a = [0 : 360/6 : 180]) _rotP(a, 1, 2) + [0, 2] ], [ for (a = [180 : 360/6 : 360]) _rotP(a, 1, 2) - [0, 2] ]), "Should return a list of points to draw an ellipse stadium with wall of 1 and a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawStadium(w=6, h=20, rx=3, ry=5, $fa=12, $fs=2), concat([ for (a = [0 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 3, 5) + [0, 5] ], [ for (a = [180 : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 3, 5) - [0, 5] ]), "Should return a list of points to draw an ellipse stadium with wall of 10 and a radius of x=3, y=5 and 16 facets");

                assertEqual(drawStadium(w=2, h=8, dx=2, dy=4, $fn=3), [ _rotP(0, 1, 2) + [0, 2], _rotP(120, 1, 2) + [0, 2], _rotP(180, 1, 2) + [0, 2], _rotP(180, 1, 2) - [0, 2], _rotP(300, 1, 2) - [0, 2], _rotP(360, 1, 2) - [0, 2] ], "Should return a list of points to draw an ellipse stadium with wall of 1 and a diameter of x=2, y=4 and 3 facets (triangle)");
                assertEqual(drawStadium(w=2, h=8, dx=2, dy=4, $fn=4), concat([ for (a = [0 : 360/4 : 180]) _rotP(a, 1, 2) + [0, 2] ], [ for (a = [180 : 360/4 : 360]) _rotP(a, 1, 2) - [0, 2] ]), "Should return a list of points to draw an ellipse stadium with wall of 1 and a diameter of x=2, y=4 and 4 facets (square)");
                assertEqual(drawStadium(w=2, h=8, dx=2, dy=4, $fn=6), concat([ for (a = [0 : 360/6 : 180]) _rotP(a, 1, 2) + [0, 2] ], [ for (a = [180 : 360/6 : 360]) _rotP(a, 1, 2) - [0, 2] ]), "Should return a list of points to draw an ellipse stadium with wall of 1 and a diameter of x=2, y=4 and 6 facets (hexagon)");
                assertEqual(drawStadium(w=6, h=20, dx=6, dy=10, $fa=12, $fs=2), concat([ for (a = [0 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 3, 5) + [0, 5] ], [ for (a = [180 : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 3, 5) - [0, 5] ]), "Should return a list of points to draw an ellipse stadium with wall of 10 and a diameter of x=6, y=10 and 16 facets");
            }
        }
        // test shape/2D/rounded/drawRoundedRectangle()
        testModule("drawRoundedRectangle", 4) {
            testUnit("no parameter", 1) {
                assertEqual(drawRoundedRectangle(), [ [0.5, 0.5], [-0.5, 0.5], [-0.5, -0.5], [0.5, -0.5] ], "Should return a simple rectangle without rounder corners if no parameter is provided");
            }
            testUnit("size, but radius", 6) {
                assertEqual(drawRoundedRectangle(2), [ [1, 1], [-1, 1], [-1, -1], [1, -1] ], "Should return a simple rectangle without rounder corners if only the size is provided. Single number should be translated into vector.");
                assertEqual(drawRoundedRectangle([2, 4]), [ [1, 2], [-1, 2], [-1, -2], [1, -2] ], "Should return a simple rectangle without rounder corners if only the size is provided.");
                assertEqual(drawRoundedRectangle(w=2), [ [1, 0.5], [-1, 0.5], [-1, -0.5], [1, -0.5] ], "Should return a simple rectangle without rounder corners if only the size is provided. Missing height should be set to default.");
                assertEqual(drawRoundedRectangle(h=2), [ [0.5, 1], [-0.5, 1], [-0.5, -1], [0.5, -1] ], "Should return a simple rectangle without rounder corners if only the size is provided. Missing width should be set to default.");
                assertEqual(drawRoundedRectangle(w=2, h=4), [ [1, 2], [-1, 2], [-1, -2], [1, -2] ], "Should return a simple rectangle without rounder corners if only the size is provided. Size provided separately.");
                assertEqual(drawRoundedRectangle(size=[5, 6], w=2, h=4), [ [1, 2], [-1, 2], [-1, -2], [1, -2] ], "Should return a simple rectangle without rounder corners if only the size is provided. Size provided separately. Separate size should overwrite the size vector.");
            }
            testUnit("radius or diameter, but size", 24) {
                assertEqual(drawRoundedRectangle(r=2, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a radius of 2 and 3 facets (triangle)");
                assertEqual(drawRoundedRectangle(r=2, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a radius of 2 and 4 facets (square)");
                assertEqual(drawRoundedRectangle(r=2, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a radius of 2 and 6 facets (hexagon)");
                assertEqual(drawRoundedRectangle(r=5, $fa=12, $fs=2), [ for (a = [astep(5, $fa=12, $fs=2) : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a radius of 5 and 16 facets");

                assertEqual(drawRoundedRectangle(d=2, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a diameter of 2 and 3 facets (triangle)");
                assertEqual(drawRoundedRectangle(d=3, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1.5, 1.5) ], "Should return a list of points to draw a circle with a diameter of 3 and 4 facets (square)");
                assertEqual(drawRoundedRectangle(d=4, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a diameter of 4 and 6 facets (hexagon)");
                assertEqual(drawRoundedRectangle(d=10, $fa=12, $fs=2), [ for (a = [astep(5, $fa=12, $fs=2) : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a diameter of 5 and 16 facets");

                assertEqual(drawRoundedRectangle(r=[1, 2], $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawRoundedRectangle(r=[1, 2], $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawRoundedRectangle(r=[1, 2], $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawRoundedRectangle(r=[5, 6], $fa=12, $fs=2), [ for (a = [0 : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], "Should return a list of points to draw an ellipse with a radius of [5, 6] and 20 facets");

                assertEqual(drawRoundedRectangle(d=[1, 2], $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 3 facets (triangle)");
                assertEqual(drawRoundedRectangle(d=[1, 2], $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 4 facets (square)");
                assertEqual(drawRoundedRectangle(d=[1, 2], $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawRoundedRectangle(d=[10, 12], $fa=12, $fs=2), [ for (a = [0 : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], "Should return a list of points to draw an ellipse with a diameter of [10, 12] and 20 facets");

                assertEqual(drawRoundedRectangle(rx=1, ry=2, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawRoundedRectangle(rx=1, ry=2, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawRoundedRectangle(rx=1, ry=2, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawRoundedRectangle(rx=5, ry=6, $fa=12, $fs=2), [ for (a = [0 : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], "Should return a list of points to draw an ellipse with a radius of x=5, y=6 and 20 facets");

                assertEqual(drawRoundedRectangle(dx=1, dy=2, $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawRoundedRectangle(dx=1, dy=2, $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 4 facets (square)");
                assertEqual(drawRoundedRectangle(dx=1, dy=2, $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawRoundedRectangle(dx=10, dy=12, $fa=12, $fs=2), [ for (a = [0 : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 5, 6) ], "Should return a list of points to draw an ellipse with a diameter of x=10, y=12 and 20 facets");
            }
            testUnit("size and radius", 12) {
                assertEqual(
                    drawRoundedRectangle([4, 8], r=[1, 2], $fn=3),
                    [
                        _rotP(0, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2],
                        _rotP(90, 1, 2) + [-1, 2], _rotP(180, 1, 2) + [-1, 2],
                        _rotP(180, 1, 2) + [-1, -2], _rotP(270, 1, 2) + [-1, -2],
                        _rotP(270, 1, 2) + [1, -2], _rotP(360, 1, 2) + [1, -2]
                    ],
                    "Should return a list of points to draw a rounded rectangle with size of [4, 8] and a radius of [1, 2] and 3 facets (triangle)"
                );
                assertEqual(
                    drawRoundedRectangle([4, 8], r=[1, 2], $fn=4),
                    [
                        _rotP(0, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2],
                        _rotP(90, 1, 2) + [-1, 2], _rotP(180, 1, 2) + [-1, 2],
                        _rotP(180, 1, 2) + [-1, -2], _rotP(270, 1, 2) + [-1, -2],
                        _rotP(270, 1, 2) + [1, -2], _rotP(360, 1, 2) + [1, -2]
                    ],
                    "Should return a list of points to draw a rounded rectangle with size of [4, 8] and a radius of [1, 2] and 4 facets (square)"
                );
                assertEqual(
                    drawRoundedRectangle([4, 8], r=[1, 2], $fn=6),
                    [
                        _rotP(0, 1, 2) + [1, 2], _rotP(60, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2],
                        _rotP(90, 1, 2) + [-1, 2], _rotP(150, 1, 2) + [-1, 2], _rotP(180, 1, 2) + [-1, 2],
                        _rotP(180, 1, 2) + [-1, -2], _rotP(240, 1, 2) + [-1, -2], _rotP(270, 1, 2) + [-1, -2],
                        _rotP(270, 1, 2) + [1, -2], _rotP(330, 1, 2) + [1, -2], _rotP(360, 1, 2) + [1, -2]
                    ],
                    "Should return a list of points to draw a rounded rectangle with size of [4, 8] and a radius of [1, 2] and 6 facets (hexagon)"
                );
                assertEqual(
                    drawRoundedRectangle([20, 20], r=[3, 5], $fa=12, $fs=2),
                    concat(
                        [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) + [7, 5] ],
                        [ for (a = [90 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 3, 5) + [-7, 5] ],
                        [ for (a = [180 : astep(5, $fa=12, $fs=2) : 270]) _rotP(a, 3, 5) + [-7, -5] ],
                        [ for (a = [270 : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 3, 5) + [7, -5] ]
                    ),
                    "Should return a list of points to draw a rounded rectangle with size of [20, 20] and a radius of [3, 5] and 16 facets"
                );

                assertEqual(
                    drawRoundedRectangle([4, 8], d=[2, 4], $fn=3),
                    [
                        _rotP(0, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2],
                        _rotP(90, 1, 2) + [-1, 2], _rotP(180, 1, 2) + [-1, 2],
                        _rotP(180, 1, 2) + [-1, -2], _rotP(270, 1, 2) + [-1, -2],
                        _rotP(270, 1, 2) + [1, -2], _rotP(360, 1, 2) + [1, -2]
                    ],
                    "Should return a list of points to draw a rounded rectangle with size of [4, 8] and a diameter of [2, 4] and 3 facets (triangle)"
                );
                assertEqual(
                    drawRoundedRectangle([4, 8], d=[2, 4], $fn=4),
                    [
                        _rotP(0, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2],
                        _rotP(90, 1, 2) + [-1, 2], _rotP(180, 1, 2) + [-1, 2],
                        _rotP(180, 1, 2) + [-1, -2], _rotP(270, 1, 2) + [-1, -2],
                        _rotP(270, 1, 2) + [1, -2], _rotP(360, 1, 2) + [1, -2]
                    ],
                    "Should return a list of points to draw a rounded rectangle with size of [4, 8] and a diameter of [2, 4] and 4 facets (square)"
                );
                assertEqual(
                    drawRoundedRectangle([4, 8], d=[2, 4], $fn=6),
                    [
                        _rotP(0, 1, 2) + [1, 2], _rotP(60, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2],
                        _rotP(90, 1, 2) + [-1, 2], _rotP(150, 1, 2) + [-1, 2], _rotP(180, 1, 2) + [-1, 2],
                        _rotP(180, 1, 2) + [-1, -2], _rotP(240, 1, 2) + [-1, -2], _rotP(270, 1, 2) + [-1, -2],
                        _rotP(270, 1, 2) + [1, -2], _rotP(330, 1, 2) + [1, -2], _rotP(360, 1, 2) + [1, -2]
                    ],
                    "Should return a list of points to draw a rounded rectangle with size of [4, 8] and a diameter of [2, 4] and 6 facets (hexagon)"
                );
                assertEqual(
                    drawRoundedRectangle([20, 20], d=[6, 10], $fa=12, $fs=2),
                    concat(
                        [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) + [7, 5] ],
                        [ for (a = [90 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 3, 5) + [-7, 5] ],
                        [ for (a = [180 : astep(5, $fa=12, $fs=2) : 270]) _rotP(a, 3, 5) + [-7, -5] ],
                        [ for (a = [270 : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 3, 5) + [7, -5] ]
                    ),
                    "Should return a list of points to draw a rounded rectangle with size of [20, 20] and a diameter of [6, 10] and 16 facets"
                );

                assertEqual(
                    drawRoundedRectangle(w=4, h=8, rx=1, ry=2, $fn=3),
                    [
                        _rotP(0, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2],
                        _rotP(90, 1, 2) + [-1, 2], _rotP(180, 1, 2) + [-1, 2],
                        _rotP(180, 1, 2) + [-1, -2], _rotP(270, 1, 2) + [-1, -2],
                        _rotP(270, 1, 2) + [1, -2], _rotP(360, 1, 2) + [1, -2]
                    ],
                    "Should return a list of points to draw a rounded rectangle with size of w=4, h=8 and a radius of rx=1, ry=2 and 3 facets (triangle)"
                );
                assertEqual(
                    drawRoundedRectangle(w=4, h=8, rx=1, ry=2, $fn=4),
                    [
                        _rotP(0, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2],
                        _rotP(90, 1, 2) + [-1, 2], _rotP(180, 1, 2) + [-1, 2],
                        _rotP(180, 1, 2) + [-1, -2], _rotP(270, 1, 2) + [-1, -2],
                        _rotP(270, 1, 2) + [1, -2], _rotP(360, 1, 2) + [1, -2]
                    ],
                    "Should return a list of points to draw a rounded rectangle with size of w=4, h=8 and a radius of rx=1, ry=2 and 4 facets (square)"
                );
                assertEqual(
                    drawRoundedRectangle(w=4, h=8, rx=1, ry=2, $fn=6),
                    [
                        _rotP(0, 1, 2) + [1, 2], _rotP(60, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2],
                        _rotP(90, 1, 2) + [-1, 2], _rotP(150, 1, 2) + [-1, 2], _rotP(180, 1, 2) + [-1, 2],
                        _rotP(180, 1, 2) + [-1, -2], _rotP(240, 1, 2) + [-1, -2], _rotP(270, 1, 2) + [-1, -2],
                        _rotP(270, 1, 2) + [1, -2], _rotP(330, 1, 2) + [1, -2], _rotP(360, 1, 2) + [1, -2]
                    ],
                    "Should return a list of points to draw a rounded rectangle with size of w=4, h=8 and a radius of rx=1, ry=2 and 6 facets (hexagon)"
                );
                assertEqual(
                    drawRoundedRectangle(w=20, h=20, rx=3, ry=5, $fa=12, $fs=2),
                    concat(
                        [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) + [7, 5] ],
                        [ for (a = [90 : astep(5, $fa=12, $fs=2) : 180]) _rotP(a, 3, 5) + [-7, 5] ],
                        [ for (a = [180 : astep(5, $fa=12, $fs=2) : 270]) _rotP(a, 3, 5) + [-7, -5] ],
                        [ for (a = [270 : astep(5, $fa=12, $fs=2) : 360]) _rotP(a, 3, 5) + [7, -5] ]
                    ),
                    "Should return a list of points to draw a rounded rectangle with size of w=20, h=20 and a radius of rx=3, ry=5 and 16 facets"
                );
            }
        }
    }
    function _rotP(a, x, y) = [cos(a) * x, sin(a) * y];
}

testShape2dRounded();
