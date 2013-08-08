C code generation
emitCCodeAsFieldReferenceOn: aStream level: level generator: aCodeGen
	"If appropriate, translate this message send as a pointer dereference"

	(self isStructSend: aCodeGen) ifFalse:
		[^false].

	aStream nextPut: $(.
	receiver  emitCCodeAsExpressionOn: aStream level: 0 generator: aCodeGen.
	(receiver structTargetKind: aCodeGen) caseOf: {
		[#pointer] -> [aStream nextPut: $-; nextPut: $>].
		[#struct] -> [aStream nextPut: $.] }.
	aStream nextPutAll: (aCodeGen cFunctionNameFor: selector).
	arguments isEmpty ifFalse:
		[self assert: arguments size = 1.
		 aStream nextPutAll: ' = '.
		 arguments first emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen].
	aStream nextPut: $).
	^true