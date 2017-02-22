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
 * Unit tests: Polyhedron shapes.
 *
 * @package test/shape/3D
 * @author jsconan
 */
module testShape3dPolyhedron() {
    testPackage("shape/3D/polyhedron.scad", 4) {
        // test shape/3D/polyhedron/sizeBox()
        testModule("sizeBox()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeBox(), [1, 1, 1], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeBox("12", "12", "12"), [1, 1, 1], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeBox(true, true, true), [1, 1, 1], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 8) {
                assertEqual(sizeBox(3), [3, 3, 3], "Should produce a size vector from a single number size");
                assertEqual(sizeBox([3]), [3, 1, 1], "Should complete incomplete size vector");
                assertEqual(sizeBox([3, 2]), [3, 2, 1], "Should complete incomplete size vector");
                assertEqual(sizeBox([3, 4, 5]), [3, 4, 5], "Should keep the provided size vector");
                assertEqual(sizeBox([3, 4, 5, 6]), [3, 4, 5], "Should truncate too big size vector");
                assertEqual(sizeBox([3, 4, 2], l=5), [5, 4, 2], "Should set the length with the provided length in the provided size vector");
                assertEqual(sizeBox([3, 4, 2], w=5), [3, 5, 2], "Should set the width with the provided width in the provided size vector");
                assertEqual(sizeBox([3, 4, 2], h=5), [3, 4, 5], "Should set the height with the provided width in the provided size vector");
            }
        }
        // test shape/3D/polyhedron/sizeTrapeziumBox()
        testModule("sizeTrapeziumBox()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeTrapeziumBox(), [1, 1, 1, 1], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeTrapeziumBox("12", "12", "12"), [1, 1, 1, 1], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeTrapeziumBox(true, true, true), [1, 1, 1, 1], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 10) {
                assertEqual(sizeTrapeziumBox(3), [3, 3, 3, 3], "Should produce a size vector from a single number size");
                assertEqual(sizeTrapeziumBox([3]), [3, 1, 1, 1], "Should complete incomplete size vector (A)");
                assertEqual(sizeTrapeziumBox([3, 4]), [3, 4, 1, 1], "Should complete incomplete size vector, (A, B)");
                assertEqual(sizeTrapeziumBox([3, 4, 2]), [3, 4, 2, 1], "Should complete incomplete size vector (A, B, W)");
                assertEqual(sizeTrapeziumBox([3, 4, 2, 5]), [3, 4, 2, 5], "Should keep the provided size vector");
                assertEqual(sizeTrapeziumBox([3, 4, 2, 5, 6]), [3, 4, 2, 5], "Should truncate too big size vector");
                assertEqual(sizeTrapeziumBox([3, 4, 2, 3], a=5), [5, 4, 2, 3], "Should set the bottom length with the provided value in the provided size vector");
                assertEqual(sizeTrapeziumBox([3, 4, 2, 3], b=5), [3, 5, 2, 3], "Should set the top length with the provided value in the provided size vector");
                assertEqual(sizeTrapeziumBox([3, 4, 2, 3], w=5), [3, 4, 5, 3], "Should set the width with the provided value in the provided size vector");
                assertEqual(sizeTrapeziumBox([3, 4, 2, 3], h=5), [3, 4, 2, 5], "Should set the height with the provided value in the provided size vector");
            }
        }
        // test shape/3D/polyhedron/sizeRegularPolygonBoxBox()
        testModule("sizeRegularPolygonBox()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeRegularPolygonBox(), [1, 1, 1, 3], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeRegularPolygonBox("12", "12", "12"), [1, 1, 1, 3], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeRegularPolygonBox(true, true, true), [1, 1, 1, 3], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 12) {
                assertEqual(sizeRegularPolygonBox(2), [2, 2, 2, 3], "Should produce a size vector from a single number size");
                assertEqual(sizeRegularPolygonBox([3]), [3, 1, 1, 3], "Should complete incomplete size vector (L)");
                assertEqual(sizeRegularPolygonBox([3, 4]), [3, 4, 1, 3], "Should complete incomplete size vector, (L, W)");
                assertEqual(sizeRegularPolygonBox([3, 4, 2]), [3, 4, 2, 3], "Should keep the provided size vector)");
                assertEqual(sizeRegularPolygonBox([3, 4, 2, 5]), [3, 4, 2, 3], "Should truncate too big size vector");
                assertEqual(sizeRegularPolygonBox([3, 4, 2], n=5), [3, 4, 2, 5], "Should set the number of facets");
                assertEqual(sizeRegularPolygonBox([3, 4, 2], l=5), [5, 4, 2, 3], "Should set the length with the provided value in the provided size vector");
                assertEqual(sizeRegularPolygonBox([3, 4, 2], w=5), [3, 5, 2, 3], "Should set the width with the provided value in the provided size vector");
                assertEqual(sizeRegularPolygonBox([3, 4, 2], h=5), [3, 4, 5, 3], "Should set the height with the provided value in the provided size vector");
                assertEqual(sizeRegularPolygonBox(s=2, n=3), [4/(2 * sin(180/3)), 4/(2 * sin(180/3)), 4/(2 * sin(180/3)), 3], "Should set the size of the triangle based on the length of a facet");
                assertEqual(sizeRegularPolygonBox(s=2, n=4), [4/(2 * sin(180/4)), 4/(2 * sin(180/4)), 4/(2 * sin(180/4)), 4], "Should set the size of the diamond based on the length of a facet");
                assertEqual(sizeRegularPolygonBox(s=2, n=5), [4/(2 * sin(180/5)), 4/(2 * sin(180/5)), 4/(2 * sin(180/5)), 5], "Should set the size of the pentagon based on the length of a facet");
            }
        }
        // test shape/3D/polyhedron/sizeStarBoxBox()
        testModule("sizeStarBox()", 2) {
            testUnit("default values", 3) {
                edges = 3;
                size = [1, 1, 1];
                core = [1, 1] * 0.2;
                assertEqual(sizeStarBox(), [size, core, edges], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeStarBox("12", "12", "12"), [size, core, edges], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeStarBox(true, true, true), [size, core, edges], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 13) {
                assertEqual(sizeStarBox(3), [[3, 3, 3], [3, 3] * 0.2, 3], "Should produce a size vector from a single number size");
                assertEqual(sizeStarBox(3, 2), [[3, 3, 3], [2, 2], 3], "Should produce a size vector from a single number sizes");
                assertEqual(sizeStarBox(3, 2, 1), [[3, 3, 3], [2, 2], 3], "Should produce force a minimum number of edges");
                assertEqual(sizeStarBox(3, 2, 4), [[3, 3, 3], [2, 2], 4], "Should produce accept a number of edges greater than the minimum");

                assertEqual(sizeStarBox([3, 2, 4], 1, 4), [[3, 2, 4], [1, 1], 4], "Should accept vector for the outer size");
                assertEqual(sizeStarBox(3, [1, 2], 4), [[3, 3, 3], [1, 2], 4], "Should accept vector for the core size");

                assertEqual(sizeStarBox([3, 2, 4], 1, 4, l=5), [[5, 2, 4], [1, 1], 4], "Should accept to override the length");
                assertEqual(sizeStarBox([3, 2, 4], 1, 4, w=5), [[3, 5, 4], [1, 1], 4], "Should accept to override the width");
                assertEqual(sizeStarBox([3, 2, 4], 1, 4, h=5), [[3, 2, 5], [1, 1], 4], "Should accept to override the height");

                assertEqual(sizeStarBox(3, [1, 1], 4, cl=2), [[3, 3, 3], [2, 1], 4], "Should accept to override the core length");
                assertEqual(sizeStarBox(4, [1, 1], 4, cw=2), [[4, 4, 4], [1, 2], 4], "Should accept to override the core width");

                assertEqual(sizeStarBox(l=4, w=3, h=6, edges=5), [[4, 3, 6], [4, 3] * (1 - 3 / 5), 5], "Should accept separate length, width and height");
                assertEqual(sizeStarBox(l=4, w=3, h=6, cl=2, cw=1, edges=5), [[4, 3, 6], [2, 1], 5], "Should accept separate core length and width");
            }
        }
    }
}

testShape3dPolyhedron();
