primitives
primitiveDrawLoop
	"Invoke the line drawing primitive."
	| rcvr xDelta yDelta |
	<export: true>
	rcvr := interpreterProxy stackValue: 2.
	xDelta := interpreterProxy stackIntegerValue: 1.
	yDelta := interpreterProxy stackIntegerValue: 0.
	(self loadBitBltFrom: rcvr) ifFalse:[^interpreterProxy primitiveFail].
	interpreterProxy failed ifFalse:[
		self drawLoopX: xDelta Y: yDelta.
		self showDisplayBits].
	interpreterProxy failed ifFalse:[interpreterProxy pop: 2].