/**
 * @license
 * MIT License
 *
 * Copyright (c) 2022 Jean-Sebastien CONAN
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

/**
 * Part of the camelSCAD library.
 *
 * Entry point for visual testing.
 *
 * Test the shape: buildPlate()
 *
 * @package test/suite
 * @author jsconan
 */

include <../../../../../full.scad>

RENDER_MODE = "prod";
TESTBED_SELECT = -1;
TESTBED_RANGE = [0, 8];
TESTBED_SHOW = true;

applyMode(RENDER_MODE) {
    size = DEFAULT_BUILD_VOLUME_SIZE * 2;
    visualTestSuite(length=size, width=size, cols=3, margin=2, center=true) {
        /*  0 */  buildPlate();
        /*  1 */  buildPlate(100, 5);
        /*  2 */  buildPlate(center=true);

        /*  3 */  buildPlate(size=100, l=50);
        /*  4 */  buildPlate(size=100, w=50);
        /*  5 */  buildPlate(size=100, l=50, w=50);

        /*  6 */  buildPlate(size=100, cell=5, cl=10);
        /*  7 */  buildPlate(size=100, cell=5, cw=10);
        /*  8 */  buildPlate(size=100, cell=5, cl=10, cw=10);
    }
}
