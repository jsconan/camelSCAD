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
include <../../../core/constants.scad>

/**
 * Part of the camelSCAD library.
 *
 * Unit tests: Rounded shapes.
 *
 * @package test/shape/2D
 * @author jsconan
 */
module testShape2dRounded() {
    testPackage("shape/2D/rounded.scad", 11) {
        // test shape/2D/rounded/sizeRounded2D()
        testModule("sizeRounded2D()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeRounded2D(), [0, 0], "Should always return a valid vector even if not parameter has been provided");
                assertEqual(sizeRounded2D("12", "12", "12", "12", "12", "12"), [0, 0], "Should always return a valid vector even if wrong parameter has been provided (string)");
                assertEqual(sizeRounded2D(true, true, true, true, true, true), [0, 0], "Should always return a valid vector even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 15) {
                assertEqual(sizeRounded2D(3), [3, 3], "Should produce a radius from a single radius number");
                assertEqual(sizeRounded2D(d=3), [1.5, 1.5], "Should produce a radius from a single diameter number");

                assertEqual(sizeRounded2D([2, 3]), [2, 3], "Should keep the the radius if a vector is provided");
                assertEqual(sizeRounded2D(d=[2, 3]), [1, 1.5], "Should adjust the diameter if a vector is provided");

                assertEqual(sizeRounded2D(r=[3, 4], rx=5), [5, 4], "Should set the provided X radius in the provided radius vector");
                assertEqual(sizeRounded2D(r=[3, 4], ry=5), [3, 5], "Should set the provided Y radius in the provided radius vector");

                assertEqual(sizeRounded2D(r=[3, 4], dx=5), [2.5, 4], "Should set the provided X diameter in the provided radius vector");
                assertEqual(sizeRounded2D(r=[3, 4], dy=5), [3, 2.5], "Should set the provided Y diameter in the provided radius vector");

                assertEqual(sizeRounded2D(d=[3, 4], rx=5), [5, 2], "Should set the provided X radius in the provided diameter vector");
                assertEqual(sizeRounded2D(d=[3, 4], ry=5), [1.5, 5], "Should set the provided Y radius in the provided diameter vector");

                assertEqual(sizeRounded2D(d=[3, 4], dx=5), [2.5, 2], "Should set the provided X diameter in the provided diameter vector");
                assertEqual(sizeRounded2D(d=[3, 4], dy=5), [1.5, 2.5], "Should set the provided Y diameter in the provided diameter vector");

                assertEqual(sizeRounded2D(rx=3), [3, 0], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizeRounded2D(ry=4), [0, 4], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizeRounded2D(rx=3, ry=4), [3, 4], "Should set the provided radius in the radius vector");
            }
        }
        // test shape/2D/rounded/sizeArch()
        testModule("sizeArch()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeArch(), [[1, 1], [0.5, 0.5]], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeArch("12", "12", "12", "12", "12", "12"), [[1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeArch(true, true, true, true, true, true), [[1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 29) {
                assertEqual(sizeArch(3), [[3, 3], [1.5, 1.5]], "Should produce a size from a single size number in order to draw a half-circle");
                assertEqual(sizeArch(r=3), [[6, 3], [3, 3]], "Should produce a size from a single radius number in order to draw a half-circle");
                assertEqual(sizeArch(d=3), [[3, 1.5], [1.5, 1.5]], "Should produce a size from a single diameter number in order to draw a half-circle");

                assertEqual(sizeArch(3, 2), [[3, 3], [1.5, 2]], "Should produce the size and the radius from single number size and radius");
                assertEqual(sizeArch(3, d=2), [[3, 3], [1.5, 1]], "Should produce the size and the radius from single number size and diameter");

                assertEqual(sizeArch([3, 4], [2, 2]), [[3, 4], [1.5, 2]], "Should keep the size and adjust the radius if vectors are provided");
                assertEqual(sizeArch([3, 4], d=[2, 2]), [[3, 4], [1.5, 1]], "Should keep the size and adjust the diameter if vectors are provided");
                assertEqual(sizeArch([3, 4], d=[6, 8]), [[3, 4], [1.5, 4]], "Should keep the size and adjust the diameter if vectors are provided");

                assertEqual(sizeArch([3, 4]), [[3, 4], [1.5, 1.5]], "Should keep the provided size vector and should produce the radius accordingly");
                assertEqual(sizeArch(r=[3, 4]), [[6, 4], [3, 4]], "Should keep the provided radius vector and should produce the size accordingly");
                assertEqual(sizeArch(d=[3, 4]), [[3, 2], [1.5, 2]], "Should translate the provided diameter vector to a radius vector and should produce the size accordingly");

                assertEqual(sizeArch([3, 4], w=5), [[5, 4], [2.5, 2.5]], "Should set the provided width in the provided size vector");
                assertEqual(sizeArch([3, 4], h=5), [[3, 5], [1.5, 1.5]], "Should set the provided height in the provided size vector");

                assertEqual(sizeArch(r=[3, 4], rx=5), [[10, 4], [5, 4]], "Should set the provided X radius in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeArch(r=[3, 4], ry=5), [[6, 5], [3, 5]], "Should set the provided Y radius in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeArch(r=[3, 4], dx=5), [[5, 4], [2.5, 4]], "Should set the provided X diameter in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeArch(r=[3, 4], dy=5), [[6, 2.5], [3, 2.5]], "Should set the provided Y diameter in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeArch(d=[3, 4], rx=5), [[10, 2], [5, 2]], "Should set the provided X radius in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeArch(d=[3, 4], ry=5), [[3, 5], [1.5, 5]], "Should set the provided Y radius in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeArch(d=[3, 4], dx=5), [[5, 2], [2.5, 2]], "Should set the provided X diameter in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeArch(d=[3, 4], dy=5), [[3, 2.5], [1.5, 2.5]], "Should set the provided Y diameter in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeArch(w=3), [[3, 1], [1.5, 1]], "Should set the provided width in the size vector and use the default for the height");
                assertEqual(sizeArch(h=4), [[1, 4], [0.5, 0.5]], "Should set the provided height in the size vector and use the default for the width");
                assertEqual(sizeArch(w=3, h=4), [[3, 4], [1.5, 1.5]], "Should set the provided width and height in the size vector");

                assertEqual(sizeArch(rx=3), [[6, 1], [3, 1]], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizeArch(ry=4), [[1, 4], [0.5, 4]], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizeArch(rx=3, ry=4), [[6, 4], [3, 4]], "Should set the provided radius in the radius vector");

                assertEqual(sizeArch(h=4, rx=3), [[6, 4], [3, 3]], "Should set the provided height in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizeArch(w=4, ry=3), [[4, 3], [2, 3]], "Should set the provided width in the size vector and set the provide Y radius in the radius vector");
            }
        }
        // test shape/2D/rounded/sizeStadium()
        testModule("sizeStadium()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeStadium(), [[1, 1], [0.5, 0.5]], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeStadium("12", "12", "12", "12", "12", "12"), [[1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeStadium(true, true, true, true, true, true), [[1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 29) {
                assertEqual(sizeStadium(3), [[3, 3], [1.5, 1.5]], "Should produce a size from a single size number in order to draw a circle");
                assertEqual(sizeStadium(r=3), [[6, 6], [3, 3]], "Should produce a size from a single radius number in order to draw a circle");
                assertEqual(sizeStadium(d=3), [[3, 3], [1.5, 1.5]], "Should produce a size from a single diameter number in order to draw a circle");

                assertEqual(sizeStadium(3, 2), [[3, 3], [1.5, 1.5]], "Should produce the size and the radius from single number size and radius");
                assertEqual(sizeStadium(3, d=2), [[3, 3], [1.5, 1]], "Should produce the size and the radius from single number size and diameter");

                assertEqual(sizeStadium([3, 4], [2, 2]), [[3, 4], [1.5, 2]], "Should keep the size and adjust the radius if vectors are provided");
                assertEqual(sizeStadium([3, 4], d=[2, 2]), [[3, 4], [1.5, 1]], "Should keep the size and adjust the diameter if vectors are provided");
                assertEqual(sizeStadium([3, 4], d=[8, 10]), [[3, 4], [1.5, 2]], "Should keep the size and adjust the diameter if vectors are provided");

                assertEqual(sizeStadium([3, 4]), [[3, 4], [1.5, 1.5]], "Should keep the provided size vector and should produce the radius accordingly");
                assertEqual(sizeStadium(r=[3, 4]), [[6, 8], [3, 4]], "Should keep the provided radius vector and should produce the size accordingly");
                assertEqual(sizeStadium(d=[3, 4]), [[3, 4], [1.5, 2]], "Should translate the provided diameter vector to a radius vector and should produce the size accordingly");

                assertEqual(sizeStadium([3, 4], w=5), [[5, 4], [2.5, 2]], "Should set the provided width in the provided size vector");
                assertEqual(sizeStadium([3, 4], h=5), [[3, 5], [1.5, 1.5]], "Should set the provided height in the provided size vector");

                assertEqual(sizeStadium(r=[3, 4], rx=5), [[10, 8], [5, 4]], "Should set the provided X radius in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeStadium(r=[3, 4], ry=5), [[6, 10], [3, 5]], "Should set the provided Y radius in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeStadium(r=[3, 4], dx=5), [[5, 8], [2.5, 4]], "Should set the provided X diameter in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeStadium(r=[3, 4], dy=5), [[6, 5], [3, 2.5]], "Should set the provided Y diameter in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeStadium(d=[3, 4], rx=5), [[10, 4], [5, 2]], "Should set the provided X radius in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeStadium(d=[3, 4], ry=5), [[3, 10], [1.5, 5]], "Should set the provided Y radius in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeStadium(d=[3, 4], dx=5), [[5, 4], [2.5, 2]], "Should set the provided X diameter in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeStadium(d=[3, 4], dy=5), [[3, 5], [1.5, 2.5]], "Should set the provided Y diameter in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeStadium(w=3), [[3, 1], [1.5, 0.5]], "Should set the provided width in the size vector and use the default for the height");
                assertEqual(sizeStadium(h=4), [[1, 4], [0.5, 0.5]], "Should set the provided height in the size vector and use the default for the width");
                assertEqual(sizeStadium(w=3, h=4), [[3, 4], [1.5, 1.5]], "Should set the provided width and height in the size vector");

                assertEqual(sizeStadium(rx=3), [[6, 1], [3, 0.5]], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizeStadium(ry=4), [[1, 8], [0.5, 4]], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizeStadium(rx=3, ry=4), [[6, 8], [3, 4]], "Should set the provided radius in the radius vector");

                assertEqual(sizeStadium(h=4, rx=3), [[6, 4], [3, 2]], "Should set the provided height in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizeStadium(w=4, ry=3), [[4, 6], [2, 3]], "Should set the provided width in the size vector and set the provide Y radius in the radius vector");
            }
        }
        // test shape/2D/rounded/sizeRoundedRectangle()
        testModule("sizeRoundedRectangle()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeRoundedRectangle(), [[1, 1], [0, 0]], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeRoundedRectangle("12", "12", "12", "12", "12", "12"), [[1, 1], [0, 0]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeRoundedRectangle(true, true, true, true, true, true), [[1, 1], [0, 0]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 29) {
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
        // test shape/2D/rounded/sizeRoundedCorner()
        testModule("sizeRoundedCorner()", 8) {
            s = 20;
            r = 40;
            S = [s, s];
            R = [r, r];
            A = [0, s];
            B = [s, 0];

            testUnit("default values", 3) {
                assertEqual(sizeRoundedCorner(), [[1, 1], [1, 1], [1, 1], 0, 180, 90], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeRoundedCorner("12", "12"), [[1, 1], [1, 1], [1, 1], 0, 180, 90], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeRoundedCorner(true, true), [[1, 1], [1, 1], [1, 1], 0, 180, 90], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size of a concave corner with default position", 7) {
                assertEqual(sizeRoundedCorner(s), [S, S, S, 0, 180, 90], "Should produce a size in order to draw an upper right rounded concave corner");
                assertEqual(sizeRoundedCorner(r=s), [S, S, S, 0, 180, 90], "Should produce a size from radius in order to draw an upper right rounded concave corner");
                assertEqual(sizeRoundedCorner(d=s), [S/2, S/2, S/2, 0, 180, 90], "Should produce a size from diameter in order to draw an upper right rounded concave corner");
                assertEqual(sizeRoundedCorner(s, s-1), [S, S, S, 0, 180, 90], "Should produce a size in order to draw an upper right rounded concave corner, when the radius is too small it should be adjusted");

                C = center2D(A, B, r, true);
                angle = angle2D(C - A, C - B);
                start = 180 + (90 - angle) / 2;
                assertTrue(angle >= 0 && angle <= 90, "The arc angle should be between O° and 90°");
                assertTrue(start >= 180 && start <= 270, "The start angle should be between 18O° and 270°");
                assertEqual(sizeRoundedCorner(s, r), [S, R, C, 0, start, angle], "Should produce a size in order to draw an upper right rounded concave corner, when the radius is bigger than the size, the center should be computed");
            }
            testUnit("compute size of a convex corner with default position", 7) {
                assertEqual(sizeRoundedCorner(s, convex=1), [S, S, [0, 0], 0, 0, 90], "Should produce a size in order to draw an upper right rounded convex corner");
                assertEqual(sizeRoundedCorner(r=s, convex=1), [S, S, [0, 0], 0, 0, 90], "Should produce a size from radius in order to draw an upper right rounded convex corner");
                assertEqual(sizeRoundedCorner(d=s, convex=1), [S/2, S/2, [0, 0], 0, 0, 90], "Should produce a size from diameter in order to draw an upper right rounded convex corner");
                assertEqual(sizeRoundedCorner(s, s-1, convex=1), [S, S, [0, 0], 0, 0, 90], "Should produce a size in order to draw an upper right rounded convex corner, when the radius is too small it should be adjusted");

                C = center2D(A, B, r, false);
                angle = angle2D(C - A, C - B);
                start = (90 - angle) / 2;
                assertTrue(angle >= 0 && angle <= 90, "The arc angle should be between O° and 90°");
                assertTrue(start >= 0 && start <= 90, "The start angle should be between O° and 90°");
                assertEqual(sizeRoundedCorner(s, r, convex=1), [S, R, C, 0, start, angle], "Should produce a size in order to draw an upper right rounded convex corner, when the radius is bigger than the size, the center should be computed");
            }
            testUnit("compute size for each position", 8) {
                assertEqual(sizeRoundedCorner(size=s, r=s, p="ne"), [S, S, [s, s], 0, 180, 90], "Should produce a size in order to draw an upper right rounded concave corner");
                assertEqual(sizeRoundedCorner(size=s, r=s, p="nw"), [S, S, [-s, s], 90, 270, 90], "Should produce a size in order to draw an upper left rounded concave corner");
                assertEqual(sizeRoundedCorner(size=s, r=s, p="sw"), [S, S, [-s, -s], 180, 360, 90], "Should produce a size in order to draw a lower left rounded concave corner");
                assertEqual(sizeRoundedCorner(size=s, r=s, p="se"), [S, S, [s, -s], 270, 90, 90], "Should produce a size in order to draw a lower right rounded concave corner");

                assertEqual(sizeRoundedCorner(size=s, r=s, p="ne", convex=1), [S, S, [0, 0], 0, 0, 90], "Should produce a size in order to draw an upper right rounded convex corner");
                assertEqual(sizeRoundedCorner(size=s, r=s, p="nw", convex=1), [S, S, [0, 0], 90, 90, 90], "Should produce a size in order to draw an upper left rounded convex corner");
                assertEqual(sizeRoundedCorner(size=s, r=s, p="sw", convex=1), [S, S, [0, 0], 180, 180, 90], "Should produce a size in order to draw a lower left rounded convex corner");
                assertEqual(sizeRoundedCorner(size=s, r=s, p="se", convex=1), [S, S, [0, 0], 270, 270, 90], "Should produce a size in order to draw a lower right rounded convex corner");
            }
            testUnit("compute size of corner with bigger radius and position Nort East", 6) {
                C1 = center2D(A, B, r, true);
                angle1 = angle2D(C1 - A, C1 - B);
                start1 = 180 + (90 - angle1) / 2;
                assertTrue(angle1 >= 0 && angle1 <= 90, "The arc angle should be between O° and 90° (concave)");
                assertTrue(start1 >= 180 && start1 <= 270, "The start angle should be between 18O° and 270° (concave)");
                assertEqual(
                    sizeRoundedCorner(size=s, r=r, p="ne"),
                    [S, R, C1, 0, start1, angle1],
                    "Should produce a size in order to draw an upper right rounded concave corner, when the radius is bigger than the size, the center should be computed"
                );

                C2 = center2D(A, B, r, false);
                angle2 = angle2D(C2 - A, C2 - B);
                start2 = (90 - angle2) / 2;
                assertTrue(angle2 >= 0 && angle2 <= 90, "The arc angle should be between O° and 90° (convex)");
                assertTrue(start2 >= 0 && start2 <= 90, "The start angle should be between O° and 90° (convex)");
                assertEqual(
                    sizeRoundedCorner(size=s, r=r, p="ne", convex=1),
                    [S, R, C2, 0, start2, angle2],
                    "Should produce a size in order to draw an upper right rounded convex corner, when the radius is bigger than the size, the center should be computed");
            }
            testUnit("compute size of corner with bigger radius and position Nort West", 6) {
                A = [0, s];
                B = [-s, 0];

                C1 = center2D(A, B, r, false);
                angle1 = angle2D(C1 - A, C1 - B);
                start1 = 270 + (90 - angle1) / 2;
                assertTrue(angle1 >= 0 && angle1 <= 90, "The arc angle should be between O° and 90° (concave)");
                assertTrue(start1 >= 270 && start1 <= 360, "The start angle should be between 27O° and 360° (concave)");
                assertEqual(
                    sizeRoundedCorner(size=s, r=r, p="nw"),
                    [S, R, C1, 90, start1, angle1],
                    "Should produce a size in order to draw an upper right rounded concave corner, when the radius is bigger than the size, the center should be computed"
                );

                C2 = center2D(A, B, r, true);
                angle2 = angle2D(C2 - A, C2 - B);
                start2 = 90 + (90 - angle2) / 2;
                assertTrue(angle2 >= 0 && angle2 <= 90, "The arc angle should be between O° and 90° (convex)");
                assertTrue(start2 >= 90 && start2 <= 180, "The start angle should be between 9O° and 180° (convex)");
                assertEqual(
                    sizeRoundedCorner(size=s, r=r, p="nw", convex=1),
                    [S, R, C2, 90, start2, angle2],
                    "Should produce a size in order to draw an upper right rounded convex corner, when the radius is bigger than the size, the center should be computed");
            }
            testUnit("compute size of corner with bigger radius and position South West", 6) {
                A = [0, -s];
                B = [-s, 0];

                C1 = center2D(A, B, r, true);
                angle1 = angle2D(C1 - A, C1 - B);
                start1 = (90 - angle1) / 2;
                assertTrue(angle1 >= 0 && angle1 <= 90, "The arc angle should be between O° and 90° (concave)");
                assertTrue(start1 >= 0 && start1 <= 90, "The start angle should be between O° and 90° (concave)");
                assertApproxEqual(
                    sizeRoundedCorner(size=s, r=r, p="sw"),
                    [S, R, C1, 180, start1, angle1],
                    "Should produce a size in order to draw an upper right rounded concave corner, when the radius is bigger than the size, the center should be computed"
                );

                C2 = center2D(A, B, r, false);
                angle2 = angle2D(C2 - A, C2 - B);
                start2 = 180 + (90 - angle2) / 2;
                assertTrue(angle2 >= 0 && angle2 <= 90, "The arc angle should be between O° and 90° (convex)");
                assertTrue(start2 >= 180 && start2 <= 270, "The start angle should be between 18O° and 270° (convex)");
                assertEqual(
                    sizeRoundedCorner(size=s, r=r, p="sw", convex=1),
                    [S, R, C2, 180, start2, angle2],
                    "Should produce a size in order to draw an upper right rounded convex corner, when the radius is bigger than the size, the center should be computed");
            }
            testUnit("compute size of corner with bigger radius and position South East", 6) {
                A = [0, -s];
                B = [s, 0];

                C1 = center2D(A, B, r, false);
                angle1 = angle2D(C1 - A, C1 - B);
                start1 = 90 + (90 - angle1) / 2;
                assertTrue(angle1 >= 0 && angle1 <= 90, "The arc angle should be between O° and 90° (concave)");
                assertTrue(start1 >= 90 && start1 <= 180, "The start angle should be between 9O° and 180° (concave)");
                assertApproxEqual(
                    sizeRoundedCorner(size=s, r=r, p="se"),
                    [S, R, C1, 270, start1, angle1],
                    "Should produce a size in order to draw an upper right rounded concave corner, when the radius is bigger than the size, the center should be computed"
                );

                C2 = center2D(A, B, r, true);
                angle2 = angle2D(C2 - A, C2 - B);
                start2 = 270 + (90 - angle2) / 2;
                assertTrue(angle2 >= 0 && angle2 <= 90, "The arc angle should be between O° and 90° (convex)");
                assertTrue(start2 >= 270 && start2 <= 360, "The start angle should be between 27O° and 360° (convex)");
                assertEqual(
                    sizeRoundedCorner(size=s, r=r, p="se", convex=1),
                    [S, R, C2, 270, start2, angle2],
                    "Should produce a size in order to draw an upper right rounded convex corner, when the radius is bigger than the size, the center should be computed");
            }
        }
        // test shape/2D/rounded/sizeLinkProfile()
        testModule("sizeLinkProfile()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeLinkProfile(), [[1, 1], [1, 1]], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeLinkProfile("12", "12", "12", "12", "12", "12", "12", "12"), [[1, 1], [1, 1]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeLinkProfile(true, true, true, true, true, true, true, true), [[1, 1], [1, 1]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 23) {
                assertEqual(sizeLinkProfile(3), [[3, 3], [1.5, 1.5]], "Should produce a size from a single size number");
                assertEqual(sizeLinkProfile(bulb=3), [[3, 3], [1.5, 1.5]], "Should produce a size from a the bulb diameter number");
                assertEqual(sizeLinkProfile(neck=3, bulb=2), [[3, 3], [1, 1]], "Should produce the size and the radius from single numbers");
                assertEqual(sizeLinkProfile(neck=[3, 4], bulb=[2, 2]), [[3, 4], [1, 1]], "Should keep the size and adjust the radius if vectors are provided");
                assertEqual(sizeLinkProfile(neck=[3, 4]), [[3, 4], [1.5, 2]], "Should keep the provided size vector and should produce the radius accordingly");

                assertEqual(sizeLinkProfile(neck=[3, 4], w=5), [[5, 4], [2.5, 2]], "Should set the provided width in the provided size vector");
                assertEqual(sizeLinkProfile(neck=[3, 4], h=5), [[3, 5], [1.5, 2.5]], "Should set the provided height in the provided size vector");

                assertEqual(sizeLinkProfile(bulb=[3, 4], rx=5), [[3, 4], [5, 2]], "Should set the provided X radius in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeLinkProfile(bulb=[3, 4], ry=5), [[3, 4], [1.5, 5]], "Should set the provided Y radius in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeLinkProfile(bulb=[3, 4], dx=5), [[3, 4], [2.5, 2]], "Should set the provided X diameter in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeLinkProfile(bulb=[3, 4], dy=5), [[3, 4], [1.5, 2.5]], "Should set the provided Y diameter in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeLinkProfile(bulb=[3, 4], rx=5), [[3, 4], [5, 2]], "Should set the provided X radius in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeLinkProfile(bulb=[3, 4], ry=5), [[3, 4], [1.5, 5]], "Should set the provided Y radius in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeLinkProfile(bulb=[3, 4], dx=5), [[3, 4], [2.5, 2]], "Should set the provided X diameter in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeLinkProfile(bulb=[3, 4], dy=5), [[3, 4], [1.5, 2.5]], "Should set the provided Y diameter in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeLinkProfile(w=3), [[3, 1], [1.5, 1]], "Should set the provided width in the size vector and use the default for the height");
                assertEqual(sizeLinkProfile(h=4), [[1, 4], [1, 2]], "Should set the provided height in the size vector and use the default for the width");
                assertEqual(sizeLinkProfile(w=3, h=4), [[3, 4], [1.5, 2]], "Should set the provided width and height in the size vector");

                assertEqual(sizeLinkProfile(rx=3), [[1, 1], [3, 1]], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizeLinkProfile(ry=4), [[1, 1], [1, 4]], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizeLinkProfile(rx=3, ry=4), [[1, 1], [3, 4]], "Should set the provided radius in the radius vector");

                assertEqual(sizeLinkProfile(h=4, rx=3), [[1, 4], [3, 2]], "Should set the provided height in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizeLinkProfile(w=4, ry=3), [[4, 1], [2, 3]], "Should set the provided width in the size vector and set the provide Y radius in the radius vector");
            }
        }
        // test shape/2D/rounded/drawArch()
        testModule("drawArch()", 5) {
            testUnit("default values", 3) {
                assertEqual(drawArch($fn=3), [ [0.5, 0], _rotP(0, 0.5, 0.5) + [0, 0.5], _rotP(120, 0.5, 0.5) + [0, 0.5], _rotP(180, 0.5, 0.5) + [0, 0.5], [-0.5, 0]], "Should return a list of points to draw an arch with a radius of 1 and 3 facets");
                assertEqual(drawArch($fn=4), concat([[0.5, 0]], [ for (a = [0 : 360/4 : 180]) _rotP(a, 0.5, 0.5) + [0, 0.5] ], [[-0.5, 0]]), "Should return a list of points to draw a 90° arch with a radius of 1 and 4 facets");
                assertEqual(drawArch($fn=6), concat([[0.5, 0]], [ for (a = [0 : 360/6 : 180]) _rotP(a, 0.5, 0.5) + [0, 0.5] ], [[-0.5, 0]]), "Should return a list of points to draw a 90° arch with a radius of 1 and 6 facets");
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
                assertEqual(drawArch([2, 1], $fn=3), [ _rotP(0, 1, 1), _rotP(120, 1, 1), _rotP(180, 1, 1) ], "Should return a list of points to draw a half-ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawArch([3, 1], $fn=4), [ for (a = [0 : 360/4 : 180]) _rotP(a, 1.5, 1) ], "Should return a list of points to draw a half-ellipse with a radius of [1.5, 3] and 4 facets (square)");
                assertEqual(drawArch([4, 1], $fn=6), [ for (a = [0 : 360/6 : 180]) _rotP(a, 2, 1) ], "Should return a list of points to draw a half-ellipse with a radius of [2, 4] and 6 facets (hexagon)");
                assertEqual(drawArch([5, 2], $fa=12, $fs=2), [ for (a = [0 : astep(2.5, $fa=12, $fs=2) : 180]) _rotP(a, 2.5, 2) ], "Should return a list of points to draw a half-ellipse with a radius of [2.5, 5] and 16 facets");

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
        testModule("drawStadium()", 5) {
            testUnit("default values", 3) {
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
                assertEqual(drawStadium([2, 1], $fn=3), [ for (a = [360/3 : 360/3 : 360]) _rotP(a, 1, 0.5) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawStadium([2, 1], $fn=4), [ for (a = [360/4 : 360/4 : 360]) _rotP(a, 1, 0.5) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawStadium([2, 1], $fn=6), [ for (a = [360/6 : 360/6 : 360]) _rotP(a, 1, 0.5) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawStadium([12, 10], $fa=12, $fs=2), [ for (a = [0 : astep(6, $fa=12, $fs=2) : 360]) _rotP(a, 6, 5) ], "Should return a list of points to draw an ellipse with a radius of [5, 6] and 20 facets");

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
        testModule("drawRoundedRectangle()", 4) {
            testUnit("default values", 1) {
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
        // test shape/2D/rounded/drawRoundedCorner()
        testModule("drawRoundedCorner()", 7) {
            s = 20;
            r = 40;
            A = [0, s];
            B = [s, 0];

            testUnit("default values", 3) {
                assertEqual(drawRoundedCorner($fn=3), [ [0, 0], [0, 1], [1, 0] ], "Should return a list of points to draw a rounded corner with a size of 1 and 3 facets (triangle)");
                assertEqual(drawRoundedCorner($fn=4), [ [0, 0], [0, 1], [1, 0] ], "Should return a list of points to draw a rounded corner with a size of 1 and 4 facets (square)");
                assertApproxEqual(drawRoundedCorner($fn=6), [ [0, 0], [0, 1], [0.5, 0.13397], [1, 0] ], "Should return a list of points to draw a rounded corner with a size of 1 and 6 facets (hexagon)");
            }
            testUnit("compute points of a concave corner with default position", 4) {
                assertEqual(drawRoundedCorner(s, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [180 : astep(s, $fa=12, $fs=2) : 270]) _rotP(a, s, s) + [s, s] ], [[s, 0]]), "Should produce a list of points to draw an upper right rounded concave corner");

                C = center2D(A, B, r, true);
                angle = angle2D(C - A, C - B);
                start = 180 + (90 - angle) / 2;
                assertTrue(angle >= 0 && angle <= 90, "The arc angle should be between O° and 90°");
                assertTrue(start >= 180 && start <= 270, "The start angle should be between 18O° and 270°");
                assertEqual(drawRoundedCorner(s, r, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [start : astep(r, $fa=12, $fs=2) : start + angle]) _rotP(a, r, r) + C ], [[s, 0]]), "Should produce a list of points in order to draw an upper right rounded concave corner, when the radius is bigger than the size, the center should be computed");
            }
            testUnit("compute points of a convex corner with default position", 4) {
                assertEqual(drawRoundedCorner(s, convex=1, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [0 : astep(s, $fa=12, $fs=2) : 90]) _rotP(a, s, s) ], [[0, s]]), "Should produce a list of points to draw an upper right rounded convex corner");

                C = center2D(A, B, r, false);
                angle = angle2D(C - A, C - B);
                start = (90 - angle) / 2;
                assertTrue(angle >= 0 && angle <= 90, "The arc angle should be between O° and 90°");
                assertTrue(start >= 0 && start <= 90, "The start angle should be between O° and 90°");
                assertEqual(drawRoundedCorner(s, r, convex=1, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [start : astep(r, $fa=12, $fs=2) : start + angle]) _rotP(a, r, r) + C ], [[0, s]]), "Should produce a list of points in order to draw an upper right rounded convex corner, when the radius is bigger than the size, the center should be computed");
            }
            testUnit("compute points for each position", 8) {
                assertEqual(drawRoundedCorner(s, p="ne", $fa=12, $fs=2), concat([[0, 0]], [ for (a = [180 : astep(s, $fa=12, $fs=2) : 270]) _rotP(a, s, s) + [s, s] ], [[s, 0]]), "Should produce a list of points in order to draw an upper right rounded concave corner");
                assertEqual(drawRoundedCorner(s, p="nw", $fa=12, $fs=2), concat([[0, 0]], [ for (a = [270 : astep(s, $fa=12, $fs=2) : 360]) _rotP(a, s, s) + [-s, s] ], [[0, s]]), "Should produce a list of points in order to draw an upper left rounded concave corner");
                assertEqual(drawRoundedCorner(s, p="sw", $fa=12, $fs=2), concat([[0, 0]], [ for (a = [0 : astep(s, $fa=12, $fs=2) : 90]) _rotP(a, s, s) + [-s, -s] ], [[-s, 0]]), "Should produce a list of points in order to draw a lower left rounded concave corner");
                assertEqual(drawRoundedCorner(s, p="se", $fa=12, $fs=2), concat([[0, 0]], [ for (a = [90 : astep(s, $fa=12, $fs=2) : 180]) _rotP(a, s, s) + [s, -s] ], [[0, -s]]), "Should produce a list of points in order to draw a lower right rounded concave corner");

                assertEqual(drawRoundedCorner(s, p="ne", convex=1, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [0 : astep(s, $fa=12, $fs=2) : 90]) _rotP(a, s, s) ], [[0, s]]), "Should produce a list of points in order to draw an upper right rounded convex corner");
                assertEqual(drawRoundedCorner(s, p="nw", convex=1, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [90 : astep(s, $fa=12, $fs=2) : 180]) _rotP(a, s, s) ], [[-s, 0]]), "Should produce a list of points in order to draw an upper left rounded convex corner");
                assertEqual(drawRoundedCorner(s, p="sw", convex=1, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [180 : astep(s, $fa=12, $fs=2) : 270]) _rotP(a, s, s) ], [[0, -s]]), "Should produce a list of points in order to draw a lower left rounded convex corner");
                assertEqual(drawRoundedCorner(s, p="se", convex=1, $fa=12, $fs=2), concat([[0, 0]], [ for (a = [270 : astep(s, $fa=12, $fs=2) : 360]) _rotP(a, s, s) ], [[s, 0]]), "Should produce a list of points in order to draw a lower right rounded convex corner");
            }
            testUnit("compute points for each position and adjust value", 8) {
                assertEqual(drawRoundedCorner(s, p="ne", adjust=1, $fa=12, $fs=2), concat([[s, -1], [-1, -1], [-1, s]], [ for (a = [180 : astep(s, $fa=12, $fs=2) : 270]) _rotP(a, s, s) + [s, s] ], [[s, 0]]), "Should produce a list of points in order to draw an upper right rounded concave corner");
                assertEqual(drawRoundedCorner(s, p="nw", adjust=1, $fa=12, $fs=2), concat([[1, s], [1, -1], [-s, -1]], [ for (a = [270 : astep(s, $fa=12, $fs=2) : 360]) _rotP(a, s, s) + [-s, s] ], [[0, s]]), "Should produce a list of points in order to draw an upper left rounded concave corner");
                assertEqual(drawRoundedCorner(s, p="sw", adjust=1, $fa=12, $fs=2), concat([[-s, 1], [1, 1], [1, -s]], [ for (a = [0 : astep(s, $fa=12, $fs=2) : 90]) _rotP(a, s, s) + [-s, -s] ], [[-s, 0]]), "Should produce a list of points in order to draw a lower left rounded concave corner");
                assertEqual(drawRoundedCorner(s, p="se", adjust=1, $fa=12, $fs=2), concat([[-1, -s], [-1, 1], [s, 1]], [ for (a = [90 : astep(s, $fa=12, $fs=2) : 180]) _rotP(a, s, s) + [s, -s] ], [[0, -s]]), "Should produce a list of points in order to draw a lower right rounded concave corner");

                assertEqual(drawRoundedCorner(s, p="ne", convex=1, adjust=1, $fa=12, $fs=2), concat([[-1, s], [-1, -1], [s, -1]], [ for (a = [0 : astep(s, $fa=12, $fs=2) : 90]) _rotP(a, s, s) ], [[0, s]]), "Should produce a list of points in order to draw an upper right rounded convex corner");
                assertEqual(drawRoundedCorner(s, p="nw", convex=1, adjust=1, $fa=12, $fs=2), concat([[-s, -1], [1, -1], [1, s]], [ for (a = [90 : astep(s, $fa=12, $fs=2) : 180]) _rotP(a, s, s) ], [[-s, 0]]), "Should produce a list of points in order to draw an upper left rounded convex corner");
                assertEqual(drawRoundedCorner(s, p="sw", convex=1, adjust=1, $fa=12, $fs=2), concat([[1, -s], [1, 1], [-s, 1]], [ for (a = [180 : astep(s, $fa=12, $fs=2) : 270]) _rotP(a, s, s) ], [[0, -s]]), "Should produce a list of points in order to draw a lower left rounded convex corner");
                assertEqual(drawRoundedCorner(s, p="se", convex=1, adjust=1, $fa=12, $fs=2), concat([[s, 1], [-1, 1], [-1, -s]], [ for (a = [270 : astep(s, $fa=12, $fs=2) : 360]) _rotP(a, s, s) ], [[s, 0]]), "Should produce a list of points in order to draw a lower right rounded convex corner");
            }
            testUnit("compute points of corner with bigger radius for each position", 10) {
                C = center2D(A, B, r, true);
                C2 = center2D(A, B, r, false);
                angle = angle2D(C - A, C - B);
                start = (90 - angle) / 2;
                start2 = absdeg(absdeg(round(atan2(-1, -1) - 45)) + 180 + (90 - angle) / 2);
                assertTrue(angle >= 0 && angle <= 90, "The arc angle should be between O° and 90°");
                assertTrue(start2 >= 0 && start2 <= 90, "The start angle should be between O° and 90°");

                assertEqual(drawRoundedCorner(s, r, p="ne", $fa=12, $fs=2), concat([[0, 0]], arc(r=r, o=rotp(C, 0), a1=start + 180, a=angle)), "Should produce a list of points in order to draw an upper right rounded concave corner");
                assertEqual(drawRoundedCorner(s, r, p="nw", $fa=12, $fs=2), concat([[0, 0]], arc(r=r, o=rotp(C, 90), a1=start + 270, a=angle)), "Should produce a list of points in order to draw an upper left rounded concave corner");
                assertEqual(drawRoundedCorner(s, r, p="sw", $fa=12, $fs=2), concat([[0, 0]], arc(r=r, o=rotp(C, 180), a1=start2, a=angle)), "Should produce a list of points in order to draw a lower left rounded concave corner");
                assertEqual(drawRoundedCorner(s, r, p="se", $fa=12, $fs=2), concat([[0, 0]], arc(r=r, o=rotp(C, 270), a1=start2 + 90, a=angle)), "Should produce a list of points in order to draw a lower right rounded concave corner");

                assertEqual(drawRoundedCorner(s, r, p="ne", convex=1, $fa=12, $fs=2), concat([[0, 0]], arc(r=r, o=rotp(C2, 0), a1=start, a=angle)), "Should produce a list of points in order to draw an upper right rounded convex corner");
                assertEqual(drawRoundedCorner(s, r, p="nw", convex=1, $fa=12, $fs=2), concat([[0, 0]], arc(r=r, o=rotp(C2, 90), a1=start + 90, a=angle)), "Should produce a list of points in order to draw an upper left rounded convex corner");
                assertEqual(drawRoundedCorner(s, r, p="sw", convex=1, $fa=12, $fs=2), concat([[0, 0]], arc(r=r, o=rotp(C2, 180), a1=start + 180, a=angle)), "Should produce a list of points in order to draw a lower left rounded convex corner");
                assertEqual(drawRoundedCorner(s, r, p="se", convex=1, $fa=12, $fs=2), concat([[0, 0]], arc(r=r, o=rotp(C2, 270), a1=start + 270, a=angle)), "Should produce a list of points in order to draw a lower right rounded convex corner");
            }
            testUnit("compute points of corner with bigger radius for each position and adjust value", 10) {
                C = center2D(A, B, r, true);
                C2 = center2D(A, B, r, false);
                angle = angle2D(C - A, C - B);
                start = (90 - angle) / 2;
                start2 = absdeg(absdeg(round(atan2(-1, -1) - 45)) + 180 + (90 - angle) / 2);
                assertTrue(angle >= 0 && angle <= 90, "The arc angle should be between O° and 90°");
                assertTrue(start2 >= 0 && start2 <= 90, "The start angle should be between O° and 90°");

                assertEqual(drawRoundedCorner(s, r, p="ne", adjust=1, $fa=12, $fs=2), concat([[s, -1], [-1, -1], [-1, s]], arc(r=r, o=rotp(C, 0), a1=start + 180, a=angle)), "Should produce a list of points in order to draw an upper right rounded concave corner");
                assertEqual(drawRoundedCorner(s, r, p="nw", adjust=1, $fa=12, $fs=2), concat([[1, s], [1, -1], [-s, -1]], arc(r=r, o=rotp(C, 90), a1=start + 270, a=angle)), "Should produce a list of points in order to draw an upper left rounded concave corner");
                assertEqual(drawRoundedCorner(s, r, p="sw", adjust=1, $fa=12, $fs=2), concat([[-s, 1], [1, 1], [1, -s]], arc(r=r, o=rotp(C, 180), a1=start2, a=angle)), "Should produce a list of points in order to draw a lower left rounded concave corner");
                assertEqual(drawRoundedCorner(s, r, p="se", adjust=1, $fa=12, $fs=2), concat([[-1, -s], [-1, 1], [s, 1]], arc(r=r, o=rotp(C, 270), a1=start2 + 90, a=angle)), "Should produce a list of points in order to draw a lower right rounded concave corner");

                assertEqual(drawRoundedCorner(s, r, p="ne", convex=1, adjust=1, $fa=12, $fs=2), concat([[-1, s], [-1, -1], [s, -1]], arc(r=r, o=rotp(C2, 0), a1=start, a=angle)), "Should produce a list of points in order to draw an upper right rounded convex corner");
                assertEqual(drawRoundedCorner(s, r, p="nw", convex=1, adjust=1, $fa=12, $fs=2), concat([[-s, -1], [1, -1], [1, s]], arc(r=r, o=rotp(C2, 90), a1=start + 90, a=angle)), "Should produce a list of points in order to draw an upper left rounded convex corner");
                assertEqual(drawRoundedCorner(s, r, p="sw", convex=1, adjust=1, $fa=12, $fs=2), concat([[1, -s], [1, 1], [-s, 1]], arc(r=r, o=rotp(C2, 180), a1=start + 180, a=angle)), "Should produce a list of points in order to draw a lower left rounded convex corner");
                assertEqual(drawRoundedCorner(s, r, p="se", convex=1, adjust=1, $fa=12, $fs=2), concat([[s, 1], [-1, 1], [-1, -s]], arc(r=r, o=rotp(C2, 270), a1=start + 270, a=angle)), "Should produce a list of points in order to draw a lower right rounded convex corner");
            }
        }
        // test shape/2D/rounded/drawLinkProfile()
        testModule("drawLinkProfile()", 2) {
            testUnit("default values", 1) {
                assertEqual(drawLinkProfile(), path([
                    ["P", ALIGN, 0.5],
                    ["H", -1 - ALIGN],
                    ["C", 1, 0, 180],
                    ["V", -1],
                    ["C", 1, 180, 360],
                    ["H", 1 + ALIGN]
                ]), "Should return a list of points to draw a link with a radius of 1 and a neck of 1");
            }
            testUnit("neck and bulb values", 4) {
                assertEqual(drawLinkProfile(neck=3, bulb=2), path([
                    ["P", ALIGN, 1.5],
                    ["H", -3 - ALIGN],
                    ["C", 1, 0, 180],
                    ["V", -3],
                    ["C", 1, 180, 360],
                    ["H", 3 + ALIGN]
                ]), "Should return a list of points to draw a link with a radius of 2 and a neck of 3");

                assertEqual(drawLinkProfile(neck=3, bulb=2, distance=1), outline(path([
                    ["P", ALIGN, 1.5],
                    ["H", -3 - ALIGN],
                    ["C", 1, 0, 180],
                    ["V", -3],
                    ["C", 1, 180, 360],
                    ["H", 3 + ALIGN]
                ]), 1), "Should return a list of points to draw a link with a radius of 2 and a neck of 3, and an additional outline of 1");

                assertEqual(drawLinkProfile(neck=3, bulb=2, w=4, h=5, rx=2, ry=3), path([
                    ["P", ALIGN, 2.5],
                    ["H", -4 - ALIGN],
                    ["C", [2,3], 0, 180],
                    ["V", -5],
                    ["C", [2,3], 180, 360],
                    ["H", 4 + ALIGN]
                ]), "Should return a list of points to draw a link with a radius of [2,3] and a neck of [4,5]");

                assertEqual(drawLinkProfile(neck=3, bulb=2, distance=1, w=4, h=5, rx=2, ry=3), outline(path([
                    ["P", ALIGN, 2.5],
                    ["H", -4 - ALIGN],
                    ["C", [2,3], 0, 180],
                    ["V", -5],
                    ["C", [2,3], 180, 360],
                    ["H", 4 + ALIGN]
                ]), 1), "Should return a list of points to draw a link with a radius of [2,3] and a neck of [4,5], and an additional outline of 1");
            }
        }
    }
    function _rotP(a, x, y) = [cos(a) * x, sin(a) * y];
}

testShape2dRounded();
