arithmetic float primitives
primitiveSmallFloatSine
	<option: #Spur64BitMemoryManager>
	| rcvr |
	<var: #rcvr type: #double>
	rcvr := objectMemory smallFloatValueOf: self stackTop.
	self pop: 1
		thenPushFloat: (self cCode: [rcvr sin]
							inSmalltalk: [rcvr = rcvr
											ifTrue: [rcvr sin]
											ifFalse: [Float nan]])