/**
 * Samples using the camelSCAD library.
 *
 * A parametric card holder.
 *
 * @author jsconan
 * @license CC0-1.0
 */

// As we need to use some shapes, use the right entry point of the library
use <../shapes.scad>

// Defines the dimensions of the object
length = 60;
width = 20;
thickness = 1;
slotWidth = 1.2;

// Computes additional dimensions, especially the size of the mount body
cornerRadius = width / 4;
mountLength = length * 0.9;
mountWidth = width / 3;
mountHeight = mountWidth;

// Computes the size of the wedge that will drill the card slot in the card mount
wedgeAngle = atan2(slotWidth / 2, mountHeight) * 2;

// We will render the object using the specifications of this mode
renderMode = "prod";

// Sets the minimum facet angle and size using the defined render mode.
$fa = facetAngle(renderMode);
$fs = facetSize(renderMode);

// First draw the socle
cushion(size=[length, width, thickness], r=cornerRadius);

// Then draw the card mount
difference() {
    // This is the mount body
    pill(size=[mountLength, mountWidth, mountHeight * 2]);

    // Will remove the unused part of the mount body (the side that is under the socle)
    translate([0, 0, -mountHeight]) {
        box(size=[mountLength, mountWidth, mountHeight + thickness / 2]);
    }

    // Will drill the card slot
    translate([0, 0, thickness]) {
        rotateY(270) {
            wedge(r=wedgeAngle, h=length, a1=-wedgeAngle / 2, a=wedgeAngle, center=true);
        }
    }
}
