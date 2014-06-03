compiled methods
headerOf: methodPointer
	<api>
	| methodHeader |
	methodHeader := self rawHeaderOf: methodPointer.
	^(self isCogMethodReference: methodHeader)
		ifTrue:
			[self assert: (self cCoerceSimple: methodHeader to: #'CogMethod *') objectHeader = objectMemory nullHeaderForMachineCodeMethod.
			(self cCoerceSimple: methodHeader to: #'CogMethod *') methodHeader]
		ifFalse: [methodHeader]