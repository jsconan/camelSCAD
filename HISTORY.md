# camelSCAD history

## [Version 0.6.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.6.0)

Add core functions:
- `vangle()`: Computes the angle between two vectors.
- `getAngle()`: Computes the angle of a point on a circle.
- `vertexAngle2D()`: Computes the vertex angle given three 2D points.
- `vertexAngle3D()`: Computes the vertex angle given three 3D points.
- `vertexOutline2D()`: Computes the outline of a vertex at the given distance from the edges.
- `outline()`: Computes the outline of a polygon. The outline can be at a particular distance.
- `getPolygonAngle()`: Gets the angle value at a particular index in a regular polygon.
- `lineAdd()`: Adds a value to each point of a line.
- `simplePolyhedronFaces()`: Builds a vector of faces to be used in a polyhedron. The function accepts the number of points defining one main face of the polyhedron, then returns the faces vector that contains the indices of each face enclosing the solid. This only apply on simple polyhedron where two opposite faces share the same number of points.
- `simplePolyhedronPoints()`: Composes a list of points to be used in a simple polyhedron.
- `sizeCross()`: Computes the size of a cross shape.
- `sizeCrossBox()`: Computes the size of a cross shape.
- `drawCross()`: Computes the points that draws the sketch of a cross shape.
- `quadrant()`: gets a point on a particular quadrant.

With the add of `vangle()` and `getAngle()`, the following functions have beed updated:
- `angle2D()` and `angle3D()` now make use of `vangle()` to compute the angle instead of directly applying the formula.
- `tangent2D()`, `isosceles2D()`, `protractor()` now make use of `getAngle()` to compute the angles. The biggest change is on the `protractor()` that should always return a positive value within the `0..360` range.

Add 2D shapes:
- `regularCross`: Creates a cross at the origin.

Add 3D shapes:
- `regularCrossBox()`: Creates a cross box at the origin.
- `simplePolyhedron `: Creates a simple polyhedron, where only two opposite faces are defined by a list of points.

Add operators:
- `repeatShape2D(size, count=1)`: Repeats horizontally a shape on two directions, the interval is set by the shape size. An option allows to center the repeated shapes in repeatShape operators, `false` by default.
- `repeatShape3D(size, count=1)`: Repeats a shape on three directions, the interval is set by the shape size. An option allows to center the repeated shapes in repeatShape operators, `false` by default.

Features:
- Filter the extension from the name of the package to test. Now the test script accept the name of a package with or without the extension. So both commands are now equivalent:
    ```
    ./scripts/test.sh core/vector-2d
    ```
    ```
    ./scripts/test.sh core/vector-2d.scad
    ```

Fixes:
- Fix non manifold issue in simplePolyhedron. The issue was due to a counter clock wise order used to define faces.
- Fix typo in the name of function `pythagoras()` (was` pythagore()` before)

## [Version 0.5.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.5.0)

Add core functions:
- `parallel2D()`: computes a parallel line.
- `intersect2D()`: computes the point at the intersection of two lines defined by four points.
- `tangent2D()`: computes the point at the tangent between a circle and a line passing through a particular point.
- `isosceles2D()`: computes the third edge of an isosceles triangle defined by the two other edges and either the height or the angle.
- `protractor()`: computes the angle of a line defined by two points.
- `extend2D()`: computes the 2D point at the wanted distance from the origin on the defined 2D line.
- `extend3D()`: computes the 3D point at the wanted distance from the origin on the defined 3D line.
- `apothem()`: Computes the apothem of a regular N-sides polygon. An apothem is a line from the center of a regular polygon at right angles to any of its sides.
- `circumradius()`: Computes the radius of a circle circumscribing a regular N-sides polygon.
- `quadraticEquation()`: Resolve a quadratic equation given the A, B and C terms.
- `circleLineIntersect2D()`: Computes the points at the intersection of a circle and a line.
- `circleIntersect2D()`: Computes the points at the intersection of two circles.

Add shapes:
- `chamferedRectangle(size, chamfer, l, w, cl, cw)`:  Creates a chamfered rectangle at the origin.
- `chamferedBox(size, chamfer, l, w, h, cl, cw, center)`: Creates a chamfered box at the origin.

Improvements on the core function `path()`:
- accept either points or separated coordinates in commands `P`, `L`,  and `T`.
- added commands to compute intersection and tangent lines from the last point.

Fixes:
- Fix an issue occurring with the function `arc()`, when the provided angles are descending.
- Fix misuse of cat command, that could lead to a performance issue.

## [Version 0.4.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.4.0)

Add core functions:
- `floorBy()`: Rounds a value by the provided unit to the lowest.
- `ceilBy()`: Rounds a value by the provided unit to the highest.
- `path()`: Computes a line/polygon from a path.

Bring back the samples into the main branch.

Fix a typo in the unit test of arcPoint.

## [Version 0.3.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.3.0)

Add bezier curves functions:
- `quadraticBezierPoint()`: computes the coordinates of a point along a quadratic bezier curve.
- `cubicBezierPoint()`: computes the coordinates of a point along a cubic bezier curve.
- `quadraticBezierCurve()`: computes the coordinates of a quadratic bezier curve.
- `cubicBezierCurve()`: computes the coordinates of a cubic bezier curve.

Add core functions:
- `splice()`: Changes the contents of an array by removing existing elements and/or adding new elements.
- `straight()`: Ensures an angle is defined within an absolute straight angle range (0..180).

Add global constants related to angles and circle quadrants, maximum recursion, ...

Shapes:
- `controlPoints()`: Displays a list of control points.

Fixes:
- Fix the computation of fragments in `sinusoid()` and `cosinusoid()`
- typo and other errors in annotations

## [Version 0.2.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.2.0)

New features:
- Core:
    - Global constants (render modes, common values, default values, etc.)
    - Operations on hex grids (position, size, count)
    - Functions (maths: `roundBy()`, `decimals()`, type: `isZero()`, util: `align()`)
    - Improved entry points (nested includes)
- Operators:
    - `applyMode`: applies a render mode onto the children modules.
    - `negativeExtrude`: extrudes linearly the children modules, and applies a wall adjustment to ensure the final object will not produce artifacts after a `difference()` operation.
    - `sample()`: takes a sample of the scene and place it at the origin.
    - `translateX()`, `translateY()`, `translateZ()`: translates the children modules along a particular axis.
    - `testUnitContext()`: declares a unit test context. That allows to isolate context data from other unit tests.
- Shapes:
    - Hexagons can now be oriented (flat topped or pointy topped)
    - `mesh()`, `meshBox()`: creates a mesh with honeycomb cells using a hex grid pattern.
    -  `buildPlate()`, `buildVolume`, `buildBox()`: shape operators that allow to visualize the build box context.
- Fixes:
   - Annotations
   - Better consistency in parameters of array operators
   - Unit tests

## [Version 0.1.0](https://github.com/jsconan/camelSCAD/releases/tag/v0.1.0)

First features of the library. More to come...
