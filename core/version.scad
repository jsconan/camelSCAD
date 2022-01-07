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
 * Part of the camelSCAD library.
 *
 * All about the version.
 *
 * @package core/version
 * @author jsconan
 */

/**
 * The version of the library.
 * @type Vector
 */
CAMEL_SCAD_VERSION = [1, 0, 1];

/**
 * The minimal version of OpenSCAD required by the library.
 * @type Vector
 */
REQUIRED_OPEN_SCAD_VERSION = [2019, 5, 0];

/**
 * Gets the version of the library.
 *
 * @param Boolean [string] - Whether or not return the version as a string instead of a vector.
 * @returns Vector|String
 */
function camelSCAD(string=false) = string ? join(CAMEL_SCAD_VERSION, ".") : CAMEL_SCAD_VERSION;

/**
 * Checks if the installed version of OpenSCAD meets the requirements.
 *
 * @returns Boolean - Returns `true` if the installed version of OpenSCAD is up to date enough.
 */
function checkOpenSCAD() =
    let(
        required = REQUIRED_OPEN_SCAD_VERSION[0] * 10000 +
                   REQUIRED_OPEN_SCAD_VERSION[1] * 100 +
                   REQUIRED_OPEN_SCAD_VERSION[2]
    )
    version_num() >= required
;

/**
 * Validates the requirements.
 * Displays a message in the console whether the requirements are not met.
 */
module validateRequirements() {
    if (!checkOpenSCAD()) {
        echo("****");
        echo("** WARNING!!! YOUR VERSION OF OPENSCAD IS TOO OLD!");
        echo("****");
        echo("** PLEASE UPDATE IT, OTHERWISE CAMELSCAD WON'T WORK PROPERLY!");
        echo("****");
    }
}
