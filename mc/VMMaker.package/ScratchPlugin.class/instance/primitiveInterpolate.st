bilinear interpolation
primitiveInterpolate

	| inOop xFixed yFixed width in sz result |
	<export: true>
	<var: 'in' declareC: 'unsigned int *in'>

	inOop := interpreterProxy stackValue: 3.
	width := interpreterProxy stackIntegerValue: 2.
	xFixed := interpreterProxy stackIntegerValue: 1.
	yFixed := interpreterProxy stackIntegerValue: 0.
	in := self checkedUnsignedIntPtrOf: inOop.
	sz := interpreterProxy stSizeOf: inOop.
	interpreterProxy failed ifTrue: [^ nil].

	result := self interpolatedFrom: in x: xFixed y: yFixed width: width height: sz // width.

	interpreterProxy pop: 5.  "pop args and rcvr"
	interpreterProxy pushInteger: result.
	^ 0
