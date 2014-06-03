common selector sends
bytecodePrimBlockCopy

	| rcvr hdr |
	rcvr := self internalStackValue: 1.
	self initPrimCall.
	hdr := self baseHeader: rcvr.
	self success: (self isContextHeader: hdr).
	self successful ifTrue: [self externalizeIPandSP.
		self primitiveBlockCopy.
		self internalizeIPandSP].
	self successful ifFalse: [messageSelector := self specialSelector: 24.
		argumentCount := 1.
		^ self normalSend].
	self fetchNextBytecode.
