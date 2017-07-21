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
 * Unit tests: Operations on hex grids.
 *
 * @package test/core/hex
 * @author jsconan
 */
module testCoreHex() {
    testPackage("core/hex.scad", 9) {
        // test core/hex/radialHexGrid()
        testModule("radialHexGrid()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(radialHexGrid(), [[0, 0]], "Without parameter the function should produce a default grid of 1 cell");
            }
            testUnit("wrong type", 4) {
                assertEqual(radialHexGrid("10"), [[0, 0]], "A string should produce a default grid of 1 cell");
                assertEqual(radialHexGrid(true), [[0, 0]], "A boolean should produce a default grid of 1 cell");
                assertEqual(radialHexGrid([]), [[0, 0]], "An empty array should produce a default grid of 1 cell");
                assertEqual(radialHexGrid(["1"]), [[0, 0]], "An array should produce a default grid of 1 cell");
            }
            testUnit("number", 5) {
                assertEqual(radialHexGrid(0), [[0, 0]], "A grid of range 0 is a grid with one cell");
                assertEqual(radialHexGrid(3), [[-1, 1], [-1, 0], [0, 1], [0, 0], [0, -1], [1, 0], [1, -1]], "A grid with 3 cells on a line will have 7 cells");
                assertEqual(radialHexGrid(4), [[-1, 1], [-1, 0], [0, 1], [0, 0], [0, -1], [1, 0], [1, -1]], "A grid with 4 cells on a line will have 7 cells");
                assertEqual(radialHexGrid(5), [[-2, 2], [-2, 1], [-2, 0], [-1, 2], [-1, 1], [-1, 0], [-1, -1], [0, 2], [0, 1], [0, 0], [0, -1], [0, -2], [1, 1], [1, 0], [1, -1], [1, -2], [2, 0], [2, -1], [2, -2]], "A grid with 5 cells on a line will have 7 cells");
                assertEqual(radialHexGrid(-3), [[-1, 1], [-1, 0], [0, 1], [0, 0], [0, -1], [1, 0], [1, -1]], "Negative range should be converted to positive");
            }
            testUnit("vector", 5) {
                assertEqual(radialHexGrid([0, 0]), [[0, 0]], "A grid of range 0 is a grid with one cell");
                assertEqual(radialHexGrid([3, 4]), [[-1, 1], [-1, 0], [0, 1], [0, 0], [0, -1], [1, 0], [1, -1]], "A grid with [3, 4] cells on a line will have 7 cells");
                assertEqual(radialHexGrid([4, 5]), [[-1, 1], [-1, 0], [0, 1], [0, 0], [0, -1], [1, 0], [1, -1]], "A grid with [4, 5] cells on a line will have 7 cells");
                assertEqual(radialHexGrid([5, 6]), [[-2, 2], [-2, 1], [-2, 0], [-1, 2], [-1, 1], [-1, 0], [-1, -1], [0, 2], [0, 1], [0, 0], [0, -1], [0, -2], [1, 1], [1, 0], [1, -1], [1, -2], [2, 0], [2, -1], [2, -2]], "A grid with [5, 6] cells on a line will have 7 cells");
                assertEqual(radialHexGrid([-3, -4]), [[-1, 1], [-1, 0], [0, 1], [0, 0], [0, -1], [1, 0], [1, -1]], "Negative range should be converted to positive");
            }
        }
        // test core/hex/radialHexRange()
        testModule("radialHexRange()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(radialHexRange(), 0, "Without parameter the function should tell the grid has range 0");
            }
            testUnit("wrong type", 4) {
                assertEqual(radialHexRange("10"), 0, "With a string the function should tell the grid is has range 0");
                assertEqual(radialHexRange(true), 0, "With a boolean the function should tell the grid is has range 0");
                assertEqual(radialHexRange([]), 0, "With an empty array the function should tell the grid is has range 0");
                assertEqual(radialHexRange(["1"]), 0, "With an array the function should tell the grid is has range 0");
            }
            testUnit("number", 5) {
                assertEqual(radialHexRange(0), 0, "An empty size should produce a range 0");
                assertEqual(radialHexRange(1), 0, "A size of 1 should produce a range 0");
                assertEqual(radialHexRange(2), 0, "A size of 2 should produce a range 0");
                assertEqual(radialHexRange(3), 1, "A size of 3 should produce a range 1");
                assertEqual(radialHexRange(10), 4, "A size of 10 should produce a range 4");
            }
            testUnit("vector", 6) {
                assertEqual(radialHexRange([0, 0]), 0, "An empty size should produce a range 0");
                assertEqual(radialHexRange([1, 1]), 0, "A size of 1 should produce a range 0");
                assertEqual(radialHexRange([2, 2]), 0, "A size of 2 should produce a range 0");
                assertEqual(radialHexRange([3, 3]), 1, "A size of 3 should produce a range 1");
                assertEqual(radialHexRange([10, 10]), 4, "A size of 10 should produce a range 4");
                assertEqual(radialHexRange([15, 20]), 7, "Should take the lower size to compute the range");
            }
        }
        // test core/hex/radialHexCount()
        testModule("radialHexCount()", 3) {
            testUnit("no parameter", 1) {
                assertEqual(radialHexCount(), [1, 1], "Without parameter the function should assume it is a range 0 and the size should be 1");
            }
            testUnit("wrong type", 5) {
                assertEqual(radialHexCount("10"), [1, 1], "With a string the function should assume it is a range 0 and the size should be 1");
                assertEqual(radialHexCount(true), [1, 1], "With a boolean the function should assume it is a range 0 and the size should be 1");
                assertEqual(radialHexCount([]), [1, 1], "With an empty array the function should assume it is a range 0 and the size should be 1");
                assertEqual(radialHexCount(["1"]), [1, 1], "With an array the function should assume it is a range 0 and the size should be 1");
                assertEqual(radialHexCount([10]), [1, 1], "With a vector the function should assume it is a range 0 and the size should be 1");
            }
            testUnit("number", 5) {
                assertEqual(radialHexCount(0), [1, 1], "A range 0 should produce a size of 1");
                assertEqual(radialHexCount(1), [3, 3], "A range 1 should produce a size of 3");
                assertEqual(radialHexCount(2), [5, 5], "A range 2 should produce a size of 5");
                assertEqual(radialHexCount(3), [7, 7], "A range 3 should produce a size of 7");
                assertEqual(radialHexCount(10), [21, 21], "A range 10 should produce a size of 21");
            }
        }
        // test core/hex/radialHexCoord()
        testModule("radialHexCoord()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(radialHexCoord(), [0, 0], "Without parameter the function should produce coordinates at the origin");
            }
            testUnit("wrong type", 4) {
                assertEqual(radialHexCoord("10"), [0, 0], "A string should produce coordinates at the origin");
                assertEqual(radialHexCoord(true), [0, 0], "A boolean should produce coordinates at the origin");
                assertEqual(radialHexCoord([]), [0, 0], "An empty array should produce coordinates at the origin");
                assertEqual(radialHexCoord(["1"]), [0, 0], "An array should produce coordinates at the origin");
            }
            testUnit("number", 4) {
                assertEqual(radialHexCoord(hex=0), [0, 0], "Should return the coordinates of the origin");
                assertEqual(radialHexCoord(hex=0, size=10), [0, 0], "Should return the coordinates of the origin, no matter the size");
                testUnitContext("flat topped", 3) {
                    assertEqual(radialHexCoord(hex=1, size=10, pointy=false), [15, 15 * sqrt(3)], "Should return the coordinates of the cell at 1,1");
                    assertEqual(radialHexCoord(hex=-1, size=10, pointy=false), [-15, -15 * sqrt(3)], "Should return the coordinates of the cell at -1,-1");
                    assertApproxEqual(radialHexCoord(hex=1, size=10, y=2, w=12, pointy=false), [15, 30 * sqrt(3)], "Should return the coordinates of the cell at 1,2");
                }
                testUnitContext("pointy topped", 3) {
                    assertEqual(radialHexCoord(hex=1, size=10, pointy=true), [15 * sqrt(3), 15], "Should return the coordinates of the cell at 1,1");
                    assertEqual(radialHexCoord(hex=-1, size=10, pointy=true), [-15 * sqrt(3), -15], "Should return the coordinates of the cell at -1,-1");
                    assertEqual(radialHexCoord(hex=1, size=10, y=2, w=12, pointy=true), [20 * sqrt(3), 36], "Should return the coordinates of the cell at 1,2");
                }
            }
            testUnit("vector", 4) {
                assertEqual(radialHexCoord(hex=[0, 0]), [0, 0], "Should return the coordinates of the origin");
                assertEqual(radialHexCoord(hex=[0, 0], size=[10, 10]), [0, 0], "Should return the coordinates of the origin, no matter the size");
                testUnitContext("flat topped", 4) {
                    assertEqual(radialHexCoord(hex=[1, 1], size=[10, 10], pointy=false), [15, 15 * sqrt(3)], "Should return the coordinates of the cell at 1,1");
                    assertApproxEqual(radialHexCoord(hex=[1, 2], size=[10, 12], pointy=false), [15, 30 * sqrt(3)], "Should return the coordinates of the cell at 1,2");
                    assertApproxEqual(radialHexCoord(hex=[-1, -2], size=[10, 12], pointy=false), [-15, -30 * sqrt(3)], "Should return the coordinates of the cell at -1,-2");
                    assertApproxEqual(radialHexCoord(hex=[1, 1], size=[10, 10], y=2, w=12, pointy=false), [15, 30 * sqrt(3)], "Should return the coordinates of the cell at 1,2");
                }
                testUnitContext("pointy topped", 4) {
                    assertEqual(radialHexCoord(hex=[1, 1], size=[10, 10], pointy=true), [15 * sqrt(3), 15], "Should return the coordinates of the cell at 1,1");
                    assertEqual(radialHexCoord(hex=[1, 2], size=[10, 12], pointy=true), [20 * sqrt(3), 36], "Should return the coordinates of the cell at 1,2");
                    assertEqual(radialHexCoord(hex=[-1, -2], size=[10, 12], pointy=true), [-20 * sqrt(3), -36], "Should return the coordinates of the cell at -1,-2");
                    assertEqual(radialHexCoord(hex=[1, 1], size=[10, 10], y=2, w=12, pointy=true), [20 * sqrt(3), 36], "Should return the coordinates of the cell at 1,2");
                }
            }
        }
        // test core/hex/linearHexCoord()
        testModule("linearHexCoord()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(linearHexCoord(), [0, 0], "Without parameter the function should produce coordinates at the origin");
            }
            testUnit("wrong type", 4) {
                assertEqual(linearHexCoord("10"), [0, 0], "A string should produce coordinates at the origin");
                assertEqual(linearHexCoord(true), [0, 0], "A boolean should produce coordinates at the origin");
                assertEqual(linearHexCoord([]), [0, 0], "An empty array should produce coordinates at the origin");
                assertEqual(linearHexCoord(["1"]), [0, 0], "An array should produce coordinates at the origin");
            }
            testUnit("number", 3) {
                assertEqual(linearHexCoord(hex=0), [0, 0], "Should return the coordinates of the origin");
                testUnitContext("flat topped", 2) {
                    testUnitContext("odd", 4) {
                        assertEqual(linearHexCoord(hex=0, size=10, pointy=false, even=false), [0, 0], "Should return the coordinates of the origin, no matter the size");
                        assertEqual(linearHexCoord(hex=1, size=10, pointy=false, even=false), [15, 15 * sqrt(3)], "Should return the coordinates of the cell at 1,1");
                        assertEqual(linearHexCoord(hex=-1, size=10, pointy=false, even=false), [-15, -15 * sqrt(3)], "Should return the coordinates of the cell at -1,-1");
                        assertApproxEqual(linearHexCoord(hex=1, size=10, y=2, w=12, pointy=false, even=false), [15, 30 * sqrt(3)], "Should return the coordinates of the cell at 1,2");
                    }
                    testUnitContext("even", 4) {
                        assertEqual(linearHexCoord(hex=0, size=10, pointy=false, even=true), [0, 0], "Should return the coordinates of the origin, with an offset on the vertical axis");
                        assertEqual(linearHexCoord(hex=1, size=10, pointy=false, even=true), [15, 5 * sqrt(3)], "Should return the coordinates of the cell at 1,1");
                        assertEqual(linearHexCoord(hex=-1, size=10, pointy=false, even=true), [-15, -5 * sqrt(3)], "Should return the coordinates of the cell at -1,-1");
                        assertApproxEqual(linearHexCoord(hex=1, size=10, y=2, w=12, pointy=false, even=true), [15, 18 * sqrt(3)], "Should return the coordinates of the cell at 1,2");
                    }
                }
                testUnitContext("pointy topped", 2) {
                    testUnitContext("odd", 4) {
                        assertEqual(linearHexCoord(hex=0, size=10, pointy=true, even=false), [0, 0], "Should return the coordinates of the origin, no matter the size");
                        assertEqual(linearHexCoord(hex=1, size=10, pointy=true, even=false), [15 * sqrt(3), 15], "Should return the coordinates of the cell at 1,1");
                        assertEqual(linearHexCoord(hex=-1, size=10, pointy=true, even=false), [-15 * sqrt(3), -15], "Should return the coordinates of the cell at -1,-1");
                        assertEqual(linearHexCoord(hex=1, size=10, y=2, w=12, pointy=true, even=false), [10 * sqrt(3), 36], "Should return the coordinates of the cell at 1,2");
                    }
                    testUnitContext("even", 4) {
                        assertEqual(linearHexCoord(hex=0, size=10, pointy=true, even=true), [0, 0], "Should return the coordinates of the origin, with an offset on the horizontal axis");
                        assertEqual(linearHexCoord(hex=1, size=10, pointy=true, even=true), [5 * sqrt(3), 15], "Should return the coordinates of the cell at 1,1");
                        assertEqual(linearHexCoord(hex=-1, size=10, pointy=true, even=true), [-5 * sqrt(3), -15], "Should return the coordinates of the cell at -1,-1");
                        assertEqual(linearHexCoord(hex=1, size=10, y=2, w=12, pointy=true, even=true), [10 * sqrt(3), 36], "Should return the coordinates of the cell at 1,2");
                    }
                }
            }
            testUnit("vector", 3) {
                assertEqual(linearHexCoord(hex=[0, 0]), [0, 0], "Should return the coordinates of the origin");
                testUnitContext("flat topped", 2) {
                    testUnitContext("odd", 4) {
                        assertEqual(linearHexCoord(hex=[0, 0], size=[10, 10], pointy=false, even=false), [0, 0], "Should return the coordinates of the origin, no matter the size");
                        assertEqual(linearHexCoord(hex=[1, 1], size=[10, 10], pointy=false, even=false), [15, 15 * sqrt(3)], "Should return the coordinates of the cell at 1,1");
                        assertEqual(linearHexCoord(hex=[-1, -1], size=[10, 10], pointy=false, even=false), [-15, -15 * sqrt(3)], "Should return the coordinates of the cell at -1,-1");
                        assertApproxEqual(linearHexCoord(hex=[1, 1], size=[10, 10], y=2, w=12, pointy=false, even=false), [15, 30 * sqrt(3)], "Should return the coordinates of the cell at 1,2");
                    }
                    testUnitContext("even", 4) {
                        assertEqual(linearHexCoord(hex=[0, 0], size=[10, 10], pointy=false, even=true), [0, 0], "Should return the coordinates of the origin, with an offset on the vertical axis");
                        assertEqual(linearHexCoord(hex=[1, 1], size=[10, 10], pointy=false, even=true), [15, 5 * sqrt(3)], "Should return the coordinates of the cell at 1,1");
                        assertEqual(linearHexCoord(hex=[-1, -1], size=[10, 10], pointy=false, even=true), [-15, -5 * sqrt(3)], "Should return the coordinates of the cell at -1,-1");
                        assertApproxEqual(linearHexCoord(hex=[1, 1], size=[10, 10], y=2, w=12, pointy=false, even=true), [15, 18 * sqrt(3)], "Should return the coordinates of the cell at 1,2");
                    }
                }
                testUnitContext("pointy topped", 2) {
                    testUnitContext("odd", 4) {
                        assertEqual(linearHexCoord(hex=[0, 0], size=[10, 10], pointy=true, even=false), [0, 0], "Should return the coordinates of the origin, no matter the size");
                        assertEqual(linearHexCoord(hex=[1, 1], size=[10, 10], pointy=true, even=false), [15 * sqrt(3), 15], "Should return the coordinates of the cell at 1,1");
                        assertEqual(linearHexCoord(hex=[-1, -1], size=[10, 10], pointy=true, even=false), [-15 * sqrt(3), -15], "Should return the coordinates of the cell at -1,-1");
                        assertEqual(linearHexCoord(hex=[1, 1], size=[10, 10], y=2, w=12, pointy=true, even=false), [10 * sqrt(3), 36], "Should return the coordinates of the cell at 1,2");
                    }
                    testUnitContext("even", 4) {
                        assertEqual(linearHexCoord(hex=[0, 0], size=[10, 10], pointy=true, even=true), [0, 0], "Should return the coordinates of the origin, with an offset on the horizontal axis");
                        assertEqual(linearHexCoord(hex=[1, 1], size=[10, 10], pointy=true, even=true), [5 * sqrt(3), 15], "Should return the coordinates of the cell at 1,1");
                        assertEqual(linearHexCoord(hex=[-1, -1], size=[10, 10], pointy=true, even=true), [-5 * sqrt(3), -15], "Should return the coordinates of the cell at -1,-1");
                        assertEqual(linearHexCoord(hex=[1, 1], size=[10, 10], y=2, w=12, pointy=true, even=true), [10 * sqrt(3), 36], "Should return the coordinates of the cell at 1,2");
                    }
                }
            }
        }
        // test core/hex/sizeHexGrid()
        testModule("sizeHexGrid()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(sizeHexGrid(), [0, 0], "Without parameter the function should produce a void size");
            }
            testUnit("wrong type", 4) {
                assertEqual(sizeHexGrid("10"), [0, 0], "A string should produce a void size");
                assertEqual(sizeHexGrid(true), [0, 0], "A boolean should produce a void size");
                assertEqual(sizeHexGrid([]), [0, 0], "An empty array should produce a void size");
                assertEqual(sizeHexGrid(["1"]), [0, 0], "An array should produce a void size");
            }
            testUnit("number", 2) {
                testUnitContext("flat topped", 2) {
                    testUnitContext("radial", 3) {
                        assertEqual(sizeHexGrid(2), [2, sqrt(3)], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexGrid(2, 3), [5, sqrt(3) * 3], "Should produce a size corresponding to a grid of 3 cells");
                        assertEqual(sizeHexGrid(2, 3, l=1, w=2, cx=3, cy=4), [2.5, sqrt(3) * 4], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                    }
                    testUnitContext("linear", 3) {
                        assertEqual(sizeHexGrid(2, linear=true), [2, sqrt(3) * 1.5], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexGrid(2, 3, linear=true), [5, sqrt(3) * 3.5], "Should produce a size corresponding to a grid of 3 cells");
                        assertEqual(sizeHexGrid(2, 3, linear=true, l=1, w=2, cx=3, cy=4), [2.5, sqrt(3) * 4.5], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                    }
                }
                testUnitContext("pointy topped", 2) {
                    testUnitContext("radial", 3) {
                        assertEqual(sizeHexGrid(2, pointy=true), [sqrt(3), 2], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexGrid(2, 3, pointy=true), [sqrt(3) * 3, 5], "Should produce a size corresponding to a grid of 3 cells");
                        assertEqual(sizeHexGrid(2, 3, pointy=true, l=1, w=2, cx=3, cy=4), [sqrt(3) / 2 * 3, 2 + 9 / 2], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                    }
                    testUnitContext("linear", 3) {
                        assertEqual(sizeHexGrid(2, linear=true, pointy=true), [sqrt(3) * 1.5, 2], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexGrid(2, 3, linear=true, pointy=true), [sqrt(3) * 3.5, 5], "Should produce a size corresponding to a grid of 3 cells");
                        assertEqual(sizeHexGrid(2, 3, linear=true, pointy=true, l=1, w=2, cx=3, cy=4), [sqrt(3) / 2 * 3.5, 2 + 9 / 2], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                    }
                }
            }
            testUnit("vector", 2) {
                testUnitContext("flat topped", 2) {
                    testUnitContext("radial", 3) {
                        assertEqual(sizeHexGrid([2, 2]), [2, sqrt(3)], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexGrid([2, 2], [3, 3]), [5, sqrt(3) * 3], "Should produce a size corresponding to a grid of 3 cells");
                        assertEqual(sizeHexGrid([2, 2], [3, 3], l=1, w=2, cx=3, cy=4), [2.5, sqrt(3) * 4], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                    }
                    testUnitContext("linear", 3) {
                        assertEqual(sizeHexGrid([2, 2], linear=true), [2, sqrt(3) * 1.5], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexGrid([2, 2], [3, 3], linear=true), [5, sqrt(3) * 3.5], "Should produce a size corresponding to a grid of 3 cells");
                        assertEqual(sizeHexGrid([2, 2], [3, 3], linear=true, l=1, w=2, cx=3, cy=4), [2.5, sqrt(3) * 4.5], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                    }
                }
                testUnitContext("pointy topped", 2) {
                    testUnitContext("radial", 3) {
                        assertEqual(sizeHexGrid([2, 2], pointy=true), [sqrt(3), 2], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexGrid([2, 2], [3, 3], pointy=true), [sqrt(3) * 3, 5], "Should produce a size corresponding to a grid of 3 cells");
                        assertEqual(sizeHexGrid([2, 2], [3, 3], pointy=true, l=1, w=2, cx=3, cy=4), [sqrt(3) / 2 * 3, 2 + 9 / 2], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                    }
                    testUnitContext("linear", 3) {
                        assertEqual(sizeHexGrid([2, 2], linear=true, pointy=true), [sqrt(3) * 1.5, 2], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexGrid([2, 2], [3, 3], linear=true, pointy=true), [sqrt(3) * 3.5, 5], "Should produce a size corresponding to a grid of 3 cells");
                        assertEqual(sizeHexGrid([2, 2], [3, 3], linear=true, pointy=true, l=1, w=2, cx=3, cy=4), [sqrt(3) / 2 * 3.5, 2 + 9 / 2], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                    }
                }
            }
        }
        // test core/hex/sizeHexCell()
        testModule("sizeHexCell()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(sizeHexCell(), [0, 0], "Without parameter the function should produce a void size");
            }
            testUnit("wrong type", 4) {
                assertEqual(sizeHexCell("10"), [0, 0], "A string should produce a void size");
                assertEqual(sizeHexCell(true), [0, 0], "A boolean should produce a void size");
                assertEqual(sizeHexCell([]), [0, 0], "An empty array should produce a void size");
                assertEqual(sizeHexCell(["1"]), [0, 0], "An array should produce a void size");
            }
            testUnit("number", 2) {
                testUnitContext("flat topped", 2) {
                    testUnitContext("radial", 3) {
                        assertApproxEqual(sizeHexCell(10), [10, 10 / cos(30)], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexCell(10, 3), [4, 10 * 2 / 3 / sqrt(3)], "Should produce the size of a cell in a grid of 3");
                        assertEqual(sizeHexCell(10, 3, l=10, w=20, cx=3, cy=4), [4, 20 * 2 / 4 / sqrt(3)], "Should produce the size of a cell in a grid of 3x4");
                    }
                    testUnitContext("linear", 3) {
                        assertApproxEqual(sizeHexCell(10, linear=true), [10, 20 / 1.5 / sqrt(3)], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexCell(10, 3, linear=true), [4, 20 / 3.5 / sqrt(3)], "Should produce the size of a cell in a grid of 3");
                        assertEqual(sizeHexCell(10, 3, linear=true, l=10, w=20, cx=3, cy=4), [4, 40 / 4.5 / sqrt(3)], "Should produce the size of a cell in a grid of 3x4");
                    }
                }
                testUnitContext("pointy topped", 2) {
                    testUnitContext("radial", 3) {
                        assertApproxEqual(sizeHexCell(10, pointy=true), [10 / cos(30), 10], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexCell(10, 3, pointy=true), [10 * 2 / 3 / sqrt(3), 4], "Should produce the size of a cell in a grid of 3");
                        assertEqual(sizeHexCell(10, 3, pointy=true, l=10, w=20, cx=3, cy=4), [10 * 2 / 3 / sqrt(3), 80 / 13], "Should produce the size of a cell in a grid of 3x4");
                    }
                    testUnitContext("linear", 3) {
                        assertApproxEqual(sizeHexCell(10, linear=true, pointy=true), [20 / 1.5 / sqrt(3), 10], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexCell(10, 3, linear=true, pointy=true), [20 / 3.5 / sqrt(3), 4], "Should produce the size of a cell in a grid of 3");
                        assertEqual(sizeHexCell(10, 3, linear=true, pointy=true, l=10, w=20, cx=3, cy=4), [20 / 3.5 / sqrt(3), 80 / 13], "Should produce the size of a cell in a grid of 3x4");
                    }
                }
            }
            testUnit("vector", 2) {
                testUnitContext("flat topped", 2) {
                    testUnitContext("radial", 3) {
                        assertApproxEqual(sizeHexCell([10, 10]), [10, 10 / cos(30)], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexCell([10, 10], [3, 3]), [4, 10 * 2 / sqrt(3) / 3], "Should produce the size of a cell in a grid of 3");
                        assertEqual(sizeHexCell([10, 10], [3, 3], l=10, w=20, cx=3, cy=4), [4, 20 * 2 / sqrt(3) / 4], "Should produce the size of a cell in a grid of 3x4");
                    }
                    testUnitContext("linear", 3) {
                        assertApproxEqual(sizeHexCell([10, 10], linear=true), [10, 20 / 1.5 / sqrt(3)], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexCell([10, 10], [3, 3], linear=true), [4, 20 / 3.5 / sqrt(3)], "Should produce the size of a cell in a grid of 3");
                        assertEqual(sizeHexCell([10, 10], [3, 3], linear=true, l=10, w=20, cx=3, cy=4), [4, 40 / 4.5 / sqrt(3)], "Should produce the size of a cell in a grid of 3x4");
                    }
                }
                testUnitContext("pointy topped", 2) {
                    testUnitContext("radial", 3) {
                        assertApproxEqual(sizeHexCell([10, 10], pointy=true), [10 / cos(30), 10], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexCell([10, 10], [3, 3], pointy=true), [10 * 2 / 3 / sqrt(3), 4], "Should produce the size of a cell in a grid of 3");
                        assertEqual(sizeHexCell([10, 10], [3, 3], pointy=true, l=10, w=20, cx=3, cy=4), [10 * 2 / 3 / sqrt(3), 80 / 13], "Should produce the size of a cell in a grid of 3x4");
                    }
                    testUnitContext("linear", 3) {
                        assertApproxEqual(sizeHexCell([10, 10], linear=true, pointy=true), [20 / 1.5 / sqrt(3), 10], "When only the size is provided the function should assume a count of 1 and should produce a size");
                        assertEqual(sizeHexCell([10, 10], [3, 3], linear=true, pointy=true), [20 / 3.5 / sqrt(3), 4], "Should produce the size of a cell in a grid of 3");
                        assertEqual(sizeHexCell([10, 10], [3, 3], linear=true, pointy=true, l=10, w=20, cx=3, cy=4), [20 / 3.5 / sqrt(3), 80 / 13], "Should produce the size of a cell in a grid of 3x4");
                    }
                }
            }
        }
        // test core/hex/countHexCell()
        testModule("countHexCell()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(countHexCell(), [1, 1], "Without parameter the function should tell the grid is 1x1");
            }
            testUnit("wrong type", 4) {
                assertEqual(countHexCell("10"), [1, 1], "With a string the function should tell the grid is 1x1");
                assertEqual(countHexCell(true), [1, 1], "With a boolean the function should tell the grid is 1x1");
                assertEqual(countHexCell([]), [1, 1], "With an empty array the function should tell the grid is 1x1");
                assertEqual(countHexCell(["1"]), [1, 1], "With an array the function should tell the grid is 1x1");
            }
            testUnit("number", 2) {
                testUnitContext("flat topped", 2) {
                    testUnitContext("radial", 3) {
                        assertApproxEqual(countHexCell(10), [13, 11], "Should tell the grid is 13x11");
                        assertEqual(countHexCell(10, 3), [4, 3], "Should tell the grid is 4x3");
                        assertEqual(countHexCell(10, 3, l=10, w=20, cl=3, cw=4), [4, 5], "Should tell the grid is 4x5");
                    }
                    testUnitContext("linear", 3) {
                        assertApproxEqual(countHexCell(10, linear=true), [13, 11], "Should tell the grid is 13x11");
                        assertEqual(countHexCell(10, 3, linear=true), [4, 3], "Should tell the grid is 4x3");
                        assertEqual(countHexCell(10, 3, linear=true, l=10, w=20, cl=3, cw=4), [4, 5], "Should tell the grid is 4x5");
                    }
                }
                testUnitContext("pointy topped", 2) {
                    testUnitContext("radial", 3) {
                        assertApproxEqual(countHexCell(10, pointy=true), [11, 13], "Should tell the grid is 11x13");
                        assertEqual(countHexCell(10, 3, pointy=true), [3, 4], "Should tell the grid is 3x4");
                        assertEqual(countHexCell(10, 3, pointy=true, l=10, w=20, cl=3, cw=4), [3, 6], "Should tell the grid is 3x6");
                    }
                    testUnitContext("linear", 3) {
                        assertApproxEqual(countHexCell(10, linear=true, pointy=true), [11, 13], "Should tell the grid is 11x13");
                        assertEqual(countHexCell(10, 3, linear=true, pointy=true), [3, 4], "Should tell the grid is 3x4");
                        assertEqual(countHexCell(10, 3, linear=true, pointy=true, l=10, w=20, cl=3, cw=4), [3, 6], "Should tell the grid is 3x6");
                    }
                }
            }
            testUnit("vector", 2) {
                testUnitContext("flat topped", 2) {
                    testUnitContext("radial", 3) {
                        assertApproxEqual(countHexCell([10, 10]), [13, 11], "Should tell the grid is 13x11");
                        assertEqual(countHexCell([10, 10], [3, 3]), [4, 3], "Should tell the grid is 4x3");
                        assertEqual(countHexCell([10, 10], [3, 3], l=10, w=20, cl=3, cw=4), [4, 5], "Should tell the grid is 4x5");
                    }
                    testUnitContext("linear", 3) {
                        assertApproxEqual(countHexCell([10, 10], linear=true), [13, 11], "Should tell the grid is 13x11");
                        assertEqual(countHexCell([10, 10], [3, 3], linear=true), [4, 3], "Should tell the grid is 4x3");
                        assertEqual(countHexCell([10, 10], [3, 3], linear=true, l=10, w=20, cl=3, cw=4), [4, 5], "Should tell the grid is 4x5");
                    }
                }
                testUnitContext("pointy topped", 2) {
                    testUnitContext("radial", 3) {
                        assertApproxEqual(countHexCell([10, 10], pointy=true), [11, 13], "Should tell the grid is 11x13");
                        assertEqual(countHexCell([10, 10], [3, 3], pointy=true), [3, 4], "Should tell the grid is 3x4");
                        assertEqual(countHexCell([10, 10], [3, 3], pointy=true, l=10, w=20, cl=3, cw=4), [3, 6], "Should tell the grid is 3x6");
                    }
                    testUnitContext("linear", 3) {
                        assertApproxEqual(countHexCell([10, 10], linear=true, pointy=true), [11, 13], "Should tell the grid is 11x13");
                        assertEqual(countHexCell([10, 10], [3, 3], linear=true, pointy=true), [3, 4], "Should tell the grid is 3x4");
                        assertEqual(countHexCell([10, 10], [3, 3], linear=true, pointy=true, l=10, w=20, cl=3, cw=4), [3, 6], "Should tell the grid is 3x6");
                    }
                }
            }
        }
        // test core/hex/offsetHexGrid()
        testModule("offsetHexGrid()", 4) {
            testUnit("no parameter", 1) {
                assertEqual(offsetHexGrid(), [0, 0], "Without parameter the function should produce a void offset");
            }
            testUnit("wrong type", 4) {
                assertEqual(offsetHexGrid("10"), [0, 0], "A string should produce a void offset");
                assertEqual(offsetHexGrid(true), [0, 0], "A boolean should produce a void offset");
                assertEqual(offsetHexGrid([]), [0, 0], "An empty array should produce a void offset");
                assertEqual(offsetHexGrid(["1"]), [0, 0], "An array should produce a void offset");
            }
            testUnit("number", 2) {
                testUnitContext("flat topped", 2) {
                    testUnitContext("radial", 3) {
                        assertEqual(offsetHexGrid(2), [0, 0], "The offset to place a radial hex grid is always at the origin");
                        assertEqual(offsetHexGrid(2, 3), [0, 0], "The offset to place a radial hex grid is always at the origin, no matter the size");
                        assertEqual(offsetHexGrid(2, 3, l=1, w=2, cx=3, cy=4), [0, 0], "The offset to place a radial hex grid is always at the origin, no matter the size");
                    }
                    testUnitContext("linear", 2) {
                        testUnitContext("odd", 3) {
                            assertApproxEqual(offsetHexGrid(2, linear=true, even=false), [0, -sqrt(3) / 4], "When only the size is provided the function should assume a count of 1 and should produce a size");
                            assertApproxEqual(offsetHexGrid(2, 3, linear=true, even=false), [-1.5, -5 * sqrt(3) / 4], "Should produce a size corresponding to a grid of 3 cells");
                            assertApproxEqual(offsetHexGrid(2, 3, linear=true, even=false, l=1, w=2, cx=3, cy=4), [-3 / 4, -7 * sqrt(3) / 4], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                        }
                        testUnitContext("even", 3) {
                            assertApproxEqual(offsetHexGrid(2, linear=true, even=true), [0, sqrt(3) / 4], "When only the size is provided the function should assume a count of 1 and should produce a size");
                            assertApproxEqual(offsetHexGrid(2, 3, linear=true, even=true), [-1.5, -3 * sqrt(3) / 4], "Should produce a size corresponding to a grid of 3 cells");
                            assertApproxEqual(offsetHexGrid(2, 3, linear=true, even=true, l=1, w=2, cx=3, cy=4), [-3 / 4, -5 * sqrt(3) / 4], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                        }
                    }
                }
                testUnitContext("pointy topped", 2) {
                    testUnitContext("radial", 3) {
                        assertEqual(offsetHexGrid(2, pointy=true), [0, 0], "The offset to place a radial hex grid is always at the origin");
                        assertEqual(offsetHexGrid(2, 3, pointy=true), [0, 0], "The offset to place a radial hex grid is always at the origin, no matter the size");
                        assertEqual(offsetHexGrid(2, 3, pointy=true, l=1, w=2, cx=3, cy=4), [0, 0], "The offset to place a radial hex grid is always at the origin, no matter the size");
                    }
                    testUnitContext("linear", 2) {
                        testUnitContext("odd", 3) {
                            assertApproxEqual(offsetHexGrid(2, linear=true, pointy=true, even=false), [-1 * sqrt(3) / 4, 0], "When only the size is provided the function should assume a count of 1 and should produce a size");
                            assertApproxEqual(offsetHexGrid(2, 3, linear=true, pointy=true, even=false), [-5 * sqrt(3) / 4, -1.5], "Should produce a size corresponding to a grid of 3 cells");
                            assertApproxEqual(offsetHexGrid(2, 3, linear=true, pointy=true, even=false, l=1, w=2, cx=3, cy=4), [-2.5 * sqrt(3) / 4, -9 / 4], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                        }
                        testUnitContext("even", 3) {
                            assertApproxEqual(offsetHexGrid(2, linear=true, pointy=true, even=true), [sqrt(3) / 4, 0], "When only the size is provided the function should assume a count of 1 and should produce a size");
                            assertApproxEqual(offsetHexGrid(2, 3, linear=true, pointy=true, even=true), [-3 * sqrt(3) / 4, -1.5], "Should produce a size corresponding to a grid of 3 cells");
                            assertApproxEqual(offsetHexGrid(2, 3, linear=true, pointy=true, even=true, l=1, w=2, cx=3, cy=4), [-1.5 * sqrt(3) / 4, -9 / 4], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                        }
                    }
                }
            }
            testUnit("vector", 2) {
                testUnitContext("flat topped", 2) {
                    testUnitContext("radial", 3) {
                        assertEqual(offsetHexGrid([2, 2]), [0, 0], "The offset to place a radial hex grid is always at the origin");
                        assertEqual(offsetHexGrid([2, 2], [3, 3]), [0, 0], "The offset to place a radial hex grid is always at the origin, no matter the size");
                        assertEqual(offsetHexGrid([2, 2], [3, 3], l=1, w=2, cx=3, cy=4), [0, 0], "The offset to place a radial hex grid is always at the origin, no matter the size");
                    }
                    testUnitContext("linear", 2) {
                        testUnitContext("odd", 3) {
                            assertApproxEqual(offsetHexGrid([2, 2], linear=true, even=false), [0, -sqrt(3) / 4], "When only the size is provided the function should assume a count of 1 and should produce a size");
                            assertApproxEqual(offsetHexGrid([2, 2], [3, 3], linear=true, even=false), [-1.5, -5 * sqrt(3) / 4], "Should produce a size corresponding to a grid of 3 cells");
                            assertApproxEqual(offsetHexGrid([2, 2], [3, 3], linear=true, even=false, l=1, w=2, cx=3, cy=4), [-3 / 4, -7 * sqrt(3) / 4], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                        }
                        testUnitContext("even", 3) {
                            assertApproxEqual(offsetHexGrid([2, 2], linear=true, even=true), [0, sqrt(3) / 4], "When only the size is provided the function should assume a count of 1 and should produce a size");
                            assertApproxEqual(offsetHexGrid([2, 2], [3, 3], linear=true, even=true), [-1.5, -3 * sqrt(3) / 4], "Should produce a size corresponding to a grid of 3 cells");
                            assertApproxEqual(offsetHexGrid([2, 2], [3, 3], linear=true, even=true, l=1, w=2, cx=3, cy=4), [-3 / 4, -5 * sqrt(3) / 4], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                        }
                    }
                }
                testUnitContext("pointy topped", 2) {
                    testUnitContext("radial", 3) {
                        assertEqual(offsetHexGrid([2, 2], pointy=true), [0, 0], "The offset to place a radial hex grid is always at the origin");
                        assertEqual(offsetHexGrid([2, 2], [3, 3], pointy=true), [0, 0], "The offset to place a radial hex grid is always at the origin, no matter the size");
                        assertEqual(offsetHexGrid([2, 2], [3, 3], pointy=true, l=1, w=2, cx=3, cy=4), [0, 0], "The offset to place a radial hex grid is always at the origin, no matter the size");
                    }
                    testUnitContext("linear", 2) {
                        testUnitContext("odd", 3) {
                            assertApproxEqual(offsetHexGrid([2, 2], linear=true, pointy=true, even=false), [-1 * sqrt(3) / 4, 0], "When only the size is provided the function should assume a count of 1 and should produce a size");
                            assertApproxEqual(offsetHexGrid([2, 2], [3, 3], linear=true, pointy=true, even=false), [-5 * sqrt(3) / 4, -1.5], "Should produce a size corresponding to a grid of 3 cells");
                            assertApproxEqual(offsetHexGrid([2, 2], [3, 3], linear=true, pointy=true, even=false, l=1, w=2, cx=3, cy=4), [-2.5 * sqrt(3) / 4, -9 / 4], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                        }
                        testUnitContext("even", 3) {
                            assertApproxEqual(offsetHexGrid([2, 2], linear=true, pointy=true, even=true), [sqrt(3) / 4, 0], "When only the size is provided the function should assume a count of 1 and should produce a size");
                            assertApproxEqual(offsetHexGrid([2, 2], [3, 3], linear=true, pointy=true, even=true), [-3 * sqrt(3) / 4, -1.5], "Should produce a size corresponding to a grid of 3 cells");
                            assertApproxEqual(offsetHexGrid([2, 2], [3, 3], linear=true, pointy=true, even=true, l=1, w=2, cx=3, cy=4), [-1.5 * sqrt(3) / 4, -9 / 4], "Should produce a size corresponding to a grid of 3x4 cells(1, 2)");
                        }
                    }
                }
            }
        }
    }
}

testCoreHex();
