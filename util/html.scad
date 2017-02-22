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
 * Strings manipulations for HTML output.
 *
 * @package util/html
 * @author jsconan
 */

/**
 * Builds an attribute string that is suitable to use in a HTML tag.
 *
 * @param String name
 * @param String value
 * @returns String
 */
function htmlAttribute(name, value) =
    name ? str(name, "=\"", isArray(value) ? htmlProperties(value) : string(value), "\"")
         : ""
;

/**
 * Builds a property string that is suitable to use in a CSS rule.
 *
 * @param String name
 * @param String value
 * @returns String
 */
function htmlProperty(name, value) =
    name ? str(name, ":", string(value), ";")
         : ""
;

/**
 * Builds the attributes clause of HTML tag.
 *
 * @param Array|String attr
 * @returns String
 */
function htmlAttributes(attr) =
    attr && isArray(attr) ? join(glue=" ", terms=[
                                for (a = attr)
                                    isArray(a) ? htmlAttribute(a[0], a[1])
                                               : a
                            ])
                          : attr ? string(attr)
                                 : ""
;

/**
 * Builds the properties list of CSS style.
 *
 * @param Array|String props
 * @returns String
 */
function htmlProperties(props) =
    props && isArray(props) ? join(glue=" ", terms=[
                                  for (p = props)
                                      isArray(p) ? htmlProperty(p[0], p[1])
                                                 : p
                              ])
                            : props ? string(props)
                                    : ""
;

/**
 * Builds a HTML tag.
 *
 * @param String name
 * @param String content
 * @param Array attr
 * @returns String
 */
function htmlTag(name, content, attr) =
    let(
        attr = attr ? str(" ", htmlAttributes(attr)) : "",
        start = str("<", name, attr, ">"),
        end = str("</", name, ">")
    )
    name ? str(start, string(content), end)
         : string(content)
;

/**
 * Builds a single HTML tag.
 *
 * @param String name
 * @param Array attr
 * @returns String
 */
function htmlSingleTag(name, attr) =
    let(
        attr = attr ? str(" ", htmlAttributes(attr)) : ""
    )
    name ? str("<", name, attr, " />")
         : ""
;

/**
 * Builds a single HTML tag.
 *
 * @param String col
 * @param String content
 * @returns String
 */
function htmlColorize(col, content) =
    col && content ? htmlTag("font", content, [["color", col]])
                   : string(content)
;
