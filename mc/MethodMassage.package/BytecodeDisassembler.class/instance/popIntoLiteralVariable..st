instruction decoding
popIntoLiteralVariable: aLiteral
	| litIndex |
	litIndex := method encoderClass literalIndexOfBytecodeAt: thePC in: method.
	litIndex ifNil: [self error: 'could not decode literal index'].
	instructions
		at: thePC
		put: (Message
				selector: #popIntoLiteralVariableAtIndex:
				argument: litIndex)