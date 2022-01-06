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
 * Strings manipulations for ANSI terminal.
 *
 * @package util/ansi
 * @author jsconan
 */

 /**
  * Defines ANSI colors.
  * @type Number
  */
ANSI_COLOR_BLACK = 0;
ANSI_COLOR_RED = 1;
ANSI_COLOR_GREEN = 2;
ANSI_COLOR_YELLOW = 3;
ANSI_COLOR_BLUE = 4;
ANSI_COLOR_MAGENTA = 5;
ANSI_COLOR_CYAN = 6;
ANSI_COLOR_WHITE = 7;

/**
 * Defines ANSI color mode.
 * @type Number
 */
ANSI_COLOR_NORMAL = 0;
ANSI_COLOR_BRIGHT = 1;

/**
 * Defines ANSI color ground.
 * @type Number
 */
ANSI_COLOR_FOREGROUND = 30;
ANSI_COLOR_BACKGROUND = 40;

/**
 * Produces an ANSI SGR code to change the console output.
 * @param Number|String code - An ANSI code, or a list of ANSI codes that will be join with `;` separator.
 * @returns String
 */
function ansiCode(code) =  str(
    chr(27),
    "[",
    or(is_list(code) ? join(code, ";") : code, "0"),
    "m"
);

/**
 * Produces an ANSI SGR code to reset attributes.
 * @returns String
 */
function ansiCodeOff() = ansiCode("0");

/**
 * Produces an ANSI background color code.
 * @param Number color - A color index in the range [0..7].
 * @returns Number
 */
function ansiBackgroundColor(color) = ANSI_COLOR_BACKGROUND + abs(integer(color)) % 8;

/**
 * Produces an ANSI foreground color code.
 * @param Number color - A color index in the range [0..7].
 * @returns Number
 */
function ansiForegroundColor(color) = ANSI_COLOR_FOREGROUND + abs(integer(color)) % 8;

/**
 * Produces an ANSI code to colorize the console background.
 * @param Number color - A color index in the range [0..7].
 * @returns String
 */
function ansiBackground(color) =  ansiCode(ansiBackgroundColor(color));

/**
 * Produces an ANSI code to colorize the console foreground.
 * @param Number color - A color index in the range [0..7].
 * @param Boolean [bright] - Whether use bright color mode.
 * @returns String
 */
function ansiForeground(color, bright) =  ansiCode([
    bright ? ANSI_COLOR_BRIGHT : ANSI_COLOR_NORMAL,
    ansiForegroundColor(color)
]);
