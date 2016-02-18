*MethodMassageCompatibility-accessing
encoderClass
	"Answer the encoder class that encoded the bytecodes in this method.
	 The sign flag bit may be used by the VM to select a bytecode set."

	"THIS IS A TEMPORARY COMPATIBILITY METHOD TO ENABLE MethodMassage.
	 IT SHOULD BE A BASE METHOD THAT ALLOWS FOR A SECOND BYTECODE SET."

	^self header >= 0
		ifTrue: [EncoderForV3PlusClosures]
		ifFalse: [self error: 'unknown encoder class']