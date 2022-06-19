/**
 * Samples using the camelSCAD library.
 *
 * A parametric tube cap.
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
thickness = 1;
rimDiameter = 40;
holeDiameter = 30;
tubeDiameter = holeDiameter + 2 * thickness;
tubeDepth = 5;

// Displays a build box visualization to preview the printer area.
buildBox(center=true);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    difference() {
        union() {
            pipe(d=tubeDiameter, w=thickness, h=tubeDepth + thickness);
            cylinder(d=rimDiameter, h=thickness);
        }
        translateZ(-ALIGN) {
            cylinder(d1=tubeDiameter, d2=holeDiameter, h=thickness + ALIGN2);
        }
    }
}
