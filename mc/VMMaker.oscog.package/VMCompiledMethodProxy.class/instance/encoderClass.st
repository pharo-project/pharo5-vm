accessing
encoderClass

	^(coInterpreter headerIndicatesAlternateBytecodeSet: self header)
		ifTrue: [EncoderForNewsqueakV4]
		ifFalse: [EncoderForV3PlusClosures]