compiled methods
cogMethodOf: aMethodOop
	<api>
	| methodHeader |
	methodHeader := self rawHeaderOf: aMethodOop.
	self assert: ((objectMemory isNonImmediate: methodHeader)
				and: [methodHeader asUnsignedInteger < objectMemory startOfMemory]).
	^self cCoerceSimple: methodHeader to: #'CogMethod *'