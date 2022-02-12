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
 * Operators that animate child modules with respect to particular rules.
 *
 * @package operator/animate
 * @author jsconan
 */

/**
 * Scales the child modules, interpolating the scale ratios with respect to the `$t` variable.
 *
 * @param Vector [from] - The scale ratios from where starts the interpolation.
 * @param Vector [to] - The scale ratios to where ends the interpolation.
 * @param Number [start] - The start threshold under what the from-scale ratios will persist and above what it will be interpolated.
 * @param Number [end] - The end threshold above what the to-scale ratios will persist and under what it will be interpolated.
 * @param Number [domain] - The percentage domain used to compute the thresholds (default: 100).
 * @param Vector [values] - A list of scale ratios composing the range to interpolate.
 * @param Vector [range] - A pre-built interpolation range. If missing, it will be built from the parameters `from`, `to`, `start`, `end`, `domain`.
 * @returns Number
 */
module scaleAnimate(from, to, start, end, domain, values, range) {
    scale(interpolateStep3D(step=$t, low=from, high=to, start=start, end=end, domain=domain, values=values, range=range)) {
        children();
    }
}
