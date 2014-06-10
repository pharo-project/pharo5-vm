common selector sends
bytecodePrimValueWithArg
	| rcvr isBlock |
	rcvr := self internalStackValue: 1.
	argumentCount := 1.
	isBlock := self isInstanceOfClassBlockClosure: rcvr.
	isBlock ifTrue:
		[self externalizeIPandSP.
		self initPrimCall.
		self primitiveClosureValue.
		self internalizeIPandSP.
		self successful ifTrue:
			[^self fetchNextBytecode].
		primFailCode := 0].
	messageSelector := self specialSelector: 26.
	self normalSend