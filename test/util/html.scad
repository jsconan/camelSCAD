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
 * Unit tests: Strings manipulations for HTML output.
 *
 * @package test/util/html
 * @author jsconan
 */
module testUtilHtml() {
    testPackage("util/html.scad", 7) {
        // test util/html/htmlAttribute()
        testModule("htmlAttribute()", 5) {
            testUnit("no parameters", 1) {
                assertEmptyString(htmlAttribute());
            }
            testUnit("only the value", 1) {
                assertEmptyString(htmlAttribute(value="test"));
            }
            testUnit("only the name", 1) {
                assertEqual(htmlAttribute("test"), "test=\"\"", "Should return an empty attribute");
            }
            testUnit("name and value", 1) {
                assertEqual(htmlAttribute("test", 20), "test=\"20\"", "Should return the right attribute");
            }
            testUnit("name and array of properties as value", 1) {
                assertEqual(htmlAttribute("test", [["prop1", "value1"], ["prop2", "value2"], "prop3"]), "test=\"prop1:value1; prop2:value2; prop3\"", "Should return the right attribute");
            }
        }
        // test util/html/htmlProperty()
        testModule("htmlProperty()", 4) {
            testUnit("no parameters", 1) {
                assertEmptyString(htmlProperty());
            }
            testUnit("only the value", 1) {
                assertEmptyString(htmlProperty(value="test"));
            }
            testUnit("only the name", 1) {
                assertEqual(htmlProperty("test"), "test:;", "Should return an empty property");
            }
            testUnit("name and value", 1) {
                assertEqual(htmlProperty("test", "10"), "test:10;", "Should return the right property");
            }
        }
        // test util/html/htmlAttributes()
        testModule("htmlAttributes()", 6) {
            testUnit("no parameters", 1) {
                assertEmptyString(htmlAttributes());
            }
            testUnit("an empty parameter", 2) {
                assertEmptyString(htmlAttributes(""));
                assertEmptyString(htmlAttributes([]));
            }
            testUnit("a string", 1) {
                assertEqual(htmlAttributes("attr"), "attr", "Sould return the right string");
            }
            testUnit("an array of strings", 1) {
                assertEqual(htmlAttributes(["attr1", "attr2"]), "attr1 attr2", "Sould return the right string");
            }
            testUnit("an array of attributes", 1) {
                assertEqual(htmlAttributes([["attr1", "value1"], ["attr2", "value2"], "attr3"]), "attr1=\"value1\" attr2=\"value2\" attr3", "Sould return the right string");
            }
            testUnit("an array of attributes with properties", 1) {
                assertEqual(htmlAttributes([["attr1", "value1"], ["attr2", [["prop1", "value1"], ["prop2", "value2"], "prop3"]], "attr3"]), "attr1=\"value1\" attr2=\"prop1:value1; prop2:value2; prop3\" attr3", "Sould return the right string");
            }
        }
        // test util/html/htmlProperties()
        testModule("htmlProperties()", 5) {
            testUnit("no parameters", 1) {
                assertEmptyString(htmlProperties());
            }
            testUnit("an empty parameter", 2) {
                assertEmptyString(htmlProperties(""));
                assertEmptyString(htmlProperties([]));
            }
            testUnit("a string", 1) {
                assertEqual(htmlProperties("prop"), "prop", "Sould return the right string");
            }
            testUnit("an array of strings", 1) {
                assertEqual(htmlProperties(["prop1", "prop2"]), "prop1 prop2", "Sould return the right string");
            }
            testUnit("an array of properties", 1) {
                assertEqual(htmlProperties([["prop1", "value1"], ["prop2", "value2"], "prop3"]), "prop1:value1; prop2:value2; prop3", "Sould return the right string");
            }
        }
        // test util/html/htmlTag()
        testModule("htmlTag()", 5) {
            testUnit("no parameters", 1) {
                assertEmptyString(htmlTag());
            }
            testUnit("only the attributes", 2) {
                assertEmptyString(htmlTag("", "", [["color", "red"]]));
                assertEmptyString(htmlTag(attr=[["color", "red"]]));
            }
            testUnit("only the name", 1) {
                assertEqual(htmlTag("span"), "<span></span>", "Should return the right tag");
            }
            testUnit("name and content, no attributes", 1) {
                assertEqual(htmlTag("span", "Hello"), "<span>Hello</span>", "Should return the right tag");
            }
            testUnit("name, content, and attributes", 1) {
                assertEqual(htmlTag("span", "Hello", [["id", "test"], ["style", [["color", "blue"], ["font-weight", "bold"]]]]), "<span id=\"test\" style=\"color:blue; font-weight:bold;\">Hello</span>", "Should return the right tag");
            }
        }
        // test util/html/htmlSingleTag()
        testModule("htmlSingleTag()", 4) {
            testUnit("no parameters", 1) {
                assertEmptyString(htmlSingleTag());
            }
            testUnit("only the attributes", 2) {
                assertEmptyString(htmlSingleTag("", [["color", "red"]]));
                assertEmptyString(htmlSingleTag(attr=[["color", "red"]]));
            }
            testUnit("only the name", 1) {
                assertEqual(htmlSingleTag("br"), "<br />", "Should return the right tag");
            }
            testUnit("tag and attributes", 1) {
                assertEqual(htmlSingleTag("input", [["name", "test"], ["id", "test1"]]), "<input name=\"test\" id=\"test1\" />", "Should return the right tag");
            }
        }
        // test util/html/htmlColorize()
        testModule("htmlColorize()", 4) {
            testUnit("no parameters", 1) {
                assertEmptyString(htmlColorize());
            }
            testUnit("content but no color", 1) {
                assertEqual(htmlColorize(content="test"), "test", "Should simply return the content");
            }
            testUnit("color but no content", 1) {
                assertEmptyString(htmlColorize(col="yellow"));
            }
            testUnit("color and content", 1) {
                assertEqual(htmlColorize("red", "Hello"), "<font color=\"red\">Hello</font>", "Should return the colored content");
            }
        }
    }
}

testUtilHtml();
