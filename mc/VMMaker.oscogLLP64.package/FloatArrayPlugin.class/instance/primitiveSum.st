arithmetic primitives
primitiveSum
	"Primitive. Find the sum of each float in the receiver, a FloatArray, and stash the result into the argument Float."
	| rcvr rcvrPtr length sum |
	<export: true>
	<var: #sum type: #double>
	<var: #rcvrPtr type: #'float *'>
	rcvr := interpreterProxy stackValue: 0.
	(interpreterProxy isWords: rcvr) ifFalse:
		[^interpreterProxy primitiveFail].
	length := interpreterProxy stSizeOf: rcvr.
	rcvrPtr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: #'float *'.
	sum := 0.0.
	0 to: length-1 do:[:i|
		sum := sum + (self cCoerce: (rcvrPtr at: i) to: #double).
	].
	interpreterProxy pop: 1 thenPush: (interpreterProxy floatObjectOf: sum)