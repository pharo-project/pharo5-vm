common selector sends
bytecodePrimBlockCopy

	| rcvr hdr |
	rcvr := self internalStackValue: 1.
	successFlag := true.
	hdr := self baseHeader: rcvr.
	self success: (self isContextHeader: hdr).
	successFlag ifTrue: [self externalizeIPandSP.
		self primitiveBlockCopy.
		self internalizeIPandSP].
	successFlag ifFalse: [messageSelector := self specialSelector: 24.
		argumentCount := 1.
		^ self normalSend].
	self fetchNextBytecode.
