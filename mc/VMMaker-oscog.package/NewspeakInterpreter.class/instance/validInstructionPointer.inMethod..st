debug support
validInstructionPointer: anInstrPointer inMethod: aMethod
	^anInstrPointer >= (aMethod + (self lastPointerOf: aMethod) + 1)
	  and: [anInstrPointer < (aMethod + (self byteLengthOf: aMethod))]