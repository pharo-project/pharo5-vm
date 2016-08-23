C translation
generateIfNotNilIfNilAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self isNilConstantReceiverOf: msgNode)
		ifFalse:
			[aStream nextPut: $(.
			msgNode receiver emitCCodeAsExpressionOn: aStream level: level generator: self.
			aStream crtab: level + 1; nextPut: $?; space.
			msgNode args first emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream crtab: level + 1; nextPut: $:; space.
			msgNode args last emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			aStream nextPut: $)]
		ifTrue:
			[msgNode args last emitCCodeAsArgumentOn: aStream level: level generator: self]