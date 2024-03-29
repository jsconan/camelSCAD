/**
 * @license
 * MIT License
 *
 * Copyright (c) 2017-2022 Jean-Sebastien CONAN
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
 * Features set: Includes the core components and the operators.
 *
 * @author jsconan
 */

/* CORE */
include <core.scad>

/* OPERATORS */
include <operator/animate/mirror.scad>
include <operator/animate/present.scad>
include <operator/animate/resize.scad>
include <operator/animate/rotate.scad>
include <operator/animate/scale.scad>
include <operator/animate/translate.scad>

include <operator/distribute/grid.scad>
include <operator/distribute/mirror.scad>
include <operator/distribute/rotate.scad>
include <operator/distribute/translate.scad>

include <operator/extrude/negative.scad>
include <operator/extrude/polygon.scad>

include <operator/repeat/alternate.scad>
include <operator/repeat/grid.scad>
include <operator/repeat/mirror.scad>
include <operator/repeat/rotate.scad>
include <operator/repeat/translate.scad>

include <operator/rotate/axis.scad>
include <operator/rotate/origin.scad>

include <operator/test/test.scad>

include <operator/translate/axis.scad>

include <operator/operation.scad>
include <operator/transform.scad>
include <operator/sample.scad>
