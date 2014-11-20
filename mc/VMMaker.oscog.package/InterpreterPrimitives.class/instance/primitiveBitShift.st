arithmetic integer primitives
primitiveBitShift 
	| integerReceiver integerArgument shifted |
	integerArgument := self stackTop.
	(objectMemory isIntegerObject: integerArgument) ifFalse:
		[^self primitiveFail].
	integerReceiver := self stackValue: 1.
	objectMemory wordSize = 4
		ifTrue:
			[integerReceiver := self positive32BitValueOf: integerReceiver]
		ifFalse:
			[integerReceiver := self signed64BitValueOf: integerReceiver].
	self successful ifTrue:
		[(integerArgument := objectMemory integerValueOf: integerArgument) >= 0
			ifTrue: "Left shift -- must fail if we lose bits beyond 32"
				[integerArgument <= objectMemory numSmallIntegerBits ifFalse:
					[^self primitiveFail].
				shifted := integerReceiver << integerArgument.
				(shifted >> integerArgument) = integerReceiver ifFalse:
					[^self primitiveFail]]
			ifFalse: "Right shift -- OK to lose bits"
				[integerArgument >= objectMemory numSmallIntegerBits negated ifFalse:
					[^self primitiveFail].
			shifted := integerReceiver >> (0 - integerArgument)].
		shifted := (objectMemory isIntegerValue: shifted)
					ifTrue: [objectMemory integerObjectOf: shifted]
					ifFalse:
						[objectMemory wordSize = 4
							ifTrue: [self positive32BitIntegerFor: shifted]
							ifFalse: [self signed64BitIntegerFor: shifted]].
		self pop: 2 thenPush: shifted]