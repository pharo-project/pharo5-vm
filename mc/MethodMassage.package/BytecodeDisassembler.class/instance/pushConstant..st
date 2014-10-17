instruction decoding
pushConstant: aLiteral
	instructions
		at: thePC
		put: ((method encoderClass literalIndexOfBytecodeAt: thePC in: method)
				ifNil: [Message
						selector: #pushSpecialConstant:
						argument: aLiteral]
				ifNotNil:
					[:index|
					Message
						selector: #pushConstantAtIndex:
						argument: index])