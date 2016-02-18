arithmetic integer primitives
primitiveBitAnd
	<inline: false>
	| integerReceiver integerArgument |
	integerArgument := self stackTop.
	integerReceiver := self stackValue: 1.
	"Comment out the short-cut.  Either the inline interpreter bytecode or the JIT primitive will handle this case.
	 ((objectMemory isIntegerObject: integerArgument)
	 and: [objectMemory isIntegerObject: integerReceiver])
		ifTrue: [self pop: 2 thenPush: (integerArgument bitAnd: integerReceiver)]
		ifFalse:
			["objectMemory wordSize = 8
				ifTrue:
					[integerArgument := self positive64BitValueOf: integerArgument.
					 integerReceiver := self positive64BitValueOf: integerReceiver.
					 self successful ifTrue:
						[self pop: 2 thenPush: (self positive64BitIntegerFor: (integerArgument bitAnd: integerReceiver))]]
				ifFalse:
					[integerArgument := self positive32BitValueOf: integerArgument.
					 integerReceiver := self positive32BitValueOf: integerReceiver.
					 self successful ifTrue:
						[self pop: 2 thenPush: (self positive32BitIntegerFor: (integerArgument bitAnd: integerReceiver))]]"]"