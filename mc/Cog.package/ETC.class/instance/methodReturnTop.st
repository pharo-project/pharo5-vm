instruction decoding
methodReturnTop
	currentContext isExecutingBlock
		ifTrue: [self blockReturnTop]
		ifFalse: [currentContext pop.
				self doJoin]