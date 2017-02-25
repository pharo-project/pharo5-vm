arithmetic float primitives
primitiveSmallFloatFractionalPart
	<option: #Spur64BitMemoryManager>
	| rcvr frac trunc |
	<var: #rcvr type: #double>
	<var: #frac type: #double>
	<var: #trunc type: #double>
	rcvr := objectMemory smallFloatValueOf: self stackTop.
	frac := self cCode: [self mod: rcvr f: (self addressOf: trunc)]
				inSmalltalk: [rcvr fractionPart].
	self stackTopPut: (objectMemory floatObjectOf: frac)