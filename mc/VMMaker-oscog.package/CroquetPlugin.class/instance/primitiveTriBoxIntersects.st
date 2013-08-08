transforms
primitiveTriBoxIntersects
	"Primitive. Answer whether an AABB intersects with a given triangle"
	| minCorner maxCorner v0 v1 v2 result |
	<export: true>
	<var: #minCorner type: #'float *'>
	<var: #maxCorner type: #'float *'>
	<var: #v0 type: #'float *'>
	<var: #v1 type: #'float *'>
	<var: #v2 type: #'float *'>

	interpreterProxy methodArgumentCount = 5
		ifFalse:[^interpreterProxy primitiveFail].
	v2 := self stackVector3: 0.
	v1 := self stackVector3: 1.
	v0 := self stackVector3: 2.
	maxCorner := self stackVector3: 3.
	minCorner := self stackVector3: 4.

	result := self cCode:'triBoxOverlap(minCorner, maxCorner, v0, v1, v2)' 
				inSmalltalk:[minCorner. maxCorner. v0. v1. v2. -1].
	result < 0 ifTrue:[^interpreterProxy primitiveFail].

	interpreterProxy pop: 6. "args+rcvr"
	^interpreterProxy pushBool: result.