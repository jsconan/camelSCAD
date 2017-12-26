/**
 * Samples using the camelSCAD library.
 *
 * A parametric target for darts gun.
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
targetDiameter = 50;
socleLength = 60;
socleWidth = 20;
socleAngle = 80;
thickness = 1;
rings = 3;

// Computes additional dimensions, especially the size of the mount body
ringDiameter = targetDiameter / rings;
ringWidth = ringDiameter / 4;
armWidth = ringWidth / 2;
armLength = targetDiameter * 1.1;
cornerRadius = socleWidth / 4;

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
buildBox(mode=renderMode) {
    // First draw the rings
    cylinder(d=ringDiameter, h=thickness);
    if (rings > 1) {
        for(i = [2 : rings]) {
            pipe(d=ringDiameter * i, w=ringWidth, h=thickness);
        }
    }

    // Then draw the cross
    box(l=armLength, w=armWidth, h=thickness);
    box(w=armLength, l=armWidth, h=thickness);

    // Finally draw the socle
    translate([0, armWidth - (socleWidth + targetDiameter) / 2, 0]) {
        trapeziumBox(a=socleLength * 0.8, b=armWidth * 2, w=socleWidth, h=thickness);
    }
    translate([0, armWidth - (socleWidth + targetDiameter / 2), 0]) {
        rotateX(socleAngle) {
            translateY(socleWidth / 2) {
                cushion(size=[socleLength, socleWidth, thickness], r=cornerRadius);
            }
        }
    }
}
