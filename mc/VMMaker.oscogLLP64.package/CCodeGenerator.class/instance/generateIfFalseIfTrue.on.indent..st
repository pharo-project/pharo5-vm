C translation
generateIfFalseIfTrue: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode receiver)
		ifNil:
			[(self tryToCollapseBothArmsOfConditional: msgNode on: aStream indent: level) ifFalse:
				[aStream nextPutAll: 'if ('.
				 msgNode receiver emitCCodeAsExpressionOn: aStream level: level generator: self.
				 aStream nextPutAll: ') {'; cr.
				 msgNode args last emitCCodeOn: aStream level: level + 1 generator: self.
				 aStream tab: level; nextPut: $}; crtab: level; nextPutAll: 'else {'; cr.
				 msgNode args first emitCCodeOn: aStream level: level + 1 generator: self.
				 aStream tab: level; nextPut: $}]]
		ifNotNil:
			[:const |
			 (const ifTrue: [msgNode args last] ifFalse: [msgNode args first])
				emitCCodeOn: aStream level: level generator: self]