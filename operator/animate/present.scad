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
 * Presents the child modules only between the start and end thresholds, with respect to the `$t` variable.
 *
 * @param Number [start] - The start threshold under what the child modules will be hidden and above what they will be presented.
 * @param Number [end] - The end threshold above what the child modules will be hidden and under what they will be presented.
 * @param Number [domain] - The percentage domain used to compute the thresholds (default: 100).
 */
module presentAnimate(start, end, domain) {
    start = abs(percentage(numberOr(start, 0), domain=domain));
    end = abs(percentage(numberOr(end, 1), domain=domain));
    if( $t >= min(start, end) && $t <= max(start, end) ) {
        children();
    }
}
