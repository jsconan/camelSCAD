/**
 * @license
 * MIT License
 *
 * Copyright (c) 2017-2019 Jean-Sebastien CONAN
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
 * Rendering mode.
 *
 * @package core/mode
 * @author jsconan
 */

/**
 * Specifications for each rendering modes.
 * Each mode is defined this way: ["name", value for $fa, value for $fs]
 * @type Vector
 */
MODES = [
    [MODE_DIRTY, 6, 2],
    [MODE_DEV, 1, 1.5],
    [MODE_PROD, .5, .5]
];

/**
 * Gets the specifications of a particular rendering mode.
 *
 * @param String [mode] - The mode for which get the specifications.
 * @returns Vector
 */
function renderMode(mode) = fetch(MODES, or(mode, DEFAULT_MODE));

/**
 * Gets the minimum facet angle for a particular rendering mode.
 *
 * @param String [mode] - The mode for which get the specification.
 * @returns Number
 */
function facetAngle(mode) = renderMode(mode)[1];

/**
 * Gets the minimum facet size for a particular rendering mode.
 *
 * @param String [mode] - The mode for which get the specification.
 * @returns Number
 */
function facetSize(mode) = renderMode(mode)[2];

/**
 * Applies a render mode onto the children modules.
 *
 * @param String [mode] - The mode to apply on the children modules.
 */
module applyMode(mode) {
    $fa = facetAngle(mode);
    $fs = facetSize(mode);

    children();
}
