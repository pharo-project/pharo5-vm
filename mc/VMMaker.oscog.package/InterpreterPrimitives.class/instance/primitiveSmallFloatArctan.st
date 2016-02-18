arithmetic float primitives
primitiveSmallFloatArctan
	<option: #Spur64BitMemoryManager>
	| rcvr |
	<var: #rcvr type: #double>
	rcvr := objectMemory smallFloatValueOf: self stackTop.
	self pop: 1
		thenPushFloat: (self cCode: [rcvr atan]
							inSmalltalk: [rcvr = rcvr
											ifTrue: [rcvr arcTan]
											ifFalse: [Float nan]])