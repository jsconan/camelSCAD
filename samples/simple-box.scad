/**
 * Samples using the camelSCAD library.
 *
 * A simple parametric box with rounded corners.
 *
 * @author jsconan
 * @license CC0-1.0
 */

// As we need to use some shapes, use the right entry point of the library
use <../shapes.scad>
include <../core/constants.scad>

/**
 * Renders a rounded box at the origin.
 *
 * @param Vector|Number size - The outer dimensions of the box
 * @param Number thickness - The thickness of the box walls (default 1). Cannot be greater than 10% of the lowest dimension.
 * @param Number radius - The radius of the corner (default 10% of the lowest dimension)
 */
module simpleBox(size, thickness, radius) {
    // Adjust the values to get usable size, thickness, and rounded corner radius
    size = vector3D(size);
    lowest = min(size[0], size[1]) / 10;
    thickness = min(numberOr(thickness, 1), lowest);
    radius = numberOr(radius, lowest);

    // Compute the size and position of the handle hole
    handleRadius = size[0] + size[1];
    handleCenter = center2D(
        a=apply2D(x=-size[0] / 2 + radius, y=size[2]),
        b=apply2D(x=size[0] / 2 - radius, y=size[2]),
        r=handleRadius,
        negative=true
    );

    difference() {
        // This is the outside of the box
        cushion(size=size, r=radius);

        // This is the inside of the box
        translateZ(thickness) {
            cushion(size=apply3D(size, x=size[0] - thickness * 2, y=size[1] - thickness * 2), r=radius-thickness/2);
        }

        // This is the handle hole
        rotateX(90) {
            translate(vector3D(handleCenter)) {
                cylinder(r=handleRadius, h=size[1] + 1, center=true);
            }
        }
    }

}

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the dimensions of the box
length = 100;
width = 70;
height = 40;
thickness = 1;
radius = 5;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(renderMode) {
    // And draw the box accordingly
    simpleBox(size = [length, width, height], thickness=thickness, radius=radius);

    // We may also draw a cover by rendering another box that has an increased size with respect to the wall thickness...
    %translateZ(height + thickness) {
        rotateX(180) {
            // Use an additional adjustment value (0.1) to counter the printer's precision lack and
            // allow to put the cover in place once printed.
            sizeAdjust = thickness * 2 + 0.1;
            simpleBox(size = [length + sizeAdjust, width + sizeAdjust, height + thickness], thickness=thickness, radius=radius);
        }
    }
}
