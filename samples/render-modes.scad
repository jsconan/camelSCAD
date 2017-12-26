/**
 * Samples using the camelSCAD library.
 *
 * Rendering mode.
 *
 * @author jsconan
 * @license CC0-1.0
 */

// Only include the core of the library as only the render mode helpers are needed
use <../core.scad>
include <../core/constants.scad>

// Defines the list of shapes sizes
DEMO_RANGE = [1 : 10];

// The space between each shape on the same line
DEMO_STEP = 5;

// The start offset of a line
DEMO_OFFSET_X = 20;

// The space between two lines
DEMO_OFFSET_Y = 30;

// The size of the displayed text (the name of illustrated render mode)
DEMO_FONT_SIZE = 10;

// The list of render modes to illustrate
DEMO_MODES = [
    [null, null], // MODE_DEFAULT
    [[.5, 0, 0], MODE_DIRTY],
    [[0, .5, 0], MODE_DEV],
    [[0, 0, .5], MODE_PROD],
];

/**
 * Will illustrate the current render mode by drawing some shapes
 * @param String mode
 */
module demo(mode) {
    // Draw some shapes
    applyMode(mode) {
        for(i = DEMO_RANGE) {
            translate([DEMO_OFFSET_X + DEMO_STEP * i, 0, 0]) {
                sphere(i);
            }
        }
    }

    // Display the mode name
    text(or(mode, "default"), DEMO_FONT_SIZE, halign="center", valign="center");
}

/**
 * Will apply each render mode and will illustrate them by drawing some shapes
 */
for (i = [0 : len(DEMO_MODES) - 1]) {
    translate([DEMO_OFFSET_X, (i + .5) * DEMO_OFFSET_Y, 0]) {
        color(DEMO_MODES[i][0]) {
            demo(DEMO_MODES[i][1]);
        }
    }
}
