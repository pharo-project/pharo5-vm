C translation
generateIfFalse: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self nilOrBooleanConstantReceiverOf: msgNode receiver)
		ifNil:
			["Eliminate double-negatives"
			 (msgNode receiver isSend and: [msgNode receiver selector == #not]) ifTrue:
				[^self generateIfTrue: (TSendNode new
											setSelector: msgNode selector
											receiver: msgNode receiver receiver
											arguments: msgNode args
											isBuiltInOp: msgNode isBuiltinOperator)
					on: aStream
					indent: level].
			aStream nextPutAll: 'if (!'.
			msgNode receiver isLeaf ifFalse: [aStream nextPut: $(]. "grrrrr"
			msgNode receiver emitCCodeAsExpressionOn: aStream level: level + 1 generator: self.
			msgNode receiver isLeaf ifFalse: [aStream nextPut: $)]. "grrrrr"
			aStream nextPutAll: ') {'; cr.
			msgNode args last emitCCodeOn: aStream level: level + 1 generator: self.
			aStream tab: level.
			aStream nextPut: $}]
		ifNotNil:
			[:const |
			const ifFalse:
				[msgNode args first emitCCodeOn: aStream level: level generator: self]]