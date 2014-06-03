arithmetic integer primitives
primitiveDivide
	| integerReceiver integerArgument |
	integerReceiver := self stackIntegerValue: 1.
	integerArgument := self stackIntegerValue: 0.
	(integerArgument ~= 0 and: [integerReceiver \\ integerArgument = 0])
		ifTrue: [self pop2AndPushIntegerIfOK: integerReceiver // integerArgument]
		ifFalse: [self primitiveFail]