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
 * Type detection and type casting.
 *
 * @package core/type
 * @author jsconan
 */

/**
 * Checks if the value is undefined.
 *
 * @param * value - The value to check.
 * @returns Boolean - Returns `true` whether the value is not defined.
 * @deprecated - Use is_undef instead.
 */
function isUndef(value) = is_undef(value);

/**
 * Checks if the value is NAN (Not A Number).
 *
 * @param * value - The value to check.
 * @returns Boolean - Returns `true` whether the value is NAN.
 */
function isNAN(value) = (!is_undef(value) && value != value);

/**
 * Checks if the value is infinite.
 *
 * @param * value - The value to check.
 * @returns Boolean - Returns `true` whether the value is infinite.
 */
function isInfinity(value) = (is_num(value) && (value >= INFINITY || value <= -INFINITY));

/**
 * Checks if the value is numeric.
 *
 * @param * value - The value to check.
 * @returns Boolean - Returns `true` whether the value is numeric.
 * @deprecated - Use is_num instead.
 */
function isNumber(value) = is_num(value);

/**
 * Checks if the value is integer.
 *
 * @param * value - The value to check.
 * @returns Boolean - Returns `true` whether the value is integer.
 */
function isInteger(value) = (is_num(value) && floor(value) == value);

/**
 * Checks if the value is small enough to be considered equal to 0.
 *
 * @param * value - The value to check.
 * @returns Boolean - Returns `true` whether the value is equal to 0 or near enough.
 */
function isZero(value) = (is_num(value) && value > -EPSILON && value < EPSILON);

/**
 * Checks if the value is boolean.
 *
 * @param * value - The value to check.
 * @returns Boolean - Returns `true` whether the value is boolean.
 * @deprecated - Use is_bool instead.
 */
function isBoolean(value) = is_bool(value);

/**
 * Checks if the value is a string.
 *
 * @param * value - The value to check.
 * @returns Boolean - Returns `true` whether the value is a string.
* @deprecated - Use is_string instead.
 */
function isString(value) = is_string(value);

/**
 * Checks if the value is an array or a vector.
 *
 * @param * value - The value to check.
 * @returns Boolean - Returns `true` whether the value is an array or a vector.
 * @deprecated - Use is_list instead.
 */
function isArray(value) = is_list(value);

/**
 * Checks if the value is a vector.
 *
 * @param * value - The value to check.
 * @returns Boolean - Returns `true` whether the value is a vector.
 */
function isVector(value) = (is_list(value) && value * 1 == value);

/**
 * Checks if the value is a N-dimensions vector.
 *
 * @param * value - The value to check.
 * @param Number length - The required length of the vector.
 * @returns Boolean - Returns `true` whether the value is a vector and has the required length.
 */
function isVectorN(value, length) = (is_list(value) && len(value) == float(length) && value * 1 == value);

/**
 * Checks if the value is a 2D vector.
 *
 * @param * value - The value to check.
 * @returns Boolean - Returns `true` whether the value is a 2D vector.
 */
function isVector2D(value) = (is_list(value) && len(value) == 2 && value * 1 == value);

/**
 * Checks if the value is a 3D vector.
 *
 * @param * value - The value to check.
 * @returns Boolean - Returns `true` whether the value is a 3D vector.
 */
function isVector3D(value) = (is_list(value) && len(value) == 3 && value * 1 == value);

/**
 * Typecasts the value to a number.
 *
 * @param * value - The value to cast.
 * @returns Number - Returns a number. If the value cannot be casted, 0 will be returned.
 */
function number(value) = value == true ? 1 : float(value);

/**
 * Typecasts the value to a float.
 *
 * @param * value - The value to cast.
 * @returns Number - Returns a number. If the value cannot be casted, 0 will be returned.
 */
function float(value) = value && is_num(value) ? value : 0;

/**
 * Typecasts the value to a float, and ensures it is a safe divisor.
 * Prevent "divide by zero" issues.
 *
 * @param * value - The value to cast.
 * @returns Number - Returns a number. If the value cannot be casted, of if the value is 0, 1 will be returned.
 */
function divisor(value) = value && is_num(value) ? value : 1;

/**
 * Typecasts the value to an integer.
 *
 * @param * value - The value to cast.
 * @returns Number - Returns a number. If the value cannot be casted, 0 will be returned.
 */
function integer(value) =
    !value ? 0
   :let( value = float(value) )
    value > 0 ? floor(value)
   :value < 0 ? ceil(value)
   :0
;

/**
 * Typecasts the value to a boolean.
 *
 * @param * value - The value to cast.
 * @returns Boolean - Returns a boolean. Falsy values will be replaced by `false`, while others will be replaced by `true`.
 */
function boolean(value) = !value || value == "false" ? false : true;

/**
 * Typecasts the value to a string.
 *
 * @param * value - The value to cast.
 * @returns String - Returns a string. Strings remain unchanged, other values are "stringified".
 */
function string(value) = is_undef(value) ? "" : str(value);

/**
 * Typecasts the value to an array.
 *
 * @param * value - The value to cast.
 * @returns Array - Returns an array. Arrays and vectors remain unchanged.
 *                  `undef` produces an empty array, other values are wrapped in an array.
 */
function array(value) = is_undef(value) ? [] : concat(value);

/**
 * Typecasts the value to a vector with the desired length.
 * If a number is provided instead of a vector, a vector will all elements filled with the provided number will be returned.
 *
 * @param Vector|Number value - The value to cast.
 * @param Number length - The desired vector length.
 * @returns Vector - Returns a vector. Vectors remain unchanged, unless they don't have the required length,
 *                   additional elements are removed while missing ones are replaced by 0.
 *                   Arrays are casted, not numbers are replaced by 0.
 *                   Other values are replaced by an array with the requested length where all elements are 0.
 */
function vector(value, length) =
    let(
        array = is_list(value),
        length = float(
            is_undef(length) ? (array ? len(value) : 0)
                            : length
        )
    )
    !array ? fill(float(value), length)
    :length ? [ for (i = [0 : length - 1]) float(value[i]) ]
    :[]
;
