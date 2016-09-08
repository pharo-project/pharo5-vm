C translation
generateIfTrueAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode receiver)
		ifNil:
			[aStream nextPut: $(.
			 msgNode receiver emitCCodeAsArgumentOn: aStream level: level generator: self.
			 aStream crtab: level + 1; nextPut: $?; space.
			 msgNode args first emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			 aStream crtab: level + 1; nextPutAll: ': 0)']
		ifNotNil:
			[:const|
			const ifTrue:
				[msgNode args first emitCCodeAsArgumentOn: aStream level: level generator: self]]