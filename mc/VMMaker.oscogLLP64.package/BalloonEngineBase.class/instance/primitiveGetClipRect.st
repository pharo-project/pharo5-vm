primitives-access
primitiveGetClipRect
	| failureCode rectOop pointOop |
	<export: true>
	<inline: false>

	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 1)) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	rectOop := interpreterProxy stackObjectValue: 0.
	(interpreterProxy failed not
	and: [(interpreterProxy isPointers: rectOop)
	and: [(interpreterProxy slotSizeOf: rectOop) >= 2]])
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	interpreterProxy pushRemappableOop: rectOop.
	pointOop := interpreterProxy makePointwithxValue: self clipMinXGet yValue: self clipMinYGet.
	interpreterProxy storePointer: 0 ofObject: interpreterProxy topRemappableOop withValue: pointOop.
	pointOop := interpreterProxy makePointwithxValue: self clipMaxXGet yValue: self clipMaxYGet.
	rectOop := interpreterProxy popRemappableOop.
	interpreterProxy storePointer: 1 ofObject: rectOop withValue: pointOop.

	interpreterProxy pop: 2 thenPush: rectOop.