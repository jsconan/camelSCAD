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
 * Unit tests: Maths and arithmetic operations.
 *
 * @package test/core/maths
 * @author jsconan
 */
module testCoreMaths() {
    testPackage("core/maths.scad", 18) {
        // test core/maths/deg()
        testModule("deg()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(deg(), 0, "Without parameter the function should return 0");
            }
            testUnit("wrong type", 5) {
                assertEqual(deg("10"), 0, "A string should be converted to 0");
                assertEqual(deg(true), 0, "A boolean should be converted to 0");
                assertEqual(deg([]), 0, "An empty array should be converted to 0");
                assertEqual(deg(["1"]), 0, "An array should be converted to 0");
                assertEqual(deg([1]), 0, "A vector should be converted to 0");
            }
            testUnit("number", 9) {
                assertEqual(deg(0), 0, "0 degree should be converted to 0");
                assertEqual(deg(-10), -10, "-10 degrees should be converted to -10");
                assertEqual(deg(10), 10, "10 degrees should be converted to 10");
                assertEqual(deg(-360), -360, "-360 degrees should be converted to -360");
                assertEqual(deg(360), 360, "360 degrees should be converted to 360");
                assertEqual(deg(-720), -360, "-720 degrees should be converted to -360");
                assertEqual(deg(720), 360, "720 degrees should be converted to 360");
                assertEqual(deg(-420), -60, "-420 degrees should be converted to -60");
                assertEqual(deg(420), 60, "420 degrees should be converted to 60");
            }
        }
        // test core/maths/absdeg()
        testModule("absdeg()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(absdeg(), 0, "Without parameter the function should return 0");
            }
            testUnit("wrong type", 5) {
                assertEqual(absdeg("10"), 0, "A string should be converted to 0");
                assertEqual(absdeg(true), 0, "A boolean should be converted to 0");
                assertEqual(absdeg([]), 0, "An empty array should be converted to 0");
                assertEqual(absdeg(["1"]), 0, "An array should be converted to 0");
                assertEqual(absdeg([1]), 0, "A vector should be converted to 0");
            }
            testUnit("number", 9) {
                assertEqual(absdeg(0), 0, "0 degree should be converted to 0");
                assertEqual(absdeg(-10), 350, "-10 degrees should be converted to 350");
                assertEqual(absdeg(10), 10, "10 degrees should be converted to 10");
                assertEqual(absdeg(-360), 0, "-360 degrees should be converted to 0");
                assertEqual(absdeg(360), 360, "360 degrees should be converted to 360");
                assertEqual(absdeg(-720), 0, "-720 degrees should be converted to 0");
                assertEqual(absdeg(720), 360, "720 degrees should be converted to 360");
                assertEqual(absdeg(-420), 300, "-420 degrees should be converted to 300");
                assertEqual(absdeg(420), 60, "420 degrees should be converted to 60");
            }
        }
        // test core/maths/straight()
        testModule("straight()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(straight(), 0, "Without parameter the function should return 0");
            }
            testUnit("wrong type", 5) {
                assertEqual(straight("10"), 0, "A string should be converted to 0");
                assertEqual(straight(true), 0, "A boolean should be converted to 0");
                assertEqual(straight([]), 0, "An empty array should be converted to 0");
                assertEqual(straight(["1"]), 0, "An array should be converted to 0");
                assertEqual(straight([1]), 0, "A vector should be converted to 0");
            }
            testUnit("number", 9) {
                assertEqual(straight(0), 0, "0 degree should be converted to 0");
                assertEqual(straight(-10), 10, "-10 degrees should be converted to 10");
                assertEqual(straight(10), 10, "10 degrees should be converted to 10");
                assertEqual(straight(-360), 0, "-360 degrees should be converted to 180");
                assertEqual(straight(360), 0, "360 degrees should be converted to 0");
                assertEqual(straight(-720), 0, "-720 degrees should be converted to 180");
                assertEqual(straight(720), 0, "720 degrees should be converted to 0");
                assertEqual(straight(-420), 60, "-420 degrees should be converted to 60");
                assertEqual(straight(420), 60, "420 degrees should be converted to 60");
            }
        }
        // test core/maths/fragments()
        testModule("fragments()", 6) {
            testUnit("no parameter", 1) {
                assertEqual(fragments(), 3, "The minimal returned value should be 3, if the radius is missing or too small");
            }
            testUnit("wrong type", 3) {
                assertEqual(fragments("10"), 3, "A string should be replaced by 0, and the returned value should be 3");
                assertEqual(fragments([10]), 3, "A vector should be replaced by 0, and the returned value should be 3");
                assertEqual(fragments(true), 3, "A boolean should be replaced by 0, and the returned value should be 3");
            }
            testUnit("radius is 0", 3) {
                assertEqual(fragments(r=0, $fn=0), 3, "If the radius is 0, the returned value should be 3");
                assertEqual(fragments(r=0, $fn=1), 3, "If the radius is 0, the returned value should be 3, even if $fn is set to a value lower than 3");
                assertEqual(fragments(r=0, $fn=9), 3, "If the radius is 0, the returned value should be 3, even if $fn is set to a value greater than 3");
            }
            testUnit("diameter is 0", 3) {
                assertEqual(fragments(d=0, $fn=0), 3, "If the diameter is 0, the returned value should be 3");
                assertEqual(fragments(d=0, $fn=1), 3, "If the diameter is 0, the returned value should be 3, even if $fn is set to a value lower than 3");
                assertEqual(fragments(d=0, $fn=9), 3, "If the diameter is 0, the returned value should be 3, even if $fn is set to a value greater than 3");
            }
            testUnit("radius provided", 12) {
                assertEqual(fragments(r=100, $fn=1), 3, "Whatever the radius is, the returned value should be 3, if $fn is set to a value lower than 3");
                assertEqual(fragments(r=100, $fn=9), 9, "Whatever the radius is, the returned value should be $fn, if $fn is set to a value greater than 3");

                assertEqual(fragments(r=10, $fn=0, $fa=12, $fs=2), 30, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 30 facets with default $fa and $fs");
                assertEqual(fragments(r=10, $fn=0, $fa=6, $fs=2), 32, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 32 facets with $fa=6 $fs=2");
                assertEqual(fragments(r=10, $fn=0, $fa=1, $fs=1), 63, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 63 facets with $fa=1 $fs=1");
                assertEqual(fragments(r=10, $fn=0, $fa=1, $fs=1.5), 42, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 42 facets with $fa=1 $fs=1.5");
                assertEqual(fragments(r=10, $fn=0, $fa=0.5, $fs=0.5), 126, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 63 facets with $fa=1 $fs=1");

                assertEqual(fragments(r=100, $fn=0, $fa=12, $fs=2), 30, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 30 facets with default $fa and $fs");
                assertEqual(fragments(r=100, $fn=0, $fa=6, $fs=2), 60, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 32 facets with $fa=6 $fs=2");
                assertEqual(fragments(r=100, $fn=0, $fa=1, $fs=1), 360, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 63 facets with $fa=1 $fs=1");
                assertEqual(fragments(r=100, $fn=0, $fa=1, $fs=1.5), 360, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 42 facets with $fa=1 $fs=1.5");
                assertEqual(fragments(r=100, $fn=0, $fa=0.5, $fs=0.5), 720, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 63 facets with $fa=1 $fs=1");
            }
            testUnit("diameter provided", 12) {
                assertEqual(fragments(d=100, $fn=1), 3, "Whatever the diameter is, the returned value should be 3, if $fn is set to a value lower than 3");
                assertEqual(fragments(d=100, $fn=9), 9, "Whatever the diameter is, the returned value should be $fn, if $fn is set to a value greater than 3");

                assertEqual(fragments(d=20, $fn=0, $fa=12, $fs=2), 30, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 20 should be fragmented in 30 facets with default $fa and $fs");
                assertEqual(fragments(d=20, $fn=0, $fa=6, $fs=2), 32, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 20 should be fragmented in 32 facets with $fa=6 $fs=2");
                assertEqual(fragments(d=20, $fn=0, $fa=1, $fs=1), 63, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 20 should be fragmented in 63 facets with $fa=1 $fs=1");
                assertEqual(fragments(d=20, $fn=0, $fa=1, $fs=1.5), 42, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 20 should be fragmented in 42 facets with $fa=1 $fs=1.5");
                assertEqual(fragments(d=20, $fn=0, $fa=0.5, $fs=0.5), 126, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 20 should be fragmented in 63 facets with $fa=1 $fs=1");

                assertEqual(fragments(d=200, $fn=0, $fa=12, $fs=2), 30, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 200 should be fragmented in 30 facets with default $fa and $fs");
                assertEqual(fragments(d=200, $fn=0, $fa=6, $fs=2), 60, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 200 should be fragmented in 32 facets with $fa=6 $fs=2");
                assertEqual(fragments(d=200, $fn=0, $fa=1, $fs=1), 360, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 200 should be fragmented in 63 facets with $fa=1 $fs=1");
                assertEqual(fragments(d=200, $fn=0, $fa=1, $fs=1.5), 360, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 200 should be fragmented in 42 facets with $fa=1 $fs=1.5");
                assertEqual(fragments(d=200, $fn=0, $fa=0.5, $fs=0.5), 720, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 200 should be fragmented in 63 facets with $fa=1 $fs=1");
            }
        }
        // test core/maths/astep()
        testModule("astep()", 8) {
            testUnit("no parameter", 1) {
                assertEqual(astep(), 120, "The minimal returned value should be 120, if the radius is missing or too small");
            }
            testUnit("wrong type", 6) {
                assertEqual(astep("10"), 120, "A string should be replaced by 0, and the returned value should be 120");
                assertEqual(astep([10]), 120, "A vector should be replaced by 0, and the returned value should be 120");
                assertEqual(astep(true), 120, "A boolean should be replaced by 0, and the returned value should be 120");

                assertEqual(astep("10", "10"), 0, "The returned value should be 0, if the parameters are wrong (string)");
                assertEqual(astep([10], [10]), 0, "The returned value should be 0, if the parameters are wrong (vector)");
                assertEqual(astep(true, true), 0, "The returned value should be 0, if the parameters are wrong (boolean)");
            }
            testUnit("radius is 0", 3) {
                assertEqual(astep(r=0, $fn=0), 360/3, "If the radius is 0, the returned value should be 120");
                assertEqual(astep(r=0, $fn=1), 360/3, "If the radius is 0, the returned value should be 120, even if $fn is set to a value lower than 3");
                assertEqual(astep(r=0, $fn=9), 360/3, "If the radius is 0, the returned value should be 120, even if $fn is set to a value greater than 3");
            }
            testUnit("diameter is 0", 3) {
                assertEqual(astep(d=0, $fn=0), 360/3, "If the diameter is 0, the returned value should be 120");
                assertEqual(astep(d=0, $fn=1), 360/3, "If the diameter is 0, the returned value should be 120, even if $fn is set to a value lower than 3");
                assertEqual(astep(d=0, $fn=9), 360/3, "If the diameter is 0, the returned value should be 120, even if $fn is set to a value greater than 3");
            }
            testUnit("only radius provided", 12) {
                assertEqual(astep(r=100, $fn=1), 120, "Whatever the radius is, the returned value should be 120, if $fn is set to a value lower than 3");
                assertEqual(astep(r=100, $fn=9), 360/9, "Whatever the radius is, the returned value should be 360/$fn, if $fn is set to a value greater than 3");

                assertEqual(astep(r=10, $fn=0, $fa=12, $fs=2), 360/30, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 30 facets with default $fa and $fs");
                assertEqual(astep(r=10, $fn=0, $fa=6, $fs=2), 360/32, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 32 facets with $fa=6 $fs=2");
                assertEqual(astep(r=10, $fn=0, $fa=1, $fs=1), 360/63, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 63 facets with $fa=1 $fs=1");
                assertEqual(astep(r=10, $fn=0, $fa=1, $fs=1.5), 360/42, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 42 facets with $fa=1 $fs=1.5");
                assertEqual(astep(r=10, $fn=0, $fa=0.5, $fs=0.5), 360/126, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 63 facets with $fa=1 $fs=1");

                assertEqual(astep(r=100, $fn=0, $fa=12, $fs=2), 360/30, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 30 facets with default $fa and $fs");
                assertEqual(astep(r=100, $fn=0, $fa=6, $fs=2), 360/60, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 32 facets with $fa=6 $fs=2");
                assertEqual(astep(r=100, $fn=0, $fa=1, $fs=1), 360/360, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 63 facets with $fa=1 $fs=1");
                assertEqual(astep(r=100, $fn=0, $fa=1, $fs=1.5), 360/360, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 42 facets with $fa=1 $fs=1.5");
                assertEqual(astep(r=100, $fn=0, $fa=0.5, $fs=0.5), 360/720, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 63 facets with $fa=1 $fs=1");
            }
            testUnit("only diameter provided", 12) {
                assertEqual(astep(d=100, $fn=1), 120, "Whatever the diameter is, the returned value should be 120, if $fn is set to a value lower than 3");
                assertEqual(astep(d=100, $fn=9), 360/9, "Whatever the diameter is, the returned value should be 360/$fn, if $fn is set to a value greater than 3");

                assertEqual(astep(d=20, $fn=0, $fa=12, $fs=2), 360/30, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 20 should be fragmented in 30 facets with default $fa and $fs");
                assertEqual(astep(d=20, $fn=0, $fa=6, $fs=2), 360/32, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 20 should be fragmented in 32 facets with $fa=6 $fs=2");
                assertEqual(astep(d=20, $fn=0, $fa=1, $fs=1), 360/63, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 20 should be fragmented in 63 facets with $fa=1 $fs=1");
                assertEqual(astep(d=20, $fn=0, $fa=1, $fs=1.5), 360/42, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 20 should be fragmented in 42 facets with $fa=1 $fs=1.5");
                assertEqual(astep(d=20, $fn=0, $fa=0.5, $fs=0.5), 360/126, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 20 should be fragmented in 63 facets with $fa=1 $fs=1");

                assertEqual(astep(d=200, $fn=0, $fa=12, $fs=2), 360/30, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 200 should be fragmented in 30 facets with default $fa and $fs");
                assertEqual(astep(d=200, $fn=0, $fa=6, $fs=2), 360/60, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 200 should be fragmented in 32 facets with $fa=6 $fs=2");
                assertEqual(astep(d=200, $fn=0, $fa=1, $fs=1), 360/360, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 200 should be fragmented in 63 facets with $fa=1 $fs=1");
                assertEqual(astep(d=200, $fn=0, $fa=1, $fs=1.5), 360/360, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 200 should be fragmented in 42 facets with $fa=1 $fs=1.5");
                assertEqual(astep(d=200, $fn=0, $fa=0.5, $fs=0.5), 360/720, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 200 should be fragmented in 63 facets with $fa=1 $fs=1");
            }
            testUnit("radius and angle provided", 30) {
                assertEqual(astep(r=0, a=180, $fn=0), 120, "If the radius is 0, the returned value should be 120");
                assertEqual(astep(r=0, a=180, $fn=1), 120, "If the radius is 0, the returned value should be 120, even if $fn is set to a value lower than 3");
                assertEqual(astep(r=0, a=180, $fn=9), 120, "If the radius is 0, the returned value should be 120, even if $fn is set to a value greater than 3");

                assertEqual(astep(r=0, a=90, $fn=0), 90, "If the radius is 0 but the angle lesser than 120, the returned value should be the provided angle");
                assertEqual(astep(r=0, a=90, $fn=1), 90, "If the radius is 0 but the angle lesser than 120, the returned value should be the provided angle, even if $fn is set to a value lower than 3");
                assertEqual(astep(r=0, a=90, $fn=9), 90, "If the radius is 0 but the angle lesser than 120, the returned value should be the provided angle, even if $fn is set to a value greater than 3");

                assertEqual(astep(r=100, a=180, $fn=1), 120, "Whatever the radius is, the returned value should be 120, if $fn is set to a value lower than 3");
                assertEqual(astep(r=100, a=180, $fn=9), 360/9, "Whatever the radius is, the returned value should be 360/$fn, if $fn is set to a value greater than 3");

                assertEqual(astep(r=100, a=30, $fn=1), 30, "Whatever the radius is, the returned value should be provided angle if lesser than 120, if $fn is set to a value lower than 3");
                assertEqual(astep(r=100, a=30, $fn=9), 30, "Whatever the radius is, the returned value should be provided angle if lesser than 360/$fn, if $fn is set to a value greater than 3");

                assertEqual(astep(r=10, a=180, $fn=0, $fa=12, $fs=2), 360/30, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 30 facets with default $fa and $fs");
                assertEqual(astep(r=10, a=180, $fn=0, $fa=6, $fs=2), 360/32, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 32 facets with $fa=6 $fs=2");
                assertEqual(astep(r=10, a=180, $fn=0, $fa=1, $fs=1), 360/63, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 63 facets with $fa=1 $fs=1");
                assertEqual(astep(r=10, a=180, $fn=0, $fa=1, $fs=1.5), 360/42, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 42 facets with $fa=1 $fs=1.5");
                assertEqual(astep(r=10, a=180, $fn=0, $fa=0.5, $fs=0.5), 360/126, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 63 facets with $fa=1 $fs=1");

                assertEqual(astep(r=10, a=1, $fn=0, $fa=12, $fs=2), 1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 30 facets with default $fa and $fs, but the returned angle should be the provided one if lesser");
                assertEqual(astep(r=10, a=1, $fn=0, $fa=6, $fs=2), 1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 32 facets with $fa=6 $fs=2, but the returned angle should be the provided one if lesser");
                assertEqual(astep(r=10, a=1, $fn=0, $fa=1, $fs=1), 1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 63 facets with $fa=1 $fs=1, but the returned angle should be the provided one if lesser");
                assertEqual(astep(r=10, a=1, $fn=0, $fa=1, $fs=1.5), 1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 42 facets with $fa=1 $fs=1.5, but the returned angle should be the provided one if lesser");
                assertEqual(astep(r=10, a=1, $fn=0, $fa=0.5, $fs=0.5), 1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 10 should be fragmented in 63 facets with $fa=1 $fs=1, but the returned angle should be the provided one if lesser");

                assertEqual(astep(r=100, a=180, $fn=0, $fa=12, $fs=2), 360/30, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 30 facets with default $fa and $fs");
                assertEqual(astep(r=100, a=180, $fn=0, $fa=6, $fs=2), 360/60, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 32 facets with $fa=6 $fs=2");
                assertEqual(astep(r=100, a=180, $fn=0, $fa=1, $fs=1), 360/360, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 63 facets with $fa=1 $fs=1");
                assertEqual(astep(r=100, a=180, $fn=0, $fa=1, $fs=1.5), 360/360, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 42 facets with $fa=1 $fs=1.5");
                assertEqual(astep(r=100, a=180, $fn=0, $fa=0.5, $fs=0.5), 360/720, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 63 facets with $fa=1 $fs=1");

                assertEqual(astep(r=100, a=0.1, $fn=0, $fa=12, $fs=2), 0.1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 30 facets with default $fa and $fs, but the returned angle should be the provided one if lesser");
                assertEqual(astep(r=100, a=0.1, $fn=0, $fa=6, $fs=2), 0.1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 32 facets with $fa=6 $fs=2, but the returned angle should be the provided one if lesser");
                assertEqual(astep(r=100, a=0.1, $fn=0, $fa=1, $fs=1), 0.1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 63 facets with $fa=1 $fs=1, but the returned angle should be the provided one if lesser");
                assertEqual(astep(r=100, a=0.1, $fn=0, $fa=1, $fs=1.5), 0.1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 42 facets with $fa=1 $fs=1.5, but the returned angle should be the provided one if lesser");
                assertEqual(astep(r=100, a=0.1, $fn=0, $fa=0.5, $fs=0.5), 0.1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a radius of 100 should be fragmented in 63 facets with $fa=1 $fs=1, but the returned angle should be the provided one if lesser");
            }
            testUnit("diameter and angle provided", 30) {
                assertEqual(astep(d=0, a=180, $fn=0), 120, "If the diameter is 0, the returned value should be 120");
                assertEqual(astep(d=0, a=180, $fn=1), 120, "If the diameter is 0, the returned value should be 120, even if $fn is set to a value lower than 3");
                assertEqual(astep(d=0, a=180, $fn=9), 120, "If the diameter is 0, the returned value should be 120, even if $fn is set to a value greater than 3");

                assertEqual(astep(d=0, a=90, $fn=0), 90, "If the diameter is 0 but the angle lesser than 120, the returned value should be the provided angle");
                assertEqual(astep(d=0, a=90, $fn=1), 90, "If the diameter is 0 but the angle lesser than 120, the returned value should be the provided angle, even if $fn is set to a value lower than 3");
                assertEqual(astep(d=0, a=90, $fn=9), 90, "If the diameter is 0 but the angle lesser than 120, the returned value should be the provided angle, even if $fn is set to a value greater than 3");

                assertEqual(astep(d=100, a=180, $fn=1), 120, "Whatever the diameter is, the returned value should be 120, if $fn is set to a value lower than 3");
                assertEqual(astep(d=100, a=180, $fn=9), 360/9, "Whatever the diameter is, the returned value should be 360/$fn, if $fn is set to a value greater than 3");

                assertEqual(astep(d=100, a=30, $fn=1), 30, "Whatever the diameter is, the returned value should be provided angle if lesser than 120, if $fn is set to a value lower than 3");
                assertEqual(astep(d=100, a=30, $fn=9), 30, "Whatever the diameter is, the returned value should be provided angle if lesser than 360/$fn, if $fn is set to a value greater than 3");

                assertEqual(astep(d=20, a=180, $fn=0, $fa=12, $fs=2), 360/30, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 10 should be fragmented in 30 facets with default $fa and $fs");
                assertEqual(astep(d=20, a=180, $fn=0, $fa=6, $fs=2), 360/32, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 10 should be fragmented in 32 facets with $fa=6 $fs=2");
                assertEqual(astep(d=20, a=180, $fn=0, $fa=1, $fs=1), 360/63, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 10 should be fragmented in 63 facets with $fa=1 $fs=1");
                assertEqual(astep(d=20, a=180, $fn=0, $fa=1, $fs=1.5), 360/42, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 10 should be fragmented in 42 facets with $fa=1 $fs=1.5");
                assertEqual(astep(d=20, a=180, $fn=0, $fa=0.5, $fs=0.5), 360/126, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 10 should be fragmented in 63 facets with $fa=1 $fs=1");

                assertEqual(astep(d=20, a=1, $fn=0, $fa=12, $fs=2), 1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 10 should be fragmented in 30 facets with default $fa and $fs, but the returned angle should be the provided one if lesser");
                assertEqual(astep(d=20, a=1, $fn=0, $fa=6, $fs=2), 1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 10 should be fragmented in 32 facets with $fa=6 $fs=2, but the returned angle should be the provided one if lesser");
                assertEqual(astep(d=20, a=1, $fn=0, $fa=1, $fs=1), 1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 10 should be fragmented in 63 facets with $fa=1 $fs=1, but the returned angle should be the provided one if lesser");
                assertEqual(astep(d=20, a=1, $fn=0, $fa=1, $fs=1.5), 1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 10 should be fragmented in 42 facets with $fa=1 $fs=1.5, but the returned angle should be the provided one if lesser");
                assertEqual(astep(d=20, a=1, $fn=0, $fa=0.5, $fs=0.5), 1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 10 should be fragmented in 63 facets with $fa=1 $fs=1, but the returned angle should be the provided one if lesser");

                assertEqual(astep(d=200, a=180, $fn=0, $fa=12, $fs=2), 360/30, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 100 should be fragmented in 30 facets with default $fa and $fs");
                assertEqual(astep(d=200, a=180, $fn=0, $fa=6, $fs=2), 360/60, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 100 should be fragmented in 32 facets with $fa=6 $fs=2");
                assertEqual(astep(d=200, a=180, $fn=0, $fa=1, $fs=1), 360/360, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 100 should be fragmented in 63 facets with $fa=1 $fs=1");
                assertEqual(astep(d=200, a=180, $fn=0, $fa=1, $fs=1.5), 360/360, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 100 should be fragmented in 42 facets with $fa=1 $fs=1.5");
                assertEqual(astep(d=200, a=180, $fn=0, $fa=0.5, $fs=0.5), 360/720, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 100 should be fragmented in 63 facets with $fa=1 $fs=1");

                assertEqual(astep(d=200, a=0.1, $fn=0, $fa=12, $fs=2), 0.1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 100 should be fragmented in 30 facets with default $fa and $fs, but the returned angle should be the provided one if lesser");
                assertEqual(astep(d=200, a=0.1, $fn=0, $fa=6, $fs=2), 0.1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 100 should be fragmented in 32 facets with $fa=6 $fs=2, but the returned angle should be the provided one if lesser");
                assertEqual(astep(d=200, a=0.1, $fn=0, $fa=1, $fs=1), 0.1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 100 should be fragmented in 63 facets with $fa=1 $fs=1, but the returned angle should be the provided one if lesser");
                assertEqual(astep(d=200, a=0.1, $fn=0, $fa=1, $fs=1.5), 0.1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 100 should be fragmented in 42 facets with $fa=1 $fs=1.5, but the returned angle should be the provided one if lesser");
                assertEqual(astep(d=200, a=0.1, $fn=0, $fa=0.5, $fs=0.5), 0.1, "When the $fn value is not set, the number of fragments should be computed using $fa and $fs. A circle with a diameter of 100 should be fragmented in 63 facets with $fa=1 $fs=1, but the returned angle should be the provided one if lesser");
            }
        }
        // test core/maths/getAngle()
        testModule("getAngle()", 2) {
            testUnit("default value", 5) {
                assertEqual(getAngle(), 0, "Should return 0 if no parameter was provided");
                assertEqual(getAngle([], []), 0, "Cannot compute angle of arrays");
                assertEqual(getAngle([1, 2], [3, 4]), 0, "Cannot compute angle of vectors");
                assertEqual(getAngle("1", "2"), 0, "Cannot compute angle of strings");
                assertEqual(getAngle(true, true), 0, "Cannot compute angle of booleans");
            }
            testUnit("compute angle", 12) {
                assertEqual(getAngle(0, 0), 0, "Angle of vector [0,0]");
                assertEqual(getAngle(0, 1), 90, "Angle of vector [0,1]");
                assertEqual(getAngle(0, -1), 270, "Angle of vector [0,-1]");
                assertEqual(getAngle(1, 0), 0, "Angle of vector [1,0]");
                assertEqual(getAngle(-1, 0), 180, "Angle of vector [-1,0]");
                assertEqual(getAngle(1, 1), 45, "Angle of vector [1,1]");
                assertEqual(getAngle(-1, -1), 225, "Angle of vector [-1,-1]");
                assertEqual(getAngle(1, 2), atan2(2, 1), "Angle of vector [1,2]");
                assertEqual(getAngle(2, 1), atan2(1, 2), "Angle of vector [2,1]");
                assertEqual(getAngle(-2, 1), atan2(1, -2), "Angle of vector [-2,1]");
                assertEqual(getAngle(2, -1), 360 + atan2(-1, 2), "Angle of vector [2,-1]");
                assertEqual(getAngle(-2, -1), 360 + atan2(-1, -2), "Angle of vector [-2,-1]");
            }
        }
        // test core/maths/getPolygonAngle()
        testModule("getPolygonAngle()", 2) {
            testUnit("default value", 5) {
                assertEqual(getPolygonAngle(), 0, "Should return 0 if no parameter was provided");
                assertEqual(getPolygonAngle([], []), 0, "Cannot compute angle of arrays");
                assertEqual(getPolygonAngle([1, 2], [3, 4]), 0, "Cannot compute angle of vectors");
                assertEqual(getPolygonAngle("1", "2"), 0, "Cannot compute angle of strings");
                assertEqual(getPolygonAngle(true, true), 0, "Cannot compute angle of booleans");
            }
            testUnit("compute angle", 15) {
                assertEqual(getPolygonAngle(0, 0), 0, "Angle at index 0, should be 0");
                assertEqual(getPolygonAngle(5, 0), 0, "Null count should be defaulted to 1");
                assertEqual(getPolygonAngle(0), 0, "Default polygon, index 0");
                assertEqual(getPolygonAngle(1), 90, "Default polygon, index 1");
                assertEqual(getPolygonAngle(2), 180, "Default polygon, index 2");
                assertEqual(getPolygonAngle(3), 270, "Default polygon, index 3");
                assertEqual(getPolygonAngle(4), 0, "Default polygon, index 4");
                assertEqual(getPolygonAngle(0, 6), 0, "Hexagon, index 0");
                assertEqual(getPolygonAngle(1, 6), 360 / 6, "Hexagon, index 1");
                assertEqual(getPolygonAngle(3, 6), 360 / 6 * 3, "Hexagon, index 3");
                assertEqual(getPolygonAngle(10, 6), 360 / 6 * 4, "Hexagon, index 10");
                assertEqual(getPolygonAngle(0, 8), 0, "Octogon, index 0");
                assertEqual(getPolygonAngle(1, 8), 360 / 8, "Octogon, index 1");
                assertEqual(getPolygonAngle(3, 8), 360 / 8 * 3, "Octogon, index 3");
                assertEqual(getPolygonAngle(13, 8), 360 / 8 * 5, "Octogon, index 13");
            }
        }
        // test core/maths/pythagoras()
        testModule("pythagoras()") {
            testUnit("no parameter", 1) {
                assertEqual(pythagoras(), 0, "Without parameter the function should return 0");
            }
            testUnit("wrong type", 5) {
                assertEqual(pythagoras("10", "10"), 0, "Strings should be converted to 0");
                assertEqual(pythagoras(true, true), 0, "Booleans should be converted to 0");
                assertEqual(pythagoras([], []), 0, "Empty arrays should be converted to 0");
                assertEqual(pythagoras(["1"], ["2"]), 0, "Arrays should be converted to 0");
                assertEqual(pythagoras([1], [2]), 0, "Vectors should be converted to 0");
            }
            testUnit("number", 9) {
                assertEqual(pythagoras(0), 0, "If the only one parameter is 0, the function should not fail, but should return 0");
                assertEqual(pythagoras(0, 0, 0), 0, "If all parameters are 0 the function should not fail, but should return 0");

                assertEqual(pythagoras(a=10), 10, "If only one parameter is provided, the function cannot compute the result, but it should return the provided value");
                assertEqual(pythagoras(b=20), 20, "If only one parameter is provided, the function cannot compute the result, but it should return the provided value");
                assertEqual(pythagoras(c=30), 30, "If only one parameter is provided, the function cannot compute the result, but it should return the provided value");

                assertEqual(pythagoras(a=2, b=3), sqrt(4+9), "If A and B are provided the function should compute C");
                assertEqual(pythagoras(a=5, c=7), sqrt(49-25), "If A and C are provided the function should compute B");
                assertEqual(pythagoras(a=3, c=8), sqrt(64-9), "If B and C are provided the function should compute A");
                assertEqual(pythagoras(a=3, b=5, c=8), sqrt(64-9), "If A, B and C are provided the function should compute B");

            }
        }
        // test core/maths/apothem()
        testModule("apothem()") {
            testUnit("no parameter", 1) {
                assertEqual(apothem(), 0, "Without parameter the function should return 0");
            }
            testUnit("wrong type", 5) {
                assertEqual(apothem("10", "10"), 0, "Strings should be converted to 0");
                assertEqual(apothem(true, true), 0, "Booleans should be converted to 0");
                assertEqual(apothem([], []), 0, "Empty arrays should be converted to 0");
                assertEqual(apothem(["1"], ["2"]), 0, "Arrays should be converted to 0");
                assertEqual(apothem([1], [2]), 0, "Vectors should be converted to 0");
            }
            testUnit("number", 18) {
                assertEqual(apothem(0), 0, "If the only one parameter is 0, the function should not fail, but should return 0");
                assertEqual(apothem(0, 0, 0), 0, "If all parameters are 0 the function should not fail, but should return 0");

                assertEqual(apothem(r=8), 8 * cos(60), "If only the radius is provided, the function should compute the apothem of a triangle");
                assertEqual(apothem(l=8), 8 / (2 * tan(60)), "If only the length of a side is provided, the function should compute the apothem of a triangle");
                assertEqual(apothem(n=8), 0, "If only the number of sides is provided, the function cannot compute the result");

                assertEqual(apothem(r=8, n=4), 8 * cos(45), "Apothem of a square, using the radius");
                assertEqual(apothem(r=8, n=5), 8 * cos(36), "Apothem of a pentagon, using the radius");
                assertEqual(apothem(r=8, n=6), 8 * cos(30), "Apothem of an hexagon, using the radius");
                assertEqual(apothem(r=8, n=8), 8 * cos(22.5), "Apothem of an octogon, using the radius");

                assertEqual(apothem(l=8, n=4), 8 / (2 * tan(45)), "Apothem of a square, using the side");
                assertEqual(apothem(l=8, n=5), 8 / (2 * tan(36)), "Apothem of a pentagon, using the side");
                assertEqual(apothem(l=8, n=6), 8 / (2 * tan(30)), "Apothem of an hexagon, using the side");
                assertEqual(apothem(l=8, n=8), 8 / (2 * tan(22.5)), "Apothem of an octogon, using the side");

                assertEqual(apothem(6, 8), 8 * cos(30), "Apothem of an hexagon, using the default order of parameters");
                assertEqual(apothem(6, 8, 10), 8 * cos(30), "Apothem of an hexagon, using the default order of parameters with all provided (radius should predomin)");

                assertEqual(apothem(n=4, r=sqrt(32) / 2), apothem(n=4, l=4), "Apothem of a square, comparing results using radius and side");
                assertApproxEqual(apothem(n=4, l=4), 2, "Apothem of a square, comparing results and side");
                assertApproxEqual(apothem(n=6, r=4), apothem(n=6, l=4), "Apothem of an hexagon, comparing results using radius and side");
            }
        }
        // test core/maths/circumradius()
        testModule("circumradius()") {
            testUnit("no parameter", 1) {
                assertEqual(circumradius(), 0, "Without parameter the function should return 0");
            }
            testUnit("wrong type", 5) {
                assertEqual(circumradius("10", "10"), 0, "Strings should be converted to 0");
                assertEqual(circumradius(true, true), 0, "Booleans should be converted to 0");
                assertEqual(circumradius([], []), 0, "Empty arrays should be converted to 0");
                assertEqual(circumradius(["1"], ["2"]), 0, "Arrays should be converted to 0");
                assertEqual(circumradius([1], [2]), 0, "Vectors should be converted to 0");
            }
            testUnit("number", 22) {
                assertEqual(circumradius(0), 0, "If the only one parameter is 0, the function should not fail, but should return 0");
                assertEqual(circumradius(0, 0, 0), 0, "If all parameters are 0 the function should not fail, but should return 0");

                assertEqual(circumradius(a=8), 8 / cos(60), "If only the length is provided, the function should compute the circumradius of a triangle");
                assertEqual(circumradius(l=8), apothem(l=8)/ cos(60), "If only the length of a side is provided, the function should compute the circumradius of a triangle");
                assertEqual(circumradius(n=8), 0, "If only the number of sides is provided, the function cannot compute the result");

                assertEqual(circumradius(a=8, n=4), 8 / cos(45), "Circumradius of a square, using the the apothem");
                assertEqual(circumradius(a=8, n=5), 8 / cos(36), "Circumradius of a pentagon, using the the apothem");
                assertEqual(circumradius(a=8, n=6), 8 / cos(30), "Circumradius of an hexagon, using the the apothem");
                assertEqual(circumradius(a=8, n=8), 8 / cos(22.5), "Circumradius of an octogon, using the the apothem");

                assertEqual(circumradius(l=8, n=4), apothem(l=8, n=4) / cos(45), "Circumradius of a square, using the the side");
                assertEqual(circumradius(l=8, n=5), apothem(l=8, n=5) / cos(36), "Circumradius of a pentagon, using the the side");
                assertEqual(circumradius(l=8, n=6), apothem(l=8, n=6) / cos(30), "Circumradius of an hexagon, using the the side");
                assertEqual(circumradius(l=8, n=8), apothem(l=8, n=8) / cos(22.5), "Circumradius of an octogon, using the the side");

                assertEqual(circumradius(6, 8), 8 / cos(30), "Circumradius of an hexagon, using the default order of parameters");
                assertEqual(circumradius(6, 8, 10), 8 / cos(30), "Circumradius of an hexagon, using the default order of parameters with all provided (apothem should predomin)");

                assertEqual(circumradius(n=6, a=apothem(n=6, l=8)), circumradius(n=6, l=8), "Circumradius of an hexagon, comparing results using apothem and side");
                assertApproxEqual(circumradius(n=4, a=2), circumradius(n=4, l=4), "Circumradius of a square, comparing results using apothem and side");
                assertApproxEqual(circumradius(n=6, l=4), 4, "Circumradius of an hexagon, comparing results and side");

                assertEqual(circumradius(n=4, a=apothem(n=4, r=8)), 8, "Circumradius of a square, using radius of the inscribed circle");
                assertEqual(circumradius(n=5, a=apothem(n=5, r=8)), 8, "Circumradius of a pentagon, using radius of the inscribed circle");
                assertEqual(circumradius(n=6, a=apothem(n=6, r=8)), 8, "Circumradius of an hexagon, using radius of the inscribed circle");
                assertEqual(circumradius(n=8, a=apothem(n=8, r=8)), 8, "Circumradius of an octogon, using radius of the inscribed circle");
            }
        }
        // test core/maths/factorial()
        testModule("factorial()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(factorial(), 1, "No parameter should be translated to 0, the function should return 1");
            }
            testUnit("not a number", 3) {
                assertEqual(factorial(true), 1, "A boolean should be translated to 0, the function should return 1");
                assertEqual(factorial("10"), 1, "A String should be translated to 0, the function should return 1");
                assertEqual(factorial([14]), 1, "A Vector should be translated to 0, the function should return 1");
            }
            testUnit("number", 11) {
                assertEqual(factorial(0), 1, "The factorial of 0 is 1");
                assertEqual(factorial(1), 1, "The factorial of 1 is 1");
                assertEqual(factorial(2), 2, "The factorial of 2 is 2");
                assertEqual(factorial(3), 6, "The factorial of 3 is 6");
                assertEqual(factorial(4), 24, "The factorial of 4 is 24");
                assertEqual(factorial(5), 120, "The factorial of 5 is 120");
                assertEqual(factorial(6), 720, "The factorial of 6 is 720");
                assertEqual(factorial(7), 5040, "The factorial of 7 is 5040");
                assertEqual(factorial(8), 40320, "The factorial of 8 is 40320");
                assertEqual(factorial(9), 362880, "The factorial of 9 is 362880");
                assertEqual(factorial(10), 3628800, "The factorial of 10 is 3628800");
            }
        }
        // test core/maths/limit()
        testModule("limit()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(limit(), 0, "Should return a 0");
            }
            testUnit("value, no domain", 14) {
                assertEqual(limit(undef), 0, "Undef should be converted to 0");
                assertEqual(limit(false), 0, "False should be converted to 0");
                assertEqual(limit(true), 0, "True should be converted to 0");
                assertEqual(limit(""), 0, "An empty string should be converted to 0");
                assertEqual(limit("10"), 0, "An string containing a number should be converted to 0");
                assertEqual(limit("abc"), 0, "An string containing letters should be converted to 0");
                assertEqual(limit([]), 0, "An empty array should be converted to 0");
                assertEqual(limit([1]), 0, "A vector should be converted to 0");
                assertEqual(limit(["1"]), 0, "An array should be converted to 0");
                assertEqual(limit(0), 0, "A zero value should be kept");
                assertEqual(limit(4), 0, "An integer value should be forced to 0");
                assertEqual(limit(3.14), 0, "A float value should be forced to 0");
                assertEqual(limit(-5), 0, "A negative integer value should be forced to 0");
                assertEqual(limit(-3.14), 0, "A negative float value should be forced to 0");
            }
            testUnit("value, partial domain", 28) {
                assertEqual(limit(undef, low=1), 0, "Undef should be converted to 0");
                assertEqual(limit(undef, high=1), 0, "Undef should be converted to 0");

                assertEqual(limit(false, low=1), 0, "False should be converted to 0");
                assertEqual(limit(false, high=1), 0, "False should be converted to 0");

                assertEqual(limit(true, low=1), 0, "True should be converted to 0");
                assertEqual(limit(true, high=1), 0, "True should be converted to 0");

                assertEqual(limit("", low=1), 0, "An empty string should be converted to 0");
                assertEqual(limit("", high=1), 0, "An empty string should be converted to 0");

                assertEqual(limit("10", low=1), 0, "An string containing a number should be converted to 0");
                assertEqual(limit("10", high=1), 0, "An string containing a number should be converted to 0");

                assertEqual(limit("abc", low=1), 0, "An string containing letters should be converted to 0");
                assertEqual(limit("abc", high=1), 0, "An string containing letters should be converted to 0");

                assertEqual(limit([], low=1), 0, "An empty array should be converted to 0");
                assertEqual(limit([], high=1), 0, "An empty array should be converted to 0");

                assertEqual(limit([1], low=1), 0, "A vector should be converted to 0");
                assertEqual(limit([1], high=1), 0, "A vector should be converted to 0");

                assertEqual(limit(["1"], low=1), 0, "An array should be converted to 0");
                assertEqual(limit(["1"], high=1), 0, "An array should be converted to 0");

                assertEqual(limit(0, low=1), 0, "A zero value should be kept");
                assertEqual(limit(0, high=1), 0, "A zero value should be kept");

                assertEqual(limit(4, low=1), 1, "The integer value should be replaced by the highest");
                assertEqual(limit(4, high=1), 1, "The integer value should be replaced by the highest");

                assertEqual(limit(3.14, low=1), 1, "A float value should be replaced by the highest");
                assertEqual(limit(3.14, high=1), 1, "A float value should be replaced by the highest");

                assertEqual(limit(-5, low=-1), -1, "A negative integer value should be replaced by the lowest");
                assertEqual(limit(-5, high=-1), -1, "A negative integer value should be replaced by the lowest");

                assertEqual(limit(-3.14, low=-1), -1, "A negative float value should be replaced by the lowest");
                assertEqual(limit(-3.14, high=-1), -1, "A negative float value should be replaced by the lowest");
            }
            testUnit("value and domain", 42) {
                assertEqual(limit(undef, -1, 1), 0, "Undef should be converted to 0");
                assertEqual(limit(undef, 1, 2), 1, "Undef should be converted to 1");
                assertEqual(limit(undef, -1, -2), -1, "Undef should be converted to -1");

                assertEqual(limit(false, -1, 1), 0, "False should be converted to 0");
                assertEqual(limit(false, 1, 2), 1, "False should be converted to 1");
                assertEqual(limit(false, -1, -2), -1, "False should be converted to -1");

                assertEqual(limit(true, -1, 1), 0, "True should be converted to 0");
                assertEqual(limit(true, 1, 2), 1, "True should be converted to 1");
                assertEqual(limit(true, -1, -2), -1, "True should be converted to 1");

                assertEqual(limit("", -1, 1), 0, "An empty string should be converted to 0");
                assertEqual(limit("", 1, 2), 1, "An empty string should be converted to 1");
                assertEqual(limit("", -1, -2), -1, "An empty string should be converted to -1");

                assertEqual(limit("10", -1, 1), 0, "An string containing a number should be converted to 0");
                assertEqual(limit("10", 1, 2), 1, "An string containing a number should be converted to 1");
                assertEqual(limit("10", -1, -2), -1, "An string containing a number should be converted to -1");

                assertEqual(limit("abc", -1, 1), 0, "An string containing letters should be converted to 0");
                assertEqual(limit("abc", 1, 2), 1, "An string containing letters should be converted to 1");
                assertEqual(limit("abc", -1, -2), -1, "An string containing letters should be converted to -1");

                assertEqual(limit([], -1, 1), 0, "An empty array should be converted to 0");
                assertEqual(limit([], 1, 2), 1, "An empty array should be converted to 1");
                assertEqual(limit([], -1, -2), -1, "An empty array should be converted to -1");

                assertEqual(limit([1], -1, 1), 0, "A vector should be converted to 0");
                assertEqual(limit([1], 1, 2), 1, "A vector should be converted to 1");
                assertEqual(limit([1], -1, -2), -1, "A vector should be converted to -1");

                assertEqual(limit(["1"], -1, 1), 0, "An array should be converted to 0");
                assertEqual(limit(["1"], 1, 2), 1, "An array should be converted to 1");
                assertEqual(limit(["1"], -1, -2), -1, "An array should be converted to -1");

                assertEqual(limit(0, -1, 1), 0, "A zero value should be kept");
                assertEqual(limit(0, 1, 2), 1, "A zero value should be forced to 1");
                assertEqual(limit(0, -1, -2), -1, "A zero value should be forced -1");

                assertEqual(limit(4, -10, 3), 3, "The integer value should be replaced by the highest");
                assertEqual(limit(4, 5, 10), 5, "The integer value should be replaced by the lowest");
                assertEqual(limit(4, 0, 10), 4, "The integer value should be kept if within the domain");

                assertEqual(limit(3.14, -10, 2.5), 2.5, "A float value should be replaced by the highest");
                assertEqual(limit(3.14, 4.5, 10), 4.5, "A float value should be replaced by the lowest");
                assertEqual(limit(3.14, -10, 10), 3.14, "A float value should be kept if within the domain");

                assertEqual(limit(-5, -4, 4), -4, "A negative integer value should be replaced by the lowest");
                assertEqual(limit(-5, -10, -6), -6, "A negative integer value should be replaced by the higest");
                assertEqual(limit(-5, -10, 10), -5, "A negative integer value should be kept if within the domain");

                assertEqual(limit(-3.14, -2.5, 10), -2.5, "A negative float value should be replaced by the lowest");
                assertEqual(limit(-3.14, -10, -5.6), -5.6, "A negative float value should be replaced by the highest");
                assertEqual(limit(-3.14, -10, 10), -3.14, "A negative float value should be kept if within the domain");
            }
        }
        // test core/maths/fixed()
        testModule("fixed()", 2) {
            testUnit("default value", 4) {
                assertEqual(fixed(), 0, "Should return a 0");
                assertEqual(fixed("8"), 0, "Cannot round a string");
                assertEqual(fixed(true), 0, "Cannot round a boolean");
                assertEqual(fixed([10]), 0, "Cannot round a vector");
            }
            testUnit("round value", 8) {
                assertEqual(fixed(18), 18, "Should return the provided integer");
                assertEqual(fixed(18, 5), 18, "Should return the provided integer, even if a decimal precision have been provided");
                assertEqual(fixed(3.14), 3, "Should truncate the positive number if no precision is provided");
                assertEqual(fixed(-3.14), -3, "Should truncate the negative number if no precision is provided");
                assertEqual(fixed(1.12345678, 3), 1.123, "Should round the positive number with the provided precision (3)");
                assertEqual(fixed(1.12345678, 5), 1.12346, "Should round the positive number with the provided precision (5)");
                assertEqual(fixed(-1.12345678, 3), -1.123, "Should round the negative number with the provided precision (3)");
                assertEqual(fixed(-1.12345678, 5), -1.12346, "Should round the negative number with the provided precision (5)");
            }
        }
        // test core/maths/roundBy()
        testModule("roundBy()", 2) {
            testUnit("default value", 4) {
                assertEqual(roundBy(), 0, "Should return a 0");
                assertEqual(roundBy("8"), 0, "Cannot round a string");
                assertEqual(roundBy(true), 0, "Cannot round a boolean");
                assertEqual(roundBy([10]), 0, "Cannot round a vector");
            }
            testUnit("round value", 12) {
                assertEqual(roundBy(11), 11, "Should return the provided integer");
                assertEqual(roundBy(11, unit=0), 11, "Should return the provided integer, even if a zero unit has been provided");
                assertEqual(roundBy(18, unit=5), 20, "Should round the provided integer to the near unit (18 ~ 20)");
                assertEqual(roundBy(16, unit=5), 15, "Should round the provided integer to the near unit (16 ~ 15)");
                assertEqual(roundBy(3.14), 3, "Should truncate the positive number if no unit is provided");
                assertEqual(roundBy(-3.14), -3, "Should truncate the negative number if no unit is provided");
                assertEqual(roundBy(1.12345678, unit=.5), 1, "Should round the number to the nearest unit of .5 (1.12345678 ~ 1)");
                assertEqual(roundBy(1.35, unit=.5), 1.5, "Should round the number to the nearest unit of .5 (1.35 ~ 1.5)");
                assertEqual(roundBy(1.73, unit=.5), 1.5, "Should round the number to the nearest unit of .5 (1.73 ~ 1.5)");
                assertEqual(roundBy(1.78, unit=.5), 2, "Should round the number to the nearest unit of .5 (1.78 ~ 2)");
                assertEqual(roundBy(1.5, .2), 1.6, "Should round the positive number to the nearest unit of .2 (1.5 ~ 1.6)");
                assertEqual(roundBy(-1.5, .2), -1.6, "Should round the negative number to the nearest unit of .2 (1.5 ~ 1.6)");
            }
        }
        // test core/maths/floorBy()
        testModule("floorBy()", 2) {
            testUnit("default value", 4) {
                assertEqual(floorBy(), 0, "Should return a 0");
                assertEqual(floorBy("8"), 0, "Cannot round a string");
                assertEqual(floorBy(true), 0, "Cannot round a boolean");
                assertEqual(floorBy([10]), 0, "Cannot round a vector");
            }
            testUnit("round value", 12) {
                assertEqual(floorBy(11), 11, "Should return the provided integer");
                assertEqual(floorBy(11, unit=0), 11, "Should return the provided integer, even if a zero unit has been provided");
                assertEqual(floorBy(18, unit=5), 15, "Should round the provided integer to the near unit (18 ~ 15)");
                assertEqual(floorBy(16, unit=5), 15, "Should round the provided integer to the near unit (16 ~ 15)");
                assertEqual(floorBy(3.14), 3, "Should truncate the positive number if no unit is provided");
                assertEqual(floorBy(-3.14), -4, "Should truncate the negative number if no unit is provided");
                assertEqual(floorBy(1.12345678, unit=.5), 1, "Should round the number to the nearest unit of .5 (1.12345678 ~ 1)");
                assertEqual(floorBy(1.35, unit=.5), 1, "Should round the number to the nearest unit of .5 (1.35 ~ 1)");
                assertEqual(floorBy(1.73, unit=.5), 1.5, "Should round the number to the nearest unit of .5 (1.73 ~ 1.5)");
                assertEqual(floorBy(1.78, unit=.5), 1.5, "Should round the number to the nearest unit of .5 (1.78 ~ 1.5)");
                assertApproxEqual(floorBy(1.5, .2), 1.4, "Should round the positive number to the nearest unit of .2 (1.5 ~ 1.4)");
                assertEqual(floorBy(-1.5, .2), -1.6, "Should round the negative number to the nearest unit of .2 (1.5 ~ 1.6)");
            }
        }
        // test core/maths/ceilBy()
        testModule("ceilBy()", 2) {
            testUnit("default value", 4) {
                assertEqual(ceilBy(), 0, "Should return a 0");
                assertEqual(ceilBy("8"), 0, "Cannot round a string");
                assertEqual(ceilBy(true), 0, "Cannot round a boolean");
                assertEqual(ceilBy([10]), 0, "Cannot round a vector");
            }
            testUnit("round value", 12) {
                assertEqual(ceilBy(11), 11, "Should return the provided integer");
                assertEqual(ceilBy(11, unit=0), 11, "Should return the provided integer, even if a zero unit has been provided");
                assertEqual(ceilBy(18, unit=5), 20, "Should round the provided integer to the near unit (18 ~ 20)");
                assertEqual(ceilBy(16, unit=5), 20, "Should round the provided integer to the near unit (16 ~ 20)");
                assertEqual(ceilBy(3.14), 4, "Should truncate the positive number if no unit is provided");
                assertEqual(ceilBy(-3.14), -3, "Should truncate the negative number if no unit is provided");
                assertEqual(ceilBy(1.12345678, unit=.5), 1.5, "Should round the number to the nearest unit of .5 (1.12345678 ~ 1.5)");
                assertEqual(ceilBy(1.35, unit=.5), 1.5, "Should round the number to the nearest unit of .5 (1.35 ~ 1.5)");
                assertEqual(ceilBy(1.73, unit=.5), 2, "Should round the number to the nearest unit of .5 (1.73 ~ 2)");
                assertEqual(ceilBy(1.78, unit=.5), 2, "Should round the number to the nearest unit of .5 (1.78 ~ 2)");
                assertEqual(ceilBy(1.5, .2), 1.6, "Should round the positive number to the nearest unit of .2 (1.5 ~ 1.6)");
                assertApproxEqual(ceilBy(-1.5, .2), -1.4, "Should round the negative number to the nearest unit of .2 (1.5 ~ 1.4)");
            }
        }
        // test core/maths/decimals()
        testModule("decimals()", 2) {
            testUnit("default value", 4) {
                assertEqual(decimals(), 0, "Should return a 0");
                assertEqual(decimals("8"), 0, "Cannot count decimals in a string");
                assertEqual(decimals(true), 0, "Cannot count decimals in a boolean");
                assertEqual(decimals([10]), 0, "Cannot count decimals in a vector");
            }
            testUnit("number value", 9) {
                assertEqual(decimals(18), 0, "Should not count any decimals in the provided integer");
                assertEqual(decimals(.2), 1, "Should count 1 decimal in this positive number");
                assertEqual(decimals(-.2), 1, "Should count 1 decimal in this negative number");
                assertEqual(decimals(3.14), 2, "Should count 2 decimals in this positive number");
                assertEqual(decimals(-3.14), 2, "Should count 2 decimals in this negative number");
                assertEqual(decimals(1.123456), 6, "Should count 6 decimals in this positive number");
                assertEqual(decimals(-1.123456), 6, "Should count 6 decimals in this negative number");
                assertEqual(decimals(1.12345678), 7, "Should count 7 decimals in this positive number");
                assertEqual(decimals(-1.12345678), 7, "Should count 7 decimals in this negative number");
            }
        }
        // test core/maths/quadraticEquation()
        testModule("quadraticEquation()", 2) {
            testUnit("default value", 4) {
                assertEqual(quadraticEquation(), [], "Cannot resolve quadratic equation of undefined");
                assertEqual(quadraticEquation("1", "2", "3"), [], "Cannot resolve quadratic equation of strings");
                assertEqual(quadraticEquation(true, true, true), [], "Cannot resolve quadratic equation of booleans");
                assertEqual(quadraticEquation([1], [2], [3]), [], "Cannot resolve quadratic equation of vectors");
            }
            testUnit("resolve", 6) {
                assertEqual(quadraticEquation(2, -22, 53), [(22 - sqrt(60)) / 4, (22 + sqrt(60)) / 4], "Should resolve the quadratic equation 2x^2 - 22x + 53 = 0");
                assertEqual(quadraticEquation(2, 4, -4), [-1 - sqrt(3), -1 + sqrt(3)], "Should resolve the quadratic equation 2x^2 + 4x - 4 = 0");
                assertEqual(quadraticEquation(10, -124, 1603), [], "Should not resolve the quadratic equation 10x^2 + -124x - 1603 = 0");
                assertEqual(quadraticEquation(0, 1, 2), [], "Should not resolve the quadratic equation 0x^2 + 1x - 2 = 0");
                assertEqual(quadraticEquation(1, 0, 2), [], "Should not resolve the quadratic equation 1x^2 + 0x - 2 = 0");
                assertEqual(quadraticEquation(1, 2, 0), [-2, 0], "Should resolve the quadratic equation 1x^2 + 2x - 0 = 0");
            }
        }
    }
}

testCoreMaths();
