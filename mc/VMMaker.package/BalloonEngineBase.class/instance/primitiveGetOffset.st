primitives-access
primitiveGetOffset
	| failureCode pointOop |
	<export: true>
	<inline: false>

	interpreterProxy methodArgumentCount = 0
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 0)) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].
	pointOop := interpreterProxy makePointwithxValue: self destOffsetXGet yValue: self destOffsetYGet.
	interpreterProxy pop: 1 thenPush: pointOop.