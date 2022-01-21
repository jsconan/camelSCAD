# camelSCAD history

## [Version 1.1.0](https://github.com/jsconan/camelSCAD/releases/tag/v1.1.0)

Add core functions:

-   `xAxis2D()`: Produces a 2D vector that only contains a value for the X-axis. Other components are zeroed.
-   `yAxis2D()`: Produces a 2D vector that only contains a value for the Y-axis. Other components are zeroed.
-   `xAxis3D()`: Produces a 3D vector that only contains a value for the X-axis. Other components are zeroed.
-   `yAxis3D()`: Produces a 3D vector that only contains a value for the Y-axis. Other components are zeroed.
-   `zAxis3D()`: Produces a 3D vector that only contains a value for the Z-axis. Other components are zeroed.

Add operators:

-   `repeatGrid()`: Repeats the children module `count` times and place each copy on a grid with the provided `interval`, up to `line` elements per line.

Fix operators:

-   `distributeGrid()`: The centering of elements was producing results when the number of elements was lower than a line, or when the number of lines was even.

## [Version 1.0.1](https://github.com/jsconan/camelSCAD/releases/tag/v1.0.1)

Fix a comparison issue occurring with `complete(collection, start, end)`, when the collection start and end elements are very close to the elements to add. When these elements are different only after the Nth decimal, when N > 5, the function can add duplicate values.

## [Version 1.0.0](https://github.com/jsconan/camelSCAD/releases/tag/v1.0.0)

Support update for OpenSCAD 2019 and OpenSCAD 2021.

Fixes:

-   Warnings messages appearing after the update to OpenSCAD 2019.05.
-   Failing unit tests after the update to OpenSCAD 2021.01.

Features:

-   Improve the readability of the unit tests error report from the CLI script (at least with dark background).

**Breaking changes:**

-   The default return value of some API have been changed (`rotp()`, `mirp()`, `arcp()`), when used with wrong parameters.
-   Use new API added by OpenSCAD 2019.05 to test types.
-   Require OpenSCAD 2019.05 as minimal version.

Refactoring:

-   Use dot notation indexing instead of list indexing when relevant.

## [Version 0.14.1](https://github.com/jsconan/camelSCAD/releases/tag/v0.14.1)

Fix a script early break when the source path only contains folders.

Add script utils:

-   `recursepath()`: print the list of subfolders
-   `scadrenderallrecurse()`: render all files in the path and its sub-folders
-   `slic3rsliceallrecurse()`: slice all files in the path and its sub-folders

## [Version 0.14.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.14.0)

Improve the util scripts, adding parameters to make them configurable.

-   `./scripts/render.sh`:

```
Renders OpenSCAD files
  Usage:
	./scripts/render.sh [command] [-h|--help] [-o|--option value]

  -h,  --help         Show this help
  -i   --input        Set the folder that contains the input files (default: ./)
  -o   --output       Set the folder that contains the output files (default: ./output)
  -f   --format       Set the output format
  -p   --parallel     Set the number of parallel processes
  -c   --clean        Clean up the output folder before rendering
  -r   --recurse      Recurse into sub-directories
```

-   `./scripts/slice.sh`:

```
Slices model files
  Usage:
	./scripts/slice.sh [command] [-h|--help] [-o|--option value]

  -h,  --help         Show this help
  -i   --input        Set the folder that contains the input files (default: ./output)
  -o   --output       Set the folder that contains the output files (default: ./dist)
  -s   --config       Set the path to the config file
  -f   --format       Set the output format
  -p   --parallel     Set the number of parallel processes
  -c   --clean        Clean up the output folder before rendering
  -r   --recurse      Recurse into sub-directories
  -ps  --prusaslicer  Use PrusaSlicer instead of Slic3r
```

-   `./scripts/test.sh`:

```
Runs a tests suite for OpenSCAD files
  Usage:
	./scripts/test.sh [command] [-h|--help] [-o|--option value] "test suite"

  -h,  --help         Show this help
  -i   --input        Set the folder that contains the input files (default: ./test)
  -o   --output       Set the folder that contains the output files (default: ./output)
  -d   --default      Set the default test suite (default: suite)
  -c   --clean        Clean up the output folder before running the tests suite
```

## [Version 0.13.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.13.0)

Add shapes to add a link between parts:

-   `linkProfile(neck, bulb, w, h, rx, ry, dx, dy, distance = 0)`: Draws the profile of a link.
-   `link(neck, bulb, height, w, h, rx, ry, dx, dy, distance = 0, center=false)`: Draws a link.

## [Version 0.12.3](https://github.com/jsconan/camelSCAD/releases/tag/v0.12.3)

Improve the internal handling of format and extension in the slicer script.

## [Version 0.12.2](https://github.com/jsconan/camelSCAD/releases/tag/v0.12.2)

Rename the utils function `sclic3rmodel` to `slic3rformat` for better consistency in API.

## [Version 0.12.1](https://github.com/jsconan/camelSCAD/releases/tag/v0.12.1)

Fix the message displayed by the script utils when no config file is set for the slicer.

## [Version 0.12.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.12.0)

Improve the render script utils:

-   `scripts/utils/slic3r.sh`: set of function to apply Slic3r on model files.
-   `scripts/slice.sh`: slices each model file contained in a folder.

## [Version 0.11.1](https://github.com/jsconan/camelSCAD/releases/tag/v0.11.1)

Fixes:

-   Use of `buildBox()` and `buildPlate()` in samples
-   Missing history in previous releases

## [Version 0.11.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.11.0)

Add core functions:

-   `getChordHeight()`: Gets the height of a chord given the radius and the angle
-   `getChordDistance()`: Gets the distance to a chord given the radius and the length

Improve the render script utils:

-   spawn several processes when rendering multiple files
-   add function `scadprocesses()`: set and display the number of parallel processes to spawn when rendering multiple files

Rework the build box shapes, making them more consistent. They now offer a `center` option, `false` by default so that the build box will have its origin at `[0, 0, 0]`.

Breaking change: the `buildBox()` shape does not apply the render mode anymore.

## [Version 0.10.1](https://github.com/jsconan/camelSCAD/releases/tag/v0.10.1)

Fixes:

-   Fix the planarity of faces generated by the function `simplePolyhedronFaces()`. Generate triangles instead of rectangles.
-   Fix typos in annotations.

## [Version 0.10.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.10.0)

Improvements:

-   Add the sinusoid command to the `path()` function.
-   Allow drawing sinusoid and co-sinusoid in reverse (from right to left instead of left to right).
-   Allow adding an initial translation to sinusoid and co-sinusoid.
-   add function `tolower()` in render script utils: print the value to lower case
-   add function `toupper()` in render script utils: print the value to upper case
-   add function `scadformat()` in render script utils: set the output format for rendered files

Breaking changes:

-   `scadtostl()` renamed to `scadrender()`
-   `scadtostlall()` renamed to `scadrenderall()`
-   add a `suffix` parameter to `scadrender()` and `scadrenderall()`

## [Version 0.9.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.9.0)

Add operators:

-   `repeatMap(map, offset, x, y, z)`: Repeats the children modules on every position given in the `map`.
-   `repeatRotateMap(map, offset, x, y, z)`: Repeats the children modules on every angle given in the `map`.

Improvements:

-   Add an option to center the repeated shapes in `repeat*`, `mirror*`, `rotate*`, and `distributed*` operators, `false` by default.

## [Version 0.8.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.8.0)

Add core functions:

-   `getArcLength()`: Gets the length of an arc given the radius and the angle
-   `getArcAngle()`: Gets the angle of an arc given the radius and the length
-   `getChordLength()`: Gets the length of a chord given the radius and the angle
-   `getChordAngle()`: Gets the angle of a chord given the radius and the length

Add shapes:

-   `ringSegment(r, w, a=RIGHT, d, a1, a2, rx, ry, dx, dy, wx, wy)`: Creates a ring section at the origin.
-   `pipeSegment(r, h, w=0.1, a=90, d, a1, a2, rx, ry, dx, dy, wx, wy, center)`: Creates a pipe segment at the origin.

Fixes:

-   Fixed wrong parameter name used in `chord()` shape

## [Version 0.7.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.7.0)

Add core functions:

-   `times()`: fills an array by repeating a value N times. Arrays will be concatained. The result will be a flatten array.
-   `isNAN()`: Checks if the value is NAN (Not A Number).
-   `isInfinity()`: Checks if the value is infinite.

Fixes:

-   Fix warnings that occurs when using `sinusoid()` or `cosinusoid()` with an empty length.
-   Ignore empty var definitions in additional params for `scadcall()`
-   Missing parameter in `drawPlate()`.
-   Fix compatibility issue with camelSCAD and OpenSCAD 2019.05 due to change in strings management.
    -   check array of strings in `flatten()`
    -   check string in `vadd()`, `vsub()`, `vmin()`, `vmax()`, `vpow()`, `vabs()`, `vsign()`
    -   fix stricness issue in unit test for `apothem()`
    -   improve detection of numbers
-   Fix context initialization in unit tests, as a lot of warnings regarding context variables were displayed with OpenSCAD 2019.05.

Improvements:

-   Improve the core function `path` by adding commands to nest or repeat a subpath.
-   Improve types management in core functions.
-   Add constant `INFINITY`.
-   Add constant `NAN`.
-   Refactoring on the scripts side, adding some shared utils:
    -   `scripts/test.sh`: unit tests the project using the `test` folder. By default target the file names `suite.scad`.
    -   `scripts/render.sh`: renders each OpenSCAD file contained in a folder.

## [Version 0.6.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.6.0)

Add core functions:

-   `vangle()`: Computes the angle between two vectors.
-   `getAngle()`: Computes the angle of a point on a circle.
-   `vertexAngle2D()`: Computes the vertex angle given three 2D points.
-   `vertexAngle3D()`: Computes the vertex angle given three 3D points.
-   `vertexOutline2D()`: Computes the outline of a vertex at the given distance from the edges.
-   `outline()`: Computes the outline of a polygon. The outline can be at a particular distance.
-   `getPolygonAngle()`: Gets the angle value at a particular index in a regular polygon.
-   `lineAdd()`: Adds a value to each point of a line.
-   `simplePolyhedronFaces()`: Builds a vector of faces to be used in a polyhedron. The function accepts the number of points defining one main face of the polyhedron, then returns the faces vector that contains the indices of each face enclosing the solid. This only apply on simple polyhedron where two opposite faces share the same number of points.
-   `simplePolyhedronPoints()`: Composes a list of points to be used in a simple polyhedron.
-   `sizeCross()`: Computes the size of a cross shape.
-   `sizeCrossBox()`: Computes the size of a cross shape.
-   `drawCross()`: Computes the points that draws the sketch of a cross shape.
-   `quadrant()`: gets a point on a particular quadrant.

With the add of `vangle()` and `getAngle()`, the following functions have beed updated:

-   `angle2D()` and `angle3D()` now make use of `vangle()` to compute the angle instead of directly applying the formula.
-   `tangent2D()`, `isosceles2D()`, `protractor()` now make use of `getAngle()` to compute the angles. The biggest change is on the `protractor()` that should always return a positive value within the `0..360` range.

Add 2D shapes:

-   `regularCross`: Creates a cross at the origin.

Add 3D shapes:

-   `regularCrossBox()`: Creates a cross box at the origin.
-   `simplePolyhedron `: Creates a simple polyhedron, where only two opposite faces are defined by a list of points.

Add operators:

-   `repeatShape2D(size, count=1)`: Repeats horizontally a shape on two directions, the interval is set by the shape size. An option allows to center the repeated shapes in repeatShape operators, `false` by default.
-   `repeatShape3D(size, count=1)`: Repeats a shape on three directions, the interval is set by the shape size. An option allows to center the repeated shapes in repeatShape operators, `false` by default.

Features:

-   Filter the extension from the name of the package to test. Now the test script accept the name of a package with or without the extension. So both commands are now equivalent:
    ```
    ./scripts/test.sh core/vector-2d
    ```
    ```
    ./scripts/test.sh core/vector-2d.scad
    ```

Fixes:

-   Fix non manifold issue in simplePolyhedron. The issue was due to a counter clock wise order used to define faces.
-   Fix typo in the name of function `pythagoras()` (was` pythagore()` before)

## [Version 0.5.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.5.0)

Add core functions:

-   `parallel2D()`: computes a parallel line.
-   `intersect2D()`: computes the point at the intersection of two lines defined by four points.
-   `tangent2D()`: computes the point at the tangent between a circle and a line passing through a particular point.
-   `isosceles2D()`: computes the third edge of an isosceles triangle defined by the two other edges and either the height or the angle.
-   `protractor()`: computes the angle of a line defined by two points.
-   `extend2D()`: computes the 2D point at the wanted distance from the origin on the defined 2D line.
-   `extend3D()`: computes the 3D point at the wanted distance from the origin on the defined 3D line.
-   `apothem()`: Computes the apothem of a regular N-sides polygon. An apothem is a line from the center of a regular polygon at right angles to any of its sides.
-   `circumradius()`: Computes the radius of a circle circumscribing a regular N-sides polygon.
-   `quadraticEquation()`: Resolve a quadratic equation given the A, B and C terms.
-   `circleLineIntersect2D()`: Computes the points at the intersection of a circle and a line.
-   `circleIntersect2D()`: Computes the points at the intersection of two circles.

Add shapes:

-   `chamferedRectangle(size, chamfer, l, w, cl, cw)`: Creates a chamfered rectangle at the origin.
-   `chamferedBox(size, chamfer, l, w, h, cl, cw, center)`: Creates a chamfered box at the origin.

Improvements on the core function `path()`:

-   accept either points or separated coordinates in commands `P`, `L`, and `T`.
-   added commands to compute intersection and tangent lines from the last point.

Fixes:

-   Fix an issue occurring with the function `arc()`, when the provided angles are descending.
-   Fix misuse of cat command, that could lead to a performance issue.

## [Version 0.4.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.4.0)

Add core functions:

-   `floorBy()`: Rounds a value by the provided unit to the lowest.
-   `ceilBy()`: Rounds a value by the provided unit to the highest.
-   `path()`: Computes a line/polygon from a path.

Bring back the samples into the main branch.

Fix a typo in the unit test of arcPoint.

## [Version 0.3.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.3.0)

Add bezier curves functions:

-   `quadraticBezierPoint()`: computes the coordinates of a point along a quadratic bezier curve.
-   `cubicBezierPoint()`: computes the coordinates of a point along a cubic bezier curve.
-   `quadraticBezierCurve()`: computes the coordinates of a quadratic bezier curve.
-   `cubicBezierCurve()`: computes the coordinates of a cubic bezier curve.

Add core functions:

-   `splice()`: Changes the contents of an array by removing existing elements and/or adding new elements.
-   `straight()`: Ensures an angle is defined within an absolute straight angle range (0..180).

Add global constants related to angles and circle quadrants, maximum recursion, ...

Shapes:

-   `controlPoints()`: Displays a list of control points.

Fixes:

-   Fix the computation of fragments in `sinusoid()` and `cosinusoid()`
-   typo and other errors in annotations

## [Version 0.2.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.2.0)

New features:

-   Core:
    -   Global constants (render modes, common values, default values, etc.)
    -   Operations on hex grids (position, size, count)
    -   Functions (maths: `roundBy()`, `decimals()`, type: `isZero()`, util: `align()`)
    -   Improved entry points (nested includes)
-   Operators:
    -   `applyMode`: applies a render mode onto the children modules.
    -   `negativeExtrude`: extrudes linearly the children modules, and applies a wall adjustment to ensure the final object will not produce artifacts after a `difference()` operation.
    -   `sample()`: takes a sample of the scene and place it at the origin.
    -   `translateX()`, `translateY()`, `translateZ()`: translates the children modules along a particular axis.
    -   `testUnitContext()`: declares a unit test context. That allows to isolate context data from other unit tests.
-   Shapes:
    -   Hexagons can now be oriented (flat topped or pointy topped)
    -   `mesh()`, `meshBox()`: creates a mesh with honeycomb cells using a hex grid pattern.
    -   `buildPlate()`, `buildVolume`, `buildBox()`: shape operators that allow to visualize the build box context.
-   Fixes:
    -   Annotations
    -   Better consistency in parameters of array operators
    -   Unit tests

## [Version 0.1.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.1.0)

First features of the library. More to come...
