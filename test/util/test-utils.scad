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

use <../../full.scad>

/**
 * Part of the camelSCAD library.
 *
 * Unit tests: Unit testing API.
 *
 * @package test/util/test
 * @author jsconan
 */
module testUtilTestUtils() {
    testPackage("util/test-utils.scad", 17) {
        // test util/test/formatTestTitleHTML()
        testModule("formatTestTitleHTML()", 2) {
            testUnit("no parameters", 1) {
                assertEqual(formatTestTitleHTML(), "<font color=\"darkblue\"><small></small></font>", "An empty content should be returned");
            }
            testUnit("with parameters", 2) {
                assertEqual(formatTestTitleHTML("testTitle", "testType", true), "<font color=\"blue\">testType<big> [testTitle]</big></font>", "Should return the expected title, as big");
                assertEqual(formatTestTitleHTML("testTitle", "testType", false), "<font color=\"darkblue\">testType<small> [testTitle]</small></font>", "Should return the expected title, as small");
            }
        }
        // test util/test/formatAssertResultHTML()
        testModule("formatAssertResultHTML()", 2) {
            testUnit("no parameters", 1) {
                assertEqual(formatAssertResultHTML(), str("<font color=\"red\"><b>#FAILED</b><small> [", $testModule, ":",$testUnit, "]</small> <code></code></font>"), "An empty content should be returned");
            }
            testUnit("with parameters", 2) {
                assertEqual(formatAssertResultHTML(true, "testMessage", "details"), str("<font color=\"green\"><b>#OK</b><small> [", $testModule, ":",$testUnit, "]</small> <code>testMessage</code></font>"), "The right content should be produced when the result is true");
                assertEqual(formatAssertResultHTML(false, "testMessage", "details"), str("<font color=\"red\"><b>#FAILED</b><small> [", $testModule, ":",$testUnit, "]</small> <code>testMessage</code> (<tt>details</tt>)</font>"), "The right content should be produced when the result is false");
            }
        }
        // test util/test/formatExpectedAssertsHTML()
        testModule("formatExpectedAssertsHTML()", 2) {
            testUnit("no parameters", 1) {
                assertEqual(formatExpectedAssertsHTML(), str("<font color=\"red\"><small>[", $testModule, ":",$testUnit, "] </small><code>Expected at least one , but none were run</code></font>"), "An empty content should be returned");
            }
            testUnit("with parameters", 7) {
                assertEqual(formatExpectedAssertsHTML(1, undef, "testType"), str("<font color=\"green\"><small>[", $testModule, ":",$testUnit, "] </small><code>1 testType was run</code></font>"), "The right content should be returned");
                assertEqual(formatExpectedAssertsHTML(2, undef, "testType"), str("<font color=\"green\"><small>[", $testModule, ":",$testUnit, "] </small><code>2 testTypes were run</code></font>"), "The right content should be returned");
                assertEqual(formatExpectedAssertsHTML(1, 1, "testType"), str("<font color=\"green\"><small>[", $testModule, ":",$testUnit, "] </small><code>1 testType of 1 was run</code></font>"), "The right content should be returned");
                assertEqual(formatExpectedAssertsHTML(0, undef, "testType"), str("<font color=\"red\"><small>[", $testModule, ":",$testUnit, "] </small><code>Expected at least one testType, but none were run</code></font>"), "The right content should be returned");
                assertEqual(formatExpectedAssertsHTML(0, 2, "testType"), str("<font color=\"red\"><small>[", $testModule, ":",$testUnit, "] </small><code>Expected 2 testTypes but none were run</code></font>"), "The right content should be returned");
                assertEqual(formatExpectedAssertsHTML(1, 2, "testType"), str("<font color=\"red\"><small>[", $testModule, ":",$testUnit, "] </small><code>Expected 2 testTypes but 1 was run</code></font>"), "The right content should be returned");
                assertEqual(formatExpectedAssertsHTML(2, 1, "testType"), str("<font color=\"red\"><small>[", $testModule, ":",$testUnit, "] </small><code>Expected 1 testType but 2 were run</code></font>"), "The right content should be returned");
            }
        }
        // test util/test/formatTestTitleANSI()
        testModule("formatTestTitleANSI()", 2) {
            testUnit("no parameters", 1) {
                assertEqual(formatTestTitleANSI(), str(chr(27), "[0;34m", chr(27), "[0m"), "An empty content should be returned");
            }
            testUnit("with parameters", 2) {
                assertEqual(formatTestTitleANSI("testTitle", "testType", true), str(chr(27), "[1;34m", "testType [testTitle]", chr(27), "[0m"), "Should return the expected title, as big");
                assertEqual(formatTestTitleANSI("testTitle", "testType", false), str(chr(27), "[0;34m", "testType [testTitle]", chr(27), "[0m"), "Should return the expected title, as small");
            }
        }
        // test util/test/formatAssertResultANSI()
        testModule("formatAssertResultANSI()", 2) {
            testUnit("no parameters", 1) {
                assertEqual(formatAssertResultANSI(), str(chr(27), "[0;31m", "assert #FAILED [", $testModule, ":",$testUnit, "] ", chr(27), "[0m"), "An empty content should be returned");
            }
            testUnit("with parameters", 2) {
                assertEqual(formatAssertResultANSI(true, "testMessage", "details"), str(chr(27), "[0;32m", "assert #OK [", $testModule, ":",$testUnit, "] testMessage", chr(27), "[0m"), "The right content should be produced when the result is true");
                assertEqual(formatAssertResultANSI(false, "testMessage", "details"), str(chr(27), "[0;31m", "assert #FAILED [", $testModule, ":",$testUnit, "] testMessage (details)", chr(27), "[0m"), "The right content should be produced when the result is false");
            }
        }
        // test util/test/formatExpectedAssertsANSI()
        testModule("formatExpectedAssertsANSI()", 2) {
            testUnit("no parameters", 1) {
                assertEqual(formatExpectedAssertsANSI(), str(chr(27), "[0;31m", "expect [", $testModule, ":",$testUnit, "] Expected at least one , but none were run", chr(27), "[0m"), "An empty content should be returned");
            }
            testUnit("with parameters", 7) {
                assertEqual(formatExpectedAssertsANSI(1, undef, "testType"), str(chr(27), "[0;32m", "expect [", $testModule, ":",$testUnit, "] 1 testType was run", chr(27), "[0m"), "The right content should be returned");
                assertEqual(formatExpectedAssertsANSI(2, undef, "testType"), str(chr(27), "[0;32m", "expect [", $testModule, ":",$testUnit, "] 2 testTypes were run", chr(27), "[0m"), "The right content should be returned");
                assertEqual(formatExpectedAssertsANSI(1, 1, "testType"), str(chr(27), "[0;32m", "expect [", $testModule, ":",$testUnit, "] 1 testType of 1 was run", chr(27), "[0m"), "The right content should be returned");
                assertEqual(formatExpectedAssertsANSI(0, undef, "testType"), str(chr(27), "[0;31m", "expect [", $testModule, ":",$testUnit, "] Expected at least one testType, but none were run", chr(27), "[0m"), "The right content should be returned");
                assertEqual(formatExpectedAssertsANSI(0, 2, "testType"), str(chr(27), "[0;31m", "expect [", $testModule, ":",$testUnit, "] Expected 2 testTypes but none were run", chr(27), "[0m"), "The right content should be returned");
                assertEqual(formatExpectedAssertsANSI(1, 2, "testType"), str(chr(27), "[0;31m", "expect [", $testModule, ":",$testUnit, "] Expected 2 testTypes but 1 was run", chr(27), "[0m"), "The right content should be returned");
                assertEqual(formatExpectedAssertsANSI(2, 1, "testType"), str(chr(27), "[0;31m", "expect [", $testModule, ":",$testUnit, "] Expected 1 testType but 2 were run", chr(27), "[0m"), "The right content should be returned");
            }
        }
        // test util/test/formatTestTitleText()
        testModule("formatTestTitleText()", 2) {
            testUnit("no parameters", 1) {
                assertEqual(formatTestTitleText(), "", "An empty content should be returned");
            }
            testUnit("with parameters", 2) {
                assertEqual(formatTestTitleText("testTitle", "testType", true), "testType [testTitle]", "Should return the expected title, as big");
                assertEqual(formatTestTitleText("testTitle", "testType", false), "testType [testTitle]", "Should return the expected title, as small");
            }
        }
        // test util/test/formatAssertResultText()
        testModule("formatAssertResultText()", 2) {
            testUnit("no parameters", 1) {
                assertEqual(formatAssertResultText(), str("assert #FAILED [", $testModule, ":",$testUnit, "] "), "An empty content should be returned");
            }
            testUnit("with parameters", 2) {
                assertEqual(formatAssertResultText(true, "testMessage", "details"), str("assert #OK [", $testModule, ":",$testUnit, "] testMessage"), "The right content should be produced when the result is true");
                assertEqual(formatAssertResultText(false, "testMessage", "details"), str("assert #FAILED [", $testModule, ":",$testUnit, "] testMessage (details)"), "The right content should be produced when the result is false");
            }
        }
        // test util/test/formatExpectedAssertsText()
        testModule("formatExpectedAssertsText()", 2) {
            testUnit("no parameters", 1) {
                assertEqual(formatExpectedAssertsText(), str("expect [", $testModule, ":",$testUnit, "] Expected at least one , but none were run"), "An empty content should be returned");
            }
            testUnit("with parameters", 7) {
                assertEqual(formatExpectedAssertsText(1, undef, "testType"), str("expect [", $testModule, ":",$testUnit, "] 1 testType was run"), "The right content should be returned");
                assertEqual(formatExpectedAssertsText(2, undef, "testType"), str("expect [", $testModule, ":",$testUnit, "] 2 testTypes were run"), "The right content should be returned");
                assertEqual(formatExpectedAssertsText(1, 1, "testType"), str("expect [", $testModule, ":",$testUnit, "] 1 testType of 1 was run"), "The right content should be returned");
                assertEqual(formatExpectedAssertsText(0, undef, "testType"), str("expect [", $testModule, ":",$testUnit, "] Expected at least one testType, but none were run"), "The right content should be returned");
                assertEqual(formatExpectedAssertsText(0, 2, "testType"), str("expect [", $testModule, ":",$testUnit, "] Expected 2 testTypes but none were run"), "The right content should be returned");
                assertEqual(formatExpectedAssertsText(1, 2, "testType"), str("expect [", $testModule, ":",$testUnit, "] Expected 2 testTypes but 1 was run"), "The right content should be returned");
                assertEqual(formatExpectedAssertsText(2, 1, "testType"), str("expect [", $testModule, ":",$testUnit, "] Expected 1 testType but 2 were run"), "The right content should be returned");
            }
        }
        // test util/test/formatTestTitleCSV()
        testModule("formatTestTitleCSV()", 2) {
            testUnit("no parameters", 1) {
                assertEqual(formatTestTitleCSV(), ";", "An empty content should be returned");
            }
            testUnit("with parameters", 2) {
                assertEqual(formatTestTitleCSV("testTitle", "testType", true), "testType;testTitle", "Should return the expected title, as big");
                assertEqual(formatTestTitleCSV("testTitle", "testType", false), "testType;testTitle", "Should return the expected title, as small");
            }
        }
        // test util/test/formatAssertResultCSV()
        testModule("formatAssertResultCSV()", 2) {
            testUnit("no parameters", 1) {
                assertEqual(formatAssertResultCSV(), str("assert;#FAILED;", $testModule, ":",$testUnit, ";;"), "An empty content should be returned");
            }
            testUnit("with parameters", 2) {
                assertEqual(formatAssertResultCSV(true, "testMessage", "details"), str("assert;#OK;", $testModule, ":",$testUnit, ";testMessage;"), "The right content should be produced when the result is true");
                assertEqual(formatAssertResultCSV(false, "testMessage", "details"), str("assert;#FAILED;", $testModule, ":",$testUnit, ";testMessage;details"), "The right content should be produced when the result is false");
            }
        }
        // test util/test/formatExpectedAssertsCSV()
        testModule("formatExpectedAssertsCSV()", 2) {
            testUnit("no parameters", 1) {
                assertEqual(formatExpectedAssertsCSV(), str("expect;;;0;false;", $testModule, ":",$testUnit, ";Expected at least one , but none were run"), "An empty content should be returned");
            }
            testUnit("with parameters", 7) {
                assertEqual(formatExpectedAssertsCSV(1, undef, "testType"), str("expect;testType;;1;true;", $testModule, ":",$testUnit, ";1 testType was run"), "The right content should be returned");
                assertEqual(formatExpectedAssertsCSV(2, undef, "testType"), str("expect;testType;;2;true;", $testModule, ":",$testUnit, ";2 testTypes were run"), "The right content should be returned");
                assertEqual(formatExpectedAssertsCSV(1, 1, "testType"), str("expect;testType;1;1;true;", $testModule, ":",$testUnit, ";1 testType of 1 was run"), "The right content should be returned");
                assertEqual(formatExpectedAssertsCSV(0, undef, "testType"), str("expect;testType;;0;false;", $testModule, ":",$testUnit, ";Expected at least one testType, but none were run"), "The right content should be returned");
                assertEqual(formatExpectedAssertsCSV(0, 2, "testType"), str("expect;testType;2;0;false;", $testModule, ":",$testUnit, ";Expected 2 testTypes but none were run"), "The right content should be returned");
                assertEqual(formatExpectedAssertsCSV(1, 2, "testType"), str("expect;testType;2;1;false;", $testModule, ":",$testUnit, ";Expected 2 testTypes but 1 was run"), "The right content should be returned");
                assertEqual(formatExpectedAssertsCSV(2, 1, "testType"), str("expect;testType;1;2;false;", $testModule, ":",$testUnit, ";Expected 1 testType but 2 were run"), "The right content should be returned");
            }
        }
        // test util/test/assertStatus()
        testModule("assertStatus()", 2) {
            testUnit("no parameters", 1) {
                assertEqual(assertStatus(), "#FAILED", "An empty content should be returned");
            }
            testUnit("with parameters", 2) {
                assertEqual(assertStatus(true), "#OK", "The right content should be produced when the result is true");
                assertEqual(assertStatus(false), "#FAILED", "The right content should be produced when the result is false");
            }
        }
        // test util/test/assertContext()
        testModule("assertContext()", 2) {
            testUnit("current context", 1) {
                assertEqual(assertContext(), "assertContext():current context", "The current context should be returned");
            }
            testUnit("assertContext():empty context", 1) {
                backupUnit = $testUnit;
                $testModule = "";
                $testUnit = "";
                context = assertContext();
                $testUnit = backupUnit;
                assertEqual(context, "", "An empty content should be returned");
            }
        }
        // test util/test/assertDetails()
        testModule("assertDetails()", 3) {
            testUnit("no parameters", 1) {
                assertEqual(assertDetails(), "", "An empty content should be returned");
            }
            testUnit("single detail", 1) {
                assertEqual(assertDetails(["testValue"]), "[value: testValue]", "The detail for a single value should be returned");
            }
            testUnit("full details", 1) {
                assertEqual(assertDetails(["testActual", "testExpected"]), "[expected: testExpected] [actual: testActual]", "The details for expected and actual values should be returned");
            }
        }
        // test util/test/checkExpectedAsserts()
        testModule("checkExpectedAsserts()") {
            testUnit("no parameters", 1) {
                assertEqual(checkExpectedAsserts(), false, "When all values are empty, the result should be false");
            }
            testUnit("with parameters", 7) {
                assertTrue(checkExpectedAsserts(1, undef), "If the number of assertions is not null and there is no expected number, the result should be true");
                assertTrue(checkExpectedAsserts(2, undef), "If the number of assertions is not null and there is no expected number, the result should be true");
                assertTrue(checkExpectedAsserts(1, 1), "If the numbers are equal the result should be true");
                assertFalse(checkExpectedAsserts(0, undef), "If the number of assertions is null, the result should be false");
                assertFalse(checkExpectedAsserts(0, 2), "If the number of assertions is null, the result should be false");
                assertFalse(checkExpectedAsserts(1, 2), "If the number of assertions is lesser than expected, the result should be false");
                assertFalse(checkExpectedAsserts(2, 1), "If the number of assertions is greater than expected, the result should be false");
            }
        }
        // test util/test/messageExpectedAsserts()
        testModule("messageExpectedAsserts()") {
            testUnit("no parameters", 1) {
                assertEqual(messageExpectedAsserts(), "Expected at least one , but none were run", "An empty content should be returned");
            }
            testUnit("with parameters", 7) {
                assertEqual(messageExpectedAsserts(1, undef, "testType"), "1 testType was run", "The right content should be returned");
                assertEqual(messageExpectedAsserts(2, undef, "testType"), "2 testTypes were run", "The right content should be returned");
                assertEqual(messageExpectedAsserts(1, 1, "testType"), "1 testType of 1 was run", "The right content should be returned");
                assertEqual(messageExpectedAsserts(0, undef, "testType"), "Expected at least one testType, but none were run", "The right content should be returned");
                assertEqual(messageExpectedAsserts(0, 2, "testType"), "Expected 2 testTypes but none were run", "The right content should be returned");
                assertEqual(messageExpectedAsserts(1, 2, "testType"), "Expected 2 testTypes but 1 was run", "The right content should be returned");
                assertEqual(messageExpectedAsserts(2, 1, "testType"), "Expected 1 testType but 2 were run", "The right content should be returned");
            }
        }
    }
}

testUtilTestUtils();
