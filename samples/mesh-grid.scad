/**
 * Samples using the camelSCAD library.
 *
 * A simple mesh grid
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
length = 120;
width = 120;
thickness = 2;
corner = 8;
paddingX = 6;
paddingY = 6;
holeDiameter = 5;
holeIntervalX = length - 2 * holeDiameter;
holeIntervalY = width - 2 * holeDiameter;

cellCountX = 10;
cellCountY = 10;
cellSpaceX = 1;
cellSpaceY = 1;
meshLength = length - 2 * paddingX;
meshWidth  = width - 2 * paddingY;

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
applyMode(mode=renderMode) {
    difference() {
        cushion([length, width, thickness], d=corner);

        negativeExtrude(thickness, direction=2) {
            translate([holeIntervalX, holeIntervalY, 0] / -2) {
                repeat2D(countX=2, countY=2, intervalX=[holeIntervalX, 0, 0], intervalY=[0, holeIntervalY, 0]) {
                    circle(d=holeDiameter);
                }
            }

            mesh(
                size  = [meshLength, meshWidth],
                count = [cellCountX, cellCountY],
                gap   = [cellSpaceX, cellSpaceY],
                linear = true,
                even = true,
                pointy = false
            );
        }
    }
}
