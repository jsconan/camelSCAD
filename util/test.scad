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
 * Unit testing API.
 *
 * @package util/test
 * @author jsconan
 */

/**
 * Declares the target package of the test suite.
 *
 * @param String title
 * @param Number [expected]
 */
module testPackage(title, expected) {
    $testPackage = string(title);

    displayTestTitle(title, "package", true);
    children();
    displayExpectedAsserts($children, expected, "module");
}

/**
 * Declares the function or the feature that is tested.
 *
 * @param String title
 * @param Number [expected]
 */
module testModule(title, expected) {
    $testModule = string(title);

    displayTestTitle(title, "module");
    children();
    displayExpectedAsserts($children, expected, "test");
}

/**
 * Declares a unit test.
 *
 * @param String title
 * @param Number [expected]
 */
module testUnit(title, expected) {
    $testUnit = string(title);

    children();
    displayExpectedAsserts($children, expected, "assertion");
}

/**
 * Asserts the actual value is equal to the expected value.
 *
 * @param * actual
 * @param * expected
 * @param String [message]
 */
module assertEqual(actual, expected, message) {
    result = actual == expected;
    message = or(message, "Should be equal");
    details = [actual, expected];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the actual value is not equal to the expected value.
 *
 * @param * actual
 * @param * expected
 * @param String [message]
 */
module assertNotEqual(actual, expected, message) {
    result = actual != expected;
    message = or(message, "Should not be equal");
    details = [actual, expected];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the actual value is approximately equal to the expected value.
 *
 * @param * actual
 * @param * expected
 * @param String [message]
 */
module assertApproxEqual(actual, expected, message) {
    result = approx(actual, expected);
    message = or(message, "Should be approximately equal ");
    details = [actual, expected];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the actual value is not approximately equal to the expected value.
 *
 * @param * actual
 * @param * expected
 * @param String [message]
 */
module assertNotApproxEqual(actual, expected, message) {
    result = !approx(actual, expected);
    message = or(message, "Should not be approximately equal ");
    details = [actual, expected];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the value is equivalent to true.
 *
 * @param * value
 * @param String [message]
 */
module assertTrue(value, message) {
    result = !!value;
    message = or(message, "Should be true");
    details = [value];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the value is falsy.
 *
 * @param * value
 * @param String [message]
 */
module assertFalse(value, message) {
    result = !value;
    message = or(message, "Should be false");
    details = [value];

    displayAssertResult(result, message, details);
}

/**
 * Failed assert.
 *
 * @param String [message]
 */
module failed(message) {
    message = or(message, "Failed!");

    displayAssertResult(false, message);
}

/**
 * Asserts the value is undefined.
 *
 * @param * value
 * @param String [message]
 */
module assertUndef(value, message) {
    result = isUndef(value);
    message = or(message, "Should be an undefined value");
    details = [value];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the value is a number.
 *
 * @param * value
 * @param String [message]
 */
module assertNumber(value, message) {
    result = isNumber(value);
    message = or(message, "Should be a number");
    details = [value];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the value is an integer.
 *
 * @param * value
 * @param String [message]
 */
module assertInteger(value, message) {
    result = isInteger(value);
    message = or(message, "Should be an integer");
    details = [value];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the value is a boolean.
 *
 * @param * value
 * @param String [message]
 */
module assertBoolean(value, message) {
    result = isBoolean(value);
    message = or(message, "Should be a boolean");
    details = [value];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the value is a vector.
 *
 * @param * value
 * @param String [message]
 */
module assertVector(value, message) {
    result = isVector(value);
    message = or(message, "Should be a vector");
    details = [value];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the value is an array.
 *
 * @param * value
 * @param String [message]
 */
module assertArray(value, message) {
    result = isArray(value);
    message = or(message, "Should be an array");
    details = [value];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the value is an empty array.
 *
 * @param * value
 * @param String [message]
 */
module assertEmptyArray(value, message) {
    result = value == [];
    message = or(message, "Should be an empty array");
    details = [value];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the value is not an empty array.
 *
 * @param * value
 * @param String [message]
 */
module assertNotEmptyArray(value, message) {
    result = isArray(value) && value != [];
    message = or(message, "Should not be an empty array");
    details = [value];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the value is a string.
 *
 * @param * value
 * @param String [message]
 */
module assertString(value, message) {
    result = isString(value);
    message = or(message, "Should be a string");
    details = [value];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the value is an empty string.
 *
 * @param * value
 * @param String [message]
 */
module assertEmptyString(value, message) {
    result = value == "";
    message = or(message, "Should be an empty string");
    details = [value];

    displayAssertResult(result, message, details);
}

/**
 * Asserts the value is a not empty string.
 *
 * @param * value
 * @param String [message]
 */
module assertNotEmptyString(value, message) {
    result = isString(value) && value != "";
    message = or(message, "Should not be an empty string");
    details = [value];

    displayAssertResult(result, message, details);
}

/**
 * Displays a title.
 *
 * @private
 * @param String title
 * @param String type
 * @param Boolean [big]
 */
module displayTestTitle(title, type, big) {
    echo(formatTestTitle(title, type, big));
}

/**
 * Displays the number of expected asserts.
 *
 * @private
 * @param Number actual
 * @param Number [expected]
 * @param String [type]
 */
module displayExpectedAsserts(actual, expected, type) {
    echo(formatExpectedAsserts(actual, expected, type));
}

/**
 * Displays an assert result.
 *
 * @private
 * @param Boolean result
 * @param String message
 * @param Array [details]
 */
module displayAssertResult(result, message, details) {
    echo(formatAssertResult(result, message, details));
}
