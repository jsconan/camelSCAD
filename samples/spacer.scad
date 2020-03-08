/**
 * Samples using the camelSCAD library.
 *
 * A parametric spacer.
 *
 * @author jsconan
 * @license CC0-1.0
 */

// As we need to use some shapes, use the right entry point of the library
use <../shapes.scad>
include <../core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the dimensions of the object
length = 24;
width = 24;
height = 12.85;
diameter = 6;
fillet = ceil(min(length, width) / 10);

// Displays a build box visualization to preview the printer area.
buildBox(center=true);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    difference() {
        cushion([length, width, height], r=fillet);
        translateZ(-ALIGN) {
            cylinder(d=diameter, h=height + ALIGN2);
        }
    }
}
