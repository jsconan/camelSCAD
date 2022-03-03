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

/**
 * Part of the camelSCAD library.
 *
 * Global constants to include.
 *
 * @package core/constants
 * @author jsconan
 */

/**
 * The name of the development rendering mode.
 * @type String
 */
MODE_DEV = "dev";

/**
 * The name of the production rendering mode.
 * @type String
 */
MODE_PROD = "prod";

/**
 * The name of the dirty rendering mode.
 * @type String
 */
MODE_DIRTY = "dirty";

/**
 * The name of the default rendering mode.
 * @type String
 */
DEFAULT_MODE = MODE_DEV;

/**
 * Degrees in a circle.
 * @type Number
 */
DEGREES = 360;

/**
 * Degrees of a right angle.
 * @type Number
 */
RIGHT = 90;

/**
 * Degrees of a straight angle.
 * @type Number
 */
STRAIGHT = 180;

/**
 * The end angle of the first quadrant in a circle.
 * @type Number
 */
QUADRANT_1 = RIGHT;

/**
 * The end angle of the second quadrant in a circle.
 * @type Number
 */
QUADRANT_2 = STRAIGHT;

/**
 * The end angle of the third quadrant in a circle.
 * @type Number
 */
QUADRANT_3 = DEGREES - RIGHT;

/**
 * The end angle of the fourth quadrant in a circle.
 * @type Number
 */
QUADRANT_4 = DEGREES;

/**
 * 2D-vector for the origin coordinates.
 * @type Number
 */
ORIGIN_2D = [0, 0];

/**
 * 3D-vector for the origin coordinates.
 * @type Number
 */
ORIGIN_3D = [0, 0, 0];

/**
 * Useful value for computations based on hexagons.
 * @type Number
 */
SQRT3 = sqrt(3);

/**
 * The distance tolerance that will apply to $fs to check if we still need to subdivide the curve.
 * @type Number
 */
BEZIER_TOLERANCE = .25;

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
EPSILON = 0.0000001;

/**
 * The maximum number of decimals
 * @type Number
 */
MAX_DECIMALS = 7;

/**
 * The maximum recursion depth
 * @type Number
 */
MAX_RECURSE = 32;

/**
 * A value representing the Infinity.
 * @type Number
 */
INFINITY = 1e200 * 1e200;

/**
 * Not A Number.
 * @type Number
 */
NAN = 0/0;

/**
 * A value utilized to align wall and ensure proper cuts on one side.
 * @type Number
 */
ALIGN = 0.005;

/**
 * A value utilized to align wall and ensure proper cuts on both sides.
 * @type Number
 */
ALIGN2 = 2 * ALIGN;

/**
 * The default size of the build plate.
 * @type Number
 */
DEFAULT_BUILD_PLATE_SIZE = 200;

/**
 * The default size of the build volume.
 * @type Number
 */
DEFAULT_BUILD_VOLUME_SIZE = DEFAULT_BUILD_PLATE_SIZE;

/**
 * The default size of a cell on the build plate.
 * @type Number
 */
DEFAULT_BUILD_PLATE_CELL = 10;

/**
 * The color for the testbed.
 * @type String
 */
TESTBED_COLOR = "orange";

/**
 * The thickness of the testbed.
 * @type String
 */
TESTBED_THICKNESS = .005;

/**
 * Select a single test to show.
 * @type Number
 */
SELECT_TEST = undef;

/**
 * Show the testbed for the visual tests.
 * @type Boolean
 */
SHOW_TESTBED = true;
