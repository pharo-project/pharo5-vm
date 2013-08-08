instruction decoding
methodReturnConstant: value
	currentContext isExecutingBlock
		ifTrue: [currentContext push: value.
				self blockReturnTop]
		ifFalse: [self doJoin]