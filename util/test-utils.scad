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
 * Unit testing API.
 *
 * @package util/test
 * @author jsconan
 */

/**
 * Sets the console mode to prevent HTML use.
 * Should be set using the CLI.
 * @type Boolean
 */
CONSOLE = false;

/**
 * Activate the ANSI support for colored console output.
 * Should be set using the CLI.
 * @type Boolean
 */
ANSI = false;

/**
 * Activate the CSV support
 * Should be set using the CLI.
 * @type Boolean
 */
CSV = false;

/**
 * The mode used to output the results.
 * Default to HTML
 * @type String
 */
outputMode = CSV        ? "csv"
            :ANSI       ? "ansi"
            :CONSOLE    ? "text"
                        : "html"
;

/**
 * Formats a title with respect to the current output mode.
 *
 * @private
 * @param String title
 * @param String type
 * @param Boolean [big]
 * @returns String
 */
function formatTestTitle(title, type, big) =
    outputMode == "html" ? formatTestTitleHTML(title, type, big)
   :outputMode == "ansi" ? formatTestTitleANSI(title, type, big)
   :outputMode == "csv"  ? formatTestTitleCSV(title, type, big)
                          : formatTestTitleText(title, type, big)
;

/**
 * Formats an assert result with respect to the current output mode.
 *
 * @private
 * @param Boolean result
 * @param String message
 * @param Array [details]
 * @returns String
 */
function formatAssertResult(result, message, details) =
    let(details = assertDetails(details))
    outputMode == "html" ? formatAssertResultHTML(result, message, details)
   :outputMode == "ansi" ? formatAssertResultANSI(result, message, details)
   :outputMode == "csv"  ? formatAssertResultCSV(result, message, details)
                          : formatAssertResultText(result, message, details)
;

/**
 * Formats the message related to the expected number of asserts with respect to the current output mode.
 *
 * @private
 * @param Number actual
 * @param Number [expected]
 * @param String [type]
 * @returns String
 */
function formatExpectedAsserts(actual, expected, type) =
    outputMode == "html" ? formatExpectedAssertsHTML(actual, expected, type)
   :outputMode == "ansi" ? formatExpectedAssertsANSI(actual, expected, type)
   :outputMode == "csv"  ? formatExpectedAssertsCSV(actual, expected, type)
                          : formatExpectedAssertsText(actual, expected, type)
;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MODE: HTML
//

/**
 * Formats a title to be displayed on HTML container.
 *
 * @private
 * @param String title
 * @param String type
 * @param Boolean [big]
 * @returns String
 */
function formatTestTitleHTML(title, type, big) = htmlColorize(
    big ? "blue" : "darkblue",
    str(
        string(type),
        htmlTag(big ? "big" : "small", wrap(" [", title, "]"))
    )
);

/**
 * Formats an assert result to be displayed on HTML container.
 *
 * @private
 * @param Boolean result
 * @param String message
 * @param String [details]
 * @returns String
 */
function formatAssertResultHTML(result, message, details) = htmlColorize(
    result ? "green" : "red",
    str(
        htmlTag("b", assertStatus(result)),
        htmlTag("small", wrap(" [", assertContext(), "]")),
        " ",
        htmlTag("code", message),
        wrap(" (", !result && details ? htmlTag("tt", details) : "", ")")
    )
);

/**
 * Formats the message related to the expected number of asserts to be displayed on HTML container.
 *
 * @private
 * @param Number actual
 * @param Number [expected]
 * @param String [type]
 * @returns String
 */
function formatExpectedAssertsHTML(actual, expected, type) =
    let(
        result = checkExpectedAsserts(actual, expected),
        message = messageExpectedAsserts(actual, expected, type)
    )
    htmlColorize(
        result ? "green" : "red",
        str(
            htmlTag("small", wrap("[", assertContext(), "] ")),
            htmlTag("code", message)
        )
    )
;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MODE: ANSI
//

/**
 * Formats a title to be displayed on ANSI console.
 *
 * @private
 * @param String title
 * @param String type
 * @param Boolean [big]
 * @returns String
 */
function formatTestTitleANSI(title, type, big) = str(
    ansiForeground(ANSI_COLOR_BLUE, big),
    formatTestTitleText(title, type, big),
    ansiCodeOff()
);

/**
 * Formats an assert result to be displayed on ANSI console.
 *
 * @private
 * @param Boolean result
 * @param String message
 * @param String [details]
 * @returns String
 */
function formatAssertResultANSI(result, message, details) = str(
    ansiForeground(result ? ANSI_COLOR_GREEN : ANSI_COLOR_RED),
    formatAssertResultText(result, message, details),
    ansiCodeOff()
);

/**
 * Formats the message related to the expected number of asserts to be displayed on ANSI console.
 *
 * @private
 * @param Number actual
 * @param Number [expected]
 * @param String [type]
 * @returns String
 */
function formatExpectedAssertsANSI(actual, expected, type) =
    let(
        result = checkExpectedAsserts(actual, expected)
    )
    str(
        ansiForeground(result ? ANSI_COLOR_GREEN : ANSI_COLOR_RED),
        formatExpectedAssertsText(actual, expected, type),
        ansiCodeOff()
    )
;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MODE: TEXT
//

/**
 * Formats a title as a simple text.
 *
 * @private
 * @param String title
 * @param String type
 * @param Boolean [big]
 * @returns String
 */
function formatTestTitleText(title, type, big) = str(
    string(type),
    wrap(" [", title, "]")
);

/**
 * Formats an assert result to be displayed as simple text.
 *
 * @private
 * @param Boolean result
 * @param String message
 * @param String [details]
 * @returns String
 */
function formatAssertResultText(result, message, details) = str(
    "assert ",
    assertStatus(result),
    wrap(" [", assertContext(), "]"),
    " ",
    string(message),
    wrap(" (", !result ? string(details) : "", ")")
);

/**
 * Formats the message related to the expected number of asserts to be displayed as simple text.
 *
 * @private
 * @param Number actual
 * @param Number [expected]
 * @param String [type]
 * @returns String
 */
function formatExpectedAssertsText(actual, expected, type) =
    let(
        message = messageExpectedAsserts(actual, expected, type)
    )
    str(
        "expect ",
        wrap("[", assertContext(), "] "),
        string(message)
    )
;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MODE: CSV
//

/**
 * Formats a title to be displayed as CSV.
 *
 * @private
 * @param String title
 * @param String type
 * @param Boolean [big]
 * @returns String
 */
function formatTestTitleCSV(title, type, big) = str(
    string(type),
    ";",
    string(title)
);

/**
 * Formats an assert result to be displayed as CSV.
 *
 * @private
 * @param Boolean result
 * @param String message
 * @param String [details]
 * @returns String
 */
function formatAssertResultCSV(result, message, details) = str(
    "assert;",
    assertStatus(result),
    ";",
    assertContext(),
    ";",
    string(message),
    ";",
    !result ? string(details) : ""
);

/**
 * Formats the message related to the expected number of asserts to be displayed as CSV.
 *
 * @private
 * @param Number actual
 * @param Number [expected]
 * @param String [type]
 * @returns String
 */
function formatExpectedAssertsCSV(actual, expected, type) =
    let(
        result = checkExpectedAsserts(actual, expected),
        message = messageExpectedAsserts(actual, expected, type)
    )
    str(
        "expect;",
        string(type),
        ";",
        uor(expected, ""),
        ";",
        integer(actual),
        ";",
        result,
        ";",
        assertContext(),
        ";",
        string(message)
    )
;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// HELPERS
//

/**
 * Gets the right assert status label.
 *
 * @private
 * @param Boolean result
 * @returns String
 */
function assertStatus(result) = result ? "#OK" : "#FAILED";

/**
 * Build the context label for the current assert.
 *
 * @private
 * @returns String
 */
function assertContext() = str(
    string($testModule),
    $testModule && $testUnit ? ":" : "",
    string($testUnit)
);

/**
 * Formats the context of an assert.
 *
 * @private
 * @param Array details
 * @returns String
 */
function assertDetails(details) =
    details && is_list(details) ? (
        len(details) > 1 ? str("{expected: ", details[1], "}{actual: ", details[0], "}")
                         : str("{value: ", details[0], "}")
    )
   :""
;

/**
 * Checks if the expected number of asserts is respected.
 *
 * @private
 * @param Number actual
 * @param Number [expected]
 * @returns Boolean
 */
function checkExpectedAsserts(actual, expected) =
    let(
        actual = integer(actual),
        single = is_undef(expected),
        expected = integer(expected)
    )
    single ? !!actual : actual == expected
;

/**
 * Builds the message related to the expected number of asserts.
 *
 * @private
 * @param Number actual
 * @param Number [expected]
 * @param String [type]
 * @returns String
 */
function messageExpectedAsserts(actual, expected, type) =
    let(
        type = string(type),
        actual = integer(actual),
        single = is_undef(expected),
        expected = integer(expected)
    )
    str(
        !actual && expected ? str("Expected ", expected, " ", type, expected > 1 ? "s" : "", " but none were run")
        :!actual ? str("Expected at least one ", type, ", but none were run")
        :single ? str(actual, " ", type, actual > 1 ? "s were run" : " was run")
        :actual == expected ? str(actual, " ", type, expected > 1 ? "s" : "", " of ", expected, actual > 1 ? " were run" : " was run")
        :str("Expected ", expected, " ", type, expected > 1 ? "s" : "", " but ", actual, actual > 1 ? " were run" : " was run")
    )
;
