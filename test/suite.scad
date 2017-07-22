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
 * Part of the camelSCAD library.
 *
 * Entry point for the unit testing suite.
 *
 * @package test/suite
 * @author jsconan
 */

use <core/version.scad>
use <core/type.scad>
use <core/logic.scad>
use <core/list.scad>
use <core/maths.scad>
use <core/hex.scad>
use <core/line.scad>
use <core/vector.scad>
use <core/vector-2d.scad>
use <core/vector-3d.scad>
use <core/string.scad>
use <core/util.scad>
use <core/mode.scad>

use <util/ansi.scad>
use <util/html.scad>
use <util/test-utils.scad>

use <shape/2D/ellipse.scad>
use <shape/2D/rounded.scad>
use <shape/2D/polygon.scad>

use <shape/3D/ellipsoid.scad>
use <shape/3D/rounded.scad>
use <shape/3D/polyhedron.scad>

use <shape/context/build-box.scad>

testCoreVersion();
testCoreType();
testCoreLogic();
testCoreList();
testCoreMaths();
testCoreHex();
testCoreLine();
testCoreVector();
testCoreVector2D();
testCoreVector3D();
testCoreString();
testCoreUtil();
testCoreMode();

testUtilAnsi();
testUtilHtml();
testUtilTestUtils();

testShape2dEllipse();
testShape2dRounded();
testShape2dPolygon();

testShape3dEllipsoid();
testShape3dRounded();
testShape3dPolyhedron();

testShapeContextBuildBox();
