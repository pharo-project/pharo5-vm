compiled methods
noAssertHeaderOf: methodPointer
	<api>
	| methodHeader |
	methodHeader := self rawHeaderOf: methodPointer.
	^(self isCogMethodReference: methodHeader)
		ifTrue: [(self cCoerceSimple: methodHeader to: #'CogMethod *') methodHeader]
		ifFalse: [methodHeader]