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
 * @package test/shape/3D
 * @author jsconan
 */
module testShape3dRounded() {
    testPackage("shape/3D/rounded.scad", 12) {
        // test shape/3D/rounded/sizeRounded3D()
        testModule("sizeRounded3D()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeRounded3D(), [0, 0, 0], "Should always return a valid vector even if not parameter has been provided");
                assertEqual(sizeRounded3D("12", "12", "12", "12", "12", "12"), [0, 0, 0], "Should always return a valid vector even if wrong parameter has been provided (string)");
                assertEqual(sizeRounded3D(true, true, true, true, true, true), [0, 0, 0], "Should always return a valid vector even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 20) {
                assertEqual(sizeRounded3D(3), [3, 3, 3], "Should produce a radius from a single radius number");
                assertEqual(sizeRounded3D(d=3), [1.5, 1.5, 1.5], "Should produce a radius from a single diameter number");

                assertEqual(sizeRounded3D([2, 3, 4]), [2, 3, 4], "Should keep the the radius if a vector is provided");
                assertEqual(sizeRounded3D(d=[2, 3, 4]), [1, 1.5, 2], "Should adjust the diameter if a vector is provided");

                assertEqual(sizeRounded3D(r=[3, 4, 2], rx=5), [5, 4, 2], "Should set the provided X radius in the provided radius vector");
                assertEqual(sizeRounded3D(r=[3, 4, 2], ry=5), [3, 5, 2], "Should set the provided Y radius in the provided radius vector");
                assertEqual(sizeRounded3D(r=[3, 4, 2], rz=5), [3, 4, 5], "Should set the provided Z radius in the provided radius vector");

                assertEqual(sizeRounded3D(r=[3, 4, 2], dx=5), [2.5, 4, 2], "Should set the provided X diameter in the provided radius vector");
                assertEqual(sizeRounded3D(r=[3, 4, 2], dy=5), [3, 2.5, 2], "Should set the provided Y diameter in the provided radius vector");
                assertEqual(sizeRounded3D(r=[3, 4, 2], dz=5), [3, 4, 2.5], "Should set the provided Z diameter in the provided radius vector");

                assertEqual(sizeRounded3D(d=[3, 4, 2], rx=5), [5, 2, 1], "Should set the provided X radius in the provided diameter vector");
                assertEqual(sizeRounded3D(d=[3, 4, 2], ry=5), [1.5, 5, 1], "Should set the provided Y radius in the provided diameter vector");
                assertEqual(sizeRounded3D(d=[3, 4, 2], rz=5), [1.5, 2, 5], "Should set the provided Z radius in the provided diameter vector");

                assertEqual(sizeRounded3D(d=[3, 4, 2], dx=5), [2.5, 2, 1], "Should set the provided X diameter in the provided diameter vector");
                assertEqual(sizeRounded3D(d=[3, 4, 2], dy=5), [1.5, 2.5, 1], "Should set the provided Y diameter in the provided diameter vector");
                assertEqual(sizeRounded3D(d=[3, 4, 2], dz=5), [1.5, 2, 2.5], "Should set the provided Z diameter in the provided diameter vector");

                assertEqual(sizeRounded3D(rx=3), [3, 0, 0], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizeRounded3D(ry=4), [0, 4, 0], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizeRounded3D(rz=2), [0, 0, 2], "Should set the provided Z radius in the radius vector and use the default for the X radius");
                assertEqual(sizeRounded3D(rx=3, ry=4, rz=2), [3, 4, 2], "Should set the provided radius in the radius vector");
            }
        }
        // test shape/3D/rounded/sizeArchBox()
        testModule("sizeArchBox()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeArchBox(), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeArchBox("12", "12", "12", "12", "12", "12"), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeArchBox(true, true, true, true, true, true), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 31) {
                assertEqual(sizeArchBox(3), [[3, 3, 3], [1.5, 1.5]], "Should produce a size from a single size number in order to draw a half-circle");
                assertEqual(sizeArchBox(r=3), [[6, 3, 1], [3, 3]], "Should produce a size from a single radius number in order to draw a half-circle");
                assertEqual(sizeArchBox(d=3), [[3, 1.5, 1], [1.5, 1.5]], "Should produce a size from a single diameter number in order to draw a half-circle");

                assertEqual(sizeArchBox(3, 2), [[3, 3, 3], [1.5, 2]], "Should produce the size and the radius from single number size and radius");
                assertEqual(sizeArchBox(3, d=2), [[3, 3, 3], [1.5, 1]], "Should produce the size and the radius from single number size and diameter");

                assertEqual(sizeArchBox([3, 4, 5], [2, 2]), [[3, 4, 5], [1.5, 2]], "Should keep the size and adjust the radius if vectors are provided");
                assertEqual(sizeArchBox([3, 4, 5], d=[2, 2]), [[3, 4, 5], [1.5, 1]], "Should keep the size and adjust the diameter if vectors are provided");
                assertEqual(sizeArchBox([3, 4, 5], d=[6, 8]), [[3, 4, 5], [1.5, 4]], "Should keep the size and adjust the diameter if vectors are provided");

                assertEqual(sizeArchBox([3, 4, 5]), [[3, 4, 5], [1.5, 1.5]], "Should keep the provided size vector and should produce the radius accordingly");
                assertEqual(sizeArchBox(r=[3, 4]), [[6, 4, 1], [3, 4]], "Should keep the provided radius vector and should produce the size accordingly");
                assertEqual(sizeArchBox(d=[3, 4]), [[3, 2, 1], [1.5, 2]], "Should translate the provided diameter vector to a radius vector and should produce the size accordingly");

                assertEqual(sizeArchBox([3, 4, 2], l=5), [[5, 4, 2], [2.5, 2.5]], "Should set the provided length in the provided size vector");
                assertEqual(sizeArchBox([3, 4, 2], w=5), [[3, 5, 2], [1.5, 1.5]], "Should set the provided width in the provided size vector");
                assertEqual(sizeArchBox([3, 4, 2], h=5), [[3, 4, 5], [1.5, 1.5]], "Should set the provided height in the provided size vector");

                assertEqual(sizeArchBox(r=[3, 4], rx=5), [[10, 4, 1], [5, 4]], "Should set the provided X radius in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeArchBox(r=[3, 4], ry=5), [[6, 5, 1], [3, 5]], "Should set the provided Y radius in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeArchBox(r=[3, 4], dx=5), [[5, 4, 1], [2.5, 4]], "Should set the provided X diameter in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeArchBox(r=[3, 4], dy=5), [[6, 2.5, 1], [3, 2.5]], "Should set the provided Y diameter in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeArchBox(d=[3, 4], rx=5), [[10, 2, 1], [5, 2]], "Should set the provided X radius in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeArchBox(d=[3, 4], ry=5), [[3, 5, 1], [1.5, 5]], "Should set the provided Y radius in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeArchBox(d=[3, 4], dx=5), [[5, 2, 1], [2.5, 2]], "Should set the provided X diameter in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeArchBox(d=[3, 4], dy=5), [[3, 2.5, 1], [1.5, 2.5]], "Should set the provided Y diameter in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeArchBox(l=3), [[3, 1, 1], [1.5, 1]], "Should set the provided length in the size vector and use the default for the height");
                assertEqual(sizeArchBox(w=4), [[1, 4, 1], [0.5, 0.5]], "Should set the provided width in the size vector and use the default for the width");
                assertEqual(sizeArchBox(h=2), [[1, 1, 2], [0.5, 0.5]], "Should set the provided height in the size vector and use the default for the width");
                assertEqual(sizeArchBox(l=3, w=4, h=2), [[3, 4, 2], [1.5, 1.5]], "Should set the provided length, width and height in the size vector");

                assertEqual(sizeArchBox(rx=3), [[6, 1, 1], [3, 1]], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizeArchBox(ry=4), [[1, 4, 1], [0.5, 4]], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizeArchBox(rx=3, ry=4), [[6, 4, 1], [3, 4]], "Should set the provided radius in the radius vector");

                assertEqual(sizeArchBox(w=4, rx=3), [[6, 4, 1], [3, 3]], "Should set the provided width in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizeArchBox(l=4, ry=3), [[4, 3, 1], [2, 3]], "Should set the provided length in the size vector and set the provide Y radius in the radius vector");
            }
        }
        // test shape/3D/rounded/sizeSlot()
        testModule("sizeSlot()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeSlot(), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeSlot("12", "12", "12", "12", "12", "12"), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeSlot(true, true, true, true, true, true), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 32) {
                assertEqual(sizeSlot(3), [[3, 3, 3], [1.5, 1.5]], "Should produce a size from a single size number in order to draw a circle");
                assertEqual(sizeSlot(r=3), [[6, 6, 1], [3, 3]], "Should produce a size from a single radius number in order to draw a circle");
                assertEqual(sizeSlot(d=3), [[3, 3, 1], [1.5, 1.5]], "Should produce a size from a single diameter number in order to draw a circle");

                assertEqual(sizeSlot(3, 2), [[3, 3, 3], [1.5, 1.5]], "Should produce the size and the radius from single number size and radius");
                assertEqual(sizeSlot(3, d=2), [[3, 3, 3], [1.5, 1]], "Should produce the size and the radius from single number size and diameter");

                assertEqual(sizeSlot([3, 4, 2], [2, 2]), [[3, 4, 2], [1.5, 2]], "Should keep the size and adjust the radius if vectors are provided");
                assertEqual(sizeSlot([3, 4, 2], d=[2, 2]), [[3, 4, 2], [1.5, 1]], "Should keep the size and adjust the diameter if vectors are provided");
                assertEqual(sizeSlot([3, 4, 2], d=[8, 10]), [[3, 4, 2], [1.5, 2]], "Should keep the size and adjust the diameter if vectors are provided");

                assertEqual(sizeSlot([3, 4, 2]), [[3, 4, 2], [1.5, 1.5]], "Should keep the provided size vector and should produce the radius accordingly");
                assertEqual(sizeSlot(r=[3, 4]), [[6, 8, 1], [3, 4]], "Should keep the provided radius vector and should produce the size accordingly");
                assertEqual(sizeSlot(d=[3, 4]), [[3, 4, 1], [1.5, 2]], "Should translate the provided diameter vector to a radius vector and should produce the size accordingly");

                assertEqual(sizeSlot([3, 4, 2], l=5), [[5, 4, 2], [2.5, 2]], "Should set the provided length in the provided size vector");
                assertEqual(sizeSlot([3, 4, 2], w=5), [[3, 5, 2], [1.5, 1.5]], "Should set the provided width in the provided size vector");
                assertEqual(sizeSlot([3, 4, 2], h=5), [[3, 4, 5], [1.5, 1.5]], "Should set the provided height in the provided size vector");

                assertEqual(sizeSlot(r=[3, 4], rx=5), [[10, 8, 1], [5, 4]], "Should set the provided X radius in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeSlot(r=[3, 4], ry=5), [[6, 10, 1], [3, 5]], "Should set the provided Y radius in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeSlot(r=[3, 4], dx=5), [[5, 8, 1], [2.5, 4]], "Should set the provided X diameter in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeSlot(r=[3, 4], dy=5), [[6, 5, 1], [3, 2.5]], "Should set the provided Y diameter in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeSlot(d=[3, 4], rx=5), [[10, 4, 1], [5, 2]], "Should set the provided X radius in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeSlot(d=[3, 4], ry=5), [[3, 10, 1], [1.5, 5]], "Should set the provided Y radius in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeSlot(d=[3, 4], dx=5), [[5, 4, 1], [2.5, 2]], "Should set the provided X diameter in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeSlot(d=[3, 4], dy=5), [[3, 5, 1], [1.5, 2.5]], "Should set the provided Y diameter in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeSlot(l=3), [[3, 1, 1], [1.5, 0.5]], "Should set the provided length in the size vector and use the default for the height");
                assertEqual(sizeSlot(w=4), [[1, 4, 1], [0.5, 0.5]], "Should set the provided width in the size vector and use the default for the width");
                assertEqual(sizeSlot(h=2), [[1, 1, 2], [0.5, 0.5]], "Should set the provided height in the size vector and use the default for the width");
                assertEqual(sizeSlot(l=3, w=4, h=2), [[3, 4, 2], [1.5, 1.5]], "Should set the provided length, width and height in the size vector");

                assertEqual(sizeSlot(rx=3), [[6, 1, 1], [3, 0.5]], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizeSlot(ry=4), [[1, 8, 1], [0.5, 4]], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizeSlot(rx=3, ry=4), [[6, 8, 1], [3, 4]], "Should set the provided radius in the radius vector");

                assertEqual(sizeSlot(l=4, rx=3), [[4, 1, 1], [2, 0.5]], "Should set the provided length in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizeSlot(w=4, ry=3), [[1, 4, 1], [0.5, 2]], "Should set the provided width in the size vector and set the provide Y radius in the radius vector");
                assertEqual(sizeSlot(h=4, ry=3), [[1, 6, 4], [0.5, 3]], "Should set the provided height in the size vector and set the provide Y radius in the radius vector");
            }
        }
        // test shape/3D/rounded/sizeCushion()
        testModule("sizeCushion()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeCushion(), [[1, 1, 1], [0, 0]], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeCushion("12", "12", "12", "12", "12", "12"), [[1, 1, 1], [0, 0]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeCushion(true, true, true, true, true, true), [[1, 1, 1], [0, 0]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 32) {
                assertEqual(sizeCushion(3), [[3, 3, 3], [0, 0]], "Should produce a size from a single size number in order to draw a rectangle");
                assertEqual(sizeCushion(r=3), [[6, 6, 1], [3, 3]], "Should produce a size from a single radius number in order to draw a circle");
                assertEqual(sizeCushion(d=3), [[3, 3, 1], [1.5, 1.5]], "Should produce a size from a single diameter number in order to draw a circle");

                assertEqual(sizeCushion(3, 2), [[3, 3, 3], [1.5, 1.5]], "Should produce the size and the radius from single number size and radius");
                assertEqual(sizeCushion(3, d=2), [[3, 3, 3], [1, 1]], "Should produce the size and the radius from single number size and diameter");

                assertEqual(sizeCushion([3, 4, 2], [2, 2]), [[3, 4, 2], [1.5, 2]], "Should keep the size and adjust the radius if vectors are provided");
                assertEqual(sizeCushion([3, 4, 2], d=[2, 2]), [[3, 4, 2], [1, 1]], "Should keep the size and adjust the diameter if vectors are provided");
                assertEqual(sizeCushion([3, 4, 2], d=[8, 10]), [[3, 4, 2], [1.5, 2]], "Should keep the size and adjust the diameter if vectors are provided");

                assertEqual(sizeCushion([3, 4, 2]), [[3, 4, 2], [0, 0]], "Should keep the provided size vector and should produce the radius accordingly");
                assertEqual(sizeCushion(r=[3, 4]), [[6, 8, 1], [3, 4]], "Should keep the provided radius vector and should produce the size accordingly");
                assertEqual(sizeCushion(d=[3, 4]), [[3, 4, 1], [1.5, 2]], "Should translate the provided diameter vector to a radius vector and should produce the size accordingly");

                assertEqual(sizeCushion([3, 4, 2], l=5), [[5, 4, 2], [0, 0]], "Should set the provided length in the provided size vector");
                assertEqual(sizeCushion([3, 4, 2], w=5), [[3, 5, 2], [0, 0]], "Should set the provided width in the provided size vector");
                assertEqual(sizeCushion([3, 4, 2], h=5), [[3, 4, 5], [0, 0]], "Should set the provided height in the provided size vector");

                assertEqual(sizeCushion(r=[3, 4], rx=5), [[10, 8, 1], [5, 4]], "Should set the provided X radius in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeCushion(r=[3, 4], ry=5), [[6, 10, 1], [3, 5]], "Should set the provided Y radius in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeCushion(r=[3, 4], dx=5), [[5, 8, 1], [2.5, 4]], "Should set the provided X diameter in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeCushion(r=[3, 4], dy=5), [[6, 5, 1], [3, 2.5]], "Should set the provided Y diameter in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeCushion(d=[3, 4], rx=5), [[10, 4, 1], [5, 2]], "Should set the provided X radius in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeCushion(d=[3, 4], ry=5), [[3, 10, 1], [1.5, 5]], "Should set the provided Y radius in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeCushion(d=[3, 4], dx=5), [[5, 4, 1], [2.5, 2]], "Should set the provided X diameter in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeCushion(d=[3, 4], dy=5), [[3, 5, 1], [1.5, 2.5]], "Should set the provided Y diameter in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeCushion(l=4), [[4, 1, 1], [0, 0]], "Should set the provided length in the size vector and use the default for the height");
                assertEqual(sizeCushion(w=4), [[1, 4, 1], [0, 0]], "Should set the provided width in the size vector and use the default for the width");
                assertEqual(sizeCushion(h=4), [[1, 1, 4], [0, 0]], "Should set the provided height in the size vector and use the default for the width");
                assertEqual(sizeCushion(l=4, w=3, h=2), [[4, 3, 2], [0, 0]], "Should set the provided length, width and height in the size vector");

                assertEqual(sizeCushion(rx=3), [[6, 1, 1], [0, 0]], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizeCushion(ry=4), [[1, 8, 1], [0, 0]], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizeCushion(rx=3, ry=4), [[6, 8, 1], [3, 4]], "Should set the provided radius in the radius vector");

                assertEqual(sizeCushion(h=4, rx=3), [[6, 1, 4], [0, 0]], "Should set the provided height in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizeCushion(w=4, rx=3), [[6, 4, 1], [0, 0]], "Should set the provided width in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizeCushion(l=4, ry=3), [[4, 6, 1], [0, 0]], "Should set the provided length in the size vector and set the provide Y radius in the radius vector");
            }
        }
        // test shape/3D/rounded/sizeBullet()
        testModule("sizeBullet()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizeBullet(), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if not parameter has been provided");
                assertEqual(sizeBullet("12", "12", "12", "12", "12", "12"), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizeBullet(true, true, true, true, true, true), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 31) {
                assertEqual(sizeBullet(3), [[3, 3, 3], [1.5, 1.5]], "Should produce a size from a single size number in order to draw a half-circle");
                assertEqual(sizeBullet(r=3), [[6, 6, 3], [3, 3]], "Should produce a size from a single radius number in order to draw a half-circle");
                assertEqual(sizeBullet(d=3), [[3, 3, 1.5], [1.5, 1.5]], "Should produce a size from a single diameter number in order to draw a half-circle");

                assertEqual(sizeBullet(3, 2), [[3, 3, 3], [1.5, 2]], "Should produce the size and the radius from single number size and radius");
                assertEqual(sizeBullet(3, d=2), [[3, 3, 3], [1.5, 1]], "Should produce the size and the radius from single number size and diameter");

                assertEqual(sizeBullet([3, 4, 5], [2, 2]), [[3, 4, 5], [2, 2]], "Should keep the size and adjust the radius if vectors are provided");
                assertEqual(sizeBullet([3, 4, 5], d=[2, 2]), [[3, 4, 5], [2, 1]], "Should keep the size and adjust the diameter if vectors are provided");
                assertEqual(sizeBullet([3, 4, 5], d=[8, 8]), [[3, 4, 5], [2, 4]], "Should keep the size and adjust the diameter if vectors are provided");

                assertEqual(sizeBullet([3, 4, 5]), [[3, 4, 5], [2, 2]], "Should keep the provided size vector and should produce the radius accordingly");
                assertEqual(sizeBullet(r=[3, 4]), [[6, 6, 4], [3, 4]], "Should keep the provided radius vector and should produce the size accordingly");
                assertEqual(sizeBullet(d=[3, 4]), [[3, 3, 2], [1.5, 2]], "Should translate the provided diameter vector to a radius vector and should produce the size accordingly");

                assertEqual(sizeBullet([3, 4, 2], l=5), [[5, 4, 2], [2.5, 2]], "Should set the provided length in the provided size vector");
                assertEqual(sizeBullet([3, 4, 2], w=5), [[3, 5, 2], [2.5, 2]], "Should set the provided width in the provided size vector");
                assertEqual(sizeBullet([3, 4, 2], h=5), [[3, 4, 5], [2, 2]], "Should set the provided height in the provided size vector");

                assertEqual(sizeBullet(r=[3, 4], rx=5), [[10, 10, 4], [5, 4]], "Should set the provided X radius in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeBullet(r=[3, 4], ry=5), [[6, 6, 5], [3, 5]], "Should set the provided Y radius in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeBullet(r=[3, 4], dx=5), [[5, 5, 4], [2.5, 4]], "Should set the provided X diameter in the provided radius vector and should produce the size accordingly");
                assertEqual(sizeBullet(r=[3, 4], dy=5), [[6, 6, 2.5], [3, 2.5]], "Should set the provided Y diameter in the provided radius vector and should produce the size accordingly");

                assertEqual(sizeBullet(d=[3, 4], rx=5), [[10, 10, 2], [5, 2]], "Should set the provided X radius in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeBullet(d=[3, 4], ry=5), [[3, 3, 5], [1.5, 5]], "Should set the provided Y radius in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeBullet(d=[3, 4], dx=5), [[5, 5, 2], [2.5, 2]], "Should set the provided X diameter in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizeBullet(d=[3, 4], dy=5), [[3, 3, 2.5], [1.5, 2.5]], "Should set the provided Y diameter in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizeBullet(l=3), [[3, 1, 1], [1.5, 1]], "Should set the provided length in the size vector and use the default for the height");
                assertEqual(sizeBullet(w=4), [[1, 4, 1], [2, 1]], "Should set the provided width in the size vector and use the default for the width");
                assertEqual(sizeBullet(h=2), [[1, 1, 2], [0.5, 0.5]], "Should set the provided height in the size vector and use the default for the width");
                assertEqual(sizeBullet(l=3, w=4, h=2), [[3, 4, 2], [2, 2]], "Should set the provided length, width and height in the size vector");

                assertEqual(sizeBullet(rx=3), [[6, 6, 1], [3, 1]], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizeBullet(ry=4), [[1, 1, 4], [0.5, 4]], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizeBullet(rx=3, ry=4), [[6, 6, 4], [3, 4]], "Should set the provided radius in the radius vector");

                assertEqual(sizeBullet(w=4, rx=3), [[6, 4, 1], [3, 1]], "Should set the provided width in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizeBullet(l=4, ry=3), [[4, 1, 3], [2, 3]], "Should set the provided length in the size vector and set the provide Y radius in the radius vector");
            }
        }
        // test shape/3D/rounded/sizePill()
        testModule("sizePill()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizePill(), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if not parameter has been provided");
                assertEqual(sizePill("12", "12", "12", "12", "12", "12"), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizePill(true, true, true, true, true, true), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 30) {
                assertEqual(sizePill(3), [[3, 3, 3], [1.5, 1.5]], "Should produce a size from a single size number in order to draw a circle");
                assertEqual(sizePill(r=3), [[6, 6, 6], [3, 3]], "Should produce a size from a single radius number in order to draw a circle");
                assertEqual(sizePill(d=3), [[3, 3, 3], [1.5, 1.5]], "Should produce a size from a single diameter number in order to draw a circle");

                assertEqual(sizePill(3, 2), [[3, 3, 3], [1.5, 1.5]], "Should produce the size and the radius from single number size and radius");
                assertEqual(sizePill(3, d=2), [[3, 3, 3], [1.5, 1]], "Should produce the size and the radius from single number size and diameter");

                assertEqual(sizePill([3, 4, 2], [2, 2]), [[3, 4, 2], [2, 1]], "Should keep the size and adjust the radius if vectors are provided");
                assertEqual(sizePill([3, 4, 2], d=[2, 2]), [[3, 4, 2], [2, 1]], "Should keep the size and adjust the diameter if vectors are provided");
                assertEqual(sizePill([3, 4, 2], d=[8, 10]), [[3, 4, 2], [2, 1]], "Should keep the size and adjust the diameter if vectors are provided");

                assertEqual(sizePill([3, 4, 2]), [[3, 4, 2], [2, 1]], "Should keep the provided size vector and should produce the radius accordingly");
                assertEqual(sizePill(r=[3, 4]), [[6, 6, 8], [3, 4]], "Should keep the provided radius vector and should produce the size accordingly");
                assertEqual(sizePill(d=[3, 4]), [[3, 3, 4], [1.5, 2]], "Should translate the provided diameter vector to a radius vector and should produce the size accordingly");

                assertEqual(sizePill([3, 4, 2], l=5), [[5, 4, 2], [2.5, 1]], "Should set the provided length in the provided size vector");
                assertEqual(sizePill([3, 4, 2], w=5), [[3, 5, 2], [2.5, 1]], "Should set the provided width in the provided size vector");
                assertEqual(sizePill([3, 4, 2], h=5), [[3, 4, 5], [2, 2]], "Should set the provided height in the provided size vector");

                assertEqual(sizePill(r=[3, 4], rx=5), [[10, 10, 8], [5, 4]], "Should set the provided X radius in the provided radius vector and should produce the size accordingly");
                assertEqual(sizePill(r=[3, 4], ry=5), [[6, 6, 10], [3, 5]], "Should set the provided Y radius in the provided radius vector and should produce the size accordingly");

                assertEqual(sizePill(r=[3, 4], dx=5), [[5, 5, 8], [2.5, 4]], "Should set the provided X diameter in the provided radius vector and should produce the size accordingly");
                assertEqual(sizePill(r=[3, 4], dy=5), [[6, 6, 5], [3, 2.5]], "Should set the provided Y diameter in the provided radius vector and should produce the size accordingly");

                assertEqual(sizePill(d=[3, 4], rx=5), [[10, 10, 4], [5, 2]], "Should set the provided X radius in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizePill(d=[3, 4], ry=5), [[3, 3, 10], [1.5, 5]], "Should set the provided Y radius in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizePill(d=[3, 4], dx=5), [[5, 5, 4], [2.5, 2]], "Should set the provided X diameter in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizePill(d=[3, 4], dy=5), [[3, 3, 5], [1.5, 2.5]], "Should set the provided Y diameter in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizePill(l=3), [[3, 1, 1], [1.5, 0.5]], "Should set the provided length in the size vector and use the default for the height");
                assertEqual(sizePill(w=4), [[1, 4, 1], [2, 0.5]], "Should set the provided width in the size vector and use the default for the width");
                assertEqual(sizePill(h=2), [[1, 1, 2], [0.5, 0.5]], "Should set the provided height in the size vector and use the default for the width");
                assertEqual(sizePill(l=3, w=4, h=2), [[3, 4, 2], [2, 1]], "Should set the provided length, width and height in the size vector");

                assertEqual(sizePill(rx=3), [[6, 6, 1], [3, 0.5]], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizePill(ry=4), [[1, 1, 8], [0.5, 4]], "Should set the provided Y radius in the radius vector and use the default for the X radius");

                assertEqual(sizePill(l=4, rx=3), [[4, 6, 1], [3, 0.5]], "Should set the provided length in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizePill(w=4, ry=3), [[1, 4, 6], [2, 3]], "Should set the provided width in the size vector and set the provide Y radius in the radius vector");
            }
        }
        // test shape/3D/rounded/sizePeg()
        testModule("sizePeg()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizePeg(), [[1, 1, 1], [0, 0]], "Should always return a size even if not parameter has been provided");
                assertEqual(sizePeg("12", "12", "12", "12", "12", "12"), [[1, 1, 1], [0, 0]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizePeg(true, true, true, true, true, true), [[1, 1, 1], [0, 0]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 32) {
                assertEqual(sizePeg(3), [[3, 3, 3], [0, 0]], "Should produce a size from a single size number in order to draw a rectangle");
                assertEqual(sizePeg(r=3), [[6, 6, 6], [3, 3]], "Should produce a size from a single radius number in order to draw a circle");
                assertEqual(sizePeg(d=3), [[3, 3, 3], [1.5, 1.5]], "Should produce a size from a single diameter number in order to draw a circle");

                assertEqual(sizePeg(3, 2), [[3, 3, 3], [1.5, 1.5]], "Should produce the size and the radius from single number size and radius");
                assertEqual(sizePeg(3, d=2), [[3, 3, 3], [1, 1]], "Should produce the size and the radius from single number size and diameter");

                assertEqual(sizePeg([3, 4, 2], [2, 2]), [[3, 4, 2], [2, 1]], "Should keep the size and adjust the radius if vectors are provided");
                assertEqual(sizePeg([3, 4, 2], d=[2, 2]), [[3, 4, 2], [1, 1]], "Should keep the size and adjust the diameter if vectors are provided");
                assertEqual(sizePeg([3, 4, 2], d=[8, 10]), [[3, 4, 2], [2, 1]], "Should keep the size and adjust the diameter if vectors are provided");

                assertEqual(sizePeg([3, 4, 2]), [[3, 4, 2], [0, 0]], "Should keep the provided size vector and should produce the radius accordingly");
                assertEqual(sizePeg(r=[3, 4]), [[6, 6, 8], [3, 4]], "Should keep the provided radius vector and should produce the size accordingly");
                assertEqual(sizePeg(d=[3, 4]), [[3, 3, 4], [1.5, 2]], "Should translate the provided diameter vector to a radius vector and should produce the size accordingly");

                assertEqual(sizePeg([3, 4, 2], l=5), [[5, 4, 2], [0, 0]], "Should set the provided length in the provided size vector");
                assertEqual(sizePeg([3, 4, 2], w=5), [[3, 5, 2], [0, 0]], "Should set the provided width in the provided size vector");
                assertEqual(sizePeg([3, 4, 2], h=5), [[3, 4, 5], [0, 0]], "Should set the provided height in the provided size vector");

                assertEqual(sizePeg(r=[3, 4], rx=5), [[10, 10, 8], [5, 4]], "Should set the provided X radius in the provided radius vector and should produce the size accordingly");
                assertEqual(sizePeg(r=[3, 4], ry=5), [[6, 6, 10], [3, 5]], "Should set the provided Y radius in the provided radius vector and should produce the size accordingly");

                assertEqual(sizePeg(r=[3, 4], dx=5), [[5, 5, 8], [2.5, 4]], "Should set the provided X diameter in the provided radius vector and should produce the size accordingly");
                assertEqual(sizePeg(r=[3, 4], dy=5), [[6, 6, 5], [3, 2.5]], "Should set the provided Y diameter in the provided radius vector and should produce the size accordingly");

                assertEqual(sizePeg(d=[3, 4], rx=5), [[10, 10, 4], [5, 2]], "Should set the provided X radius in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizePeg(d=[3, 4], ry=5), [[3, 3, 10], [1.5, 5]], "Should set the provided Y radius in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizePeg(d=[3, 4], dx=5), [[5, 5, 4], [2.5, 2]], "Should set the provided X diameter in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizePeg(d=[3, 4], dy=5), [[3, 3, 5], [1.5, 2.5]], "Should set the provided Y diameter in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizePeg(l=4), [[4, 1, 1], [0, 0]], "Should set the provided length in the size vector and use the default for the height");
                assertEqual(sizePeg(w=4), [[1, 4, 1], [0, 0]], "Should set the provided width in the size vector and use the default for the width");
                assertEqual(sizePeg(h=4), [[1, 1, 4], [0, 0]], "Should set the provided height in the size vector and use the default for the width");
                assertEqual(sizePeg(l=4, w=3, h=2), [[4, 3, 2], [0, 0]], "Should set the provided length, width and height in the size vector");

                assertEqual(sizePeg(rx=3), [[6, 6, 1], [0, 0]], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizePeg(ry=4), [[1, 1, 8], [0, 0]], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizePeg(rx=3, ry=4), [[6, 6, 8], [3, 4]], "Should set the provided radius in the radius vector");

                assertEqual(sizePeg(h=4, rx=3), [[6, 6, 4], [0, 0]], "Should set the provided height in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizePeg(w=4, rx=3), [[6, 4, 1], [0, 0]], "Should set the provided width in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizePeg(l=4, ry=3), [[4, 1, 6], [0, 0]], "Should set the provided length in the size vector and set the provide Y radius in the radius vector");
            }
        }
        // test shape/3D/rounded/sizePlate()
        testModule("sizePlate()", 2) {
            testUnit("default values", 3) {
                assertEqual(sizePlate(), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if not parameter has been provided");
                assertEqual(sizePlate("12", "12", "12", "12", "12", "12"), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (string)");
                assertEqual(sizePlate(true, true, true, true, true, true), [[1, 1, 1], [0.5, 0.5]], "Should always return a size even if wrong parameter has been provided (boolean)");
            }
            testUnit("compute size", 31) {
                assertEqual(sizePlate(3), [[3, 3, 3], [1.5, 1.5]], "Should produce a size from a single size number in order to draw a circle");
                assertEqual(sizePlate(r=3), [[6, 6, 6], [3, 3]], "Should produce a size from a single radius number in order to draw a circle");
                assertEqual(sizePlate(d=3), [[3, 3, 3], [1.5, 1.5]], "Should produce a size from a single diameter number in order to draw a circle");

                assertEqual(sizePlate(3, 2), [[3, 3, 3], [1.5, 1.5]], "Should produce the size and the radius from single number size and radius");
                assertEqual(sizePlate(3, d=2), [[3, 3, 3], [1, 1.5]], "Should produce the size and the radius from single number size and diameter");

                assertEqual(sizePlate([3, 4, 2], [2, 2]), [[3, 4, 2], [2, 1]], "Should keep the size and adjust the radius if vectors are provided");
                assertEqual(sizePlate([3, 4, 2], d=[2, 2]), [[3, 4, 2], [1, 1]], "Should keep the size and adjust the diameter if vectors are provided");
                assertEqual(sizePlate([3, 4, 2], d=[8, 10]), [[3, 4, 2], [2, 1]], "Should keep the size and adjust the diameter if vectors are provided");

                assertEqual(sizePlate([3, 4, 2]), [[3, 4, 2], [1, 1]], "Should keep the provided size vector and should produce the radius accordingly");
                assertEqual(sizePlate(r=[3, 4]), [[6, 6, 8], [3, 4]], "Should keep the provided radius vector and should produce the size accordingly");
                assertEqual(sizePlate(d=[3, 4]), [[3, 3, 4], [1.5, 2]], "Should translate the provided diameter vector to a radius vector and should produce the size accordingly");

                assertEqual(sizePlate([3, 4, 2], l=5), [[5, 4, 2], [1, 1]], "Should set the provided length in the provided size vector");
                assertEqual(sizePlate([3, 4, 2], w=5), [[3, 5, 2], [1, 1]], "Should set the provided width in the provided size vector");
                assertEqual(sizePlate([3, 4, 2], h=5), [[3, 4, 5], [2, 2.5]], "Should set the provided height in the provided size vector");

                assertEqual(sizePlate(r=[3, 4], rx=5), [[10, 10, 8], [5, 4]], "Should set the provided X radius in the provided radius vector and should produce the size accordingly");
                assertEqual(sizePlate(r=[3, 4], ry=5), [[6, 6, 10], [3, 5]], "Should set the provided Y radius in the provided radius vector and should produce the size accordingly");

                assertEqual(sizePlate(r=[3, 4], dx=5), [[5, 5, 8], [2.5, 4]], "Should set the provided X diameter in the provided radius vector and should produce the size accordingly");
                assertEqual(sizePlate(r=[3, 4], dy=5), [[6, 6, 5], [3, 2.5]], "Should set the provided Y diameter in the provided radius vector and should produce the size accordingly");

                assertEqual(sizePlate(d=[3, 4], rx=5), [[10, 10, 4], [5, 2]], "Should set the provided X radius in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizePlate(d=[3, 4], ry=5), [[3, 3, 10], [1.5, 5]], "Should set the provided Y radius in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizePlate(d=[3, 4], dx=5), [[5, 5, 4], [2.5, 2]], "Should set the provided X diameter in the provided diameter vector and should produce the size accordingly");
                assertEqual(sizePlate(d=[3, 4], dy=5), [[3, 3, 5], [1.5, 2.5]], "Should set the provided Y diameter in the provided diameter vector and should produce the size accordingly");

                assertEqual(sizePlate(l=3), [[3, 1, 1], [0.5, 0.5]], "Should set the provided length in the size vector and use the default for the height");
                assertEqual(sizePlate(w=4), [[1, 4, 1], [0.5, 0.5]], "Should set the provided width in the size vector and use the default for the width");
                assertEqual(sizePlate(h=2), [[1, 1, 2], [0.5, 1]], "Should set the provided height in the size vector and use the default for the width");
                assertEqual(sizePlate(l=3, w=4, h=2), [[3, 4, 2], [1, 1]], "Should set the provided length, width and height in the size vector");

                assertEqual(sizePlate(rx=3), [[6, 6, 1], [3, 0.5]], "Should set the provided X radius in the radius vector and use the default for the Y radius");
                assertEqual(sizePlate(ry=4), [[1, 1, 8], [0.5, 4]], "Should set the provided Y radius in the radius vector and use the default for the X radius");
                assertEqual(sizePlate(rx=3, ry=4), [[6, 6, 8], [3, 4]], "Should set the provided radius in the radius vector");

                assertEqual(sizePlate(l=4, rx=3), [[4, 6, 1], [3, 0.5]], "Should set the provided length in the size vector and set the provide X radius in the radius vector");
                assertEqual(sizePlate(w=4, ry=3), [[1, 4, 6], [2, 3]], "Should set the provided width in the size vector and set the provide Y radius in the radius vector");
            }
        }
        // test shape/3D/rounded/drawBullet()
        testModule("drawBullet()", 5) {
            testUnit("default values", 3) {
                assertEqual(drawBullet($fn=3), [ [0.5, 0], _rotP(0, 0.5, 0.5) + [0, 0.5], [0, 1], [0, 0]], "Should return a list of points to draw a bullet with a radius of 1 and 3 facets");
                assertEqual(drawBullet($fn=4), concat([[0.5, 0]], [ for (a = [0 : 360/4 : 90]) _rotP(a, 0.5, 0.5) + [0, 0.5] ], [[0, 0]]), "Should return a list of points to draw a 90° bullet with a radius of 1 and 4 facets");
                assertEqual(drawBullet($fn=6), concat([[0.5, 0]], [ for (a = [0 : 360/6 : 90]) _rotP(a, 0.5, 0.5) + [0, 0.5] ], [[0, 1], [0, 0]]), "Should return a list of points to draw a 90° bullet with a radius of 1 and 6 facets");
            }
            testUnit("circle bullet, no straight walls", 12) {
                assertEqual(drawBullet([2, 2, 1], $fn=3), [ _rotP(0, 1, 1), _rotP(90, 1, 1), [0, 0] ], "Should return a list of points to draw a half-circle with a radius of 1 and 3 facets (triangle)");
                assertEqual(drawBullet([2, 2, 1], $fn=4), concat([ for (a = [0 : 360/4 : 90]) _rotP(a, 1, 1) ], [[0, 0]]), "Should return a list of points to draw a half-circle with a radius of 1 and 4 facets (square)");
                assertEqual(drawBullet([2, 2, 1], $fn=6), concat([ for (a = [0 : 360/6 : 90]) _rotP(a, 1, 1) ], [_rotP(90, 1, 1), [0, 0]]), "Should return a list of points to draw a half-circle with a radius of 1 and 6 facets (hexagon)");
                assertEqual(drawBullet([10, 10, 5], $fa=12, $fs=2), concat([ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 5, 5) ], [[0, 0]]), "Should return a list of points to draw a half-circle with a radius of 5 and 16 facets");

                assertEqual(drawBullet(r=2, $fn=3), [ _rotP(0, 2, 2), _rotP(90, 2, 2), [0, 0] ], "Should return a list of points to draw a half-circle with a radius of 2 and 3 facets (triangle)");
                assertEqual(drawBullet(r=3, $fn=4), concat([ for (a = [0 : 360/4 : 90]) _rotP(a, 3, 3) ], [[0, 0]]), "Should return a list of points to draw a half-circle with a radius of 3 and 4 facets (square)");
                assertEqual(drawBullet(r=4, $fn=6), concat([ for (a = [0 : 360/6 : 90]) _rotP(a, 4, 4) ], [_rotP(90, 4, 4), [0, 0]]), "Should return a list of points to draw a half-circle with a radius of 4 and 6 facets (hexagon)");
                assertEqual(drawBullet(r=5, $fa=12, $fs=2), concat([ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 5, 5) ], [[0, 0]]), "Should return a list of points to draw a half-circle with a radius of 5 and 16 facets");

                assertEqual(drawBullet(d=2, $fn=3), [ _rotP(0, 1, 1), _rotP(90, 1, 1), [0, 0] ], "Should return a list of points to draw a half-circle with a diameter of 2 and 3 facets (triangle)");
                assertEqual(drawBullet(d=3, $fn=4), concat([ for (a = [0 : 360/4 : 90]) _rotP(a, 1.5, 1.5) ], [[0, 0]]), "Should return a list of points to draw a half-circle with a diameter of 3 and 4 facets (square)");
                assertEqual(drawBullet(d=4, $fn=6), concat([ for (a = [0 : 360/6 : 90]) _rotP(a, 2, 2) ], [_rotP(90, 2, 2), [0, 0]]), "Should return a list of points to draw a half-circle with a diameter of 4 and 6 facets (hexagon)");
                assertEqual(drawBullet(d=5, $fa=12, $fs=2), concat([ for (a = [0 : astep(2.5, $fa=12, $fs=2) : 90]) _rotP(a, 2.5, 2.5) ], [[0, 0]]), "Should return a list of points to draw a half-circle with a diameter of 5 and 16 facets");
            }
            testUnit("ellipse bullet, no straight walls", 16) {
                assertEqual(drawBullet([1, 2, 1], $fn=3), [ _rotP(0, 1, 1), _rotP(90, 1, 1), [0, 0] ], "Should return a list of points to draw a half-ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawBullet([1, 3, 1], $fn=4), concat([ for (a = [0 : 360/4 : 90]) _rotP(a, 1.5, 1) ], [[0, 0]]), "Should return a list of points to draw a half-ellipse with a radius of [1.5, 3] and 4 facets (square)");
                assertEqual(drawBullet([1, 4, 1], $fn=6), concat([ for (a = [0 : 360/6 : 90]) _rotP(a, 2, 1) ], [_rotP(90, 2, 1), [0, 0]]), "Should return a list of points to draw a half-ellipse with a radius of [2, 4] and 6 facets (hexagon)");
                assertEqual(drawBullet([1, 5, 2], $fa=12, $fs=2), concat([ for (a = [0 : astep(2.5, $fa=12, $fs=2) : 90]) _rotP(a, 2.5, 2) ], [[0, 0]]), "Should return a list of points to draw a half-ellipse with a radius of [2.5, 5] and 16 facets");

                assertEqual(drawBullet(d=[1, 2], $fn=3), [ _rotP(0, 0.5, 1), _rotP(90, 0.5, 1), [0, 0] ], "Should return a list of points to draw a half-ellipse with a diameter of [1, 2] and 3 facets (triangle)");
                assertEqual(drawBullet(d=[1, 2], $fn=4), concat([ for (a = [0 : 360/4 : 90]) _rotP(a, 0.5, 1) ], [[0, 0]]), "Should return a list of points to draw a half-ellipse with a diameter of [1, 2] and 4 facets (square)");
                assertEqual(drawBullet(d=[1, 2], $fn=6), concat([ for (a = [0 : 360/6 : 90]) _rotP(a, 0.5, 1) ], [_rotP(90, 0.5, 1), [0, 0]]), "Should return a list of points to draw a half-ellipse with a diameter of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawBullet(d=[10, 12], $fa=12, $fs=2), concat([ for (a = [0 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6), [0, 0]]), "Should return a list of points to draw a half-ellipse with a diameter of [10, 12] and 20 facets");

                assertEqual(drawBullet(rx=1, ry=2, $fn=3), [ _rotP(0, 1, 2), _rotP(90, 1, 2), [0, 0] ], "Should return a list of points to draw a half-ellipse with a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawBullet(rx=1, ry=2, $fn=4), concat([ for (a = [0 : 360/4 : 90]) _rotP(a, 1, 2) ], [[0, 0]]), "Should return a list of points to draw a half-ellipse with a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawBullet(rx=1, ry=2, $fn=6), concat([ for (a = [0 : 360/6 : 90]) _rotP(a, 1, 2) ], [_rotP(90, 1, 2), [0, 0]]), "Should return a list of points to draw a half-ellipse with a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawBullet(rx=5, ry=6, $fa=12, $fs=2), concat([ for (a = [0 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6), [0, 0]]), "Should return a list of points to draw a half-ellipse with a radius of x=5, y=6 and 20 facets");

                assertEqual(drawBullet(dx=1, dy=2, $fn=3), [ _rotP(0, 0.5, 1), _rotP(90, 0.5, 1), [0, 0] ], "Should return a list of points to draw a half-ellipse with a diameter of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawBullet(dx=1, dy=2, $fn=4), concat([ for (a = [0 : 360/4 : 90]) _rotP(a, 0.5, 1) ], [[0, 0]]), "Should return a list of points to draw a half-ellipse with a diameter of x=1, y=2 and 4 facets (square)");
                assertEqual(drawBullet(dx=1, dy=2, $fn=6), concat([ for (a = [0 : 360/6 : 90]) _rotP(a, 0.5, 1) ], [_rotP(90, 0.5, 1), [0, 0]]), "Should return a list of points to draw a half-ellipse with a diameter of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawBullet(dx=10, dy=12, $fa=12, $fs=2), concat([ for (a = [0 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6), [0, 0]]), "Should return a list of points to draw a half-ellipse with a diameter of x=10, y=12 and 20 facets");
            }
            testUnit("circle bullet, straight walls", 4) {
                assertEqual(drawBullet([1, 2, 2], r=1, $fn=3), concat([[1, 0]], [ _rotP(0, 1, 1) + [0, 1], _rotP(90, 1, 1) + [0, 1] ], [[0, 0]]), "Should return a list of points to draw a bullet with wall of 1 and a radius of 1 and 3 facets (triangle)");
                assertEqual(drawBullet([1, 2, 2], r=1, $fn=4), concat([[1, 0]], [ for (a = [0 : 360/4 : 90]) _rotP(a, 1, 1) + [0, 1] ], [[0, 0]]), "Should return a list of points to draw a bullet with wall of 1 and a radius of 1 and 4 facets (square)");
                assertEqual(drawBullet([1, 2, 2], r=1, $fn=6), concat([[1, 0]], [ for (a = [0 : 360/6 : 90]) _rotP(a, 1, 1) + [0, 1] ], [_rotP(90, 1, 1) + [0, 1], [0, 0]]), "Should return a list of points to draw a bullet with wall of 1 and a radius of 1 and 6 facets (hexagon)");
                assertEqual(drawBullet([5, 10, 10], r=5, , $fa=12, $fs=2), concat([[5, 0]], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 5, 5) + [0, 5] ], [[0, 0]]), "Should return a list of points to draw a bullet with wall of 5 and a radius of 5 and 16 facets");
            }
            testUnit("ellipse bullet, straight walls", 12) {
                assertEqual(drawBullet([1, 2, 4], r=[1, 2], $fn=3), concat([[1, 0]], [ _rotP(0, 1, 2) + [0, 2], _rotP(90, 1, 2) + [0, 2] ], [[0, 0]]), "Should return a list of points to draw an ellipse bullet with wall of 1 and a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawBullet([1, 2, 4], r=[1, 2], $fn=4), concat([[1, 0]], [ for (a = [0 : 360/4 : 90]) _rotP(a, 1, 2) + [0, 2] ], [[0, 0]]), "Should return a list of points to draw an ellipse bullet with wall of 1 and a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawBullet([1, 2, 4], r=[1, 2], $fn=6), concat([[1, 0]], [ for (a = [0 : 360/6 : 90]) _rotP(a, 1, 2) + [0, 2] ], [_rotP(90, 1, 2) + [0, 2], [0, 0]]), "Should return a list of points to draw an ellipse bullet with wall of 1 and a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawBullet([1, 6, 10], r=[3, 5], $fa=12, $fs=2), concat([[3, 0]], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) + [0, 5] ], [[0, 0]]), "Should return a list of points to draw an ellipse bullet with wall of 5 and a radius of [3, 5] and 16 facets");

                assertEqual(drawBullet(l=1, w=2, h=4, rx=1, ry=2, $fn=3), concat([[1, 0]], [ _rotP(0, 1, 2) + [0, 2], _rotP(90, 1, 2) + [0, 2] ], [[0, 0]]), "Should return a list of points to draw an ellipse bullet with wall of 1 and a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawBullet(l=1, w=2, h=4, rx=1, ry=2, $fn=4), concat([[1, 0]], [ for (a = [0 : 360/4 : 90]) _rotP(a, 1, 2) + [0, 2] ], [[0, 0]]), "Should return a list of points to draw an ellipse bullet with wall of 1 and a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawBullet(l=1, w=2, h=4, rx=1, ry=2, $fn=6), concat([[1, 0]], [ for (a = [0 : 360/6 : 90]) _rotP(a, 1, 2) + [0, 2] ], [_rotP(90, 1, 2) + [0, 2], [0, 0]]), "Should return a list of points to draw an ellipse bullet with wall of 1 and a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawBullet(l=1, w=6, h=10, rx=3, ry=5, $fa=12, $fs=2), concat([[3, 0]], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) + [0, 5] ], [[0, 0]]), "Should return a list of points to draw an ellipse bullet with wall of 5 and a radius of x=3, y=5 and 16 facets");

                assertEqual(drawBullet(l=1, w=2, h=4, dx=2, dy=4, $fn=3), concat([[1, 0]], [ _rotP(0, 1, 2) + [0, 2], _rotP(90, 1, 2) + [0, 2] ], [[0, 0]]), "Should return a list of points to draw an ellipse bullet with wall of 1 and a diameter of x=2, y=4 and 3 facets (triangle)");
                assertEqual(drawBullet(l=1, w=2, h=4, dx=2, dy=4, $fn=4), concat([[1, 0]], [ for (a = [0 : 360/4 : 90]) _rotP(a, 1, 2) + [0, 2] ], [[0, 0]]), "Should return a list of points to draw an ellipse bullet with wall of 1 and a diameter of x=2, y=4 and 4 facets (square)");
                assertEqual(drawBullet(l=1, w=2, h=4, dx=2, dy=4, $fn=6), concat([[1, 0]], [ for (a = [0 : 360/6 : 90]) _rotP(a, 1, 2) + [0, 2] ], [_rotP(90, 1, 2) + [0, 2], [0, 0]]), "Should return a list of points to draw an ellipse bullet with wall of 1 and a diameter of x=2, y=4 and 6 facets (hexagon)");
                assertEqual(drawBullet(l=1, w=6, h=10, dx=6, dy=10, $fa=12, $fs=2), concat([[3, 0]], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) + [0, 5] ], [[0, 0]]), "Should return a list of points to draw an ellipse bullet with wall of 5 and a diameter of x=6, y=10 and 16 facets");
            }
        }
        // test shape/3D/rounded/drawPill()
        testModule("drawPill()", 5) {
            testUnit("default values", 3) {
                assertEqual(drawPill($fn=3), [ _rotP(-90, 0.5, 0.5), _rotP(30, 0.5, 0.5), _rotP(90, 0.5, 0.5) ], "Should return a list of points to draw a circle with a radius of 1 and 3 facets (triangle)");
                assertEqual(drawPill($fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 0.5, 0.5) ], "Should return a list of points to draw a circle with a radius of 1 and 4 facets (square)");
                assertEqual(drawPill($fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 0.5, 0.5) ], "Should return a list of points to draw a circle with a radius of 1 and 6 facets (hexagon)");
            }
            testUnit("circle pill, no straight walls", 12) {
                assertEqual(drawPill(2, $fn=3), [ _rotP(-90, 1, 1), _rotP(30, 1, 1), _rotP(90, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 3 facets (triangle)");
                assertEqual(drawPill(2, $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 4 facets (square)");
                assertEqual(drawPill(2, $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 1, 1) ], "Should return a list of points to draw a circle with a radius of 1 and 6 facets (hexagon)");
                assertEqual(drawPill(10, $fa=12, $fs=2), [ for (a = [-90 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a radius of 5 and 16 facets");

                assertEqual(drawPill(r=2, $fn=3), [ _rotP(-90, 2, 2), _rotP(30, 2, 2), _rotP(90, 2, 2) ], "Should return a list of points to draw a circle with a radius of 2 and 3 facets (triangle)");
                assertEqual(drawPill(r=3, $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 3, 3) ], "Should return a list of points to draw a circle with a radius of 3 and 4 facets (square)");
                assertEqual(drawPill(r=4, $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 4, 4) ], "Should return a list of points to draw a circle with a radius of 4 and 6 facets (hexagon)");
                assertEqual(drawPill(r=5, $fa=12, $fs=2), [ for (a = [-90 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a radius of 5 and 16 facets");

                assertEqual(drawPill(d=2, $fn=3), [ _rotP(-90, 1, 1), _rotP(30, 1, 1), _rotP(90, 1, 1) ], "Should return a list of points to draw a circle with a diameter of 2 and 3 facets (triangle)");
                assertEqual(drawPill(d=3, $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 1.5, 1.5) ], "Should return a list of points to draw a circle with a diameter of 3 and 4 facets (square)");
                assertEqual(drawPill(d=4, $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a diameter of 4 and 6 facets (hexagon)");
                assertEqual(drawPill(d=10, $fa=12, $fs=2), [ for (a = [-90 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a diameter of 5 and 16 facets");
            }
            testUnit("ellipse pill, no straight walls", 20) {
                assertEqual(drawPill([1, 2, 1], $fn=3), [ _rotP(-90, 1, 0.5), _rotP(30, 1, 0.5), _rotP(90, 1, 0.5) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawPill([1, 2, 1], $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 1, 0.5) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawPill([1, 2, 1], $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 1, 0.5) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawPill([5, 12, 10], $fa=12, $fs=2), concat([ for (a = [-90 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 6, 5) ], [_rotP(90, 6, 5)]), "Should return a list of points to draw an ellipse with a radius of [5, 6] and 20 facets");

                assertEqual(drawPill(r=[1, 2], $fn=3), [ _rotP(-90, 1, 2), _rotP(30, 1, 2), _rotP(90, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawPill(r=[1, 2], $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawPill(r=[1, 2], $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawPill(r=[5, 6], $fa=12, $fs=2), concat([ for (a = [-90 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6)]), "Should return a list of points to draw an ellipse with a radius of [5, 6] and 20 facets");

                assertEqual(drawPill(d=[1, 2], $fn=3), [ _rotP(-90, 0.5, 1), _rotP(30, 0.5, 1), _rotP(90, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 3 facets (triangle)");
                assertEqual(drawPill(d=[1, 2], $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 4 facets (square)");
                assertEqual(drawPill(d=[1, 2], $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawPill(d=[10, 12], $fa=12, $fs=2), concat([ for (a = [-90 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6)]), "Should return a list of points to draw an ellipse with a diameter of [10, 12] and 20 facets");

                assertEqual(drawPill(rx=1, ry=2, $fn=3), [ _rotP(-90, 1, 2), _rotP(30, 1, 2), _rotP(90, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawPill(rx=1, ry=2, $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawPill(rx=1, ry=2, $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawPill(rx=5, ry=6, $fa=12, $fs=2), concat([ for (a = [-90 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6)]), "Should return a list of points to draw an ellipse with a radius of x=5, y=6 and 20 facets");

                assertEqual(drawPill(dx=1, dy=2, $fn=3), [ _rotP(-90, 0.5, 1), _rotP(30, 0.5, 1), _rotP(90, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawPill(dx=1, dy=2, $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 4 facets (square)");
                assertEqual(drawPill(dx=1, dy=2, $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawPill(dx=10, dy=12, $fa=12, $fs=2), concat([ for (a = [-90 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6)]), "Should return a list of points to draw an ellipse with a diameter of x=10, y=12 and 20 facets");
            }
            testUnit("circle pill, straight walls", 4) {
                assertEqual(drawPill([1, 2, 4], r=1, $fn=3), [ _rotP(-90, 1, 1) - [0, 1], _rotP(0, 1, 1) - [0, 1], _rotP(0, 1, 1) + [0, 1], _rotP(90, 1, 1) + [0, 1] ], "Should return a list of points to draw an pill with wall of 1 and a radius of 1 and 3 facets (triangle)");
                assertEqual(drawPill([1, 2, 4], r=1, $fn=4), concat([ for (a = [-90 : 360/4 : 0]) _rotP(a, 1, 1) - [0, 1] ], [ for (a = [0 : 360/4 : 90]) _rotP(a, 1, 1) + [0, 1] ]), "Should return a list of points to draw an pill with wall of 1 and a radius of 1 and 4 facets (square)");
                assertEqual(drawPill([1, 2, 4], r=1, $fn=6), concat([ for (a = [-90 : 360/6 : 0]) _rotP(a, 1, 1) - [0, 1] ], [_rotP(0, 1, 1) - [0, 1]], [ for (a = [0 : 360/6 : 90]) _rotP(a, 1, 1) + [0, 1] ], [_rotP(90, 1, 1) + [0, 1]]), "Should return a list of points to draw an pill with wall of 1 and a radius of 1 and 6 facets (hexagon)");
                assertEqual(drawPill([5, 10, 20], r=5, , $fa=12, $fs=2), concat([ for (a = [-90 : astep(5, $fa=12, $fs=2) : 0]) _rotP(a, 5, 5) - [0, 5] ], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 5, 5) + [0, 5] ]), "Should return a list of points to draw an pill with wall of 10 and a radius of 5 and 16 facets");
            }
            testUnit("ellipse pill, straight walls", 12) {
                assertEqual(drawPill([1, 2, 8], r=[1, 2], $fn=3), [ _rotP(-90, 1, 2) - [0, 2], _rotP(0, 1, 2) - [0, 2], _rotP(0, 1, 2) + [0, 2], _rotP(90, 1, 2) + [0, 2] ], "Should return a list of points to draw an ellipse pill with wall of 1 and a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawPill([1, 2, 8], r=[1, 2], $fn=4), concat([ for (a = [-90 : 360/4 : 0]) _rotP(a, 1, 2) - [0, 2] ], [ for (a = [0 : 360/4 : 90]) _rotP(a, 1, 2) + [0, 2] ]), "Should return a list of points to draw an ellipse pill with wall of 1 and a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawPill([1, 2, 8], r=[1, 2], $fn=6), concat([ for (a = [-90 : 360/6 : 0]) _rotP(a, 1, 2) - [0, 2] ], [_rotP(0, 1, 2) - [0, 2]], [ for (a = [0 : 360/6 : 90]) _rotP(a, 1, 2) + [0, 2] ], [_rotP(90, 1, 2) + [0, 2]]), "Should return a list of points to draw an ellipse pill with wall of 1 and a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawPill([3, 6, 20], r=[3, 5], $fa=12, $fs=2), concat([ for (a = [-90 : astep(5, $fa=12, $fs=2) : 0]) _rotP(a, 3, 5) - [0, 5] ], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) + [0, 5] ]), "Should return a list of points to draw an ellipse pill with wall of 10 and a radius of [3, 5] and 16 facets");

                assertEqual(drawPill(l=1, w=2, h=8, rx=1, ry=2, $fn=3), [ _rotP(-90, 1, 2) - [0, 2], _rotP(0, 1, 2) - [0, 2], _rotP(0, 1, 2) + [0, 2], _rotP(90, 1, 2) + [0, 2] ], "Should return a list of points to draw an ellipse pill with wall of 1 and a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawPill(l=1, w=2, h=8, rx=1, ry=2, $fn=4), concat([ for (a = [-90 : 360/4 : 0]) _rotP(a, 1, 2) - [0, 2] ], [ for (a = [0 : 360/4 : 90]) _rotP(a, 1, 2) + [0, 2] ]), "Should return a list of points to draw an ellipse pill with wall of 1 and a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawPill(l=1, w=2, h=8, rx=1, ry=2, $fn=6), concat([ for (a = [-90 : 360/6 : 0]) _rotP(a, 1, 2) - [0, 2] ], [_rotP(0, 1, 2) - [0, 2]], [ for (a = [0 : 360/6 : 90]) _rotP(a, 1, 2) + [0, 2] ], [_rotP(90, 1, 2) + [0, 2]]), "Should return a list of points to draw an ellipse pill with wall of 1 and a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawPill(l=1, w=6, h=20, rx=3, ry=5, $fa=12, $fs=2), concat([ for (a = [-90 : astep(5, $fa=12, $fs=2) : 0]) _rotP(a, 3, 5) - [0, 5] ], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) + [0, 5] ]), "Should return a list of points to draw an ellipse pill with wall of 10 and a radius of x=3, y=5 and 16 facets");

                assertEqual(drawPill(l=1, w=2, h=8, dx=2, dy=4, $fn=3), [ _rotP(-90, 1, 2) - [0, 2], _rotP(0, 1, 2) - [0, 2], _rotP(0, 1, 2) + [0, 2], _rotP(90, 1, 2) + [0, 2] ], "Should return a list of points to draw an ellipse pill with wall of 1 and a diameter of x=2, y=4 and 3 facets (triangle)");
                assertEqual(drawPill(l=1, w=2, h=8, dx=2, dy=4, $fn=4), concat([ for (a = [-90 : 360/4 : 0]) _rotP(a, 1, 2) - [0, 2] ], [ for (a = [0 : 360/4 : 90]) _rotP(a, 1, 2) + [0, 2] ]), "Should return a list of points to draw an ellipse pill with wall of 1 and a diameter of x=2, y=4 and 4 facets (square)");
                assertEqual(drawPill(l=1, w=2, h=8, dx=2, dy=4, $fn=6), concat([ for (a = [-90 : 360/6 : 0]) _rotP(a, 1, 2) - [0, 2] ], [_rotP(0, 1, 2) - [0, 2]], [ for (a = [0 : 360/6 : 90]) _rotP(a, 1, 2) + [0, 2] ], [_rotP(90, 1, 2) + [0, 2]]), "Should return a list of points to draw an ellipse pill with wall of 1 and a diameter of x=2, y=4 and 6 facets (hexagon)");
                assertEqual(drawPill(l=1, w=6, h=20, dx=6, dy=10, $fa=12, $fs=2), concat([ for (a = [-90 : astep(5, $fa=12, $fs=2) : 0]) _rotP(a, 3, 5) - [0, 5] ], [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) + [0, 5] ]), "Should return a list of points to draw an ellipse pill with wall of 10 and a diameter of x=6, y=10 and 16 facets");
            }
        }
        // test shape/3D/rounded/drawPeg()
        testModule("drawPeg()", 4) {
            testUnit("default values", 1) {
                assertEqual(drawPeg(), [ [0.5, 0.5], [0, 0.5], [0, -0.5], [0.5, -0.5] ], "Should return a simple rectangle without rounder corners if no parameter is provided");
            }
            testUnit("size, but radius", 6) {
                assertEqual(drawPeg(2), [ [1, 1], [0, 1], [0, -1], [1, -1] ], "Should return a simple rectangle without rounder corners if only the size is provided. Single number should be translated into vector.");
                assertEqual(drawPeg([1, 2, 4]), [ [1, 2], [0, 2], [0, -2], [1, -2] ], "Should return a simple rectangle without rounder corners if only the size is provided.");
                assertEqual(drawPeg(l=1, w=2), [ [1, 0.5], [0, 0.5], [0, -0.5], [1, -0.5] ], "Should return a simple rectangle without rounder corners if only the size is provided. Missing height should be set to default.");
                assertEqual(drawPeg(l=1, h=2), [ [0.5, 1], [0, 1], [0, -1], [0.5, -1] ], "Should return a simple rectangle without rounder corners if only the size is provided. Missing width should be set to default.");
                assertEqual(drawPeg(l=1, w=2, h=4), [ [1, 2], [0, 2], [0, -2], [1, -2] ], "Should return a simple rectangle without rounder corners if only the size is provided. Size provided separately.");
                assertEqual(drawPeg(size=[1, 5, 6], w=2, h=4), [ [1, 2], [0, 2], [0, -2], [1, -2] ], "Should return a simple rectangle without rounder corners if only the size is provided. Size provided separately. Separate size should overwrite the size vector.");
            }
            testUnit("radius or diameter, but size", 24) {
                assertEqual(drawPeg(r=2, $fn=3), [ _rotP(-90, 2, 2), _rotP(30, 2, 2), _rotP(90, 2, 2) ], "Should return a list of points to draw a circle with a radius of 2 and 3 facets (triangle)");
                assertEqual(drawPeg(r=2, $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a radius of 2 and 4 facets (square)");
                assertEqual(drawPeg(r=2, $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a radius of 2 and 6 facets (hexagon)");
                assertEqual(drawPeg(r=5, $fa=12, $fs=2), [ for (a = [-90 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a radius of 5 and 16 facets");

                assertEqual(drawPeg(d=2, $fn=3), [ _rotP(-90, 1, 1), _rotP(30, 1, 1), _rotP(90, 1, 1) ], "Should return a list of points to draw a circle with a diameter of 2 and 3 facets (triangle)");
                assertEqual(drawPeg(d=3, $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 1.5, 1.5) ], "Should return a list of points to draw a circle with a diameter of 3 and 4 facets (square)");
                assertEqual(drawPeg(d=4, $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 2, 2) ], "Should return a list of points to draw a circle with a diameter of 4 and 6 facets (hexagon)");
                assertEqual(drawPeg(d=10, $fa=12, $fs=2), [ for (a = [-90 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 5, 5) ], "Should return a list of points to draw a circle with a diameter of 5 and 16 facets");

                assertEqual(drawPeg(r=[1, 2], $fn=3), [ _rotP(-90, 1, 2), _rotP(30, 1, 2), _rotP(90, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawPeg(r=[1, 2], $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawPeg(r=[1, 2], $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawPeg(r=[5, 6], $fa=12, $fs=2), concat([ for (a = [-90 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6)]), "Should return a list of points to draw an ellipse with a radius of [5, 6] and 20 facets");

                assertEqual(drawPeg(d=[1, 2], $fn=3), [ _rotP(-90, 0.5, 1), _rotP(30, 0.5, 1), _rotP(90, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 3 facets (triangle)");
                assertEqual(drawPeg(d=[1, 2], $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 4 facets (square)");
                assertEqual(drawPeg(d=[1, 2], $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawPeg(d=[10, 12], $fa=12, $fs=2), concat([ for (a = [-90 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6)]), "Should return a list of points to draw an ellipse with a diameter of [10, 12] and 20 facets");

                assertEqual(drawPeg(rx=1, ry=2, $fn=3), [ _rotP(-90, 1, 2), _rotP(30, 1, 2), _rotP(90, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawPeg(rx=1, ry=2, $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawPeg(rx=1, ry=2, $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 1, 2) ], "Should return a list of points to draw an ellipse with a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawPeg(rx=5, ry=6, $fa=12, $fs=2), concat([ for (a = [-90 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6)]), "Should return a list of points to draw an ellipse with a radius of x=5, y=6 and 20 facets");

                assertEqual(drawPeg(dx=1, dy=2, $fn=3), [ _rotP(-90, 0.5, 1), _rotP(30, 0.5, 1), _rotP(90, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawPeg(dx=1, dy=2, $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 4 facets (square)");
                assertEqual(drawPeg(dx=1, dy=2, $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw an ellipse with a diameter of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawPeg(dx=10, dy=12, $fa=12, $fs=2), concat([ for (a = [-90 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6)]), "Should return a list of points to draw an ellipse with a diameter of x=10, y=12 and 20 facets");
            }
            testUnit("size and radius", 12) {
                assertEqual(
                    drawPeg([2, 4, 8], r=[1, 2], $fn=3),
                    [
                        [0, -4], _rotP(-90, 1, 2) + [1, -2], _rotP(0, 1, 2) + [1, -2],
                        _rotP(0, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2], [0, 4]
                    ],
                    "Should return a list of points to draw a peg with size of [4, 8] and a radius of [1, 2] and 3 facets (triangle)"
                );
                assertEqual(
                    drawPeg([2, 4, 8], r=[1, 2], $fn=4),
                    [
                        [0, -4], _rotP(-90, 1, 2) + [1, -2], _rotP(0, 1, 2) + [1, -2],
                        _rotP(0, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2], [0, 4]
                    ],
                    "Should return a list of points to draw a peg with size of [4, 8] and a radius of [1, 2] and 4 facets (square)"
                );
                assertEqual(
                    drawPeg([2, 4, 8], r=[1, 2], $fn=6),
                    [
                        [0, -4], _rotP(-90, 1, 2) + [1, -2], _rotP(-30, 1, 2) + [1, -2], _rotP(0, 1, 2) + [1, -2],
                        _rotP(0, 1, 2) + [1, 2], _rotP(60, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2], [0, 4]
                    ],
                    "Should return a list of points to draw a peg with size of [4, 8] and a radius of [1, 2] and 6 facets (hexagon)"
                );
                assertEqual(
                    drawPeg([10, 20, 20], r=[3, 5], $fa=12, $fs=2),
                    concat(
                        [ [0, -10] ],
                        [ for (a = [-90 : astep(5, $fa=12, $fs=2) : 0]) _rotP(a, 3, 5) + [7, -5] ],
                        [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) + [7, 5] ],
                        [ [0, 10] ]
                    ),
                    "Should return a list of points to draw a peg with size of [20, 20] and a radius of [3, 5] and 16 facets"
                );

                assertEqual(
                    drawPeg([2, 4, 8], d=[2, 4], $fn=3),
                    [
                        [0, -4], _rotP(-90, 1, 2) + [1, -2], _rotP(0, 1, 2) + [1, -2],
                        _rotP(0, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2], [0, 4]
                    ],
                    "Should return a list of points to draw a peg with size of [4, 8] and a diameter of [2, 4] and 3 facets (triangle)"
                );
                assertEqual(
                    drawPeg([2, 4, 8], d=[2, 4], $fn=4),
                    [
                        [0, -4], _rotP(-90, 1, 2) + [1, -2], _rotP(0, 1, 2) + [1, -2],
                        _rotP(0, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2], [0, 4]
                    ],
                    "Should return a list of points to draw a peg with size of [4, 8] and a diameter of [2, 4] and 4 facets (square)"
                );
                assertEqual(
                    drawPeg([2, 4, 8], d=[2, 4], $fn=6),
                    [
                        [0, -4], _rotP(-90, 1, 2) + [1, -2], _rotP(-30, 1, 2) + [1, -2], _rotP(0, 1, 2) + [1, -2],
                        _rotP(0, 1, 2) + [1, 2], _rotP(60, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2], [0, 4]
                    ],
                    "Should return a list of points to draw a peg with size of [4, 8] and a diameter of [2, 4] and 6 facets (hexagon)"
                );
                assertEqual(
                    drawPeg([10, 20, 20], d=[6, 10], $fa=12, $fs=2),
                    concat(
                        [ [0, -10] ],
                        [ for (a = [-90 : astep(5, $fa=12, $fs=2) : 0]) _rotP(a, 3, 5) + [7, -5] ],
                        [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) + [7, 5] ],
                        [ [0, 10] ]
                    ),
                    "Should return a list of points to draw a peg with size of [20, 20] and a diameter of [6, 10] and 16 facets"
                );

                assertEqual(
                    drawPeg(l=2, w=4, h=8, rx=1, ry=2, $fn=3),
                    [
                        [0, -4], _rotP(-90, 1, 2) + [1, -2], _rotP(0, 1, 2) + [1, -2],
                        _rotP(0, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2], [0, 4]
                    ],
                    "Should return a list of points to draw a peg with size of w=4, h=8 and a radius of rx=1, ry=2 and 3 facets (triangle)"
                );
                assertEqual(
                    drawPeg(l=2, w=4, h=8, rx=1, ry=2, $fn=4),
                    [
                        [0, -4], _rotP(-90, 1, 2) + [1, -2], _rotP(0, 1, 2) + [1, -2],
                        _rotP(0, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2], [0, 4]
                    ],
                    "Should return a list of points to draw a peg with size of w=4, h=8 and a radius of rx=1, ry=2 and 4 facets (square)"
                );
                assertEqual(
                    drawPeg(l=2, w=4, h=8, rx=1, ry=2, $fn=6),
                    [
                        [0, -4], _rotP(-90, 1, 2) + [1, -2], _rotP(-30, 1, 2) + [1, -2], _rotP(0, 1, 2) + [1, -2],
                        _rotP(0, 1, 2) + [1, 2], _rotP(60, 1, 2) + [1, 2], _rotP(90, 1, 2) + [1, 2], [0, 4]
                    ],
                    "Should return a list of points to draw a peg with size of w=4, h=8 and a radius of rx=1, ry=2 and 6 facets (hexagon)"
                );
                assertEqual(
                    drawPeg(l=10, w=20, h=20, rx=3, ry=5, $fa=12, $fs=2),
                    concat(
                        [ [0, -10] ],
                        [ for (a = [-90 : astep(5, $fa=12, $fs=2) : 0]) _rotP(a, 3, 5) + [7, -5] ],
                        [ for (a = [0 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) + [7, 5] ],
                        [ [0, 10] ]
                    ),
                    "Should return a list of points to draw a peg with size of w=20, h=20 and a radius of rx=3, ry=5 and 16 facets"
                );
            }
        }
        // test shape/3D/rounded/drawPlate()
        testModule("drawPlate()", 5) {
            testUnit("default values", 3) {
                assertEqual(drawPlate($fn=3), [ [0, -0.5], _rotP(30, 0.5, 0.5), [0, 0.5]], "Should return a list of points to draw a plate with a radius of 1 and 3 facets");
                assertEqual(drawPlate($fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 0.5, 0.5) ], "Should return a list of points to draw a 90° plate with a radius of 1 and 4 facets");
                assertEqual(drawPlate($fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 0.5, 0.5) ], "Should return a list of points to draw a 90° plate with a radius of 1 and 6 facets");
            }
            testUnit("circle plate, no straight walls", 12) {
                assertEqual(drawPlate([1, 2, 1], $fn=3), [ [0, -0.5], _rotP(-90, 0.5, 0.5) + [0.5, 0], _rotP(30, 0.5, 0.5) + [0.5, 0], _rotP(90, 0.5, 0.5) + [0.5, 0], [0, 0.5] ], "Should return a list of points to draw a half-circle with a radius of 1 and 3 facets (triangle)");
                assertEqual(drawPlate([1, 2, 1], $fn=4), concat([[0, -0.5]], [ for (a = [-90 : 360/4 : 90]) _rotP(a, 0.5, 0.5) + [0.5, 0] ], [[0, 0.5]]), "Should return a list of points to draw a half-circle with a radius of 1 and 4 facets (square)");
                assertEqual(drawPlate([1, 2, 1], $fn=6), concat([[0, -0.5]], [ for (a = [-90 : 360/6 : 90]) _rotP(a, 0.5, 0.5) + [0.5, 0] ], [[0, 0.5]]), "Should return a list of points to draw a half-circle with a radius of 1 and 6 facets (hexagon)");
                assertEqual(drawPlate([5, 10, 5], $fa=12, $fs=2), concat([[0, -2.5]], [ for (a = [-90 : astep(2.5, $fa=12, $fs=2) : 90]) _rotP(a, 2.5, 2.5) + [2.5, 0] ], [[0, 2.5]]), "Should return a list of points to draw a half-circle with a radius of 5 and 16 facets");

                assertEqual(drawPlate(r=2, $fn=3), [ _rotP(-90, 2, 2), _rotP(30, 2, 2), _rotP(90, 2, 2) ], "Should return a list of points to draw a half-circle with a radius of 2 and 3 facets (triangle)");
                assertEqual(drawPlate(r=3, $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 3, 3) ], "Should return a list of points to draw a half-circle with a radius of 3 and 4 facets (square)");
                assertEqual(drawPlate(r=4, $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 4, 4) ], "Should return a list of points to draw a half-circle with a radius of 4 and 6 facets (hexagon)");
                assertEqual(drawPlate(r=5, $fa=12, $fs=2), [ for (a = [-90 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 5, 5) ], "Should return a list of points to draw a half-circle with a radius of 5 and 16 facets");

                assertEqual(drawPlate(d=2, $fn=3), [ _rotP(-90, 1, 1), _rotP(30, 1, 1), _rotP(90, 1, 1) ], "Should return a list of points to draw a half-circle with a diameter of 2 and 3 facets (triangle)");
                assertEqual(drawPlate(d=3, $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 1.5, 1.5) ], "Should return a list of points to draw a half-circle with a diameter of 3 and 4 facets (square)");
                assertEqual(drawPlate(d=4, $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 2, 2) ], "Should return a list of points to draw a half-circle with a diameter of 4 and 6 facets (hexagon)");
                assertEqual(drawPlate(d=5, $fa=12, $fs=2), [ for (a = [-90 : astep(2.5, $fa=12, $fs=2) : 90]) _rotP(a, 2.5, 2.5) ], "Should return a list of points to draw a half-circle with a diameter of 5 and 16 facets");
            }
            testUnit("ellipse plate, no straight walls", 16) {
                assertEqual(drawPlate([1, 2, 1], $fn=3), [ [0, -0.5], _rotP(-90, 0.5, 0.5) + [0.5, 0], _rotP(30, 0.5, 0.5) + [0.5, 0], _rotP(90, 0.5, 0.5) + [0.5, 0], [0, 0.5] ], "Should return a list of points to draw a half-ellipse with a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawPlate([1, 3, 1], $fn=4), concat([[0, -0.5]], [ for (a = [-90 : 360/4 : 90]) _rotP(a, 0.5, 0.5) + [1, 0] ], [[0, 0.5]]), "Should return a list of points to draw a half-ellipse with a radius of [1.5, 3] and 4 facets (square)");
                assertEqual(drawPlate([1, 4, 1], $fn=6), concat([[0, -0.5]], [ for (a = [-90 : 360/6 : 90]) _rotP(a, 0.5, 0.5) + [1.5, 0] ], [[0, 0.5]]), "Should return a list of points to draw a half-ellipse with a radius of [2, 4] and 6 facets (hexagon)");
                assertEqual(drawPlate([1, 4, 5], $fa=12, $fs=2), [ for (a = [-90 : astep(2.5, $fa=12, $fs=2) : 90]) _rotP(a, 2, 2.5) ], "Should return a list of points to draw a half-ellipse with a radius of [2.5, 5] and 16 facets");

                assertEqual(drawPlate(d=[1, 2], $fn=3), [ _rotP(-90, 0.5, 1), _rotP(30, 0.5, 1), _rotP(90, 0.5, 1) ], "Should return a list of points to draw a half-ellipse with a diameter of [1, 2] and 3 facets (triangle)");
                assertEqual(drawPlate(d=[1, 2], $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw a half-ellipse with a diameter of [1, 2] and 4 facets (square)");
                assertEqual(drawPlate(d=[1, 2], $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw a half-ellipse with a diameter of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawPlate(d=[10, 12], $fa=12, $fs=2), concat([ for (a = [-90 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6)]), "Should return a list of points to draw a half-ellipse with a diameter of [10, 12] and 20 facets");

                assertEqual(drawPlate(rx=1, ry=2, $fn=3), [ _rotP(-90, 1, 2), _rotP(30, 1, 2), _rotP(90, 1, 2) ], "Should return a list of points to draw a half-ellipse with a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawPlate(rx=1, ry=2, $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 1, 2) ], "Should return a list of points to draw a half-ellipse with a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawPlate(rx=1, ry=2, $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 1, 2) ], "Should return a list of points to draw a half-ellipse with a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawPlate(rx=5, ry=6, $fa=12, $fs=2), concat([ for (a = [-90 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6)]), "Should return a list of points to draw a half-ellipse with a radius of x=5, y=6 and 20 facets");

                assertEqual(drawPlate(dx=1, dy=2, $fn=3), [ _rotP(-90, 0.5, 1), _rotP(30, 0.5, 1), _rotP(90, 0.5, 1) ], "Should return a list of points to draw a half-ellipse with a diameter of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawPlate(dx=1, dy=2, $fn=4), [ for (a = [-90 : 360/4 : 90]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw a half-ellipse with a diameter of x=1, y=2 and 4 facets (square)");
                assertEqual(drawPlate(dx=1, dy=2, $fn=6), [ for (a = [-90 : 360/6 : 90]) _rotP(a, 0.5, 1) ], "Should return a list of points to draw a half-ellipse with a diameter of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawPlate(dx=10, dy=12, $fa=12, $fs=2), concat([ for (a = [-90 : astep(6, $fa=12, $fs=2) : 90]) _rotP(a, 5, 6) ], [_rotP(90, 5, 6)]), "Should return a list of points to draw a half-ellipse with a diameter of x=10, y=12 and 20 facets");
            }
            testUnit("circle plate, straight walls", 4) {
                assertEqual(drawPlate([2, 2, 2], r=1, $fn=3), [ [0, -1], _rotP(30, 1, 1), [0, 1] ], "Should return a list of points to draw a plate with wall of 1 and a radius of 1 and 3 facets (triangle)");
                assertEqual(drawPlate([2, 2, 2], r=1, $fn=4), [ [0, -1], _rotP(0, 1, 1), [0, 1] ], "Should return a list of points to draw a plate with wall of 1 and a radius of 1 and 4 facets (square)");
                assertEqual(drawPlate([2, 2, 2], r=1, $fn=6), [ [0, -1], _rotP(-30, 1, 1), _rotP(30, 1, 1), [0, 1] ], "Should return a list of points to draw a plate with wall of 1 and a radius of 1 and 6 facets (hexagon)");
                assertEqual(drawPlate([10, 10, 10], r=5, , $fa=12, $fs=2), [ for (a = [-90 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 5, 5) ], "Should return a list of points to draw a plate with wall of 5 and a radius of 5 and 16 facets");
            }
            testUnit("ellipse plate, straight walls", 12) {
                assertEqual(drawPlate([2, 2, 4], r=[1, 2], $fn=3), [ [0, -2], _rotP(30, 1, 2), [0, 2] ], "Should return a list of points to draw an ellipse plate with wall of 1 and a radius of [1, 2] and 3 facets (triangle)");
                assertEqual(drawPlate([2, 2, 4], r=[1, 2], $fn=4), [ [0, -2], _rotP(0, 1, 2), [0, 2] ], "Should return a list of points to draw an ellipse plate with wall of 1 and a radius of [1, 2] and 4 facets (square)");
                assertEqual(drawPlate([2, 2, 4], r=[1, 2], $fn=6), [ [0, -2], _rotP(-30, 1, 2), _rotP(30, 1, 2), [0, 2] ], "Should return a list of points to draw an ellipse plate with wall of 1 and a radius of [1, 2] and 6 facets (hexagon)");
                assertEqual(drawPlate([6, 6, 10], r=[3, 5], $fa=12, $fs=2), [ for (a = [-90 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) ], "Should return a list of points to draw an ellipse plate with wall of 5 and a radius of [3, 5] and 16 facets");

                assertEqual(drawPlate(l=2, w=2, h=4, rx=1, ry=2, $fn=3), [ [0, -2], _rotP(30, 1, 2), [0, 2] ], "Should return a list of points to draw an ellipse plate with wall of 1 and a radius of x=1, y=2 and 3 facets (triangle)");
                assertEqual(drawPlate(l=2, w=2, h=4, rx=1, ry=2, $fn=4), [ [0, -2], _rotP(0, 1, 2), [0, 2] ], "Should return a list of points to draw an ellipse plate with wall of 1 and a radius of x=1, y=2 and 4 facets (square)");
                assertEqual(drawPlate(l=2, w=2, h=4, rx=1, ry=2, $fn=6), [ [0, -2], _rotP(-30, 1, 2), _rotP(30, 1, 2), [0, 2] ], "Should return a list of points to draw an ellipse plate with wall of 1 and a radius of x=1, y=2 and 6 facets (hexagon)");
                assertEqual(drawPlate(l=2, w=6, h=10, rx=3, ry=5, $fa=12, $fs=2), [ for (a = [-90 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) ], "Should return a list of points to draw an ellipse plate with wall of 5 and a radius of x=3, y=5 and 16 facets");

                assertEqual(drawPlate(l=2, w=2, h=4, dx=2, dy=4, $fn=3), [ [0, -2], _rotP(30, 1, 2), [0, 2] ], "Should return a list of points to draw an ellipse plate with wall of 1 and a diameter of x=2, y=4 and 3 facets (triangle)");
                assertEqual(drawPlate(l=2, w=2, h=4, dx=2, dy=4, $fn=4), [ [0, -2], _rotP(0, 1, 2), [0, 2] ], "Should return a list of points to draw an ellipse plate with wall of 1 and a diameter of x=2, y=4 and 4 facets (square)");
                assertEqual(drawPlate(l=2, w=2, h=4, dx=2, dy=4, $fn=6), [ [0, -2], _rotP(-30, 1, 2), _rotP(30, 1, 2), [0, 2] ], "Should return a list of points to draw an ellipse plate with wall of 1 and a diameter of x=2, y=4 and 6 facets (hexagon)");
                assertEqual(drawPlate(l=2, w=6, h=10, dx=6, dy=10, $fa=12, $fs=2), [ for (a = [-90 : astep(5, $fa=12, $fs=2) : 90]) _rotP(a, 3, 5) ], "Should return a list of points to draw an ellipse plate with wall of 5 and a diameter of x=6, y=10 and 16 facets");
            }
        }
    }
    function _rotP(a, x, y) = [cos(a) * x, sin(a) * y];
}

testShape3dRounded();
