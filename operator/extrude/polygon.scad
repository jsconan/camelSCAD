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
 * Operators that extrude polygons.
 *
 * @package operator/extrude
 * @author jsconan
 */

/**
 * Extrudes a polygon defined by the given points, optionally increasing the size by
 * adding a distance to the outline.
 *
 * Note: for better results, the points should follow an anti-clockwise order.
 *
 * @param Vector[] points - The points that define the polygon.
 * @param Number [height] - The height of the extrusion. If the value is negative,
 *                          the extrusion will be made top to bottom (below the origin).
 * @param Number|String [direction] - Tells on what sides adjust the height to make sure
 *                                    the difference won't produce dummy walls.
 * @param Boolean [center] - Whether or not center the extrusion on the vertical axis.
 * @param Number [convexity] - If the extrusion fails for a non-trivial 2D shape,
 *                             try setting the convexity parameter.
 * @param Number [twist] - The number of degrees of through which the shape is extruded.
 * @param Number [slices] - Defines the number of intermediate points along the Z axis
 *                          of the extrusion.
 * @param Number|Vector [scale] - Scales the 2D shape by this value over the height of
 *                                the extrusion.
 * @param Number [distance] - A distance added to the polygon's outline.
 */
module extrudePolygon(points, height, direction, center, convexity, twist, slices, scale, distance) {
    points = array(points);

    negativeExtrude(height=height, direction=direction, center=center, convexity=convexity, twist=twist, slices=slices, scale=scale) {
        polygon(distance ? outline(points=points, distance=distance) : points);
    }
}

/**
 * Extrudes a box defined by the given polygon points, optionally increasing the size by
 * adding a distance to the outline.
 *
 * Note: for better results, the points should follow an anti-clockwise order.
 *
 * @param Vector[] points - The points that define the polygon.
 * @param Number [height] - The height of the extrusion. If the value is negative,
 *                          the extrusion will be made top to bottom (below the origin).
 * @param Number [ground] - The thickness of the box floor.
 * @param Number [wall] - The thickness of the box walls.
 * @param Boolean [center] - Whether or not center the extrusion on the vertical axis.
 * @param Number [convexity] - If the extrusion fails for a non-trivial 2D shape,
 *                             try setting the convexity parameter.
 * @param Number [twist] - The number of degrees of through which the shape is extruded.
 * @param Number [slices] - Defines the number of intermediate points along the Z axis
 *                          of the extrusion.
 * @param Number|Vector [scale] - Scales the 2D shape by this value over the height of
 *                                the extrusion.
 * @param Number [distance] - A distance added to the polygon's outline.
 */
module extrudePolygonBox(points, height, ground, wall, center, convexity, twist, slices, scale, distance) {
    wall = divisor(wall);
    ground = divisor(ground);
    distance = float(distance);

    difference() {
        extrudePolygon(points=points, height=height, center=center, convexity=convexity, twist=twist, slices=slices, scale=scale, distance=wall + distance);
        translateZ(ground) {
            extrudePolygon(points=points, height=height, center=center, convexity=convexity, twist=twist, slices=slices, scale=scale, distance=distance);
        }
    }
}
