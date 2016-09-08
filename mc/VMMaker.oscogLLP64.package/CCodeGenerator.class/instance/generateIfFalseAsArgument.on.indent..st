C translation
generateIfFalseAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode receiver)
		ifNil:
			["Eliminate double-negatives"
			 (msgNode receiver isSend and: [msgNode receiver selector == #not]) ifTrue:
				[^self generateIfTrueAsArgument: (TSendNode new
														setSelector: msgNode selector
														receiver: msgNode receiver receiver
														arguments: msgNode args
														isBuiltInOp: msgNode isBuiltinOperator)
					on: aStream
					indent: level].
			aStream nextPutAll: '(!('.
			msgNode receiver emitCCodeAsArgumentOn: aStream level: 0 generator: self.
			aStream nextPut: $); crtab: level + 1; nextPut: $?; space.
			msgNode args last emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream crtab: level + 1; nextPutAll: ': 0)']
		ifNotNil:
			[:const|
			const ifFalse:
				[msgNode args first emitCCodeAsArgumentOn: aStream level: level generator: self]]