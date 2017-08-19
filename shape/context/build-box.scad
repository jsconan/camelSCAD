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
 * Build box visualization.
 *
 * @package shape/context
 * @author jsconan
 */

/**
 * Computes the size of the build plate.
 *
 * @param Number|Vector [size] - The size of the build plate.
 * @param Number|Vector [cell] - The size of each cell on the build plate.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [cl] - The length of a cell.
 * @param Number [cw] - The width of cell.
 * @returns Vector - Returns the size vector.
 */
function sizeBuildPlate(size, cell, l, w, cl, cw) =
    let(
        size = apply2D(uor(size, DEFAULT_BUILD_PLATE_SIZE), l, w),
        cell = apply2D(uor(cell, DEFAULT_BUILD_PLATE_CELL), cl, cw),
        nb = [
            cell[0] ? floor(size[0] / cell[0]) : 0,
            cell[1] ? floor(size[1] / cell[1]) : 0
        ],
        count = [
            nb[0] + 1,
            nb[1] + 1
        ],
        offset = [
            cell[0] ? -nb[0] * cell[0] / 2 : 0,
            cell[1] ? -nb[1] * cell[1] / 2 : 0
        ]
    )
    [ size, cell, count, offset ]
;

/**
 * Creates a build plate visualization at the origin.
 *
 * @param Number|Vector [size] - The size of the build plate.
 * @param Number|Vector [cell] - The size of each cell on the build plate.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [cl] - The length of a cell.
 * @param Number [cw] - The width of cell.
 */
module buildPlate(size=DEFAULT_BUILD_PLATE_SIZE, cell=DEFAULT_BUILD_PLATE_CELL, l, w, cl, cw) {
    size = sizeBuildPlate(size=size, cell=cell, l=l, w=w, cl=cl, cw=cw);
    plateSize = size[0];
    cellSize = size[1];
    cellCount = size[2];
    cellOffset = size[3];

    plateHeight = 1;
    lineWidth = .5;

    %color([1, 1, 1, .2]) {
        negativeExtrude(height=-plateHeight, direction=0) {
            rectangle(plateSize);
        }
        negativeExtrude(height=-plateHeight, direction=2) {
            translateX(cellOffset[0]) {
                repeat(count=cellCount[0], intervalX=cellSize[0]) {
                    rectangle([lineWidth, plateSize[1]]);
                }
            }
            translateY(cellOffset[1]) {
                repeat(count=cellCount[1], intervalY=cellSize[1]) {
                    rectangle([plateSize[0], lineWidth]);
                }
            }
        }
    }
}

/**
 * Creates a build volume visualization at the origin.
 *
 * @param Number|Vector [size] - The size of the build box.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 */
module buildVolume(size=DEFAULT_BUILD_VOLUME_SIZE, l, w, h) {
    %color([1, 1, 1, .1]) {
        box(size=size, l=l, w=w, h=w);
    }
}

/**
 * Creates a build box visualization at the origin.
 * A build box contains visualizations for a build plate and a build volume.
 * It also applies a render mode.
 * @param Number|Vector [size] - The size of the build volume.
 * @param Number|Vector [cell] - The size of each cell on the build plate.
 * @param String [mode] - The mode to apply on the children modules.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [cl] - The length of a cell.
 * @param Number [cw] - The width of cell.
 */
module buildBox(size, cell, mode, l, w, h, cl, cw) {
    size = apply3D(uor(size, DEFAULT_BUILD_PLATE_SIZE), l, w, h);

    buildPlate(size=size, cell=cell, l=l, w=w, cl=cl, cw=cw);
    buildVolume(size=size, l=l, w=w, h=h);

    applyMode(mode) {
        children();
    }
}
