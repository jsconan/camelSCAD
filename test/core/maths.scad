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
    testPackage("core/maths.scad", 8) {
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
        // test core/maths/angle()
        testModule("angle()", 2) {
            testUnit("default value", 3) {
                assertEqual(angle(), 0, "Should return 0 if no vector was provided");
                assertEqual(angle("1", "2"), 0, "Cannot compute angle of strings");
                assertEqual(angle(true, true), 0, "Cannot compute angle of booleans");
            }
            testUnit("compute angle", 4) {
                assertEqual(angle(1, 2), 0, "When single numbers are provided, they should be translated to vector. Vectors with same direction does not have angle.");
                assertEqual(angle([1, 0], [0, 1]), 90, "Orthogonal vectors have an angle of 90°");
                assertEqual(angle([1, 0], [0, -1]), 90, "Orthogonal vectors have an angle of 90°, whatever their direction");
                assertEqual(angle([1, 0], [-1, 0]), 180, "Vectors with opposite direction have an angle of 180°");
            }
        }
        // test core/maths/pythagore()
        testModule("pythagore()") {
            testUnit("no parameter", 1) {
                assertEqual(pythagore(), 0, "Without parameter the function should return 0");
            }
            testUnit("wrong type", 5) {
                assertEqual(pythagore("10", "10"), 0, "Strings should be converted to 0");
                assertEqual(pythagore(true, true), 0, "Booleans should be converted to 0");
                assertEqual(pythagore([], []), 0, "Empty arrays should be converted to 0");
                assertEqual(pythagore(["1"], ["2"]), 0, "Arrays should be converted to 0");
                assertEqual(pythagore([1], [2]), 0, "Vectors should be converted to 0");
            }
            testUnit("number", 9) {
                assertEqual(pythagore(0), 0, "If the only one parameter is 0, the function should not fail, but should return 0");
                assertEqual(pythagore(0, 0, 0), 0, "If all parameters are 0 the function should not fail, but should return 0");

                assertEqual(pythagore(a=10), 10, "If only one parameter is provided, the function cannot compute the result, but it should return the provided value");
                assertEqual(pythagore(b=20), 20, "If only one parameter is provided, the function cannot compute the result, but it should return the provided value");
                assertEqual(pythagore(c=30), 30, "If only one parameter is provided, the function cannot compute the result, but it should return the provided value");

                assertEqual(pythagore(a=2, b=3), sqrt(4+9), "If A and B are provided the function should compute C");
                assertEqual(pythagore(a=5, c=7), sqrt(49-25), "If A and C are provided the function should compute B");
                assertEqual(pythagore(a=3, c=8), sqrt(64-9), "If B and C are provided the function should compute A");
                assertEqual(pythagore(a=3, b=5, c=8), sqrt(64-9), "If A, B and C are provided the function should compute B");

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
    }
}

testCoreMaths();
