arithmetic primitives
primitiveNormalize
	"Primitive. Normalize the argument (A FloatArray) in place."
	<export: true>
	| rcvr rcvrPtr length len |
	<var: #rcvrPtr type: #'float *'>
	<var: #len type: #double>
	rcvr := interpreterProxy stackValue: 0.
	(interpreterProxy isWords: rcvr) ifFalse:
		[interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	length := interpreterProxy stSizeOf: rcvr.
	rcvrPtr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: #'float *'.
	len := 0.0.
	0 to: length-1 do:[:i|
		len := len + ((self cCoerce: (rcvrPtr at: i) to: #double) * (self cCoerce: (rcvrPtr at: i) to: #double)).
	].
	len > 0.0 ifFalse:
		[interpreterProxy primitiveFailFor: PrimErrBadReceiver].

	len := self sqrt: len.
	0 to: length-1 do:[:i|
		rcvrPtr at: i put: ((self cCoerce: (rcvrPtr at: i) to: #double) / len).
	].

	"Leave receiver on the stack."