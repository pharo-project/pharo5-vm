compiled methods
cogMethodOf: aMethodOop
	<api>
	<returnTypeC: #'CogMethod *'>
	| methodHeader |
	methodHeader := self rawHeaderOf: aMethodOop.
	self assert: ((objectMemory isNonIntegerObject: methodHeader)
				and: [methodHeader asUnsignedInteger < objectMemory startOfMemory]).
	^self cCoerceSimple: methodHeader to: #'CogMethod *'