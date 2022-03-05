/**
 * @license
 * MIT License
 *
 * Copyright (c) 2022 Jean-Sebastien CONAN
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

/**
 * Part of the camelSCAD library.
 *
 * Testing helpers for visual tests.
 *
 * @package shape/context
 * @author jsconan
 */

/**
 * Places the children at the proper test area.
 * @param Number length - The length of the test area.
 * @param Number width - The width of the test area.
 * @param Number [index] - The index number of the test.
 * @param Number|Vector [margin] - A margin between each test.
 * @param Number [cols] - The number of columns per lines.
 * @param Boolean [center] - Whether or not the children are centered and need to be moved.
 */
module placeVisualTest(length, width, index=0, margin=0, cols=0, center=false) {
    margin = vector2D(margin);
    x = cols ? index % cols : index;
    y = cols ? floor(index / cols) : 0;
    offset = center ? [length, width, 0] / 2 : ORIGIN_3D;

    translate(offset + [(length + margin.x) * x, (width + margin.y) * y, 0]) {
        children();
    }
}

/**
 * Renders a test element. If no children is given, a cube with an arrow on top is rendered.
 * @param String|Vector [c] - The color of the element.
 * @param Number|Vector [angle] - The angle of the element.
 * @param Number|Vector [size] - The size of the element. It only applies if no children is given.
 * @param Boolean [center] - Whether or not the element is centered. It only applies if no children is given.
 */
module testElement(c="red", angle=0, size=1, center=false) {
    color(c) {
        rotate(angle) {
            if ($children)  {
                children();
            } else let(
                size = vector3D(size),
                half = size / 2,
                quarter = size / 4,
                offset = center ? -half : vector3D()
            ) {
                translate(offset) {
                    linear_extrude(height=size.z, convexity=10) {
                        polygon(
                            points = path([
                                ["P", half.x, size.y],
                                ["L", half.x, -half.y],
                                ["H", -quarter.x],
                                ["V", -half.y],
                                ["H", -half.x],
                                ["V", half.y],
                                ["H", -quarter.x],
                            ]),
                            convexity = 10
                        );
                    }
                    translateZ(quarter.z) {
                        cube(size=[size.x, size.y, half.z]);
                    }
                }
            }
        }
    }
}

/**
 * Colorizes a test element.
 * @param Number alpha - The alpha level for the testbed color.
 */
module testbedColor(alpha) {
    %color(TESTBED_COLOR, alpha) {
        children();
    }
}

/**
 * Extrudes and colorizes a test element.
 * @param Number alpha - The alpha level for the testbed color.
 */
module testbedExtrude(alpha) {
    testbedColor(alpha) {
        linear_extrude(height=TESTBED_THICKNESS, convexity=10, center=true) {
            children();
        }
    }
}

/**
 * Renders a test area, moving the tested shapes in it.
 * A testbed is shown, unless the global variable `TESTBED_SHOW` is set to `false`.
 * @param Number index - The index number of the test.
 * @param Number length - The length of the test area.
 * @param Number width - The width of the test area.
 * @param String [title] - The title for the test.
 * @param Number|Vector [margin] - A margin between each test.
 * @param Number [cols] - The number of columns per lines.
 * @param Boolean [center] - Whether or not the children are centered and need to be moved.
 */
module visualTest(index, length, width, title="test", margin=1, cols=0, center=false) {
    title = str(title, " ", index);

    placeVisualTest(
        length = length,
        width = width,
        index = index,
        margin = margin,
        cols = cols,
        center = center
    ) {
        // test area
        if (TESTBED_SHOW) {
            testbedExtrude(.1) {
                square([length, width], center=center);
            }
            translate(center ? ORIGIN_3D : [length, width, 0] / 2) {
                testbedExtrude(1) {
                    text(title, size=min(length, width) / len(title), font="Liberation Sans", valign="center", halign="center");
                }
            }
        }

        // tested shapes
        children();
    }
}

/**
 * Renders a test area for each child module, moving the tested shapes in it.
 * A single test can be selected by its index thanks to the global variable `SELECT_TEST`.
 * @param Number length - The length of the test area.
 * @param Number width - The width of the test area.
 * @param String [title] - The title for the test.
 * @param Number|Vector [margin] - A margin between each test.
 * @param Number [cols] - The number of columns per lines.
 * @param Boolean [center] - Whether or not center the whole suite.
 * @param Boolean [centerEach] - Whether or not center each test area.
 */
module visualTestSuite(length, width, title="test", margin=1, cols=0, center=false, centerEach=false) {
    margin = vector2D(margin);
    count = $children;
    SELECT_TEST = is_undef(SELECT_TEST) ? undef : min(max(0, SELECT_TEST), count - 1);
    start = is_undef(SELECT_TEST) ? 0 : SELECT_TEST;
    end = is_undef(SELECT_TEST) ? count - 1 : SELECT_TEST;
    lines = cols ? ceil(count / cols) : 1;
    offset = center ? -([margin.x * (cols - 1), margin.y * (lines - 1), 0] + [length * cols, width * lines, 0]) / 2 : ORIGIN_3D;

    translate(offset) {
        for (i = [start : end]) {
            visualTest(
                index = i,
                length = length,
                width = width,
                title = title,
                margin = margin,
                cols = cols,
                center = centerEach
            ) {
                children(i);
            }
        }
    }
}
