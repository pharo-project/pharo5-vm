C code generation
emitCCodeAsFieldReferenceOn: aStream level: level generator: aCodeGen
	"If appropriate, translate this message send as a pointer dereference"

	| parenCount |
	(self isStructSendIn: aCodeGen) ifFalse:
		[^false].

	parenCount := receiver isSend ifTrue: [2] ifFalse: [1].
	aStream next: parenCount put: $(.
	receiver  emitCCodeAsExpressionOn: aStream level: 0 generator: aCodeGen.
	parenCount > 1 ifTrue:
		[aStream nextPut: $)].
	(receiver structTargetKindIn: aCodeGen) caseOf: {
		[#pointer] -> [aStream nextPut: $-; nextPut: $>].
		[#struct] -> [aStream nextPut: $.] }.
	aStream nextPutAll: (aCodeGen cFunctionNameFor: selector).
	arguments isEmpty ifFalse:
		[self assert: arguments size = 1.
		 aStream nextPutAll: ' = '.
		 arguments first emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen].
	aStream nextPut: $).
	^true