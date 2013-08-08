instruction decoding
methodReturnReceiver
	currentContext isExecutingBlock
		ifTrue: [self pushReceiver.
				self blockReturnTop]
		ifFalse: [self doJoin]