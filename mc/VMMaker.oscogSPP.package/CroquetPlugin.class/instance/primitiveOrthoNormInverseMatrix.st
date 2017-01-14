transforms
primitiveOrthoNormInverseMatrix
	| srcOop dstOop src dst x y z rx ry rz |
	<export: true>
	<var: #src declareC:'float *src'>
	<var: #dst declareC:'float *dst'>
	<var: #x declareC:'double x'>
	<var: #y declareC:'double y'>
	<var: #z declareC:'double z'>
	<var: #rx declareC:'double rx'>
	<var: #ry declareC:'double ry'>
	<var: #rz declareC:'double rz'>

	interpreterProxy methodArgumentCount = 0
		ifFalse:[^interpreterProxy primitiveFail].
	srcOop := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	((interpreterProxy isWords: srcOop) and:[(interpreterProxy slotSizeOf: srcOop) = 16])
		ifFalse:[^interpreterProxy primitiveFail].
	dstOop := interpreterProxy clone: srcOop.
	"reload srcOop in case of GC"
	srcOop := interpreterProxy stackObjectValue: 0.
	src := interpreterProxy firstIndexableField: srcOop.
	dst := interpreterProxy firstIndexableField: dstOop.

	"Transpose upper 3x3 matrix"
	"dst at: 0 put: (src at: 0)."	dst at: 1 put: (src at: 4). 	dst at: 2 put: (src at: 8). 
	dst at: 4 put: (src at: 1). 	"dst at: 5 put: (src at: 5)."	dst at: 6 put: (src at: 9). 
	dst at: 8 put: (src at: 2). 	dst at: 9 put: (src at: 6). 	"dst at: 10 put: (src at: 10)."

	"Compute inverse translation vector"
	x := src at: 3.
	y := src at: 7.
	z := src at: 11.
	rx := (x * (dst at: 0)) + (y * (dst at: 1)) + (z * (dst at: 2)).
	ry := (x * (dst at: 4)) + (y * (dst at: 5)) + (z * (dst at: 6)).
	rz := (x * (dst at: 8)) + (y * (dst at: 9)) + (z * (dst at: 10)).

	dst at: 3 put: (self cCoerce: 0.0-rx to: 'float').
	dst at: 7 put: (self cCoerce: 0.0-ry to: 'float').
	dst at: 11 put: (self cCoerce: 0.0-rz to: 'float').

	interpreterProxy pop: 1.
	^interpreterProxy push: dstOop.
