C translation
generateIfFalseIfTrueAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode receiver)
		ifNil:
			[(self tryToCollapseBothArmsOfConditionalExpression: msgNode on: aStream indent: level) ifFalse:
				[aStream nextPut: $(.
				 msgNode receiver emitCCodeAsArgumentOn: aStream level: level generator: self.
				 aStream crtab: level + 1; nextPut: $?; space.
				 msgNode args last emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
				 aStream crtab: level + 1; nextPut: $:; space.
				 msgNode args first emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
				 aStream nextPut: $)]]
		ifNotNil:
			[:const|
			(const
				ifTrue: [msgNode args last]
				ifFalse: [msgNode args first])
					emitCCodeAsArgumentOn: aStream level: level generator: self]