C translation
generateIfNilAsArgument: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self isNilConstantReceiverOf: msgNode)
		ifFalse:
			[aStream nextPutAll: '(!('.
			 msgNode receiver emitCCodeAsArgumentOn: aStream level: 0 generator: self.
			 aStream nextPut: $); crtab: level + 1; nextPut: $?; space.
			 msgNode args last emitCCodeAsArgumentOn: aStream level: level + 2 generator: self.
			 aStream crtab: level + 1; nextPut: $:; space.
			 msgNode receiver emitCCodeAsArgumentOn: aStream level: 0 generator: self.
			 (msgNode receiver isLeaf
			  or: [msgNode receiver isSend
				  and: [(msgNode receiver isStructSendIn: self)
				  and: [msgNode receiver receiver isLeaf]]]) ifFalse:
				[logger cr; nextPutAll: 'sending ifNil: to non-leaf in '; nextPutAll: currentMethod selector].
			 aStream nextPut: $)]
		ifTrue:
			[msgNode args first emitCCodeAsArgumentOn: aStream level: level generator: self]