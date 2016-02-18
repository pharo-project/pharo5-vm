simulation
encoderClassForHeader: headerInteger
	^Smalltalk classNamed: ((self headerIndicatesAlternateBytecodeSet: headerInteger)
								ifTrue: [AltBytecodeEncoderClassName]
								ifFalse: [BytecodeEncoderClassName])