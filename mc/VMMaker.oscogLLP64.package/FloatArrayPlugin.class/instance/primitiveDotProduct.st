arithmetic primitives
primitiveDotProduct
	"Primitive. Compute the dot product of the receiver and the argument.
	The dot product is defined as the sum of the products of the individual elements."
	| rcvr arg rcvrPtr argPtr length result |
	<export: true>
	<var: #result type: #double>
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
	result := 0.0.
	0 to: length-1 do:[:i|
		result := result + ((self cCoerce: (rcvrPtr at: i) to: 'double') * (self cCoerce: (argPtr at: i) to: 'double')).
	].
	interpreterProxy pop: 2. "Pop args + rcvr"
	interpreterProxy pushFloat: result. "Return result"