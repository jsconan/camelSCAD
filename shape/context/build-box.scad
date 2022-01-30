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
            cell.x ? floor(size.x / cell.x) : 0,
            cell.y ? floor(size.y / cell.y) : 0
        ],
        count = [
            nb.x + 1,
            nb.y + 1
        ],
        offset = [
            cell.x ? -nb.x * cell.x / 2 : 0,
            cell.y ? -nb.y * cell.y / 2 : 0
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
 * @param Boolean [center] - The shape is centered vertically.
 */
module buildPlate(size=DEFAULT_BUILD_PLATE_SIZE, cell=DEFAULT_BUILD_PLATE_CELL, l, w, cl, cw, center=false) {
    size = sizeBuildPlate(size=size, cell=cell, l=l, w=w, cl=cl, cw=cw);
    plateSize = size[0];
    cellSize = size[1];
    cellCount = size[2];
    cellOffset = size[3];

    plateHeight = 1;
    lineWidth = .5;

    %color([1, 1, 1, .2]) {
        negativeExtrude(height=-plateHeight, direction=0) {
            translate(center ? -plateSize / 2 : [0, 0]) {
                square(plateSize);
            }
        }
        negativeExtrude(height=-plateHeight, direction=2) {
            translate(center ? [cellOffset.x, -plateSize.y / 2, 0] : ORIGIN_3D) {
                repeat(count=cellCount.x, intervalX=cellSize.x) {
                    square([lineWidth, plateSize.y]);
                }
            }
            translate(center ? [-plateSize.x / 2, cellOffset.y, 0] : ORIGIN_3D) {
                repeat(count=cellCount.y, intervalY=cellSize.y) {
                    square([plateSize.x, lineWidth]);
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
 * @param Boolean [center] - The shape is centered vertically.
 */
module buildVolume(size=DEFAULT_BUILD_VOLUME_SIZE, l, w, h, center=false) {
    %color([1, 1, 1, .1]) {
        size = apply3D(size, l, w, w);
        translate(center ? apply3D(-size / 2, z=0) : ORIGIN_3D) {
            cube(size);
        }
    }
}

/**
 * Creates a build box visualization at the origin.
 * A build box contains visualizations for a build plate and a build volume.
 *
 * @param Number|Vector [size] - The size of the build volume.
 * @param Number|Vector [cell] - The size of each cell on the build plate.
 * @param Number [l] - The overall length.
 * @param Number [w] - The overall width.
 * @param Number [h] - The overall height.
 * @param Number [cl] - The length of a cell.
 * @param Number [cw] - The width of cell.
 * @param Boolean [center] - The shape is centered vertically.
 */
module buildBox(size=DEFAULT_BUILD_VOLUME_SIZE, cell=DEFAULT_BUILD_PLATE_CELL, l, w, h, cl, cw, center=false) {
    buildPlate(size=size, cell=cell, l=l, w=w, cl=cl, cw=cw, center=center);
    buildVolume(size=size, l=l, w=w, h=h, center=center);

    children();
}
