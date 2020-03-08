/**
 * Samples using the camelSCAD library.
 *
 * A simple framed heart using Bezier curve.
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
scaleFactor = 5;
height = 4;
controls = [[0, 0], [5, 3], [5, 10], [0, 7]] * scaleFactor;

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
applyMode(renderMode) {
    // As we are using function to generate points based on the current render mode
    // we need to wrap the call into one union to ensure the render mode is well applied
    union() {
        // Computes the points that draw half the heart
        half = cubicBezierCurve(controls[0], controls[1], controls[2], controls[3]);

        // Assembles the points that draw the full heart
        points = concat(half, mirror2D(half));

        // Compute the size of the heart
        size = dimensions2D(points);
        echo("Size", size);

        // Draws the heart
        linear_extrude(height=height, convexity=10) {
            // Frame
            difference() {
                rectangle(size + vector2D(scaleFactor));
                rectangle(size);
            }

            // Heart
            translateY(-size[1] / 2) {
                polygon(
                    points=points
                );
            }
        }

        // Displays the control points to illustrate how the curve is constrained
        translate([0, -size[1] / 2, height]) {
            controlPoints(controls, size=2);
        }
        buildPlate(center=true);
    }
}
