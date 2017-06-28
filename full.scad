/**
 * @license
 * MIT License
 *
 * Copyright (c) 2017 Jean-Sebastien CONAN
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
 * Entry point of the camelSCAD library.
 *
 * Features set: Includes all components.
 *
 * @author jsconan
 */

/* CORE */
include <core/version.scad>
include <core/constants.scad>
include <core/type.scad>
include <core/logic.scad>
include <core/list.scad>
include <core/maths.scad>
include <core/line.scad>
include <core/vector.scad>
include <core/vector-2d.scad>
include <core/vector-3d.scad>
include <core/string.scad>
include <core/util.scad>
include <core/mode.scad>

/* UNIT TEST & ADDITIONAL FEATURES */
include <util/ansi.scad>
include <util/html.scad>
include <util/test-utils.scad>
include <util/test.scad>

/* OPERATORS */
include <operator/distribute/grid.scad>
include <operator/distribute/mirror.scad>
include <operator/distribute/rotate.scad>
include <operator/distribute/translate.scad>

include <operator/repeat/mirror.scad>
include <operator/repeat/rotate.scad>
include <operator/repeat/translate.scad>

include <operator/rotate/axis.scad>
include <operator/rotate/origin.scad>

include <operator/translate/axis.scad>

include <operator/operation.scad>
include <operator/transform.scad>

/* SHAPES */
include <shape/2D/ellipse.scad>
include <shape/2D/rounded.scad>
include <shape/2D/polygon.scad>

include <shape/3D/ellipsoid.scad>
include <shape/3D/rounded.scad>
include <shape/3D/polyhedron.scad>
