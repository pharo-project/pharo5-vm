arithmetic integer primitives
primitiveBitShift
	"Perform a bitShift.  In 32-bits deal only with non-negative 32-bit integers.
	  In 64-bits deal with signed 64-bit quantities (max (2^63)-1)."
	| integerReceiver integerArgument shifted |
	<var: #integerReceiver type: #sqInt>
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
			ifTrue: "Left shift -- must fail bits would be lost"
				[integerArgument <= objectMemory numSmallIntegerBits ifFalse:
					[^self primitiveFail].
				shifted := integerReceiver << integerArgument.
				self cCode: '' inSmalltalk: [shifted := objectMemory wordSize = 4
									ifTrue: [shifted signedIntFromLong]
									ifFalse: [shifted signedIntFromLong64]].
				integerReceiver = (objectMemory wordSize = 4
									ifTrue: [shifted >> integerArgument]
									ifFalse: [shifted >>> integerArgument]) ifFalse:
					[^self primitiveFail]]
			ifFalse: "Right shift -- OK to lose bits"
				[integerArgument >= objectMemory numSmallIntegerBits negated ifFalse:
					[^self primitiveFail].
				 shifted := objectMemory wordSize = 4
								ifTrue: [integerReceiver >> (0 - integerArgument)]
								ifFalse: [integerReceiver >>> (0 - integerArgument)]].
		shifted := objectMemory wordSize = 4
					ifTrue: [self positive32BitIntegerFor: shifted]
					ifFalse:
						[(objectMemory isIntegerValue: shifted)
							ifTrue: [objectMemory integerObjectOf: shifted]
							ifFalse: [self signed64BitIntegerFor: shifted]].
		self pop: 2 thenPush: shifted]