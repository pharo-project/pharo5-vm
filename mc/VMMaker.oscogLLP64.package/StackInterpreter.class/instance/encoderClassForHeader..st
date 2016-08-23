simulation
encoderClassForHeader: headerInteger
	^Smalltalk classNamed: ((objectMemory headerIndicatesAlternateBytecodeSet: headerInteger)
								ifTrue: [AltBytecodeEncoderClassName]
								ifFalse: [BytecodeEncoderClassName])