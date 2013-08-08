inlining support
argumentsForInliningCodeGenerator: aCodeGen
	^(self shouldIncludeReceiverAsFirstArgument: aCodeGen)
		ifTrue: [{receiver}, arguments]
		ifFalse: [arguments]