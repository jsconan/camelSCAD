/**
 * Samples using the camelSCAD library.
 *
 * A parametric honeycombed style box
 *
 * @author jsconan
 * @license CC0-1.0
 */

// As we need to use some shapes, use the right entry point of the library
use <../shapes.scad>

/**
 * Renders a honeycomb at the origin.
 *
 * @param Vector|Number size - The outer dimensions of the honeycomb
 * @param Number thickness - The thickness of the box walls (default 1). Cannot be greater than 10% of the lowest dimension.
 */
module honeycomb(size, thickness) {
    // Adjust the values to get usable size and thickness
    size = vector3D(size);
    width = min(size[0], size[1]);
    thickness = min(numberOr(thickness, 1), width / 10);
    adjust = max(size[0], size[1]) - width;
    innerWidth = width - thickness * 2;

    difference() {
        // This is the outside of the honeycomb
        hexagonBox(l=width, w=width, h=size[2], adjust=adjust);

        // This is the inside of the honeycomb
        translate([0, 0, thickness]) {
            hexagonBox(l=innerWidth, w=innerWidth, h=size[2], adjust=adjust);
        }
    }

}

// We will render the object using the specifications of this mode
renderMode = "prod";

// Defines the dimensions of the honeycomb
length = 60;
width = 50;
height = 30;
thickness = 2;

// intervals between honeycombs
adjustX = (max(length, width) - min(length, width)) / 4;
spaceX = cos(60) * length / 2 + thickness - adjustX;
spaceY = cos(30) * width - thickness;

// The number of honeycombs to render on both X and Y axis
nbX = 4;
nbY = 4;

// Sets the minimum facet angle and size using the defined render mode.
$fa = facetAngle(renderMode);
$fs = facetSize(renderMode);

// The honeycombed box is drawed by rendering several honeycombs using the repeat2D operator
repeat2D(countX=nbX, countY=nbY, intervalX=[length - spaceX, spaceY / 2, 0], intervalY=[0, spaceY, 0]) {
    honeycomb(size = [length, width, height], thickness=thickness);
}
