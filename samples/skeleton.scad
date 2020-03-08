/**
 * Samples using the camelSCAD library.
 *
 * A base skeleton
 *
 * @author jsconan
 * @license CC0-1.0
 */

// As we need to use some shapes, use the right entry point of the library
use <../shapes.scad>
include <../core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the constraints of the print
printResolution = 0.2;

// Defines the constraints of the object


// Defines the dimensions of the object


// Displays a build box visualization to preview the printer area.
buildBox(center=true);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {

}
