accessing
startPCOrNilOfLiteral: literalOop in: methodOop
	^(literalOop isClosure
	   and: [literalOop method == (objectMap keyAtValue: methodOop)]) ifTrue:
		[literalOop startpc]