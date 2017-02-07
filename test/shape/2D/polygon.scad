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
 * Unit tests: Polygon shapes.
 *
 * @package test/shape/2D
 * @author jsconan
 */
module testShape2dPolygon() {
    testPackage("shape/2D/polygon.scad", 9) {
        // test shape/2D/polygon/sizeRectangle()
        testModule("sizeRectangle()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeRectangle(), [1, 1], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeRectangle("12", "12", "12"), [1, 1], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeRectangle(true, true, true), [1, 1], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 6) {
                assertEqual(sizeRectangle(3), [3, 3], "Should produce a size vector from a single number size");
                assertEqual(sizeRectangle([3]), [3, 1], "Should complete incomplete size vector");
                assertEqual(sizeRectangle([3, 4]), [3, 4], "Should keep the provided size vector");
                assertEqual(sizeRectangle([3, 4, 5]), [3, 4], "Should truncate too big size vector");
                assertEqual(sizeRectangle([3, 4], l=5), [5, 4], "Should set the length with the provided length in the provided size vector");
                assertEqual(sizeRectangle([3, 4], w=5), [3, 5], "Should set the width with the provided width in the provided size vector");
            }
        }
        // test shape/2D/polygon/sizeTrapezium()
        testModule("sizeTrapezium()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeTrapezium(), [1, 1, 1], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeTrapezium("12", "12", "12"), [1, 1, 1], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeTrapezium(true, true, true), [1, 1, 1], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 8) {
                assertEqual(sizeTrapezium(3), [3, 3, 3], "Should produce a size vector from a single number size");
                assertEqual(sizeTrapezium([3]), [3, 1, 1], "Should complete incomplete size vector");
                assertEqual(sizeTrapezium([3, 4]), [3, 4, 1], "Should complete incomplete size vector");
                assertEqual(sizeTrapezium([3, 4, 2]), [3, 4, 2], "Should keep the provided size vector");
                assertEqual(sizeTrapezium([3, 4, 2, 5]), [3, 4, 2], "Should truncate too big size vector");
                assertEqual(sizeTrapezium([3, 4, 2], a=5), [5, 4, 2], "Should set the bottom length with the provided length in the provided size vector");
                assertEqual(sizeTrapezium([3, 4, 2], b=5), [3, 5, 2], "Should set the top length with the provided length in the provided size vector");
                assertEqual(sizeTrapezium([3, 4, 2], w=5), [3, 4, 5], "Should set the height with the provided width in the provided size vector");
            }
        }
        // test shape/2D/polygon/sizeRegularPolygon()
        testModule("sizeRegularPolygon()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeRegularPolygon(), [1, 1, 3], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeRegularPolygon("12", "12", "12"), [1, 1, 3], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeRegularPolygon(true, true, true), [1, 1, 3], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 10) {
                assertEqual(sizeRegularPolygon(3), [3, 3, 3], "Should produce a size vector from a single number size");
                assertEqual(sizeRegularPolygon([3]), [3, 1, 3], "Should complete incomplete size vector");
                assertEqual(sizeRegularPolygon([3, 4]), [3, 4, 3], "Should complete incomplete size vector");
                assertEqual(sizeRegularPolygon([3, 4, 2]), [3, 4, 3], "Should truncate too big size vector");
                assertEqual(sizeRegularPolygon([3, 4], n=5), [3, 4, 5], "Should set the number of facets");
                assertEqual(sizeRegularPolygon([3, 4], l=5), [5, 4, 3], "Should set the length with the provided length in the provided size vector");
                assertEqual(sizeRegularPolygon([3, 4], w=5), [3, 5, 3], "Should set the width with the provided width in the provided size vector");
                assertEqual(sizeRegularPolygon(s=2, n=3), [4/(2 * sin(180/3)), 4/(2 * sin(180/3)), 3], "Should set the size of the triangle based on the length of a facet");
                assertEqual(sizeRegularPolygon(s=2, n=4), [4/(2 * sin(180/4)), 4/(2 * sin(180/4)), 4], "Should set the size of the diamond based on the length of a facet");
                assertEqual(sizeRegularPolygon(s=2, n=5), [4/(2 * sin(180/5)), 4/(2 * sin(180/5)), 5], "Should set the size of the pentagon based on the length of a facet");
            }
        }
        // test shape/2D/polygon/sizeStar()
        testModule("sizeStar()", 2) {
            testUnit("default values", 3) {
                edges = 3;
                size = [1, 1];
                core = size * 0.2;
                assertEqual(sizeStar(), [size, core, edges], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeStar("12", "12", "12"), [size, core, edges], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeStar(true, true, true), [size, core, edges], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 12) {
                assertEqual(sizeStar(3), [[3, 3], [3, 3] * 0.2, 3], "Should produce a size vector from a single number size");
                assertEqual(sizeStar(3, 2), [[3, 3], [2, 2], 3], "Should produce a size vector from a single number sizes");
                assertEqual(sizeStar(3, 2, 1), [[3, 3], [2, 2], 3], "Should produce force a minimum number of edges");
                assertEqual(sizeStar(3, 2, 4), [[3, 3], [2, 2], 4], "Should produce accept a number of edges greater than the minimum");

                assertEqual(sizeStar([3, 2], 1, 4), [[3, 2], [1, 1], 4], "Should accept vector for the outer size");
                assertEqual(sizeStar(3, [1, 2], 4), [[3, 3], [1, 2], 4], "Should accept vector for the core size");

                assertEqual(sizeStar([3, 2], 1, 4, l=4), [[4, 2], [1, 1], 4], "Should accept to override the length");
                assertEqual(sizeStar([3, 2], 1, 4, w=4), [[3, 4], [1, 1], 4], "Should accept to override the width");

                assertEqual(sizeStar(3, [1, 1], 4, cl=2), [[3, 3], [2, 1], 4], "Should accept to override the core length");
                assertEqual(sizeStar(4, [1, 1], 4, cw=2), [[4, 4], [1, 2], 4], "Should accept to override the core width");

                assertEqual(sizeStar(l=4, w=3, edges=5), [[4, 3], [4, 3] * (1 - 3 / 5), 5], "Should accept separate length and width");
                assertEqual(sizeStar(l=4, w=3, cl=2, cw=1, edges=5), [[4, 3], [2, 1], 5], "Should accept separate core length and width");
            }
        }
        // test shape/2D/polygon/drawRectangle()
        testModule("drawRectangle()", 2) {
            testUnit("default values", 3) {
                assertEqual(drawRectangle(), [[0.5, 0.5], [-0.5, 0.5], [-0.5, -0.5], [0.5, -0.5]], "Should return a list of points to draw a rectangle with a size of 1");
                assertEqual(drawRectangle("12", "12", "12"), [[0.5, 0.5], [-0.5, 0.5], [-0.5, -0.5], [0.5, -0.5]], "Should return a list of points to draw a rectangle with a size of 1 if wrong parameter has been provided (string)");
                assertEqual(drawRectangle(true, true, true), [[0.5, 0.5], [-0.5, 0.5], [-0.5, -0.5], [0.5, -0.5]], "Should return a list of points to draw a rectangle with a size of 1 if wrong parameter has been provided (boolean)");
            }
            testUnit("draw shape", 4) {
                assertEqual(drawRectangle(3), [[1.5, 1.5], [-1.5, 1.5], [-1.5, -1.5], [1.5, -1.5]], "Should return a list of points to draw a rectangle. Single number size should be translated into vector");
                assertEqual(drawRectangle([3, 4]), [[1.5, 2], [-1.5, 2], [-1.5, -2], [1.5, -2]], "Should return a list of points to draw a rectangle using the provided size vector");
                assertEqual(drawRectangle([3, 4], l=5), [[2.5, 2], [-2.5, 2], [-2.5, -2], [2.5, -2]], "Should return a list of points to draw a rectangle using the provided size vector with the provided length");
                assertEqual(drawRectangle([3, 4], w=5), [[1.5, 2.5], [-1.5, 2.5], [-1.5, -2.5], [1.5, -2.5]], "Should return a list of points to draw a rectangle using the provided size vector with the provided width");
            }
        }
        // test shape/2D/polygon/drawTrapezium()
        testModule("drawTrapezium()", 2) {
            testUnit("default values", 3) {
                assertEqual(drawTrapezium(), [[0.5, 0.5], [-0.5, 0.5], [-0.5, -0.5], [0.5, -0.5]], "Should return a list of points to draw a rectangle with a size of 1");
                assertEqual(drawTrapezium("12", "12", "12"), [[0.5, 0.5], [-0.5, 0.5], [-0.5, -0.5], [0.5, -0.5]], "Should return a list of points to draw a rectangle with a size of 1 if wrong parameter has been provided (string)");
                assertEqual(drawTrapezium(true, true, true), [[0.5, 0.5], [-0.5, 0.5], [-0.5, -0.5], [0.5, -0.5]], "Should return a list of points to draw a rectangle with a size of 1 if wrong parameter has been provided (boolean)");
            }
            testUnit("draw shape", 5) {
                assertEqual(drawTrapezium(3), [[1.5, 1.5], [-1.5, 1.5], [-1.5, -1.5], [1.5, -1.5]], "Should return a list of points to draw a rectangle. Single number size should be translated into vector");
                assertEqual(drawTrapezium([3, 4, 2]), [[2, 1], [-2, 1], [-1.5, -1], [1.5, -1]], "Should return a list of points to draw a trapezium using the provided size vector");
                assertEqual(drawTrapezium([3, 4, 2], a=5), [[2, 1], [-2, 1], [-2.5, -1], [2.5, -1]], "Should return a list of points to draw a trapezium using the provided size vector with the provided bottom length");
                assertEqual(drawTrapezium([3, 4, 2], b=5), [[2.5, 1], [-2.5, 1], [-1.5, -1], [1.5, -1]], "Should return a list of points to draw a trapezium using the provided size vector with the provided top length");
                assertEqual(drawTrapezium([3, 4, 2], w=5), [[2, 2.5], [-2, 2.5], [-1.5, -2.5], [1.5, -2.5]], "Should return a list of points to draw a trapezium using the provided size vector with the provided width");
            }
        }
        // test shape/2D/polygon/drawRegularPolygon()
        testModule("drawRegularPolygon()", 2) {
            testUnit("default values", 3) {
                assertEqual(drawRegularPolygon(), [ for(i = [0 : 2]) _rotP(i * 360/3 + 90, 0.5, 0.5) ], "Should return a list of points to draw a triangle with a size of 1");
                assertEqual(drawRegularPolygon("12", "12", "12"), [ for(i = [0 : 2]) _rotP(i * 360/3 + 90, 0.5, 0.5) ], "Should return a list of points to draw a triangle with a size of 1 if wrong parameter has been provided (string)");
                assertEqual(drawRegularPolygon(true, true, true), [ for(i = [0 : 2]) _rotP(i * 360/3 + 90, 0.5, 0.5) ], "Should return a list of points to draw a triangle with a size of 1 if wrong parameter has been provided (boolean)");
            }
            testUnit("draw shape", 18) {
                assertEqual(drawRegularPolygon(3), [ for(i = [0 : 2]) _rotP(i * 360/3 + 90, 1.5, 1.5) ], "Should return a list of points to draw a triangle. Single number size should be translated into vector");
                assertEqual(drawRegularPolygon(3, n=4), [ for(i = [0 : 3]) _rotP(i * 360/4 + 90, 1.5, 1.5) ], "Should return a list of points to draw a diamond. Single number size should be translated into vector");
                assertEqual(drawRegularPolygon(3, n=5), [ for(i = [0 : 4]) _rotP(i * 360/5 + 90, 1.5, 1.5) ], "Should return a list of points to draw a pentagon. Single number size should be translated into vector");

                assertEqual(drawRegularPolygon([3, 4]), [ for(i = [0 : 2]) _rotP(i * 360/3 + 90, 1.5, 2) ], "Should return a list of points to draw a triangle using the provided size vector");
                assertEqual(drawRegularPolygon([3, 4], n=4), [ for(i = [0 : 3]) _rotP(i * 360/4 + 90, 1.5, 2) ], "Should return a list of points to draw a diamond using the provided size vector");
                assertEqual(drawRegularPolygon([3, 4], n=5), [ for(i = [0 : 4]) _rotP(i * 360/5 + 90, 1.5, 2) ], "Should return a list of points to draw a pentagon using the provided size vector");

                assertEqual(drawRegularPolygon([3, 4], l=2), [ for(i = [0 : 2]) _rotP(i * 360/3 + 90, 1, 2) ], "Should return a list of points to draw a triangle using the provided size vector and the particular length");
                assertEqual(drawRegularPolygon([3, 4], l=2, n=4), [ for(i = [0 : 3]) _rotP(i * 360/4 + 90, 1, 2) ], "Should return a list of points to draw a diamond using the provided size vector and the particular length");
                assertEqual(drawRegularPolygon([3, 4], l=2, n=5), [ for(i = [0 : 4]) _rotP(i * 360/5 + 90, 1, 2) ], "Should return a list of points to draw a pentagon using the provided size vector and the particular length");

                assertEqual(drawRegularPolygon([3, 4], w=2), [ for(i = [0 : 2]) _rotP(i * 360/3 + 90, 1.5, 1) ], "Should return a list of points to draw a triangle using the provided size vector and the particular width");
                assertEqual(drawRegularPolygon([3, 4], w=2, n=4), [ for(i = [0 : 3]) _rotP(i * 360/4 + 90, 1.5, 1) ], "Should return a list of points to draw a diamond using the provided size vector and the particular width");
                assertEqual(drawRegularPolygon([3, 4], w=2, n=5), [ for(i = [0 : 4]) _rotP(i * 360/5 + 90, 1.5, 1) ], "Should return a list of points to draw a pentagon using the provided size vector and the particular width");

                assertEqual(drawRegularPolygon(l=3, w=4), [ for(i = [0 : 2]) _rotP(i * 360/3 + 90, 1.5, 2) ], "Should return a list of points to draw a triangle using the provided size length and width");
                assertEqual(drawRegularPolygon(l=3, w=4, n=4), [ for(i = [0 : 3]) _rotP(i * 360/4 + 90, 1.5, 2) ], "Should return a list of points to draw a diamond using the provided size length and width");
                assertEqual(drawRegularPolygon(l=3, w=4, n=5), [ for(i = [0 : 4]) _rotP(i * 360/5 + 90, 1.5, 2) ], "Should return a list of points to draw a pentagon using the provided size length and width");

                assertEqual(drawRegularPolygon(s=2, n=3), [ for(i = [0 : 2]) _rotP(i * 360/3 + 90, 2/(2 * sin(180/3)), 2/(2 * sin(180/3))) ], "Should return a list of points to draw a triangle using the provided facet size");
                assertEqual(drawRegularPolygon(s=2, n=4), [ for(i = [0 : 3]) _rotP(i * 360/4 + 90, 2/(2 * sin(180/4)), 2/(2 * sin(180/4))) ], "Should return a list of points to draw a diamond using the provided facet size");
                assertEqual(drawRegularPolygon(s=2, n=5), [ for(i = [0 : 4]) _rotP(i * 360/5 + 90, 2/(2 * sin(180/5)), 2/(2 * sin(180/5))) ], "Should return a list of points to draw a pentagon using the provided facet size");
            }
        }
        // test shape/2D/polygon/drawHexagon()
        testModule("drawHexagon()", 2) {
            testUnit("default values", 3) {
                assertEqual(drawHexagon(), [ for(i = [0 : 5]) _rotP(i * 360/6, 0.5, 0.5) ], "Should return a list of points to draw an hexagon with a size of 1");
                assertEqual(drawHexagon("12", "12", "12"), [ for(i = [0 : 5]) _rotP(i * 360/6, 0.5, 0.5) ], "Should return a list of points to draw an hexagon with a size of 1 if wrong parameter has been provided (string)");
                assertEqual(drawHexagon(true, true, true), [ for(i = [0 : 5]) _rotP(i * 360/6, 0.5, 0.5) ], "Should return a list of points to draw an hexagon with a size of 1 if wrong parameter has been provided (boolean)");
            }
            testUnit("draw shape", 12) {
                assertEqual(drawHexagon(3), [ for(i = [0 : 5]) _rotP(i * 360/6, 1.5, 1.5) ], "Should return a list of points to draw an hexagon. Single number size should be translated into vector");
                assertEqual(drawHexagon([3, 4]), [ for(i = [0 : 5]) _rotP(i * 360/6, 1.5, 2) ], "Should return a list of points to draw an hexagon using the provided size vector");
                assertEqual(drawHexagon([3, 4], l=2), [ for(i = [0 : 5]) _rotP(i * 360/6, 1, 2) ], "Should return a list of points to draw an hexagon using the provided size vector and the particular length");
                assertEqual(drawHexagon([3, 4], w=2), [ for(i = [0 : 5]) _rotP(i * 360/6, 1.5, 1) ], "Should return a list of points to draw an hexagon using the provided size vector and the particular width");
                assertEqual(drawHexagon(l=3, w=4), [ for(i = [0 : 5]) _rotP(i * 360/6, 1.5, 2) ], "Should return a list of points to draw an hexagon using the provided size length and width");
                assertEqual(drawHexagon(s=2), [ for(i = [0 : 5]) _rotP(i * 360/6, 2/(2 * sin(180/6)), 2/(2 * sin(180/6))) ], "Should return a list of points to draw an hexagon using the provided facet size");

                assertEqual(drawHexagon(3, adjust=2), [ for(i = [0 : 5]) _rotP(i * 360/6, 1.5, 1.5) + [i >= 2 && i<= 4 ? -1 : 1, 0] ], "Should return a list of points to draw an hexagon. Single number size should be translated into vector");
                assertEqual(drawHexagon([3, 4], adjust=2), [ for(i = [0 : 5]) _rotP(i * 360/6, 1.5, 2) + [i >= 2 && i<= 4 ? -1 : 1, 0] ], "Should return a list of points to draw an hexagon using the provided size vector");
                assertEqual(drawHexagon([3, 4], l=2, adjust=2), [ for(i = [0 : 5]) _rotP(i * 360/6, 1, 2) + [i >= 2 && i<= 4 ? -1 : 1, 0] ], "Should return a list of points to draw an hexagon using the provided size vector and the particular length");
                assertEqual(drawHexagon([3, 4], w=2, adjust=2), [ for(i = [0 : 5]) _rotP(i * 360/6, 1.5, 1) + [i >= 2 && i<= 4 ? -1 : 1, 0] ], "Should return a list of points to draw an hexagon using the provided size vector and the particular width");
                assertEqual(drawHexagon(l=3, w=4, adjust=2), [ for(i = [0 : 5]) _rotP(i * 360/6, 1.5, 2) + [i >= 2 && i<= 4 ? -1 : 1, 0] ], "Should return a list of points to draw an hexagon using the provided size length and width");
                assertEqual(drawHexagon(s=2, , adjust=2), [ for(i = [0 : 5]) _rotP(i * 360/6, 2/(2 * sin(180/6)), 2/(2 * sin(180/6))) + [i >= 2 && i<= 4 ? -1 : 1, 0] ], "Should return a list of points to draw an hexagon using the provided facet size");
            }
        }
        // test shape/2D/polygon/drawStar()
        testModule("drawStar()", 2) {
            testUnit("default values", 3) {
                size = [1, 1];
                core = size * 0.2;
                default = [ for(i = [0 : 5]) _rotP(i * 360/6 + 90, i % 2 ? core[0] : size[0], i % 2 ? core[1] : size[1]) ];
                assertEqual(drawStar(), default, "Should return a list of points to draw a star with a size of 1");
                assertEqual(drawStar("12", "12", "12"), default, "Should return a list of points to draw a star with a size of 1 if wrong parameter has been provided (string)");
                assertEqual(drawStar(true, true, true), default, "Should return a list of points to draw a star with a size of 1 if wrong parameter has been provided (boolean)");
            }
            testUnit("draw shape", 12) {
                assertEqual(drawStar(3), [ for(i = [0 : 5]) _rotP(i * 360/6 + 90, i % 2 ? 3*.2 : 3, i % 2 ? 3*.2 : 3) ], "Should return a list of points to draw a star. Single number size should be translated into vector");
                assertEqual(drawStar(3, 2), [ for(i = [0 : 5]) _rotP(i * 360/6 + 90, i % 2 ? 2 : 3, i % 2 ? 2 : 3) ], "Should return a list of points to draw a star. Should produce a size vector from a single number sizes");
                assertEqual(drawStar(3, 2, 1), [ for(i = [0 : 5]) _rotP(i * 360/6 + 90, i % 2 ? 2 : 3, i % 2 ? 2 : 3) ], "Should return a list of points to draw a star. Should produce force a minimum number of edges");
                assertEqual(drawStar(3, 2, 4), [ for(i = [0 : 7]) _rotP(i * 360/8 + 90, i % 2 ? 2 : 3, i % 2 ? 2 : 3) ], "Should return a list of points to draw a star. Should produce accept a number of edges greater than the minimum");

                assertEqual(drawStar([3, 2], 1, 4), [ for(i = [0 : 7]) _rotP(i * 360/8 + 90, i % 2 ? 1 : 3, i % 2 ? 1 : 2) ], "Should return a list of points to draw a star. Should accept vector for the outer size");
                assertEqual(drawStar(3, [1, 2], 4), [ for(i = [0 : 7]) _rotP(i * 360/8 + 90, i % 2 ? 1 : 3, i % 2 ? 2 : 3) ], "Should return a list of points to draw a star. Should accept vector for the core size");

                assertEqual(drawStar([3, 2], 1, 5, l=4), [ for(i = [0 : 9]) _rotP(i * 360/10 + 90, i % 2 ? 1 : 4, i % 2 ? 1 : 2) ], "Should return a list of points to draw a star. Should accept to override the length");
                assertEqual(drawStar([3, 2], 1, 5, w=4), [ for(i = [0 : 9]) _rotP(i * 360/10 + 90, i % 2 ? 1 : 3, i % 2 ? 1 : 4) ], "Should return a list of points to draw a star. Should accept to override the width");

                assertEqual(drawStar(3, [1, 1], 6, cl=2), [ for(i = [0 : 11]) _rotP(i * 360/12 + 90, i % 2 ? 2 : 3, i % 2 ? 1 : 3) ], "Should return a list of points to draw a star. Should accept to override the core length");
                assertEqual(drawStar(4, [1, 1], 6, cw=2), [ for(i = [0 : 11]) _rotP(i * 360/12 + 90, i % 2 ? 1 : 4, i % 2 ? 2 : 4) ], "Should return a list of points to draw a star. Should accept to override the core width");

                assertEqual(drawStar(l=4, w=3, edges=5), [ for(i = [0 : 9]) _rotP(i * 360/10 + 90, i % 2 ? 4 * (1 - 3 / 5) : 4, i % 2 ? 3 * (1 - 3 / 5) : 3) ], "Should return a list of points to draw a star. Should accept separate length and width");
                assertEqual(drawStar(l=4, w=3, cl=2, cw=1, edges=5), [ for(i = [0 : 9]) _rotP(i * 360/10 + 90, i % 2 ?2 : 4, i % 2 ? 1 : 3) ], "Should return a list of points to draw a star. Should accept separate core length and width");
            }
        }
    }
    function _rotP(a, x, y) = [cos(a) * x, sin(a) * y];
}

testShape2dPolygon();
