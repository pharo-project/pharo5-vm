primitives-access
primitiveGetAALevel
	<export: true>
	<inline: false>
	| failureCode |
	interpreterProxy methodArgumentCount = 0
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 0)) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].
	interpreterProxy pop: 1.
	interpreterProxy pushInteger: self aaLevelGet.