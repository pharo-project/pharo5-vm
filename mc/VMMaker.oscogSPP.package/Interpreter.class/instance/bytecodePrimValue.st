common selector sends
bytecodePrimValue
	"In-line value for BlockClosure and BlockContext"
	| maybeBlock rcvrClass |
	maybeBlock := self internalStackTop.
	argumentCount := 0.
	successFlag := true.
	(self isNonIntegerObject: maybeBlock) ifTrue:
		[rcvrClass := self fetchClassOfNonImm: maybeBlock.
		 rcvrClass = (self splObj: ClassBlockClosure)
			ifTrue:
				[self externalizeIPandSP.
				 self primitiveClosureValue.
				 self internalizeIPandSP]
			ifFalse:
				[rcvrClass = (self splObj: ClassBlockContext)
					ifTrue:
						[self externalizeIPandSP.
						 self primitiveValue.
						 self internalizeIPandSP]
					ifFalse:
						[successFlag := false]]].
	successFlag ifFalse:
		[messageSelector := self specialSelector: 25.
		 ^self normalSend].
	self fetchNextBytecode