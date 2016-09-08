arithmetic primitives
primitiveDivFloatArray
	"Primitive. Add the receiver and the argument, both FloatArrays and store the result into the receiver."
	| rcvr arg rcvrPtr argPtr length |
	<export: true>
	<var: #rcvrPtr type: #'float *'>
	<var: #argPtr type: #'float *'>
	arg := interpreterProxy stackValue: 0.
	rcvr := interpreterProxy stackValue: 1.
	((interpreterProxy isWords: arg)
	 and: [(interpreterProxy isWords: rcvr)
	 and: [(length := interpreterProxy stSizeOf: arg) = (interpreterProxy stSizeOf: rcvr)]]) ifFalse:
		[^interpreterProxy primitiveFail].
	rcvrPtr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: #'float *'.
	argPtr := self cCoerce: (interpreterProxy firstIndexableField: arg) to: #'float *'.
	"Check if any of the argument's values is zero"
	0 to: length-1 do:[:i|
		(interpreterProxy intAtPointer:(self cCoerce: (argPtr + i) to: #'char*')) = 0 ifTrue:[^interpreterProxy primitiveFail]].
	0 to: length-1 do:[:i|
		rcvrPtr at: i put: (self cCoerce: (rcvrPtr at: i) to: #double) / (self cCoerce: (argPtr at: i) to: #double).
	].
	interpreterProxy pop: 1. "Leave rcvr on stack"