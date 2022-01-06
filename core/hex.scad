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
 * Operations on hex grids.
 *
 * @package core/hex
 * @author jsconan
 */

/**
 * Computes the number of ranges in a radial hex grid based on the number of cells.
 *
 * @param Vector|Number count - The number of cells.
 * @returns Number - The number of ranges.
 */
function radialHexRange(count) =
    let( number = is_list(count) && len(count) ? min(count) : float(count) )
    floor((abs(divisor(number)) - 1) / 2)
;

/**
 * Computes the number of cells in a radial hex grid based on the number of ranges.
 *
 * @param Number range - The number of ranges.
 * @returns Vector - The number of cells.
 */
function radialHexCount(range) = vector2D(float(range) * 2 + 1);

/**
 * Computes the logical coordinates of cells placed on a hex grid.
 * A radial hex grid is built from several hexagons put aside and has the shape of a bigger hexagon.
 * If the count contains 2 dimensions, the lower value will be used to define the radial range.
 * The number of ranges will define the size of the grid.
 * The number of hexagons will be `1 + 3 * range * (range + 1)`.
 *
 * @param Vector|Number count - The number of cells in the hex grid.
 * @param Boolean [linear] - Tells if the grid is linear instead of radial (default: false).
 * @param Number [cx] - The number of cells per lines.
 * @param Number [cy] - The number of cells per columns.
 * @returns Vector[] - Will return an array of 2D coordinates.
 */
function buildHexGrid(count, linear, cx, cy) =
    let(
        count = apply2D(count, cx, cy)
    )
    linear
   ?let(
        count = vabs(divisor2D(count))
    )
    [
        for (x = [0 : count.x - 1])
            for (y = [0 : count.y - 1])
                [x, y]
    ]
   :let(
        n = radialHexRange(count)
    )
    [
        for(x = [-n : n])
            for(y = [max(-n, -x - n) : min(n, -x + n)])
                [x, -x - y]
    ]
;

/**
 * Computes the offset of a hex grid in order to center it.
 *
 * @param Vector|Number [size] - The size of a cell in the hex grid.
 * @param Vector|Number [count] - The number of cells in the hex grid.
 * @param Boolean [pointy] - Tells if the hexagons in the grid are pointy topped (default: false, Flat topped).
 * @param Boolean [linear] - Tells if the grid is linear instead of radial (default: false).
 * @param Boolean [even] - Tells if the first hexagons of a the linear grid should be below the line (default: false).
 * @param Number [l] - The length of a cell in the hex grid.
 * @param Number [w] - The width of a cell in the hex grid.
 * @param Number [cx] - The number of cells per lines.
 * @param Number [cy] - The number of cells per columns.
 * @returns Vector - The size of the overall hex grid.
 */
function offsetHexGrid(size, count, pointy, linear, even, l, w, cx, cy) =
    !linear
   ?[0, 0]
   :let(
       size = apply2D(size, l, w),
       count = divisor2D(apply2D(count, cx, cy)),
       even = even ? 2 : 1,
       linear = linear ? .5 : 0
    )
    pointy
   ?[
        size.x * SQRT3 * ((even - (count.x + linear))) / 4,
        -size.y * (count.y - 1) * 3 / 8,
    ]
   :[
        -size.x * (count.x - 1) * 3 / 8,
        size.y * SQRT3 * ((even - (count.y + linear))) / 4,
    ]
;

/**
 * Computes the size of a hex grid based on the size of one cell and the number of cells.
 *
 * @param Vector|Number [size] - The size of a cell in the hex grid.
 * @param Vector|Number [count] - The number of cells in the hex grid.
 * @param Boolean [pointy] - Tells if the hexagons in the grid are pointy topped (default: false, Flat topped).
 * @param Boolean [linear] - Tells if the grid is linear instead of radial (default: false).
 * @param Number [l] - The length of a cell in the hex grid.
 * @param Number [w] - The width of a cell in the hex grid.
 * @param Number [cx] - The number of cells per lines.
 * @param Number [cy] - The number of cells per columns.
 * @returns Vector - The size of the overall hex grid.
 */
function sizeHexGrid(size, count, pointy, linear, l, w, cx, cy) =
    let(
        size = apply2D(size, l, w),
        count = divisor2D(apply2D(count, cx, cy)),
        linear = linear ? .5 : 0
    )
    pointy
   ?[
        size.x * SQRT3 * (count.x + linear) / 2,
        size.y * (4 + 3 * (count.y - 1)) / 4,
    ]
   :[
        size.x * (4 + 3 * (count.x - 1)) / 4,
        size.y * SQRT3 * (count.y + linear) / 2
    ]
;

/**
 * Computes the size of a cell in a hex grid based on the size of the grid and the number of cells.
 *
 * @param Vector|Number [size] - The size of the hex grid.
 * @param Vector|Number [count] - The number of cells in the hex grid.
 * @param Boolean [pointy] - Tells if the hexagons in the grid are pointy topped (default: false, Flat topped).
 * @param Boolean [linear] - Tells if the grid is linear instead of radial (default: false).
 * @param Number [l] - The length of the hex grid.
 * @param Number [w] - The width of the hex grid.
 * @param Number [cx] - The number of cells per lines.
 * @param Number [cy] - The number of cells per columns.
 * @returns Vector - The size of the overall hex grid.
 */
function sizeHexCell(size, count, pointy, linear, l, w, cx, cy) =
    let(
        size = apply2D(size, l, w),
        count = divisor2D(apply2D(count, cx, cy)),
        linear = linear ? .5 : 0
    )
    pointy
   ?[
        size.x * 2 / (count.x + linear) / SQRT3,
        size.y * 4 / (4 + 3 * (count.y - 1))
    ]
   :[
        size.x * 4 / (4 + 3 * (count.x - 1)),
        size.y * 2 / (count.y + linear) / SQRT3
    ]
;

/**
 * Computes the number of cells in a hex grid that fits the provided size.
 *
 * @param Vector|Number [size] - The size of the hex grid.
 * @param Vector|Number [cell] - The size of a cell in the hex grid.
 * @param Boolean [pointy] - Tells if the hexagons in the grid are pointy topped (default: false, Flat topped).
 * @param Boolean [linear] - Tells if the grid is linear instead of radial (default: false).
 * @param Number [l] - The length of the hex grid.
 * @param Number [w] - The width of the hex grid.
 * @param Number [cl] - The length of a cell.
 * @param Number [cw] - The width of a cell.
 * @returns Vector - The number of cells in the hex grid.
 */
function countHexCell(size, cell, pointy, linear, l, w, cl, cw) =
    let(
        size = divisor2D(apply2D(size, l, w)),
        cell = divisor2D(apply2D(cell, cl, cw)),
        linear = linear ? .5 : 0
    )
    pointy
   ?[
        floor(size.x * 2 / cell.x / SQRT3 - linear),
        floor((size.y * 4 / cell.y - 1) / 3)
    ]
   :[
        floor((size.x * 4 / cell.x - 1) / 3),
        floor(size.y * 2 / cell.y / SQRT3 - linear)
    ]
;

/**
 * Computes the physical coordinates of a cell in a hex grid based on its logical coordinates.
 *
 * @param Vector|Number hex - The logical coordinates in the hex grid.
 * @param Vector|Number [size] - The size the cell.
 * @param Boolean [pointy] - Tells if the hexagons in the grid are pointy topped (default: false, Flat topped).
 * @param Boolean [linear] - Tells if the grid is linear instead of radial (default: false).
 * @param Boolean [even] - Tells if the first hexagons should be below the line (default: false).
 * @param Number [x] - The logical X-coordinate in the hex grid.
 * @param Number [y] - The logical Y-coordinate in the hex grid.
 * @param Number [l] - The length of the cell.
 * @param Number [w] - The width of the cell.
 * @returns Vector - Physical coordinates.
 */
function coordHexCell(hex, size, pointy, linear, even, x, y, l, w) =
    let(
        hex = apply2D(hex, x, y),
        size = divisor2D(apply2D(size, l, w)) / 2,
        factor = linear && even ? -0.5 : 0.5
    )
    pointy
   ?[
        size.x * SQRT3 * (hex.x + factor * (linear ? hex.y % 2 : hex.y)),
        size.y * hex.y * 1.5
    ]
   :[
        size.x * hex.x * 1.5,
        size.y * SQRT3 * (hex.y + factor * (linear ? hex.x % 2 : hex.x))
    ]
;
