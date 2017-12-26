/**
 * Samples using the camelSCAD library.
 *
 * A parametric christmas star.
 *
 * @author jsconan
 * @license CC0-1.0
 */

// As we need to use some shapes, use the right entry point of the library
use <../shapes.scad>
include <../core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the dimensions of the star
radius = 40;
thickness = 3;
holeDiameter = 4;
ringThickness = 2;
ringDiameter = holeDiameter + ringThickness * 2;
coreRadius = (radius * 2) * (1 - 3 / 5);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(renderMode) {
    // This is the frame of the star
    difference() {
        starBox(size=radius, h=thickness, edges=5, center=true);
        starBox(size=radius / 1.5, h=thickness + 1, edges=5, center=true);
    }
    // This is the core of the star
    rotateZ(180) {
        difference() {
            regularPolygonBox(size=coreRadius, n=5, h=thickness, center=true);
            cylinder(r=radius / 5, h=thickness + 1, center=true);
        }
    }
    // This the ring to hook the star
    translate([0, radius + ringThickness]) {
        pipe(d=ringDiameter, w=ringThickness, h=thickness, center=true);
    }
}
