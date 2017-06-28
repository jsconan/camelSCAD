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

/**
 * Part of the camelSCAD library.
 *
 * Global constants to include.
 *
 * @package core/constants
 * @author jsconan
 */

/**
 * The name of the default rendering mode.
 * @type String
 */
DEFAULT_MODE = "dev";

/**
 * Degrees in a circle.
 * @type Number
 */
DEGREES = 360;

/**
 * Minimum value for $fa and $fs.
 * @type Number
 */
MIN_ANGLE = 0.01;

/**
 * Minimum allowed size.
 * @type Number
 */
MIN_SIZE = 0.000001;

/**
 * A very very small value.
 * @type Number
 */
EPSILON = 0.000001;

/**
 * A value utilized to align wall and ensure proper cuts on one side.
 * @type Number
 */
ALIGN = 0.001;

/**
 * A value utilized to align wall and ensure proper cuts on both sides.
 * @type Number
 */
ALIGN2 = 2 * ALIGN;
