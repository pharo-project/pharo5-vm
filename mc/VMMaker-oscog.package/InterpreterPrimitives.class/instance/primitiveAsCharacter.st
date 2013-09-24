object access primitives
primitiveAsCharacter
	| characterCode characterObject |
	characterCode := self stackTop.
	((objectMemory isIntegerObject: characterCode)
	and: [characterCode := objectMemory integerValueOf: characterCode.
		objectMemory isInRangeCharacterCode: characterCode]) ifFalse:
		[^self primitiveFailFor: (argumentCount = 0
									ifTrue: [PrimErrBadReceiver]
									ifFalse: [PrimErrBadArgument])].
	characterObject := self characterForAscii: characterCode.
	self pop: argumentCount + 1 thenPush: characterObject