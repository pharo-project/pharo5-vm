transforms
primitiveTransformVector3
	| x y z rx ry rz rw matrix vertex v3Oop |
	<export: true>
	<var: #vertex declareC:'float *vertex'>
	<var: #matrix declareC:'float *matrix'>
	<var: #x declareC:'double x'>
	<var: #y declareC:'double y'>
	<var: #z declareC:'double z'>
	<var: #rx declareC:'double rx'>
	<var: #ry declareC:'double ry'>
	<var: #rz declareC:'double rz'>
	<var: #rw declareC:'double rw'>

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

	rx := (x * (matrix at: 0)) + (y * (matrix at: 1)) + (z * (matrix at: 2)) + (matrix at: 3).
	ry := (x * (matrix at: 4)) + (y * (matrix at: 5)) + (z * (matrix at: 6)) + (matrix at: 7).
	rz := (x * (matrix at: 8)) + (y * (matrix at: 9)) + (z * (matrix at: 10)) + (matrix at: 11).
	rw := (x * (matrix at: 12)) + (y * (matrix at: 13)) + (z * (matrix at: 14)) + (matrix at: 15).

	v3Oop := interpreterProxy clone: v3Oop.
	vertex := interpreterProxy firstIndexableField: v3Oop.

	rw = 1.0 ifTrue:[
		vertex at: 0 put: (self cCoerce: rx to: 'float').
		vertex at: 1 put: (self cCoerce: ry to:'float').
		vertex at: 2 put: (self cCoerce: rz to: 'float').
	] ifFalse:[
		rw = 0.0 
			ifTrue:[rw := 0.0]
			ifFalse:[rw := 1.0 / rw].
		vertex at: 0 put: (self cCoerce: rx*rw to:'float').
		vertex at: 1 put: (self cCoerce: ry*rw to:'float').
		vertex at: 2 put: (self cCoerce: rz*rw to: 'float').
	].
	interpreterProxy pop: 2.
	^interpreterProxy push: v3Oop.
