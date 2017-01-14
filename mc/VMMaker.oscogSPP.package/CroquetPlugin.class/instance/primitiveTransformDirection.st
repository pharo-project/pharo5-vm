transforms
primitiveTransformDirection
	| x y z rx ry rz matrix vertex v3Oop |
	<export: true>
	<var: #vertex declareC:'float *vertex'>
	<var: #matrix declareC:'float *matrix'>
	<var: #x declareC:'double x'>
	<var: #y declareC:'double y'>
	<var: #z declareC:'double z'>
	<var: #rx declareC:'double rx'>
	<var: #ry declareC:'double ry'>
	<var: #rz declareC:'double rz'>

	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFail].
	v3Oop := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	((interpreterProxy isWords: v3Oop) and:[(interpreterProxy slotSizeOf: v3Oop) = 3])
		ifFalse:[^interpreterProxy primitiveFail].
	vertex := interpreterProxy firstIndexableField: v3Oop.
	matrix := self stackMatrix: 1.
	(matrix == nil) ifTrue:[^interpreterProxy primitiveFail].

	x := vertex at: 0.
	y := vertex at: 1.
	z := vertex at: 2.

	rx := (x * (matrix at: 0)) + (y * (matrix at: 1)) + (z * (matrix at: 2)).
	ry := (x * (matrix at: 4)) + (y * (matrix at: 5)) + (z * (matrix at: 6)).
	rz := (x * (matrix at: 8)) + (y * (matrix at: 9)) + (z * (matrix at: 10)).

	v3Oop := interpreterProxy clone: v3Oop.
	vertex := interpreterProxy firstIndexableField: v3Oop.

	vertex at: 0 put: (self cCoerce: rx to: 'float').
	vertex at: 1 put: (self cCoerce: ry to:'float').
	vertex at: 2 put: (self cCoerce: rz to: 'float').

	interpreterProxy pop: 2.
	^interpreterProxy push: v3Oop.
