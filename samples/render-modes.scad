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
    [[.5, 0, 0], "dirty"],
    [[0, .5, 0], "dev"],
    [[0, 0, .5], "prod"],
];

/**
 * Will illustrate the current render mode by drawing some shapes
 * @param String mode
 */
module demo(mode) {
    // Draw some shapes
    for(i = DEMO_RANGE) {
        translate([DEMO_OFFSET_X + DEMO_STEP * i, 0, 0]) {
            sphere(i);
        }
    }

    // Display the mode name
    text(mode, DEMO_FONT_SIZE, halign="center", valign="center");
}

/**
 * Sets the minimum facet angle and size using the default render mode.
 */
$fa = facetAngle();
$fs = facetSize();

/**
 * Will apply each render mode and will illustrate them by drawing some shapes
 */
translate([DEMO_OFFSET_X, 0, 0]) {
    demo("default");
}
for (i = [0 : len(DEMO_MODES) - 1]) {
    translate([DEMO_OFFSET_X, (i + 1) * DEMO_OFFSET_Y, 0]) {
        color(DEMO_MODES[i][0]) {
            mode = DEMO_MODES[i][1];

            $fa = facetAngle(mode);
            $fs = facetSize(mode);

            demo(mode);
        }
    }
}
