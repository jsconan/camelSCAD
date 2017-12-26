/**
 * Samples using the camelSCAD library.
 *
 * A parametric closed barrel.
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
diameter = 40;
height = 60;
fillet = ceil(min(diameter, height) / 20);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(renderMode) {
    peg([diameter, diameter, height], r=fillet);
}
