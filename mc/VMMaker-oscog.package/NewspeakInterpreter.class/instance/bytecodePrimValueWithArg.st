common selector sends
bytecodePrimValueWithArg
	"In-line value: for BlockClosure and BlockContext"
	| maybeBlock rcvrClass |
	maybeBlock := self internalStackValue: 1.
	self initPrimCall.
	argumentCount := 1.
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
						[self primitiveFail]]].
	self successful ifFalse:
		[messageSelector := self specialSelector: 26.
		 ^self normalSend].
	self fetchNextBytecode