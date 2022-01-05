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
 * Miscellaneous utils.
 *
 * @package core/util
 * @author jsconan
 */

/**
 * Builds a position value:
 * -1: there is something before
 *  0: there is nothing anywhere
 *  1: there is something after
 *  2: there is something before and after
 *
 * @param Boolean [before] - If there is something before.
 * @param Boolean [after] - If there is something after.
 * @returns Number
 */
function position(before, after) =
    before && after ? 2
   :after ? 1
   :before ? -1
   :0
;

/**
 * Checks a position value and tells if there is something before.
 * -1: there is something before
 *  0: there is nothing anywhere
 *  1: there is something after
 *  2: there is something before and after
 *
 * @param Number position - The position value.
 * @returns Boolean
 */
function before(position) =
    let( position = float(position) )
    position < 0 || position > 1
;

/**
 * Checks a position value and tells if there is something after.
 * -1: there is something before
 *  0: there is nothing anywhere
 *  1: there is something after
 *  2: there is something before and after
 *
 * @param Number position - The position value.
 * @returns Boolean
 */
function after(position) = float(position) > 0;

/**
 * Gets a numeric representation of a cardinal point.
 * West and Eath are related to X-coordinate (resp. -1 and 1, or 2 if both).
 * South and North are related to Y-coordinate (resp. -1 and 1, or 2 if both).
 *
 * A cardinal expression is a string that contains cardinal point literals:
 * - "n": North
 * - "e": East
 * - "s": South
 * - "w": West
 *
 * Combinations are allowed, for instance
 * - "ne" means North East, and will be translated to [1, 1]
 * - "nwe" means North Weast East, and will be translated to [2, 1]
 * - "nsw" means North South Weast, and will be translated to [-1, 2]
 * - "nswe" means North South Weast East, and will be translated to [2, 2]
 *
 * @param Vector|String p - A vector or a cardinal expression.
 * @returns Vector - A 2D vector that contains position values for horizontal and vertical axis.
 */
function cardinal(p) =
    is_num(p) || isVector(p) ?
        let( p = vector2D(p) )
        [ position(before(p[0]), after(p[0])),
          position(before(p[1]), after(p[1])) ]
    :
        let( p = p && p != true ? str(p) : "" )
        [ position(min(len(search("wW", p)), 1), min(len(search("eE", p)), 1)),
          position(min(len(search("sS", p)), 1), min(len(search("nN", p)), 1)) ]
;

/**
 * Computes a size value, and its offset, of an object to be used as a negative for a `difference()` operation.
 * An alignment value will be added according to the parameter `direction` to counter the wall alignment issue.
 *
 * @param Number [value] - The value of the size to adjust. If the value is negative, the offset will be adjusted
 *                         to allow top to bottom position (below the origin).
 * @param Number|String [direction] - Tells on what sides adjust the size to make sure the difference won't
 *                                    produce dummy walls.
 * @param Boolean [center] - Whether or not center the position on the axis.
 * @returns Vector - A 2D vector that contains the adjusted size and its offset.
 */
function align(value, direction, center) =
    let(
        direction = cardinal(uor(direction, 2))[1],
        value = divisor(value),
        absv = abs(value),
        adjust = direction ? (direction == 2 ? ALIGN2 : ALIGN) : 0,
        offset = center ? (direction == 2 || direction == 0 ? 0 : direction * ALIGN / 2)
                        : (direction == 2 || direction == -1 ? -ALIGN : 0)
    )
    [
        absv + adjust,
        offset + (value < 0 && !center ? value : 0)
    ]
;
