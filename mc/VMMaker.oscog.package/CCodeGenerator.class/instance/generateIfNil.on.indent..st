C translation
generateIfNil: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self isNilConstantReceiverOf: msgNode)
		ifFalse:
			[aStream nextPutAll: 'if (!('.
			 msgNode receiver emitCCodeAsExpressionOn: aStream level: level + 1 generator: self.
			 aStream nextPutAll: ')) {'; cr.
			 msgNode args last emitCCodeOn: aStream level: level + 1 generator: self.
			 aStream tab: level; nextPut: $}]
		ifTrue:
			[msgNode args first emitCCodeOn: aStream level: level generator: self]