/**
 * Samples using the camelSCAD library.
 *
 * A simple parametric pipe.
 *
 * @author jsconan
 * @license CC0-1.0
 */

// As we need to use some shapes, use the right entry point of the library
use <../shapes.scad>

// We will render the object using the specifications of this mode
renderMode = "prod";

// Defines the dimensions of the pipe
height = 50;
width = 1;
innerDiameter = 9.5;
outerDiameter = innerDiameter + width * 2;

// Sets the minimum facet angle and size using the defined render mode.
$fa = facetAngle(renderMode);
$fs = facetSize(renderMode);

// And draw the pipe accordingly
pipe(d=outerDiameter, h=height, w=width);
